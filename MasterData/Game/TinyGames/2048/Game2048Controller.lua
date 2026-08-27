local Game2048Controller = class("Game2048Controller")
local CS_Input = CS.UnityEngine.Input
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local Game2048Board = require("Game.TinyGames.2048.Game2048Board")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local tinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local DirVectorMap = {
  [1] = {x = 0, y = -1},
  [2] = {x = 0, y = 1},
  [3] = {x = -1, y = 0},
  [4] = {x = 1, y = 0}
}
local Key = 309813

function Game2048Controller:ctor()
  self:SetGame2048Score(0)
  self._gameStarted = false
  self._tinyGameNetwork = NetworkManager:GetNetwork(NetworkTypeID.TinyGame)
end

function Game2048Controller:InitGame2048(actId, gameId, taskReddotNode, isHistoryOpen, HTGData, isSetBlurBg)
  self._actId = actId
  self._gameId = gameId
  self.__isHistoryOpen = isHistoryOpen
  self.__HTGData = HTGData
  self._onUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self._onUpdate)
  self.__on2048TouchSwipe = BindCallback(self, self.On2048TouchSwipe)
  CS_LeanTouch.OnFingerSwipe("+", self.__on2048TouchSwipe)
  self._board = Game2048Board.New()
  self._highestScore = 0
  if self.__isHistoryOpen then
    self._highestScore = self.__HTGData:UpdateSelfHighScore()
    UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDay2048, function(window)
      self._window2048 = window
      self._window2048:Init2048GameWindow(self, self._highestScore, taskReddotNode, self.__isHistoryOpen)
      if isSetBlurBg then
        self._window2048:SetIniy2048BlurBg()
      end
    end)
    return
  end
  self._tinyGameNetwork:CS_ActivityGame_2048_SelfRankDetail(self._actId, self._gameId, function(dataList)
    if dataList.Count <= 0 then
      return
    end
    local msg = dataList[0]
    self._highestScore = msg.highestScore
    UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDay2048, function(window)
      self._window2048 = window
      self._window2048:Init2048GameWindow(self, self._highestScore, taskReddotNode)
      if isSetBlurBg then
        self._window2048:SetIniy2048BlurBg()
      end
      TimerManager:StartTimer(1, function()
        if UIManager:GetWindow(UIWindowTypeID.WhiteDay2048) == nil then
          return
        end
        local MainCamera = UIManager:GetMainCamera()
        MainCamera.enabled = false
      end, nil, true, true, true)
    end)
  end)
end

function Game2048Controller:Get2048ActFramId()
  return self._actId
end

function Game2048Controller:Open2048TaskUI()
  if self.__isHistoryOpen then
    return
  end
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameData = actCtrl:GetActivityFrameData(self._actId)
  if frameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.WhiteDay then
    UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayTask, function(window)
      if window == nil then
        return
      end
      local AWDCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay)
      local actId = frameData:GetActId()
      local AWDData = AWDCtrl:GetWhiteDayDataByActId(actId)
      window:InitWDTask(AWDCtrl, AWDData)
    end)
  end
end

function Game2048Controller:Set2048CtrlDeleteCallback(deleteCallback)
  self.deleteCallback = deleteCallback
end

function Game2048Controller:GetIs2048ActOver()
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameData = actCtrl:GetActivityFrameData(self._actId)
  if frameData == nil or frameData:GetActivityEndTime() < PlayerDataCenter.timestamp then
    return true
  end
  return false
end

function Game2048Controller:StartNew2048Game()
  self:SetGame2048Score(0)
  self._gameStarted = true
  self._board:InitGame2048Board()
  self._window2048:InitNew2048Window()
  self:AddRandomTile()
end

function Game2048Controller:Get2048SizeX()
  return self._board.xCount
end

function Game2048Controller:Get2048SizeY()
  return self._board.yCount
end

function Game2048Controller:IsGame2048Started()
  return self._gameStarted
end

function Game2048Controller:OnUpdate()
  if not self._gameStarted then
    return
  end
  self:CheckKeyInput()
end

function Game2048Controller:CheckKeyInput()
  if not CS_Input.anyKeyDown then
    return false
  end
  local dir = 0
  if CS_Input.GetKeyDown("up") then
    dir = 1
  elseif CS_Input.GetKeyDown("down") then
    dir = 2
  elseif CS_Input.GetKeyDown("left") then
    dir = 3
  elseif CS_Input.GetKeyDown("right") then
    dir = 4
  end
  if 0 < dir then
    self:Move2048(dir)
    return true
  end
  return false
end

