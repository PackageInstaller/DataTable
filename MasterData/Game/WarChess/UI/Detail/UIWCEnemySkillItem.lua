local UIWCEnemySkillItem = class("UIWCEnemySkillItem", UIBaseNode)
local base = UIBaseNode

function UIWCEnemySkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Item, self, self._OnValueChange)
end

function UIWCEnemySkillItem:InitEnemySkillIntroItem(skillData, onClickCallback)
  self._onClickCallback = onClickCallback
  self._skillData = skillData
  self.ui.img_SkillIcon.sprite = CRH:GetSprite(skillData:GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = skillData:GetSkillTag()
  self.ui.img_SkillTypeLine:SetIndex(skillTag)
  self.ui.img_SkillType:SetIndex(skillTag)
  local col = eBattleSkillTypeColor[skillData:GetBattleSkillTypeColor()]
  if col ~= nil then
    self.ui.img_SkillType.image.color = eBattleSkillTypeColor[skillData:GetBattleSkillTypeColor()]
  else
    error(string.format("Can't find type color by battleSkill skillId:%s typeColorId:%s", skillData.dataId, skillData:GetBattleSkillTypeColor()))
  end
  self.ui.tex_SkillName.text = skillData:GetName()
  self.ui.tex_SkillDesc.text = skillData:GetLevelDescribe(nil, nil, false)
  self:SetRefreshSelectUI(false)
end

function UIWCEnemySkillItem:_OnValueChange(value)
  self:SetRefreshSelectUI(value)
  if value ~= true then
    return
  end
  if self._onClickCallback ~= nil then
    self._onClickCallback(self._skillData)
  end
end

function UIWCEnemySkillItem:SetRefreshSelectUI(isOn)
  local index = isOn and 1 or 0
  self.ui.Img_Select:SetIndex(index)
  local nameCol = isOn and self.ui.col_SkillNameWhite or self.ui.col_SkillNameBlack
  self.ui.tex_SkillName.color = nameCol
  local descCol = isOn and self.ui.col_DescWhite or self.ui.col_DescBlack
  self.ui.tex_SkillDesc.color = descCol
end

function UIWCEnemySkillItem:OnDelete()
  base.OnDelete(self)
end

return UIWCEnemySkillItem
