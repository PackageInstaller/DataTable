local UINRandomBeforeBattle = class("UINRandomBeforeBattle", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local UINRandomBeforeBattlePassItem = require("Game.Battle.UI.UINRandomBeforeBattlePassItem")
local __randomType = {ambush = 1, stealth = 2}

function UINRandomBeforeBattle:OnInit()
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.judgeItemList = {}
  for key, value in pairs(__randomType) do
    self.judgeItemList[value] = {}
  end
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_rejudgeAmbush, self, self.RejudgeAmbush)
  UIUtil.AddButtonListener(self.ui.btn_rejudgeStealth, self, self.RejudgeSneak)
  UIUtil.AddButtonListener(self.ui.btn_stealth, self, self.StartSneak)
  self.focusPointNum = 0
  self.foucusPointItemId = ConfigData.game_config.RandomBeforeBatteleRejudgeItem
  self.focusPointNum = 0
  self.ambushPool = UIItemPool.New(UINRandomBeforeBattlePassItem, self.ui.ambushItem)
  self.ui.ambushItem:SetActive(false)
  self.stealthPool = UIItemPool.New(UINRandomBeforeBattlePassItem, self.ui.stealthItem)
  self.ui.stealthItem:SetActive(false)
  self.__updateData = BindCallback(self, self.UpdateData)
  MsgCenter:AddListener(eMsgEventId.OnBeforeBattleRandomDataChange, self.__updateData)
  self.__refreshFocusPoint = BindCallback(self, self.RefreshFocusPoint)
  MsgCenter:AddListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
end

function UINRandomBeforeBattle:InitData(roomData, focusLimit, focusPointNum)
  self.roomData = roomData
  self.roomPosition = roomData.position
  self:RefreshFocusPoint(focusPointNum, focusLimit)
end

function UINRandomBeforeBattle:UpdateData(ambush, stealth, position)
  if position ~= self.roomPosition then
    return
  end
  for key, value in pairs(__randomType) do
    self.judgeItemList[value] = {}
  end
  self.ui.btn_rejudgeAmbush.gameObject:SetActive(false)
  self.ui.btn_rejudgeStealth.gameObject:SetActive(false)
  self.ui.btn_stealth.gameObject:SetActive(false)
  if ambush ~= nil then
    self:ShowResult(__randomType.ambush, self:UnpackageData(ambush))
  end
  if stealth ~= nil then
    self:ShowResult(__randomType.stealth, self:UnpackageData(stealth))
  end
end

function UINRandomBeforeBattle:UnpackageData(data)
  local temp = data >> 16
  local judgeData = data & CommonUtil.UInt16Max
  local career = temp >> 4
  local judgeTimes = temp & 15
  local judgeResult = {}
  for i = 1, judgeTimes do
    judgeResult[i] = judgeData % 10
    judgeData = judgeData // 10
  end
  return career, judgeResult
end

function UINRandomBeforeBattle:ShowResult(type, career, judgeResult)
  local pool
  if type == __randomType.ambush then
    pool = self.ambushPool
  elseif type == __randomType.stealth then
    pool = self.stealthPool
  end
  pool:HideAll()
  for index, judgeNum in ipairs(judgeResult) do
    local isPass = 0 < judgeNum
    local item = pool:GetOne(true)
    item:InitPassItem(isPass)
    item:SetJudgeIcon(career)
    if judgeNum == 2 then
      item:LuckPass()
    end
    table.insert(self.judgeItemList[type], item)
  end
  self:RefreshJudgeBtn(type)
end

function UINRandomBeforeBattle:RefreshJudgeBtn(type)
  local isAllPass = true
  if #self.judgeItemList[type] == 0 then
    isAllPass = false
  else
    for index, item in ipairs(self.judgeItemList[type]) do
      if not item.isPass then
        isAllPass = false
        break
      end
    end
  end
  if isAllPass then
    if type == __randomType.ambush then
      self.ui.btn_rejudgeAmbush.gameObject:SetActive(false)
      ExplorationManager.epCtrl.battleCtrl:SetAmbush(true)
    elseif type == __randomType.stealth then
      self.ui.btn_stealth.gameObject:SetActive(true)
      self.ui.btn_rejudgeStealth.gameObject:SetActive(false)
    end
  elseif type == __randomType.ambush then
    ExplorationManager.epCtrl.battleCtrl:SetAmbush(false)
    if #self.judgeItemList[type] == 0 then
      self.ui.btn_rejudgeAmbush.gameObject:SetActive(false)
    else
      self.ui.btn_rejudgeAmbush.gameObject:SetActive(true)
    end
  elseif type == __randomType.stealth then
    self.ui.btn_stealth.gameObject:SetActive(false)
    if #self.judgeItemList[type] == 0 then
      self.ui.btn_rejudgeStealth.gameObject:SetActive(false)
    else
      self.ui.btn_rejudgeStealth.gameObject:SetActive(true)
    end
  end
end

function UINRandomBeforeBattle:RejudgeAmbush()
  if self.focusPointNum > 0 then
    self.explorationNetworkCtrl:CS_EXPLORATION_BATTLE_Focus(self.roomPosition, true, function(value)
      self.roomData:SetAmbushAndSneakData(value, self.roomData.stealthData)
    end)
  else
    cs_MessageCommon.ShowMessageTips("专注点数不足")
  end
end

function UINRandomBeforeBattle:RejudgeSneak()
  if self.focusPointNum > 0 then
    self.explorationNetworkCtrl:CS_EXPLORATION_BATTLE_Focus(self.roomPosition, false, function(value)
      self.roomData:SetAmbushAndSneakData(self.roomData.ambushData, value)
    end)
  else
    cs_MessageCommon.ShowMessageTips("专注点数不足")
  end
end

function UINRandomBeforeBattle:StartSneak()
  self.explorationNetworkCtrl:CS_EXPLORATION_BATTLE_Stealth(self.roomPosition)
  ExplorationManager.epCtrl.battleCtrl:SetSneak()
  self:Delete()
end

function UINRandomBeforeBattle:RefreshFocusPoint(itemNum, focusLimit)
  self.focusPointNum = itemNum
  self.ui.txt_focusPiontText:SetIndex(0, tostring(itemNum), tostring(focusLimit))
end

function UINRandomBeforeBattle:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnBeforeBattleRandomDataChange, self.__updateData)
  MsgCenter:RemoveListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
  base.OnDelete(self)
end

return UINRandomBeforeBattle
