local UINBattleDungeonAutoStart = class("UINBattleDungeonAutoStart", UIBaseNode)
local base = UIBaseNode
local UINBtDgAtMid = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.Mid.UINBtDgAtMid")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local cs_MessageCommon = CS.MessageCommon

function UINBattleDungeonAutoStart:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickConfirm)
  UIUtil.AddValueChangedListener(self.ui.slider, self, self.OnValueTimesChange)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickTimesAdd)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.OnClickTimesAdd))
  UIUtil.AddButtonListener(self.ui.btn_Sub, self, self.OnClickTimesReduce)
  self.ui.btn_Sub.onPress:AddListener(BindCallback(self, self.OnClickTimesReduce))
  UIUtil.AddButtonListener(self.ui.btn_QuickBattleTip, self, self._OnClickQuickBattleTip)
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  self.ui.quickBattle:SetActive(false)
  self.ui.tex_BtnName:SetIndex(0)
end

function UINBattleDungeonAutoStart:InitAutoStart(dungeonStageData, callback)
  self._dungeonStageData = dungeonStageData
  self.dungeonStageCfg = dungeonStageData:GetDungeonStageCfg()
  self.callback = callback
  local ticketID = ConstGlobalItem.SKey
  local costItemCfg = ConfigData.item[ticketID]
  self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite(ticketID)
  self.ui.tex_TicketName.text = LanguageUtil.GetLocaleText(costItemCfg.name)
  self:_InitMid()
  self:RefreshData()
  self:RefreshSlider()
  self:_InitQuickBattle()
  self:_UpdBattleBtnText()
end

function UINBattleDungeonAutoStart:_InitMid()
  local dungeonData = self._dungeonStageData:GetDgStageDungeonData()
  local dungeonTypeData = dungeonData:GetDgDgTypeData()
  if dungeonTypeData:GetDungeonType() ~= eDungeonEnum.eDungeonType.ATHDungeon then
    return
  end
  self._UpdCurTimesCheckFunc = self._UpdCurTimesCheckFunc or BindCallback(self, self._UpdCurTimesCheck)
  local midNode = UINBtDgAtMid.New()
  midNode:Init(self.ui.mid)
  midNode:Show()
  midNode:InitBtDgAtMid(dungeonData, self._UpdCurTimesCheckFunc)
  self._midNode = midNode
end

function UINBattleDungeonAutoStart:_InitQuickBattle()
  local quickBattleOpen = self._dungeonStageData:IsDgStageQuickBattleOpen()
  self.ui.quickBattle:SetActive(quickBattleOpen)
  if not quickBattleOpen then
    return
  end
  if self._switchQuickBattleTog == nil then
    self._switchQuickBattleTog = UINCommonSwitchToggle.New()
    self._switchQuickBattleTog:Init(self.ui.tog_SwitchQuickBattle)
    self._switchQuickBattleFunc = BindCallback(self, self._OnClickSwitchQuickBattle)
    self._switchQuickBattleTog:CommonSwitchTogAutoSetValue(false)
  end
  self._isQuickBattle = self._dungeonStageData:IsDgStageQuickBattleUnlock()
  self._switchQuickBattleTog:InitCommonSwitchToggle(self._isQuickBattle, self._switchQuickBattleFunc)
end

function UINBattleDungeonAutoStart:SetBattleAutoStartQuick(quickBattleFunc)
  self._quickBattleFunc = quickBattleFunc
end

function UINBattleDungeonAutoStart:_OnClickSwitchQuickBattle(isOn)
  if not self._dungeonStageData:IsDgStageQuickBattleUnlock() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2906))
    return
  end
  self._isQuickBattle = isOn
  self._switchQuickBattleTog:SetCommonSwitchToggleValue(isOn)
  self:_UpdBattleBtnText()
  if isOn then
    self:_UpdCurTimesCheck()
  end
end

function UINBattleDungeonAutoStart:_UpdCurTimesCheck()
  self:_SetCurTimes(self.curTimes)
end

function UINBattleDungeonAutoStart:_UpdBattleBtnText()
  self.ui.tex_BtnName:SetIndex(self._isQuickBattle and 1 or 0)
