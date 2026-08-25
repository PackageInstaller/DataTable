local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local CompWeaponPotencyItem, Super = NewViewComponent("CompWeaponPotencyItem")

function CompWeaponPotencyItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_PotencyResource(uiNode)
  self._potency = viewData.potency
end

function CompWeaponPotencyItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshVisible()
  self:_RefreshText()
end

function CompWeaponPotencyItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompWeaponPotencyItem:_RefreshText()
  if self._potency > RefineStage1MaxLevel then
    self:SetText(self.ui.Text_Potency, self._potency - RefineStage1MaxLevel)
  end
end

function CompWeaponPotencyItem:_RefreshVisible()
  if not self._potency or self._potency < 0 then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.Image_Max:SetActive(false)
  self.ui.Text_Potency:SetActive(true)
  self.ui.uiNode:SetActive(true)
  local numStars = math.min(self._potency, RefineStage1MaxLevel) or 0
  for i = 1, 3 do
    local obj = self.ui["Image_Potency_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if self._potency > RefineStage1MaxLevel then
    self.ui.Potency_4:SetActive(true)
  else
    self.ui.Potency_4:SetActive(false)
  end
end

function CompWeaponPotencyItem:GetPotency()
  return self._potency
end

return CompWeaponPotencyItem
