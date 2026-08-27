local UINBattleGirdInfoNode = class("UINBattleGirdInfoNode", UIBaseNode)

function UINBattleGirdInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBattleGirdInfoNode:InitBattleGridInfo(dynEffectGrid)
  if dynEffectGrid == nil then
    return
  end
  self.ui.img_Icon.sprite = dynEffectGrid:GetGridIconSprite()
  self.ui.tex_Name.text = dynEffectGrid:GetGridName()
  self.ui.tex_Content.text = dynEffectGrid:GetGridInfo()
end

return UINBattleGirdInfoNode
