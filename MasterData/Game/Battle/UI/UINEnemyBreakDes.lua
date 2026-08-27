local base = UIBaseNode
local UINEnemyBreakDes = class("UINEnemyBreakDes", base)

function UINEnemyBreakDes:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Item, self, self._OnValueChange)
end

function UINEnemyBreakDes:InitEnemyBreakDes(breakCompnt, clickFunc)
  self._breakCompnt = breakCompnt
  self._clickFunc = clickFunc
  local breakConfig = breakCompnt.breakConfig
  self.ui.img_BkIcon.sprite = CRH:GetSprite(breakConfig.DesIcon, CommonAtlasType.SkillIcon)
  self.ui.tex_BkName.text = breakConfig.DesName
  self.ui.tex_BkDesc.text = breakConfig.Description
  self:UpdEnemyBreakDesSelectUI(false)
end

function UINEnemyBreakDes:_OnValueChange(value)
  self:UpdEnemyBreakDesSelectUI(value)
  if value ~= true then
    return
  end
  if self._clickFunc ~= nil then
    self._clickFunc(self._breakCompnt)
  end
end

function UINEnemyBreakDes:UpdEnemyBreakDesSelectUI(isOn)
  local index = isOn and 1 or 0
  self.ui.Img_Select:SetIndex(index)
  local nameCol = isOn and Color.white or Color.black
  self.ui.tex_BkName.color = nameCol
  local descCol = isOn and self.ui.col_DescWhite or self.ui.col_DescBlack
  self.ui.tex_BkDesc.color = descCol
end

function UINEnemyBreakDes:OnDelete()
  base.OnDelete(self)
end

return UINEnemyBreakDes
