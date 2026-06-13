local skActBase = import("character.base.base_role_skillAction")
local skillBase = Util.create_child_mt(skActBase)
skillBase._skillBase = skillBase
skillBase.skillBase = skillBase

function skillBase.setClass(customSkillBase, actBases)
  local ret = customSkillBase or skillBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == skillBase then
    ret = {}
  end
  if ret ~= skillBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.skillBase = ret.skillBase or ret
    UtilTable.fill_table(skillBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function skillBase.new(customSkillBase, role, _cfg)
  local skill = setmetatable({}, customSkillBase)
  skill.base = customSkillBase
  skill.type = Const.SKILL_ACTION_TYPE.SKILL
  customSkillBase:_init(skill, role, _cfg)
  return skill
end

function skillBase._init(customSkillBase, skill, role, _cfg)
  skill.skillBase = customSkillBase
  customSkillBase.skActBase:_init(skill, role, _cfg)
  local cfg = _cfg or {}
  local trans = skill.trans
  trans.prio = cfg.TransPrio or 3
  trans.inertia = cfg.TransInertia or 3
end

function skillBase.isCommon()
end

function skillBase.isSkill()
  return true
end

return skillBase
