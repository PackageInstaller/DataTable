local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local CommonWeaponPotencyItem, Super = System.NewComponent("CommonWeaponPotencyItem")

function CommonWeaponPotencyItem:ctor(uiNode, viewData)
  Super.ctor(self)
  self.ui = UI_Common_Item_PotencyResource(uiNode)
  self.potency = viewData.potency
end

function CommonWeaponPotencyItem:OnBind(binder)
  if not self.potency or self.potency < 0 then
    binder:SetActive(self.ui.uiNode, false)
    return
  end
  binder:SetActive(self.ui.Image_Max, false)
  binder:SetActive(self.ui.Text_Potency, true)
  binder:SetActive(self.ui.uiNode, true)
  local numStars = math.min(self.potency, RefineStage1MaxLevel) or 0
  for i = 1, 3 do
    local obj = self.ui["Image_Potency_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if self.potency > RefineStage1MaxLevel then
    self.ui.Potency_4:SetActive(true)
    binder:SetText(self.ui.Text_Potency, self.potency - RefineStage1MaxLevel)
  else
    self.ui.Potency_4:SetActive(false)
  end
end

return CommonWeaponPotencyItem
