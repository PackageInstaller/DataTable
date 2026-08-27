local UINAthOptimal = class("UINAthOptimal", UIBaseNode)
local base = UIBaseNode
local UINItemWithCost = require("Game.Arithmetic.Strengthen.UINItemWithCost")
local UINAthOptAffixItem = require("Game.Arithmetic.Strengthen.UINAthOptAffixItem")
local UINAthEmptyAffix = require("Game.Arithmetic.Strengthen.UINAthEmptyAffix")
local cs_MessageCommon = CS.MessageCommon

function UINAthOptimal:ctor(affixToggleGroup)
  self.affixToggleGroup = affixToggleGroup
end

function UINAthOptimal:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Optimiz, self, self.OnClickOptimalBtn)
  UIUtil.AddValueChangedListener(self.ui.slider, self, self.OnSliderValueChange)
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  self.__onSelectAffixEvent = BindCallback(self, self.SeletAffix)
  self.__checkOptEnableEvent = BindCallback(self, self.CheckOptEnable)
  CS.EventTriggerListener.Get(self.ui.slider.gameObject):onClick("+", function()
    if not self.enableOpt then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(279))
    end
  end)
  self.ui.itemWithCount:SetActive(false)
  self.consumeItemPool = UIItemPool.New(UINItemWithCost, self.ui.itemWithCount)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.ui.emptyAffixItem:SetActive(false)
  self.emptyAffixPool = UIItemPool.New(UINAthEmptyAffix, self.ui.emptyAffixItem)
end

function UINAthOptimal:InitAthOptimal(athData, affixItemPool)
  if self.athData ~= athData then
    self.affixIndex = nil
    self.curAfficElem = nil
  end
  self.athData = athData
  self:__UpdateConsumeItem()
  self:UpdateCumulate()
  self.affixItemPool = affixItemPool
  local firstAffixIndex
  self.affixItemPool:HideAll()
  self.emptyAffixPool:HideAll()
  self.affixToggleGroup.allowSwitchOff = true
  for i = 1, 4 do
    local affix = athData.affixList[i]
    if affix ~= nil then
      local affixItem = self.affixItemPool:GetOne()
      affixItem:InitAthOptAffixItem(i, affix, self.__onSelectAffixEvent, self.__checkOptEnableEvent)
      local select = firstAffixIndex == nil and affixItem:OptimizeEnable()
      if select then
        firstAffixIndex = i
      end
      affixItem:SetAthAffixSelected(select)
      affixItem.gameObject.name = tostring(i)
    else
      local emptyItem = self.emptyAffixPool:GetOne()
      emptyItem:InitAthEmptyAffix(self.ui.affixList)
    end
  end
  self.affixToggleGroup.allowSwitchOff = false
  local enableOpt = firstAffixIndex ~= nil
  self:__RefreshEnableOpt(enableOpt)
end

function UINAthOptimal:__RefreshEnableOpt(enableOpt)
  self.enableOpt = enableOpt
  self.ui.btn_Optimiz.interactable = enableOpt
  self.ui.slider.enabled = enableOpt
  if not enableOpt then
    self.ui.slider.minValue = 0
    self.ui.slider.maxValue = 2
    self.ui.slider.value = 1
    self:__UpdateConsumeItem()
    self.ui.tex_UpValue:SetIndex(0, "0")
    self.ui.tex_SuccessValue:SetIndex(0, "0")
  end
end

function UINAthOptimal:__UpdateConsumeItem()
  self.consumeItemPool:HideAll()
  for k, itemId in ipairs(ConfigData.game_config.athOptimizeConsumeItemId) do
    local consumeNum = ConfigData.game_config.athOptimizeConsumeItemNum[k]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("Can't find itemCfg, id = " .. tostring(itemId))
    else
      local consumeItem = self.consumeItemPool:GetOne()
      consumeItem:InitItemWithCost(itemCfg, consumeNum)
    end
  end
end

function UINAthOptimal:UpdateCumulate()
  local failureCount = ConfigData.game_config.athOptimizeFailureCount
  local curFailure = PlayerDataCenter.allAthData.failure
  self.nextMustSuccess = false
  if failureCount < curFailure then
    curFailure = failureCount
  end
  self.ui.img_FailRate.fillAmount = curFailure / failureCount
  self.ui.tex_FailRate:SetIndex(0, tostring(curFailure), tostring(failureCount))
  self.__nextMustSuccess = curFailure == failureCount
end

function UINAthOptimal:OnItemUpdateEvent(itemUpdate)
  for k, itemId in ipairs(ConfigData.game_config.athOptimizeConsumeItemId) do
    if itemUpdate[itemId] ~= nil then
      local consumeItem = self.consumeItemPool.listItem[k]
      consumeItem:RefreshItemWithCost()
    end
  end
end

