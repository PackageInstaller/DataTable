local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local PlayerBoardData = class("PlayerBoardData")
local PlayerHandbookData = PlayerData.Handbook
local LocalData = require("GameCore.Data.LocalData")
local max_select_count = 5

function PlayerBoardData:Init()
  self.tbSelectBoardList = {}
  self.tbTmpSelectBoardList = {}
  self.tbTmpSelectSkinList = {}
  self.nBoardPanelShowId = 0
  self.nBoardPanelCGType = 0
  self.nCurBoardIdx = 1
end

function PlayerBoardData:CacheBoardData(mapMagData)
  local nLocalIdx = LocalData.GetPlayerLocalData("MainBoardIndex")
  if nil == nLocalIdx then
    LocalData.SetPlayerLocalData("MainBoardIndex", "1")
  end
  self.nCurBoardIdx = tonumber(LocalData.GetPlayerLocalData("MainBoardIndex"))
  self.tbSelectBoardList = mapMagData
  self:ResetBoardList()
end

function PlayerBoardData:GetSelectBoardData()
  return self.tbSelectBoardList
end

function PlayerBoardData:CheckSelectBoardChar()
  for _, nId in ipairs(self.tbSelectBoardList) do
    local handbookData = PlayerHandbookData:GetHandbookDataById(nId)
    if handbookData ~= nil and handbookData:GetType() == GameEnum.handbookType.SKIN then
      return true
    end
  end
  return false
end

function PlayerBoardData:GetCurBoardData()
  if #self.tbSelectBoardList < self.nCurBoardIdx then
    self:ResetBoardIndex()
  end
  if self.tbSelectBoardList[self.nCurBoardIdx] ~= nil then
    local nId = self.tbSelectBoardList[self.nCurBoardIdx]
    if nil ~= nId then
      local handbookData = PlayerHandbookData:GetHandbookDataById(nId)
      return handbookData
    end
  end
end

function PlayerBoardData:GetCurBoardCharID()
  local curBoardData = self:GetCurBoardData()
  if nil ~= curBoardData and curBoardData:GetType() == GameEnum.handbookType.SKIN then
    return curBoardData:GetCharId()
  end
end

function PlayerBoardData:GetTempBoardData()
  if self.tbSelectBoardList[self.nCurBoardIdx] ~= nil then
    local nId = self.tbSelectBoardList[self.nCurBoardIdx]
    if nil ~= nId then
      return PlayerHandbookData:GetTempHandbookDataById(nId)
    end
  end
end

function PlayerBoardData:ChangeNextBoard()
  if #self.tbSelectBoardList <= 1 then
    return false
  end
  self.nCurBoardIdx = self.nCurBoardIdx + 1
  if self.nCurBoardIdx > #self.tbSelectBoardList then
    self.nCurBoardIdx = 1
  end
  LocalData.SetPlayerLocalData("MainBoardIndex", tostring(self.nCurBoardIdx))
  return true
end

function PlayerBoardData:ChangeLastBoard()
  if #self.tbSelectBoardList <= 1 then
    return false
  end
  self.nCurBoardIdx = self.nCurBoardIdx - 1
  if self.nCurBoardIdx <= 0 then
    self.nCurBoardIdx = #self.tbSelectBoardList
  end
  LocalData.SetPlayerLocalData("MainBoardIndex", tostring(self.nCurBoardIdx))
  return true
end

function PlayerBoardData:ResetBoardIndex()
  self.nCurBoardIdx = 1
  LocalData.SetPlayerLocalData("MainBoardIndex", tostring(self.nCurBoardIdx))
end

function PlayerBoardData:GetMaxSelectCount()
  return max_select_count
end

function PlayerBoardData:GetBoardDragThreshold()
  return ConfigTable.GetConfigNumber("MainViewDragThreshold")
end

function PlayerBoardData:ResetBoardList()
  self.tbTmpSelectBoardList = clone(self.tbSelectBoardList)
end

function PlayerBoardData:SetTmpBoardList(tbList)
  self.tbTmpSelectBoardList = tbList
end

function PlayerBoardData:CheckInTmpBoardList(nHandbookId)
  for _, v in pairs(self.tbTmpSelectBoardList) do
    if v == nHandbookId then
      return true
    end
  end
  return false
end

function PlayerBoardData:GetTmpBoardIndexById(nHandbookId)
  for k, v in pairs(self.tbTmpSelectBoardList) do
    if v == nHandbookId then
      return k
    end
  end
  return 0
end

function PlayerBoardData:InsertTmpBoard(nHandbookId)
  if #self.tbTmpSelectBoardList >= max_select_count then
    return false
  end
  table.insert(self.tbTmpSelectBoardList, nHandbookId)
  return true
end

function PlayerBoardData:RemoveTmpBoard(nHandbookId)
  local removeIdx = 0
  for k, v in pairs(self.tbTmpSelectBoardList) do
    if v == nHandbookId then
      removeIdx = k
      break
    end
  end
  if 0 ~= removeIdx then
    table.remove(self.tbTmpSelectBoardList, removeIdx)
  end
end

function PlayerBoardData:ChangeTmpCharSkin(nCharId, nHandbookId)
  self:SetTmpSkinSelect(nCharId, nHandbookId)
  for k, v in pairs(self.tbTmpSelectBoardList) do
    local handbookData = PlayerHandbookData:GetHandbookDataById(v)
    if nil ~= handbookData and handbookData:GetType() == GameEnum.handbookType.SKIN and handbookData:GetCharId() == nCharId then
      self.tbTmpSelectBoardList[k] = nHandbookId
      break
    end
  end
