local UINBattleDungeonPlotAutoStart = class("UINBattleDungeonPlotAutoStart", UIBaseNode)
local base = UIBaseNode

function UINBattleDungeonPlotAutoStart:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickTimesAdd)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.OnClickTimesAdd))
  UIUtil.AddButtonListener(self.ui.btn_Sub, self, self.OnClickTimesReduce)
  self.ui.btn_Sub.onPress:AddListener(BindCallback(self, self.OnClickTimesReduce))
  UIUtil.AddValueChangedListener(self.ui.slider, self, self.OnValueTimeChange)
  self.__OnBattleCountRefresh = BindCallback(self, self.OnBattleCountRefresh)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__OnBattleCountRefresh)
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
end

function UINBattleDungeonPlotAutoStart:InitPlotAutoStart(dungeonStageData, callback)
  self.dungeonStageData = dungeonStageData
  self.dungeonStageCfg = dungeonStageData:GetDungeonStageCfg()
  self.heroData = self.dungeonStageData.dungeonData:GetDungeonHeroData()
  if self.heroData == nil then
    error("HeroData is NIL")
    return
  end
  self.fragId = self.heroData.fragId
  self.callback = callback
  local ticketID = ConstGlobalItem.SKey
  local costItemCfg = ConfigData.item[ticketID]
  self.ui.img_HeroIcon.sprite = CRH:GetSpriteByItemId(self.fragId)
  self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite(ticketID)
  self.ui.tex_TicketName.text = LanguageUtil.GetLocaleText(costItemCfg.name)
  self:RefreshData()
  self:RefreshSlider()
  self:RefreshPlotCount()
end

function UINBattleDungeonPlotAutoStart:RefreshData()
  local index = table.indexof(self.dungeonStageCfg.cost_itemIds, ConstGlobalItem.SKey)
  self.sKeySingleCost = 0 < index and self.dungeonStageCfg.cost_itemNums[index] or 0
  if self.sKeySingleCost <= 0 then
    error("sKey cost Error")
    return
  end
  self.battleRemainTimes = nil
  local flag, autoLimitTimes = self.dungeonStageData.dungeonData:GetDungeonAutoBattleMaxLimit()
  if not flag then
    error("limit count is NIL")
    return
  end
  self.battleRemainTimes = autoLimitTimes
  self.sKeyCount = PlayerDataCenter:GetItemCount(ConstGlobalItem.SKey)
  self.maxTimes = math.min(self.battleRemainTimes, math.floor(self.sKeyCount / self.sKeySingleCost))
  if self.curTimes == nil then
    self.curTimes = self.maxTimes
  end
  self.curTimes = math.clamp(self.curTimes, 0, self.maxTimes)
end

function UINBattleDungeonPlotAutoStart:RefreshSlider()
  if (self.maxTimes or 0) < 1 then
    error("times is 0")
    return
  end
  self.inSetSlider = true
  if self.ui.slider.maxValue ~= self.maxTimes then
    self.ui.slider.maxValue = self.maxTimes
  end
  if self.ui.slider.minValue ~= 1 then
    self.ui.slider.minValue = 1
  end
  if self.ui.slider.value ~= self.curTimes then
    self.ui.slider.value = self.curTimes
  end
  self:RefreshUIShow()
  self.inSetSlider = false
end

function UINBattleDungeonPlotAutoStart:RefreshUIShow()
  if self.curTimes == nil then
    return
  end
  self.ui.tex_BattleTimes.text = tostring(self.curTimes)
  self.ui.tex_SKey_Before.text = tostring(self.sKeyCount)
  self.ui.tex_SKey_After.text = tostring(self.sKeyCount - self.sKeySingleCost * self.curTimes)
  self.ui.tex_remain_Before.text = tostring(self.battleRemainTimes)
  self.ui.tex_remain_After.text = tostring(self.battleRemainTimes - self.curTimes)
end

function UINBattleDungeonPlotAutoStart:RefreshPlotCount()
  if self.heroData == nil then
    return
  end
  if self.heroData:IsFullRank() then
    self.ui.tex_chip_count:SetIndex(1)
    return
  end
  local needCount = self.heroData:StarNeedFrag()
  local existCount = PlayerDataCenter:GetItemCount(self.fragId)
  self.ui.tex_chip_count:SetIndex(0, tostring(existCount), tostring(needCount))
end

function UINBattleDungeonPlotAutoStart:OnClickTimesAdd()
  if self.curTimes >= self.ui.slider.maxValue then
    return
  end
  self.ui.slider.value = self.curTimes + 1
end

function UINBattleDungeonPlotAutoStart:OnClickTimesReduce()
  if self.curTimes <= self.ui.slider.minValue then
    return
  end
  self.ui.slider.value = self.curTimes - 1
end

function UINBattleDungeonPlotAutoStart:OnValueTimeChange(value)
  if self.inSetSlider then
    return
  end
  self.curTimes = math.floor(value)
  self:RefreshUIShow()
end

function UINBattleDungeonPlotAutoStart:OnClickConfirm()
  if self.callback ~= nil then
    self.callback(self.curTimes)
  end
end

function UINBattleDungeonPlotAutoStart:OnItemRefresh(itemUpdate)
  if itemUpdate[ConstGlobalItem.SKey] ~= nil then
    self:RefreshData()
    self:RefreshSlider()
  end
  if self.fragId ~= nil and itemUpdate[self.fragId] ~= nil then
    self:RefreshPlotCount()
  end
end

function UINBattleDungeonPlotAutoStart:OnBattleCountRefresh()
  self:RefreshData()
  self:RefreshSlider()
end

function UINBattleDungeonPlotAutoStart:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__OnBattleCountRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  base.OnDelete(self)
end

return UINBattleDungeonPlotAutoStart