function UINAthOptimal:SeletAffix(affixIndex, isOn)
  if not isOn then
    return
  end
  local afficElem = self.athData.affixList[affixIndex]
  self.curAffixCfg = ConfigData.ath_affix_pool[afficElem.id]
  if self.curAffixCfg == nil then
    error("Can't find ath_affix_pool, id = " .. tostring(afficElem.id))
    return
  end
  self.curAffixLvCfg = ConfigData.ath_affix_lv[afficElem.level]
  if self.curAffixLvCfg == nil then
    error("Cant get ath_affix_lv, level = " .. afficElem.level)
    return
  end
  local section = (self.curAffixLvCfg.density - 1) // 2
  if self.affixIndex ~= nil and self.affixIndex == affixIndex then
    section = self.section
  end
  self.affixIndex = affixIndex
  self.curAfficElem = afficElem
  self:SetSliderSection(section)
end

function UINAthOptimal:SetSliderSection(section)
  self.ui.slider.minValue = 0
  self.ui.slider.maxValue = self.curAffixLvCfg.density - 1
  self.ui.slider.wholeNumbers = true
  if self.__nextMustSuccess then
    section = self.ui.slider.maxValue
  end
  self.ui.slider.interactable = not self.__nextMustSuccess
  self.ui.slider.value = section
  self:RefreshPreview(section)
end

function UINAthOptimal:RefreshPreview(section)
  self.section = section
  local optCfg = self.curAffixLvCfg
  local addValue = optCfg.unit_section * section
  local baseMedian = (optCfg.base_section[1] + optCfg.base_section[2]) / 2
  local curMedian = baseMedian + addValue
  local successRate = baseMedian * optCfg.base_success / curMedian / 100
  if self.__nextMustSuccess then
    successRate = 100
  end
  self.ui.tex_SuccessValue:SetIndex(0, GetPreciseDecimalStr(successRate, 1))
  local value1 = optCfg.base_section[1] + addValue
  local value2 = optCfg.base_section[2] + addValue
  self.ui.tex_UpValue:SetIndex(1, GetPreciseDecimalStr(value1, 0), GetPreciseDecimalStr(value2, 0))
end

function UINAthOptimal:OnSliderValueChange(value)
  if not self.enableOpt then
    return
  end
  self:RefreshPreview(value)
end

function UINAthOptimal:CheckOptEnable()
  local enableIndex
  self.affixToggleGroup:SetAllTogglesOff()
  for k, item in ipairs(self.affixItemPool.listItem) do
    if item:OptimizeEnable() then
      enableIndex = k
      item:SetAthAffixSelected(true)
      break
    end
  end
  if enableIndex == nil then
    self:__RefreshEnableOpt(false)
  end
end

function UINAthOptimal:OnClickOptimalBtn()
  for k, itemId in ipairs(ConfigData.game_config.athOptimizeConsumeItemId) do
    local consumeNum = ConfigData.game_config.athOptimizeConsumeItemNum[k]
    local itemCfg = ConfigData.item[itemId]
    local consumeItemCount = PlayerDataCenter:GetItemCount(itemId)
    if consumeNum > consumeItemCount then
      local name = LanguageUtil.GetLocaleText(itemCfg.name)
      cs_MessageCommon.ShowMessageTips(name .. ConfigData:GetTipContent(TipContent.arithmetic_optimal_ItemInsufficient))
      return
    end
  end
  if self.__OnOptimalComplete == nil then
    self.__OnOptimalComplete = BindCallback(self, self.OnOptimalComplete)
  end
  self.athNetwork:CS_ATH_AthOptimize(self.athData.uid, self.affixIndex - 1, self.section, self.__OnOptimalComplete)
end

function UINAthOptimal:OnOptimalComplete(objList)
  local succeed = objList[0]
  self:UpdateCumulate()
  local affixElem = self.athData.affixList[self.affixIndex]
  if succeed then
    local fromLv = self.curAfficElem.level
    local toLv = affixElem.level
    if fromLv ~= toLv then
      local fromValue = self.curAfficElem.value
      local toValue = affixElem.value
      local affixcfg = ConfigData.ath_affix_pool[affixElem.id]
      if affixcfg == nil then
        error("Cant't find ath_affix_pool, id = " .. tostring(affixElem.id))
        return
      end
      local attrId = affixcfg.affix_para
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroLevelUpSuccess, function(window)
        UIManager:ShowWindow(UIWindowTypeID.HeroLevelUpSuccess):AthAffixLevelUp(fromLv, toLv, fromValue, toValue, attrId)
      end)
    end
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.arithmetic_optimal_Success))
    self.curAfficElem = affixElem
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.arithmetic_optimal_Failure))
  end
  self.affixItemPool.listItem[self.affixIndex]:OptAffixChange(affixElem)
  self:SetSliderSection(self.section)
end

function UINAthOptimal:OnShow()
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

function UINAthOptimal:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

function UINAthOptimal:OnDelete()
  base.OnDelete(self)
end

return UINAthOptimal