end

function PlayerBoardData:GetTmpBoardList()
  return self.tbTmpSelectBoardList
end

function PlayerBoardData:SetTmpSkinSelect(nCharId, handbookId)
  self.tbTmpSelectSkinList[nCharId] = handbookId
end

function PlayerBoardData:ResetTmpSkinSelect()
  self.tbTmpSelectSkinList = {}
end

function PlayerBoardData:GetTmpSkinSelect()
  return self.tbTmpSelectSkinList
end

function PlayerBoardData:SetBoardPanelSelectId(nId)
  self.nBoardPanelShowId = nId
end

function PlayerBoardData:GetBoardPanelSelectId()
  return self.nBoardPanelShowId
end

function PlayerBoardData:SetBoardPanelL2DType(nType)
  self.nBoardPanelCGType = nType
end

function PlayerBoardData:GetBoardPanelL2DType()
  return self.nBoardPanelCGType
end

function PlayerBoardData:SendBoardSet(callback)
  if nil ~= self.tbTmpSelectBoardList and nil ~= next(self.tbTmpSelectBoardList) then
    local sendBoardList = {}
    for _, v in pairs(self.tbTmpSelectBoardList) do
      if nil ~= v then
        table.insert(sendBoardList, v)
      end
    end
    local bChange = false
    if #sendBoardList ~= #self.tbSelectBoardList then
      bChange = true
    else
      for k, v in ipairs(sendBoardList) do
        if nil == self.tbSelectBoardList[k] or self.tbSelectBoardList[k] ~= v then
          bChange = true
          break
        end
      end
    end
    
    local function callbackFunc()
      local nSelectId = self:GetBoardPanelSelectId()
      for k, v in ipairs(self.tbSelectBoardList) do
        if v == nSelectId then
          self.nCurBoardIdx = k
          break
        end
      end
      if nil ~= callback then
        callback()
      end
    end
    
    if bChange then
      local msgData = {Ids = sendBoardList}
      HttpNetHandler.SendMsg(NetMsgId.Id.player_board_set_req, msgData, nil, callbackFunc)
    else
      callbackFunc()
    end
  end
end

function PlayerBoardData:SetBoardSuccess()
  self.tbSelectBoardList = {}
  for _, v in pairs(self.tbTmpSelectBoardList) do
    if nil ~= v then
      table.insert(self.tbSelectBoardList, v)
    end
  end
  self:ResetBoardList()
  self:ResetBoardIndex()
end

function PlayerBoardData:SetBoardFail()
  self:ResetBoardList()
end

function PlayerBoardData:GetUsableBoardCharId()
  local curBoardData = self:GetCurBoardData()
  if curBoardData:GetType() == GameEnum.handbookType.SKIN then
    return curBoardData:GetCharId(), curBoardData:GetSkinId()
  end
  local tbBoardChar = {}
  for _, nId in ipairs(self.tbSelectBoardList) do
    local handbookData = PlayerHandbookData:GetHandbookDataById(nId)
    if handbookData:GetType() == GameEnum.handbookType.SKIN then
      table.insert(tbBoardChar, handbookData)
    end
  end
  if 0 < #tbBoardChar then
    local nRandomIndex = math.random(1, #tbBoardChar)
    local boardData = tbBoardChar[nRandomIndex]
    if boardData ~= nil then
      return boardData:GetCharId(), boardData:GetSkinId()
    end
  else
    local ownedChar = PlayerData.Char:GetDataForCharList()
    local tbAllChar = {}
    for _, v in pairs(ownedChar) do
      local mapCfg = ConfigTable.GetData_Character(v.nId)
      if mapCfg ~= nil and mapCfg.Visible then
        table.insert(tbAllChar, v)
      end
    end
    local nRandomIndex = math.random(1, #tbAllChar)
    local charData = tbAllChar[nRandomIndex]
    if charData ~= nil then
      return charData.nId, PlayerData.Char:GetCharUsedSkinId(charData.nId)
    end
  end
end

function PlayerBoardData:GetNPCDefaultSkinId(nNPCId)
  local tbNPCCfg = ConfigTable.GetData("BoardNPC", nNPCId)
  if nil == tbNPCCfg then
    printError("读取BoardNPC表格失败！！！NPCId = " .. nNPCId)
    return
  end
  return tbNPCCfg.DefaultSkinId
end

function PlayerBoardData:GetNPCUsingSkinId(nNPCId)
  return self:GetNPCDefaultSkinId(nNPCId)
end

function PlayerBoardData:ChooseBoardList()
  local tbHandBook = PlayerData.Handbook:GetAllHandbookData()
  local tbAllCharHandBook = {}
  for _, v in pairs(tbHandBook) do
    if v:GetType() == GameEnum.handbookType.SKIN and v:CheckUnlock() then
      table.insert(tbAllCharHandBook, v)
    end
  end
  local remaining = #tbAllCharHandBook
  local tbResult = {}
  for i = 1, math.min(remaining, 5) do
    local index = math.random(1, remaining)
    table.insert(tbResult, tbAllCharHandBook[index]:GetId())
    tbAllCharHandBook[index] = tbAllCharHandBook[remaining]
    remaining = remaining - 1
  end
  local msgData = {Ids = tbResult}
  self.tbTmpSelectBoardList = tbResult
  
  local function callbackFunc()
    local nSelectId = self:GetBoardPanelSelectId()
    for k, v in ipairs(self.tbSelectBoardList) do
      if v == nSelectId then
        self.nCurBoardIdx = k
        break
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_board_set_req, msgData, nil, callbackFunc)
end

return PlayerBoardData
