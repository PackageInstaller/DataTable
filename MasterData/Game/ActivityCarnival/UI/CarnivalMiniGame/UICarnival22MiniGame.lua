local UICarnival22MiniGame = class("UICarnival22MiniGame", UIBaseWindow)
local base = UIBaseWindow
local UINCarnival22Ball = require("Game.ActivityCarnival.UI.CarnivalMiniGame.UINCarnival22Ball")
local UINCarnival22BallEft = require("Game.ActivityCarnival.UI.CarnivalMiniGame.UINCarnival22BallEft")
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_UnityEngine_Time = CS.UnityEngine.Time
local util = require("XLua.Common.xlua_util")
local cs_MessageCommon = CS.MessageCommon
local UINCarnivalRank = require("Game.ActivityCarnival.UI.CarnivalMiniGame.UINCarnivalRank")
local BORN_INTERVAL = 0.5
local BORN_MAXlEVEL = 5

function UICarnival22MiniGame:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseMini, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickGameBack)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.OnClickPlayGame)
  UIUtil.AddButtonListener(self.ui.btn_PlayAgain, self, self.OnClickPlayGame)
  self._ballPools = {}
  self._maxLevel = #self.ui.balls
  for i, obj in ipairs(self.ui.balls) do
    self._ballPools[i] = UIItemPool.New(UINCarnival22Ball, obj)
  end
  self._ballEftPool = UIItemPool.New(UINCarnival22BallEft, self.ui.uI_Carnival22MiniGame_click)
  self.ui.uI_Carnival22MiniGame_click:SetActive(false)
  local collider2DTrigger = CS.ColliderEventListener.Get(self.ui.line)
  collider2DTrigger:TriggerEnter2DEvent("+", BindCallback(self, self.__VirLineEnter))
  collider2DTrigger:TriggerExit2DEvent("+", BindCallback(self, self.__VirLineExit))
  self.__OnGestureStartEvent = BindCallback(self, self.__OnGestureStart)
  self.__OnGestureEvent = BindCallback(self, self.__OnGesture)
  self.__OnGestureEndEvent = BindCallback(self, self.__OnGestureEnd)
  CS_LeanTouch.OnFingerDown("+", self.__OnGestureStartEvent)
  CS_LeanTouch.OnGesture("+", self.__OnGestureEvent)
  CS_LeanTouch.OnFingerUp("+", self.__OnGestureEndEvent)
  self.__ItemCollidingEvent = BindCallback(self, self.__ItemColliding)
  self.__IEDelayBornNewItemEvent = BindCallback(self, self.__IEDelayBornNewItem)
  self._rankNode = UINCarnivalRank.New()
  self._rankNode:Init(self.ui.rank)
  self._rankNode:Hide()
  self._rankNode:BindCarnivalRankFunc(function()
    self._isPause = false
  end)
  self._isPause = false
end

function UICarnival22MiniGame:InitCarnivalMiniGame(carnivalData, isHistoryOpen, HTGData)
  self._carnivalData = carnivalData
  self._gameData = self._carnivalData:GetCarnivalTinyGame()
  self.__isHistoryOpen = isHistoryOpen
  self.__HTGData = HTGData
  self:__RefreshHistoryScore()
end

function UICarnival22MiniGame:__OnStartGame()
  AudioManager:PlayAudioById(1225)
  self._isPlaying = true
  self._score = 0
  self.ui.tex_Score.text = tostring(self._score)
  self.ui.gameOver:SetActive(false)
  self.ui.gameStart:SetActive(false)
  self.ui.play:SetActive(true)
  self:__Reset()
  self:__TryGenItem()
  self._dowmTimerId = TimerManager:StartTimer(1, self.__CheckFail, self)
end

function UICarnival22MiniGame:__OnEndGame()
  self._isPlaying = false
  self:__Reset()
  self.ui.gameOver:SetActive(true)
  local isNewHistory = self._score > self._gameData:GetWatermeHistoryScore()
  self.ui.obj_New:SetActive(isNewHistory)
  self.ui.tex_GameScore.text = tostring(self._score)
  self._gameData:UploadWatermelonScore(self._score, function()
    if not IsNull(self.transform) then
      self:__RefreshHistoryScore()
    end
  end)
end

function UICarnival22MiniGame:__Reset()
  for i, poll in pairs(self._ballPools) do
    poll:HideAll()
  end
  for i, eft in ipairs(self._ballEftPool.listItem) do
    eft.transform:SetParent(self.ui.eftPool)
  end
  self._ballEftPool:HideAll()
  self._itemGoDic = {}
  self._collisionLineDic = {}
  self._collisioLineCount = 0
  self._waitItem = nil
  self._nextBornTime = 0
  if self._dowmTimerId ~= nil then
    TimerManager:StopTimer(self._dowmTimerId)
    self._dowmTimerId = nil
  end
  if self._ieDelayBornCo ~= nil then
    GR.StopCoroutine(self._ieDelayBornCo)
    self._ieDelayBornCo = nil
  end
  self._ballToEftDic = {}
