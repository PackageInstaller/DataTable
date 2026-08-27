local UINMonsterLableNode = class("UINMonsterLableNode", UIBaseNode)
local base = UIBaseNode
local resLoader
local resLoaderUserNum = 0

function UINMonsterLableNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINMonsterLableNode:RefreshMonsterLable(dynBattleRole)
  if dynBattleRole == nil then
    self:Hide()
  end
  self:Show()
  local monsterLableCfg = dynBattleRole:GetMonsterLableCfg()
  local monsterLableThemeCfg = ConfigData.monster_lable_theme[monsterLableCfg.label_theme]
  self.ui.tex_monsterLable.text = LanguageUtil.GetLocaleText(monsterLableCfg.label_name)
  self.ui.img_Icon.sprite = CRH:GetSprite(monsterLableThemeCfg.icon, CommonAtlasType.SkillIcon)
  self.ui.tex_monsterLable.color = Color.IntArray2Color(monsterLableThemeCfg.color)
  self.ui.img_monsterLableBg.color = Color.IntArray2Color(monsterLableThemeCfg.bg)
end

function UINMonsterLableNode:OnDelete()
  base.OnDelete(self)
end

function UINMonsterLableNode:OnDeleteEntity()
  self.ui = nil
  self.active = false
  self.gameObject = nil
  self.transform = nil
  self.winTween = nil
end

return UINMonsterLableNode
