local UINBattleMetalGear = class("UINBattleMetalGear", UIBaseNode)

function UINBattleMetalGear:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBattleMetalGear:InitBattleGridMetalGear(dynEffectGrid)
  if dynEffectGrid == nil then
    return
  end
  self.ui.img_SkillIcon.sprite = dynEffectGrid:GetGridIconSprite()
  self.ui.tex_Name.text = dynEffectGrid:GetGridName()
  self.ui.tex_Info.text = dynEffectGrid:GetGridInfo()
end

return UINBattleMetalGear
