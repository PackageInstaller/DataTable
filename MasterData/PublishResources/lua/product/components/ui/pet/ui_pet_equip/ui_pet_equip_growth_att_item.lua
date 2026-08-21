_class("UIPetEquipGrowthAttItem", UICustomWidget)
UIPetEquipGrowthAttItem = UIPetEquipGrowthAttItem

function UIPetEquipGrowthAttItem:Constructor()
  self._hasGrowth = false
  local frameTime = 16.666666666666668
  self.maxLvTime_start = frameTime * 0
  self.maxLvTime_end = frameTime * 44
  self.maxLvTime_Gaps = self.maxLvTime_end - self.maxLvTime_start
  self.accTime = 0
  self._animing = false
end

function UIPetEquipGrowthAttItem:OnShow(uiParams)
  self._attName = self:GetUIComponent("UILocalizationText", "attName")
  self._attFrom = self:GetUIComponent("UILocalizationText", "attFrom")
  self._attTo = self:GetUIComponent("UILocalizationText", "attTo")
  self._icon = self:GetUIComponent("Image", "icon")
  self._arrow = self:GetGameObject("arrow")
  self._arrowToGo = self:GetGameObject("attTo")
  self._arrowImg = self:GetUIComponent("Image", "arrow")
  self._attToAlpha = self:GetUIComponent("CanvasGroup", "attTo")
  self._type2name = {
    [1] = "str_pet_equip_attack",
    [2] = "str_pet_equip_defence",
    [3] = "str_pet_equip_hp"
  }
end

function UIPetEquipGrowthAttItem:SetData(attInfo)
  self._fromValue = attInfo.attFrom
  self._toValue = attInfo.attTo
  self._icon.sprite = attInfo.sprite
  self._attName:SetText(StringTable.Get(self._type2name[attInfo.attType]))
  self._attFrom:SetText("+" .. math.modf(attInfo.attFrom))
  local toStr
  if attInfo.attTo ~= attInfo.attFrom then
    toStr = "<color=#28F2FF>+" .. math.modf(attInfo.attTo) .. "</color>"
    self._arrow:SetActive(true)
    self._attTo.gameObject:SetActive(true)
    self._attTo:SetText(toStr)
    self._hasGrowth = true
    self._attToAlpha.alpha = 1
    self._arrowImg.color = Color(1, 1, 1)
  else
    self._hasGrowth = false
    self._arrow:SetActive(false)
    self._attTo.gameObject:SetActive(false)
  end
end

function UIPetEquipGrowthAttItem:UpLevelAnim()
  if self._hasGrowth then
    self:_PlayAnim()
  end
end

function UIPetEquipGrowthAttItem:_PlayAnim()
  self._attToAlpha:DOFade(0, 0.333)
  self._arrowImg:DOColor(Color(1, 1, 1, 0), 0.333):OnComplete(function()
    self._arrowToGo:SetActive(false)
    self._arrow:SetActive(false)
    self._animing = true
  end)
end

function UIPetEquipGrowthAttItem:Update(deltaTimeMS)
  if self._animing then
    self.accTime = self.accTime + deltaTimeMS
    local percent_lv = (self.accTime - self.maxLvTime_start) / self.maxLvTime_Gaps
    if self.accTime >= self.maxLvTime_end then
      percent_lv = 1
      self.accTime = 0
      self._animing = false
    end
    if percent_lv <= 1 and 0 <= percent_lv then
      local valueRec = DG.Tweening.DOVirtual.EasedValue(self._fromValue, self._toValue, percent_lv, DG.Tweening.Ease.OutQuad)
      self._attFrom:SetText("<color=#28F2FF>+" .. math.modf(valueRec) .. "</color>")
    end
  end
end

function UIPetEquipGrowthAttItem:OnHide()
  self._attName = nil
  self._attFrom = nil
  self._attTo = nil
  self._type2name = nil
  self._icon = nil
end

_class("UIPetEquipGrowthAttInfo", Object)
UIPetEquipGrowthAttInfo = UIPetEquipGrowthAttInfo

function UIPetEquipGrowthAttInfo:Constructor(type, from, to, sprite)
  self.attType = type
  self.sprite = sprite
  self.attFrom = from
  self.attTo = to
end
