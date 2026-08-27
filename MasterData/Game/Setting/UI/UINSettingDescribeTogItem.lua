local UINSettingDescribeTogItem = class("UINSettingDescribeTogItem", UIBaseNode)
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")

function UINSettingDescribeTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.togItem, self, self.OnSwitchTogChanged)
end

function UINSettingDescribeTogItem:InitSettingDescribeItem(idx, skillID, showDetailDesc, onValueChangeCallback)
  self.idx = idx
  self.onValueChangeCallback = onValueChangeCallback
  self:UpdateSkillInfo(skillID, showDetailDesc)
end

function UINSettingDescribeTogItem:UpdateSkillInfo(skillID, showDetailDesc)
  local skillData = HeroSkillData.New(skillID)
  local maxLevel = skillData:GetMaxLevel()
  self.ui.tex_SkillDesc.text = skillData:GetLevelDescribe(maxLevel, false, showDetailDesc)
  self.ui.tex_SkillName.text = skillData:GetName()
  self.ui.isUSKill:SetActive(skillData:IsUniqueSkill())
  self.ui.img_SkillIcon.sprite = CRH:GetSprite(skillData:GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = skillData:GetSkillTag()
  self.ui.img_SkillType:SetIndex(skillTag)
  self.ui.img_SkillTypeLine:SetIndex(skillTag)
  self.ui.img_SkillType.image.color = eBattleSkillTypeColor[skillData:GetBattleSkillTypeColor()]
end

function UINSettingDescribeTogItem:SetIsON()
  self.ui.togItem.isOn = true
end

function UINSettingDescribeTogItem:OnSwitchTogChanged(value)
  if self.onValueChangeCallback ~= nil then
    self.onValueChangeCallback(self.idx, value)
  end
end

return UINSettingDescribeTogItem