function Game2048Controller:On2048TouchSwipe(leanFinger)
  if not self._gameStarted then
    return
  end
  local result = CS_LeanTouch.RaycastGui(leanFinger.StartScreenPosition)
  if result.Count == 0 then
    return
  end
  local res = result[0]
  if res.gameObject ~= self._window2048:GetGame2048Touch() then
    return
  end
  local screenFrom = leanFinger.StartScreenPosition
  local screenTo = leanFinger.ScreenPosition
  local finalDelta = screenTo - screenFrom
  local dir = 0
  if finalDelta.x < -math.abs(finalDelta.y) then
    dir = 3
  elseif finalDelta.x > math.abs(finalDelta.y) then
    dir = 4
  elseif finalDelta.y < -math.abs(finalDelta.x) then
    dir = 2
  elseif finalDelta.y > math.abs(finalDelta.x) then
    dir = 1
  end
  if 0 < dir then
    self:Move2048(dir)
  end
end

function Game2048Controller:PrepareTiles()
  for x = 1, self._board.xCount do
    for y = 1, self._board.yCount do
      local tile = self._board:CellContentDirect(x, y)
      if tile ~= nil then
        tile:PrepareTile()
      end
    end
  end
end

function Game2048Controller:Move2048(dir)
  local dirVector = DirVectorMap[dir]
  if dirVector == nil then
    return
  end
  self:PrepareTiles()
  local xstart, xend
  local xoffset = 1
  if dirVector.x == 0 then
    xstart = 1
    xend = self._board.xCount
  elseif dirVector.x > 0 then
    xstart = self._board.xCount - 1
    xend = 1
    xoffset = -1
  else
    xstart = 2
    xend = self._board.xCount
  end
  local ystart, yend
  local yoffset = 1
  if dirVector.y == 0 then
    ystart = 1
    yend = self._board.yCount
  elseif 0 < dirVector.y then
    ystart = self._board.yCount - 1
    yend = 1
    yoffset = -1
  else
    ystart = 2
    yend = self._board.yCount
  end
  local moved = false
  for x = xstart, xend, xoffset do
    for y = ystart, yend, yoffset do
      local tile = self._board:CellContentDirect(x, y)
      if tile ~= nil then
        local nextTile, farthestX, farthestY = self:FindFarthestPosition(tile.x, tile.y, dirVector)
        if nextTile ~= nil and nextTile.level == tile.level and not nextTile.merged then
          local mergedTile = self._window2048:Get2048TilePool():GetOne()
          local newLevel = nextTile.level + 1
          mergedTile:Init2048Tile(newLevel, nextTile.x, nextTile.y, self._window2048:Get2048TilePool(), self._window2048:Get2048IconByLevel(newLevel))
          mergedTile:SetTileAsMerged(tile, nextTile)
          self._board:InsertTile(mergedTile)
          self._board:RemoveTile(tile)
          self:TileUpdatePosition(mergedTile)
          tile:UpdateTilePosData(nextTile.x, nextTile.y)
          local oldScore = self:GetGame2048Score()
          self:SetGame2048Score(oldScore + 2 ^ mergedTile.level)
          moved = true
        elseif farthestX ~= tile.x or farthestY ~= tile.y then
          self:MoveTile(tile, farthestX, farthestY)
          moved = true
        end
      end
    end
  end
  if not moved then
    return
  end
  AudioManager:PlayAudioById(1206)
  self:AddRandomTile()
  self._window2048:Update2048Score(self:GetGame2048Score(), true)
  self:PlayTilesAnimation()
  if not self:MovesAvailable() then
    self:EnterGame2048OverState()
  end
end

function Game2048Controller:MovesAvailable()
  if self._board:GetAvailableCellCount() > 0 then
    return true
  end
  for x = 1, self._board.xCount do
    for y = 1, self._board.yCount do
      local tile = self._board:CellContentDirect(x, y)
      if tile ~= nil then
        for dir = 1, 4 do
          local dirVector = DirVectorMap[dir]
          local other = self._board:CellContent(x + dirVector.x, y + dirVector.y)
          if other ~= nil and other.level == tile.level then
            return true
          end
        end
      end
    end
  end
  return false
end

function Game2048Controller:MoveTile(tile, newX, newY)
  self._board:RemoveTile(tile)
  tile:UpdateTilePosData(newX, newY)
  self._board:InsertTile(tile)
end

function Game2048Controller:AddRandomTile()
  local ok, x, y = self._board:RandomAvailableCell()
  if not ok then
    return
  end
  local level = self._board:GetRandomNumLevel()
  local tile = self._window2048:Get2048TilePool():GetOne()
  tile:Init2048Tile(level, x, y, self._window2048:Get2048TilePool(), self._window2048:Get2048IconByLevel(level))
  self._board:InsertTile(tile)
  self:TileUpdatePosition(tile)
  tile:PlayTileCreateAnimation()
end

function Game2048Controller:FindFarthestPosition(originX, originY, dirVector)
  local nextCell, farthestX, farthestY
  local x = originX
  local y = originY
  while true do
    farthestX = x
    farthestY = y
    x = x + dirVector.x
    y = y + dirVector.y
    if not self._board:WithinBounds(x, y) then
      break
    end
    nextCell = self._board:CellContentDirect(x, y)
    if nextCell ~= nil then
      break
    end
  end
  return nextCell, farthestX, farthestY
end

