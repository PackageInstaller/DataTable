local module = class("cellSkillTagBox", G_UIModuleBase)
local _skillTpl = L_GameTpl:getSkillTpl()
local SKILLTAGTOIMG = {
  [0] = "Page/Skill/tex_common_icon_sk01",
  [1] = "Page/Skill/tex_common_icon_sk01",
  [2] = "Page/Skill/tex_common_icon_sk02",
  [3] = "Page/Skill/tex_common_icon_sk04",
  [4] = "Page/Skill/tex_common_icon_sk04",
  [5] = "Page/Skill/tex_common_icon_sk03"
}

function module.bind()
  return {tagIcon = "", tagText = ""}
end

function module:tryInitModule(skillTpl)
  if skillTpl == nil then
    return
  end
  local skillType = _skillTpl:getSkillDisplayType(skillTpl)
  if skillType == nil then
    return
  end
  self.bind.tagIcon = SKILLTAGTOIMG[skillType]
  self.bind.tagText = L_WordsTpl:getValue(string.format("menu_skill_type%s", skillType + 1))
end

return module
