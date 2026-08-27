local UINEnemySkillItem = class("UINEnemySkillIntroItem", UIBaseNode)
local base = UIBaseNode

function UINEnemySkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Item, self, self._OnValueChange)
end

function UINEnemySkillItem:InitEnemySkillIntroItem(skillData, onClickCallback)
  self._onClickCallback = onClickCallback
  self._skillData = skillData
  local monsterLabelid = skillData:GetSkillMonsterLabel()
  local isMonsterLabelSkill = monsterLabelid ~= nil
  self.ui.uINSkillItem:SetActive(not isMonsterLabelSkill)
  self.ui.uINTagItem:SetActive(isMonsterLabelSkill)
  if not isMonsterLabelSkill then
    self.ui.img_SkillIcon.sprite = CRH:GetSprite(skillData:GetIcon(), CommonAtlasType.SkillIcon)
  else
    local monsterLableCfg = ConfigData.monster_lable[monsterLabelid]
    local monsterLableThemeCfg = ConfigData.monster_lable_theme[monsterLableCfg.label_theme]
    self.ui.img_mlskillIcon.sprite = CRH:GetSprite(monsterLableThemeCfg.icon, CommonAtlasType.SkillIcon)
    self.ui.img_monsterLabel.color = Color.IntArray2Color(monsterLableThemeCfg.bg)
    self.ui.tex_monsterLabelDes.text = LanguageUtil.GetLocaleText(monsterLableThemeCfg.theme_des)
    self.ui.tex_monsterLabelDes.color = Color.IntArray2Color(monsterLableThemeCfg.color)
  end
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

function UINEnemySkillItem:_OnValueChange(value)
  self:SetRefreshSelectUI(value)
  if value ~= true then
    return
  end
  if self._onClickCallback ~= nil then
    self._onClickCallback(self._skillData)
  end
end

function UINEnemySkillItem:SetRefreshSelectUI(isOn)
  local index = isOn and 1 or 0
  self.ui.Img_Select:SetIndex(index)
  local nameCol = isOn and Color.white or Color.black
  self.ui.tex_SkillName.color = nameCol
  local descCol = isOn and self.ui.col_DescWhite or self.ui.col_DescBlack
  self.ui.tex_SkillDesc.color = descCol
end

function UINEnemySkillItem:OnDelete()
  base.OnDelete(self)
end

return UINEnemySkillItem
