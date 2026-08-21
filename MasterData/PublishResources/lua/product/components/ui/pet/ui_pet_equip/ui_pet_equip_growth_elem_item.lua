_class("UIPetEquipGrowthElemItem", UICustomWidget)
UIPetEquipGrowthElemItem = UIPetEquipGrowthElemItem

function UIPetEquipGrowthElemItem:Constructor()
  self._hasGrowth = false
  local frameTime = 16.666666666666668
  self.maxLvTime_start = frameTime * 0
  self.maxLvTime_end = frameTime * 44
  self.maxLvTime_Gaps = self.maxLvTime_end - self.maxLvTime_start
  self.accTime = 0
  self._animing = false
end

function UIPetEquipGrowthElemItem:OnShow(uiParams)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._attName = self:GetUIComponent("UILocalizationText", "attName")
  self._attFrom = self:GetUIComponent("UILocalizationText", "attFrom")
  self._attTo = self:GetUIComponent("UILocalizationText", "attTo")
  self._elem = self:GetUIComponent("Image", "icon")
  self._arrow = self:GetGameObject("arrow")
  self._arrowImg = self:GetUIComponent("Image", "arrow")
  self._attToAlpha = self:GetUIComponent("CanvasGroup", "attTo")
  self._elem2str = {
    [1] = "str_pet_filter_water_element",
    [2] = "str_pet_filter_fire_element",
    [3] = "str_pet_filter_sen_element",
    [4] = "str_pet_filter_electricity_element",
    [6] = "str_tale_pet_att_none"
  }
end

function UIPetEquipGrowthElemItem:SetData(attInfo)
  self._fromValue = attInfo.elemFrom
  self._toValue = attInfo.elemTo
  self._attName:SetText(StringTable.Get("str_pet_equip_property_restraint_value", StringTable.Get(self._elem2str[attInfo.elemType])))
  self._attFrom:SetText(math.modf(attInfo.elemFrom * 100) .. "%")
  local toStr
  if attInfo.elemTo ~= attInfo.elemFrom then
    toStr = "<color=#28F2FF>" .. math.modf(attInfo.elemTo * 100) .. "%</color>"
    self._attTo:SetText(toStr)
    self._attTo.gameObject:SetActive(true)
    self._arrow:SetActive(true)
    self._hasGrowth = true
    self._attToAlpha.alpha = 1
    self._arrowImg.color = Color(1, 1, 1)
  else
    self._hasGrowth = false
    self._attTo.gameObject:SetActive(false)
    self._arrow:SetActive(false)
  end
  local cfg_elem = Cfg.cfg_pet_element[attInfo.elemType]
  if cfg_elem then
    local icon = cfg_elem.Icon
    self._elem.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(icon))
  else
    Log.fatal("###[UIPetEquipElemItem] cfg_elem is nil ! id --> ", attInfo.elemType)
  end
end

function UIPetEquipGrowthElemItem:UpLevelAnim()
  if self._hasGrowth then
    self:_PlayAnim()
  end
end

function UIPetEquipGrowthElemItem:_PlayAnim()
  self._attToAlpha:DOFade(0, 0.333)
  self._arrowImg:DOColor(Color(1, 1, 1, 0), 0.333):OnComplete(function()
    self._animing = true
    self._attTo.gameObject:SetActive(false)
    self._arrow:SetActive(false)
  end)
end

function UIPetEquipGrowthElemItem:Update(deltaTimeMS)
  if self._animing then
    self.accTime = self.accTime + deltaTimeMS
    local percent_lv = (self.accTime - self.maxLvTime_start) / self.maxLvTime_Gaps
    if self.accTime >= self.maxLvTime_end then
      percent_lv = 1
      self._animing = false
      self.accTime = 0
    end
    if percent_lv <= 1 and 0 <= percent_lv then
      local valueRec = DG.Tweening.DOVirtual.EasedValue(math.modf(self._fromValue * 100), math.modf(self._toValue * 100), percent_lv, DG.Tweening.Ease.OutQuad)
      self._attFrom:SetText("<color=#28F2FF>" .. math.modf(valueRec) .. "%</color>")
    end
  end
end

function UIPetEquipGrowthElemItem:OnHide()
  self._attName = nil
  self._attFrom = nil
  self._attTo = nil
  self._elem = nil
  self._elem2str = nil
end

_class("UIPetEquipGrowthElemInfo", Object)
UIPetEquipGrowthElemInfo = UIPetEquipGrowthElemInfo

function UIPetEquipGrowthElemInfo:Constructor(elem, from, to)
  self.elemType = elem
  self.elemFrom = from
  self.elemTo = to
end
