local UINResultMetalGear = class("UINResultMetalGear", UIBaseNode)

function UINResultMetalGear:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINResultMetalGear:InitBattleResultMetalGear(chipData)
  if chipData == nil then
    return
  end
  self.ui.img_SkillIcon.sprite = chipData:GetChipIconSprite()
  self.ui.tex_Name.text = chipData:GetName()
  local showDesc = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  self.ui.tex_Info.text = chipData:GetChipDescription(showDesc)
end

return UINResultMetalGear