end

function UICarnival22MiniGame:__TryGenItem()
  if self._waitItem ~= nil then
    return
  end
  local index = math.random(1, BORN_MAXlEVEL)
  self._waitItem = self:__CreateNewItem(index, Vector3.zero)
  self._waitItem:SetRigidBody(false)
end

function UICarnival22MiniGame:__OnGestureStart(finger)
  if self._isPause then
    return
  end
  if self._waitItem == nil then
    return
  end
  local leftX, rightX = self:__GetWallBorder()
  local pos = TransitionScreenPoint(UIManager:GetUICamera(), self._waitItem.gameObject, finger.ScreenPosition)
  if rightX < pos.x or leftX > pos.x then
    return
  end
  self._touchIndex = finger.Index
  local itemRadius = self._waitItem:GetColliderRadius()
  if self._dragLimitX == nil then
    self._dragLimitX = {}
  end
  self._dragLimitX.left = leftX + itemRadius
  self._dragLimitX.right = rightX - itemRadius
end

function UICarnival22MiniGame:__OnGesture(fingerList)
  if self._waitItem == nil then
    return
  end
  local finger
  for i = 0, fingerList.Count - 1 do
    local item = fingerList[i]
    if item.Index == self._touchIndex then
      finger = item
      break
    end
  end
  if finger == nil then
    return
  end
  local pos = TransitionScreenPoint(UIManager:GetUICamera(), self._waitItem.gameObject, finger.ScreenPosition)
  pos.x = math.clamp(pos.x, self._dragLimitX.left, self._dragLimitX.right)
  pos.y = self._waitItem.transform.localPosition.y
  pos.z = self._waitItem.transform.localPosition.z
  self._waitItem.transform.localPosition = pos
end

function UICarnival22MiniGame:__OnGestureEnd(finger)
  if self._touchIndex ~= finger.Index then
    return
  end
  self._touchIndex = nil
  if self._waitItem == nil then
    return
  end
  AudioManager:PlayAudioById(1226)
  self._waitItem:SetRigidBody(true)
  self._waitItem = nil
  self._nextBornTime = CS_UnityEngine_Time.time + BORN_INTERVAL
  self._ieDelayBornCo = GR.StartCoroutine(util.cs_generator(self.__IEDelayBornNewItemEvent))
end

function UICarnival22MiniGame:__VirLineEnter(other)
  local ball = self._itemGoDic[other.gameObject]
  if ball == nil or self._collisionLineDic[ball] ~= nil then
    return
  end
  self._collisionLineDic[ball] = CS_UnityEngine_Time.time
  self._collisioLineCount = self._collisioLineCount + 1
end

function UICarnival22MiniGame:__VirLineExit(other)
  local ball = self._itemGoDic[other.gameObject]
  if ball == nil then
    return
  end
  if self._collisionLineDic[ball] == nil then
    return
  end
  self._collisionLineDic[ball] = nil
  self._collisioLineCount = self._collisioLineCount - 1
end

function UICarnival22MiniGame:__ItemColliding(item, other)
  if self._itemGoDic[item.gameObject] == nil then
    return
  end
  local otherItem = self._itemGoDic[other.gameObject]
  if otherItem == nil then
    return
  end
  local nowId = item:GetWaltermelonType()
  if nowId >= self._maxLevel or nowId ~= otherItem:GetWaltermelonType() then
    return
  end
  local nowPos
  local itemSpeed = item:GetRigidSpeed()
  local otherSpeed = otherItem:GetRigidSpeed()
  if itemSpeed.sqrMagnitude < otherSpeed.sqrMagnitude then
    nowPos = item.transform.localPosition
  else
    nowPos = otherItem.transform.localPosition
  end
  nowPos.y = nowPos.y - item:GetColliderRadius()
  self:__CleatOldItem(item)
  self:__CleatOldItem(otherItem)
  local newItem = self:__CreateNewItem(nowId + 1, nowPos)
  newItem:SetRigidBody(true)
  AudioManager:PlayAudioById(1227)
  self:__ShowCollidingEft(nowId + 1, newItem)
  self._score = self._score + self._gameData:GetWatermeScore(nowId + 1)
  self.ui.tex_Score.text = tostring(self._score)
end

