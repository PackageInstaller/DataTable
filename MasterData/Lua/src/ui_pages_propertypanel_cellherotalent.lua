local this = class("cellHeroTalent", G_UIModuleBase)
local skillTpl = L_GameTpl:getSkillTpl()
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local skillsubLogicTpl = L_GameTpl:getSkillsubLogicTpl()

function this.bind()
  return {
    skillIcon = "",
    skillName = "",
    skillLevelText = "",
    costPropertyActive = false,
    coolDownPropertyActive = false,
    costEffectText = "",
    coolDownEffectText = "",
    skillDes = "",
    tagBox = {
      moduleName = "pages/heroPanel/skill/cellSkillTagBox"
    }
  }
end

function this.methods()
  return {}
end

function this:refresh()
  local tpl = skillTpl:getTplById(self.bind.skillId)
  self.bind.skillIcon = skillTpl:getIcon(tpl)
  self.bind.skillName = skillTpl:getName(tpl)
  local isMaxLevel = skillLevelTpl:getMaxLevelById(self.bind.skillId) <= self.bind.skillLevel
  if isMaxLevel then
    self.bind.skillLevelText = L_WordsTpl:getValue("menu_common_lvMax")
  else
    self.bind.skillLevelText = L_WordsTpl:getValue("info_char_lv") .. self.bind.skillLevel
  end
  local desc = L_GameUtil.getSkillDesc(self.bind.skillId, self.bind.skillLevel)
  self.bind.skillDes = desc
  self.modules.tagBox:tryInitModule(tpl)
  local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(self.bind.skillId, self.bind.skillLevel)
  local tpl_skillSub = skillsubLogicTpl:getTplById(skillLevelTpl:getSubSkillId(tpl_skillLevel))
  self.bind.costPropertyActive = skillsubLogicTpl:getSpCost(tpl_skillLevel) > 0
  self.bind.coolDownPropertyActive = 0 < skillsubLogicTpl:getCoolDown(tpl_skillSub)
  if 0 < skillsubLogicTpl:getCoolDown(tpl_skillSub) then
    self.bind.coolDownEffectText = L_WordsTpl:getValue("menu_skill_coolDownTime", {
      [0] = skillsubLogicTpl:getCoolDown(tpl_skillSub) / 1000
    })
  end
  if skillsubLogicTpl:getSpCost(tpl_skillLevel) > 0 then
    self.bind.costEffectText = tostring(skillsubLogicTpl:getSpCost(tpl_skillLevel))
  end
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_list_tag)
end

return this
