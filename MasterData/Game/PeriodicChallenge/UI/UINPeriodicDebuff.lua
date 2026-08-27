local UINPeriodicDebuff = class("UINPeriodicDebuff", UIBaseNode)
local base = UIBaseNode

function UINPeriodicDebuff:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.debuffSelectItem, self, self.OnClickBuffItem)
end

function UINPeriodicDebuff:InitDebuffItem(buffId, permillage, selectFunc, isSelected, resloader)
  self.buffId = buffId
  self.permillage = permillage
  self.selectFunc = selectFunc
  local buffCfg = ConfigData.exploration_buff[self.buffId]
  if buffCfg == nil then
    error("不存在的 buff, id is " .. tostring(self.buffId))
    return
  end
  self.ui.img_Icon.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(buffCfg.describe)
  self.buffType = buffCfg.buff_type
  self.ui.tex_Permillage.text = tostring(Mathf.Floor(permillage / 10)) .. "%"
  self:ChangeState(isSelected, false)
end

function UINPeriodicDebuff:ChangeState(isSelected, isForbid)
  self.isSelected = isSelected
  if isForbid then
    self.ui.img_Select:SetIndex(4)
  elseif not self.isSelected then
    self.ui.img_Select:SetIndex(0)
  elseif 0 > self.permillage then
    self.ui.img_Select:SetIndex(3)
  elseif 0 < self.permillage then
    self.ui.img_Select:SetIndex(1)
  else
    self.ui.img_Select:SetIndex(2)
  end
end

function UINPeriodicDebuff:OnClickBuffItem()
  if self.selectFunc ~= nil then
    self.selectFunc(self.buffId, not self.isSelected)
  end
end

return UINPeriodicDebuff