function UICarnival22MiniGame:__CleatOldItem(item)
  self:__VirLineExit(item.gameObject)
  self._itemGoDic[item.gameObject] = nil
  local pool = self._ballPools[item:GetWaltermelonType()]
  pool:HideOne(item)
  local eft = self._ballToEftDic[item]
  if eft == nil then
    return
  end
  self._ballToEftDic[item] = nil
  if eft.transform:IsChildOf(item.transform) then
    self:__CycleCollidingEft(eft)
  end
end

function UICarnival22MiniGame:__CreateNewItem(waltermelonType, pos)
  local newItem = self._ballPools[waltermelonType]:GetOne()
  newItem.transform:SetParent(self.ui.imgHolder.transform)
  newItem:InitWaltermelonItem(waltermelonType, self.__ItemCollidingEvent)
  self._itemGoDic[newItem.gameObject] = newItem
  pos.y = pos.y + newItem:GetColliderRadius()
  newItem.transform.localPosition = pos
  return newItem
end

function UICarnival22MiniGame:__CheckFail()
  if self._waitDelEfts == nil then
    self._waitDelEfts = {}
  else
    table.removeall(self._waitDelEfts)
  end
  for i, eft in ipairs(self._ballEftPool.listItem) do
    if eft:IsBallEftFnish() then
      table.insert(self._waitDelEfts, eft)
    end
  end
  for i, eft in ipairs(self._waitDelEfts) do
    self:__CycleCollidingEft(eft)
  end
  if self._collisioLineCount == 0 then
    return
  end
  for item, _ in pairs(self._collisionLineDic) do
    if item:GetRigidSpeed().sqrMagnitude >= 0.001 then
      return
    end
  end
  self:__OnEndGame()
end

function UICarnival22MiniGame:__IEDelayBornNewItem()
  while CS_UnityEngine_Time.time < self._nextBornTime do
    coroutine.yield(nil)
  end
  self:__TryGenItem()
  self._ieDelayBornCo = nil
end

function UICarnival22MiniGame:__GetWallBorder()
  if self._leftWallLimitX == nil then
    self._leftWallLimitX = self.ui.wall_left.transform.localPosition.x - self.ui.wall_left.rect.x
  end
  if self._rightWallLimitX == nil then
    self._rightWallLimitX = self.ui.wall_right.transform.localPosition.x + self.ui.wall_right.rect.x
  end
  return self._leftWallLimitX, self._rightWallLimitX
end

function UICarnival22MiniGame:__ShowCollidingEft(index, ball)
  local item = self._ballEftPool:GetOne()
  item:InitBallEft(index)
  item.transform:SetParent(ball.transform)
  item.transform.anchoredPosition = Vector2.zero
  self._ballToEftDic[ball] = item
end

function UICarnival22MiniGame:__CycleCollidingEft(item)
  self._ballEftPool:HideOne(item)
  item.transform:SetParent(self.ui.eftPool)
end

function UICarnival22MiniGame:__RefreshHistoryScore()
  local history = self._gameData:GetWatermeHistoryScore()
  self.ui.tex_HighScoure.text = tostring(history)
end

function UICarnival22MiniGame:OnClickPlayGame()
  self:__OnStartGame()
end

function UICarnival22MiniGame:OnClickRank()
  self._isPause = true
  
  local function LocalFunc_Enter()
    local allFriend, mine = self._gameData:GetWatermeRank()
    self._rankNode:Show()
    self._rankNode:InitCarnivalRank(allFriend, mine)
    if self.__isHistoryOpen then
      self._rankNode:SetBestScore(self.__HTGData:GetHTGHistoryHighScore())
    end
  end
  
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend(LocalFunc_Enter)
  else
    LocalFunc_Enter()
  end
end

function UICarnival22MiniGame:OnClickGameBack()
  if not self._isPlaying then
    UIUtil.OnClickBackByUiTab(self)
    return
  end
  self._isPause = true
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7200), function()
    self._gameData:UploadWatermelonScore(self._score)
    UIUtil.OnClickBackByUiTab(self)
  end, function()
    self._isPause = false
  end)
end

function UICarnival22MiniGame:OnCloseMini()
  self:Delete()
end

function UICarnival22MiniGame:OnDelete()
  base.OnDelete(self)
  if self._dowmTimerId ~= nil then
    TimerManager:StopTimer(self._dowmTimerId)
    self._dowmTimerId = nil
  end
  if self._ieDelayBornCo ~= nil then
    GR.StopCoroutine(self._ieDelayBornCo)
    self._ieDelayBornCo = nil
  end
  CS_LeanTouch.OnFingerDown("-", self.__OnGestureStartEvent)
  CS_LeanTouch.OnGesture("-", self.__OnGestureEvent)
  CS_LeanTouch.OnFingerUp("-", self.__OnGestureEndEvent)
end

return UICarnival22MiniGame