function Game2048Controller:TileUpdatePosition(tile)
  tile.transform.localPosition = self._window2048:Get2048BottomCell(tile.x, tile.y).localPosition
end

function Game2048Controller:GetTilePosition(x, y)
  return self._window2048:Get2048BottomCell(x, y).localPosition
end

function Game2048Controller:PlayTilesAnimation()
  for x = 1, self._board.xCount do
    for y = 1, self._board.yCount do
      local tile = self._board:CellContentDirect(x, y)
      if tile ~= nil then
        tile:Play2048TileAnimation(self)
      end
    end
  end
end

function Game2048Controller:GetGame2048Score()
  return self._score ~ Key
end

function Game2048Controller:SetGame2048Score(score)
  self._score = score ~ Key
end

function Game2048Controller:EnterGame2048OverState()
  self._gameStarted = false
  local score = self:GetGame2048Score()
  if self.__isHistoryOpen then
    self.__HTGData:HTGCommonSettle(score)
    local newRecord = false
    if score > self._highestScore then
      self._highestScore = score
      newRecord = true
    end
    self._window2048:On2048GameOver(score, self._highestScore, newRecord)
    return
  end
  self._tinyGameNetwork:CS_ActivityGame_2048_Settle(self._actId, self._gameId, score, function()
    local newRecord = false
    if score > self._highestScore then
      self._highestScore = score
      newRecord = true
    end
    self._window2048:On2048GameOver(score, self._highestScore, newRecord)
  end)
end

function Game2048Controller:NormalExitGame2048()
  if self.__isHistoryOpen then
    return
  end
  local MainCamera = UIManager:GetMainCamera()
  if not IsNull(MainCamera) then
    MainCamera.enabled = true
  end
end

function Game2048Controller:Exit2048AndSettlement()
  self._gameStarted = false
  local score = self:GetGame2048Score()
  if self.__isHistoryOpen then
    self.__HTGData:HTGCommonSettle(score)
    return
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameData = actFrameCtrl:GetActivityFrameData(self._actId)
  if frameData ~= nil and frameData:IsInRuningState() then
    self._tinyGameNetwork:CS_ActivityGame_2048_Settle(self._actId, self._gameId, score, nil)
  end
  self:NormalExitGame2048()
end

function Game2048Controller:EnterGame2048Rank()
  local function LocalFunc_Enter()
    UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDay2048Rank, function(window)
      if window == nil then
        return
      end
      local mineGrade, allFriendData
      if self.__isHistoryOpen then
        local rankData = self.__HTGData:GetHTGRankData()
        allFriendData = rankData.allFriendData
        mineGrade = rankData.mineGrade
        window:SetBestScore(self.__HTGData:GetHTGHistoryHighScore())
      else
        mineGrade = self:__CreateMine2048Grade()
        allFriendData = self:__GetFriend2048Data() or {}
        table.insert(allFriendData, mineGrade)
        self:__SortRank2048Data(allFriendData)
        local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
        local hisBestScore = activityFrameCtrl:GetTinyGameHistoryHighScore(tinyGameEnum.eType.game2048)
        window:SetBestScore(hisBestScore)
      end
      window:Refresh2048RankingData(allFriendData, mineGrade)
    end)
  end
  
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend(LocalFunc_Enter)
  else
    LocalFunc_Enter()
  end
end

function Game2048Controller:__CreateMine2048Grade()
  if self.mineGrade == nil then
    self.mineGrade = {}
  end
  self.mineGrade.name = PlayerDataCenter:GetSelfName()
  self.mineGrade.uid = PlayerDataCenter:GetSelfId()
  self.mineGrade.score = self._highestScore
  return self.mineGrade
end

function Game2048Controller:__GetFriend2048Data()
  if not PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited() then
    return nil
  end
  local friendsData = PlayerDataCenter.friendDataCenter:GetFreindList()
  if friendsData == nil or #friendsData <= 0 then
    return nil
  end
  local all2048Grades = {}
  for _, v in ipairs(friendsData) do
    local eachFriendGrade = {}
    eachFriendGrade.name = v:GetUserName()
    eachFriendGrade.score = 0
    eachFriendGrade.uid = v:GetUserUID()
    local game2048Data = v:GetFriend2048Data()
    if game2048Data ~= nil and game2048Data.gameId == self._gameId then
      eachFriendGrade.score = game2048Data.score
    end
    table.insert(all2048Grades, eachFriendGrade)
  end
  return all2048Grades
end

function Game2048Controller:__SortRank2048Data(allFriendData)
  if 1 < #allFriendData then
    table.sort(allFriendData, function(a, b)
      if a.score == b.score then
        return a.uid < b.uid
      else
        return a.score > b.score
      end
    end)
  end
end

function Game2048Controller:Delete()
  if self.deleteCallback ~= nil then
    self.deleteCallback()
  end
  UpdateManager:RemoveUpdate(self._onUpdate)
  CS_LeanTouch.OnFingerSwipe("-", self.__on2048TouchSwipe)
end

return Game2048Controller
