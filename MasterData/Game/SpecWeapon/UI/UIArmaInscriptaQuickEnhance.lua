local UIArmaInscriptaQuickEnhance = class("UIArmaInscriptaQuickEnhance", UIBaseWindow)
local base = UIBaseWindow
local UINHeroTalentNodeDetailCost = require("Game.HeroTalent.UI.UINHeroTalentNodeDetailCost")
local UINHeroTalentNodeDetailEffect = require("Game.HeroTalent.UI.UINHeroTalentNodeDetailEffect")

function UIArmaInscriptaQuickEnhance:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseEnhance, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickBgClose)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnClickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Reduce, self, self.OnClickReduce)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickAdd)
  self.ui.btn_Reduce.onPress:AddListener(BindCallback(self, self.OnClickReduce))
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.OnClickAdd))
  UIUtil.AddValueChangedListener(self.ui.scrollbar, self, self.OnChangeValueLv)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self._heroChipPool = UIItemPool.New(UINHeroTalentNodeDetailCost, self.ui.heroNode)
  self._costItemPool = UIItemPool.New(UINHeroTalentNodeDetailCost, self.ui.itemNode)
  self._attriPool = UIItemPool.New(UINHeroTalentNodeDetailEffect, self.ui.attriItem)
  self.ui.heroNode:SetActive(false)
  self.ui.itemNode:SetActive(false)
  self.ui.attriItem:SetActive(false)
end

function UIArmaInscriptaQuickEnhance:InitQuickEnhance(heroData, specWeapon, callback)
  self._heroData = heroData
  self._specWeapon = specWeapon
  self._callback = callback
  self._maxAddLevel = 0
  self._addLevel = 0
  self.ui.tex_CurrLimit.text = tostring(self._specWeapon:GetSpecWeaponCurLevel())
  self:__CalMaxLevel()
  self.ui.scrollbar.value = self._maxAddLevel
end

function UIArmaInscriptaQuickEnhance:__CalMaxLevel()
  self._maxAddLevel = self._specWeapon:GetSpecWeaponMultipleUprageTargetLevel() - self._specWeapon:GetSpecWeaponCurLevel()
  self.ui.scrollbar.minValue = 1
  self.ui.scrollbar.maxValue = self._maxAddLevel
end

function UIArmaInscriptaQuickEnhance:__RefreshSelectLevel(level, isFromSlider)
  self._addLevel = math.floor(level)
  local targetLevel = self._specWeapon:GetSpecWeaponCurLevel() + self._addLevel
  self.ui.tex_NextLimit.text = tostring(targetLevel)
  self:__RefreshCost()
  self:__RefreshAttribute()
end

function UIArmaInscriptaQuickEnhance:__RefreshAttribute()
  self._attriPool:HideAll()
  local curLevel = self._specWeapon:GetSpecWeaponCurLevel()
  local targetLevel = curLevel + self._addLevel
  local targetCfg = self._specWeapon:GetSpecWeaponLevelCfg(targetLevel)
  local curCfg = self._specWeapon:GetSpecWeaponLevelCfg()
  local attributeDic = {}
  for attributeId, attributeVal in pairs(targetCfg.level_attribute) do
    if curCfg.level_attribute[attributeId] == nil or attributeVal - curCfg.level_attribute[attributeId] > 0 then
      local attriCfg = ConfigData.attribute[attributeId]
      local showAttriId = 0 < attriCfg.merge_attribute and attriCfg.merge_attribute or attributeId
      if attributeDic[showAttriId] == nil then
        attributeDic[showAttriId] = self._heroData:GetAttr(showAttriId, false, true)
      end
    end
  end
  self._specWeapon:RefreshSpecWeapon(self._specWeapon:GetSpecWeaponCurStep(), targetLevel)
  for showAttriId, attributeVal in pairs(attributeDic) do
    local nextVal = self._heroData:GetAttr(showAttriId, false, true)
    local item = self._attriPool:GetOne()
    item:RefreshDetailEffectByAttriId(showAttriId, attributeVal, nextVal)
  end
  self._specWeapon:RefreshSpecWeapon(self._specWeapon:GetSpecWeaponCurStep(), curLevel)
end

function UIArmaInscriptaQuickEnhance:__RefreshCost()
  self._costDic = self._specWeapon:GetSpecWeaponMultipleUprageCost(self._addLevel)
  self._costItemPool:HideAll()
  self._heroChipPool:HideAll()
  for itemId, itemCount in pairs(self._costDic) do
    local itemCfg = ConfigData.item[itemId]
    local item
    if itemCfg.action_type == eItemActionType.HeroCardFrag then
      item = self._heroChipPool:GetOne()
      item.transform:SetAsFirstSibling()
    else
      item = self._costItemPool:GetOne()
    end
    item:RefresheDetailCost(itemId, itemCount)
  end
end

function UIArmaInscriptaQuickEnhance:OnClickAdd()
  if self._addLevel < self._maxAddLevel then
    self.ui.scrollbar.value = self._addLevel + 1
  end
end

function UIArmaInscriptaQuickEnhance:OnClickReduce()
  if self._addLevel > 1 then
    self.ui.scrollbar.value = self._addLevel - 1
  end
end

function UIArmaInscriptaQuickEnhance:OnChangeValueLv(val)
  self:__RefreshSelectLevel(val)
end

function UIArmaInscriptaQuickEnhance:OnClickConfirm()
  if PlayerDataCenter.allSpecWeaponData:IsSpecWeaponCloseQuickEnhanceTip() then
    UIUtil.OnClickBackByUiTab(self)
    if self._callback ~= nil then
      self._callback(self._addLevel)
    end
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(window)
    if window == nil then
      return
    end
    local costIds = {}
    local costNums = {}
    for k, v in pairs(self._costDic) do
      table.insert(costIds, k)
      table.insert(costNums, v)
    end
    local tip = ConfigData:GetTipContent(5082, LanguageUtil.GetRomanNumber(self._specWeapon:GetSpecWeaponCurStep()), tostring(self._specWeapon:GetSpecWeaponCurLevel() + self._addLevel))
    window:ShowItemCostAny(tip, costIds, costNums, function()
      UIUtil.OnClickBackByUiTab(self)
      if self._callback ~= nil then
        self._callback(self._addLevel)
      end
    end, nil)
    window:ShowDontRemindTog(function(flag)
      PlayerDataCenter.allSpecWeaponData:SetSpecWeaponCloseQuickEnhanceTip(flag)
    end, false)
  end)
end

function UIArmaInscriptaQuickEnhance:OnClickCancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UIArmaInscriptaQuickEnhance:__ItemUpdate(itemDic)
  for k, v in pairs(ConfigData.spec_weapon_basic_config.totalCostIdDic) do
    if itemDic[k] ~= nil then
      self:__CalMaxLevel()
      return
    end
  end
end

function UIArmaInscriptaQuickEnhance:OnClickBgClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIArmaInscriptaQuickEnhance:OnCloseEnhance()
  self:Delete()
end

function UIArmaInscriptaQuickEnhance:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  base.OnDelete(self)
end

return UIArmaInscriptaQuickEnhance
