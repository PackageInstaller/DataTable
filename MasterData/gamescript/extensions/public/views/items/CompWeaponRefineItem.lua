local REFINE_STAGE_1_MAXLEVEL = DT.GetConstant("WeaponRefineSkillParaNum")
local MAX_STAR_NUM = 3
local CompWeaponRefineItem, Super = NewViewComponent("CompWeaponRefineItem")

function CompWeaponRefineItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_PotencyResource(uiNode)
  self.weaponLevel = data.weaponLevel
end

function CompWeaponRefineItem:RegisterEvents()
end

function CompWeaponRefineItem:OnEnterComponent()
  self:_InitWeaponUIElement()
end

function CompWeaponRefineItem:_InitWeaponUIElement()
  if not self.weaponLevel or self.weaponLevel < 0 then
    self:SetActive(self.ui.uiNode, false)
    return
  end
  self:SetActive(self.ui.Image_Max, false)
  self:SetActive(self.ui.Text_Potency, true)
  self:SetActive(self.ui.uiNode, true)
  local level = self.weaponLevel
  local showStars = math.min(level, REFINE_STAGE_1_MAXLEVEL)
  for i = 1, MAX_STAR_NUM do
    local obj = self.ui["Image_Potency_" .. i]
    if obj then
      obj:SetActive(i <= showStars)
    end
  end
  if level > REFINE_STAGE_1_MAXLEVEL then
    self.ui.Potency_4:SetActive(true)
    self:SetText(self.ui.Text_Potency, level - REFINE_STAGE_1_MAXLEVEL)
  else
    self.ui.Potency_4:SetActive(false)
  end
end

return CompWeaponRefineItem