end

function UINBattleDungeonAutoStart:RefreshData()
  self.sKeyCount = PlayerDataCenter:GetItemCount(ConstGlobalItem.SKey)
  local index = table.indexof(self.dungeonStageCfg.cost_itemIds, ConstGlobalItem.SKey)
  self.singleCost = 0 < index and self.dungeonStageCfg.cost_itemNums[index] or 0
  if self.singleCost > 0 then
    self.maxTimes = math.floor(self.sKeyCount / self.singleCost)
    local curTimes = self.curTimes
    curTimes = curTimes or self.maxTimes
    curTimes = curTimes <= self.maxTimes and curTimes or self.maxTimes
    self:_SetCurTimes(curTimes)
  end
end

function UINBattleDungeonAutoStart:RefreshSlider()
  if (self.maxTimes or 0) < 1 then
    self.ui.silderNode:SetActive(false)
    self:RefreshAutoStartUI()
    return
  end
  local valueChange = false
  if self.ui.slider.maxValue ~= self.maxTimes then
    self.ui.slider.maxValue = self.maxTimes
  end
  if self.ui.slider.minValue ~= 1 then
    self.ui.slider.minValue = 1
  end
  if self.ui.slider.value ~= self.curTimes then
    self.ui.slider.value = self.curTimes
    valueChange = true
  end
  if not valueChange then
    self:RefreshAutoStartUI()
  end
end

function UINBattleDungeonAutoStart:RefreshAutoStartUI()
  self.ui.tex_BattleTimes.text = tostring(math.floor(self.curTimes))
  self.ui.tex_Before.text = tostring(self.sKeyCount)
  self.ui.tex_After.text = tostring(math.floor(self.sKeyCount - self.curTimes * self.singleCost))
end

function UINBattleDungeonAutoStart:OnItemRefresh(itemUpdate)
  if itemUpdate[ConstGlobalItem.SKey] == nil then
    return
  end
  self:RefreshData()
  self:RefreshSlider()
end

function UINBattleDungeonAutoStart:OnClickTimesAdd()
  if self.curTimes >= self.maxTimes then
    return
  end
  self:_SetCurTimes(self.curTimes + 1)
  self:RefreshSlider()
end

function UINBattleDungeonAutoStart:OnClickTimesReduce()
  if self.curTimes <= 1 then
    return
  end
  self:_SetCurTimes(self.curTimes - 1)
  self:RefreshSlider()
end

function UINBattleDungeonAutoStart:OnValueTimesChange(value)
  self:_SetCurTimes(math.floor(value))
  self:RefreshAutoStartUI()
end

function UINBattleDungeonAutoStart:_SetCurTimes(value)
  if self._midNode ~= nil and self._isQuickBattle then
    value = self._midNode:CheckBtDgAtMidAutoNum(value)
  end
  self.curTimes = value
  self:RefreshSlider()
  if self._midNode ~= nil then
    self._midNode:UpdBtDgAtMidTipBuffNum(self.curTimes)
  end
end

function UINBattleDungeonAutoStart:OnClickConfirm()
  if self._isQuickBattle and self._quickBattleFunc then
    local activateDrop = false
    local autoDecoAth = false
    if self._midNode ~= nil then
      local function startQuickBattle()
        activateDrop, autoDecoAth = self._midNode:GetBtDgAtMidValue()
        
        self._quickBattleFunc(self.curTimes, activateDrop, autoDecoAth)
      end
      
      self._midNode:CheckBtDgAtMidBuffNumOpen(startQuickBattle)
      return
    end
    self._quickBattleFunc(self.curTimes, activateDrop, autoDecoAth)
    return
  end
  if self.callback == nil then
    return
  end
  self.callback(self.curTimes)
end

function UINBattleDungeonAutoStart:_OnClickQuickBattleTip()
  UIManager:CreateWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(21)
  end)
end

function UINBattleDungeonAutoStart:OnHide()
  if self._midNode ~= nil then
    self._midNode:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  base.OnHide(self)
end

return UINBattleDungeonAutoStart
