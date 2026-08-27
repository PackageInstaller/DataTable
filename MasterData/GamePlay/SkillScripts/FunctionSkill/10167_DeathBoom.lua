local bs_10167 = class("bs_10167", LuaSkillBase)
local base = LuaSkillBase
bs_10167.config = {
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  realDamageConfig = {basehurt_formula = 10034},
  effectId = 10866
}

function bs_10167:ctor()
end

function bs_10167:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRevengeCall, self.eventFunc)
  self.rand_flag = 5
  local cm = LuaSkillCtrl:GetPlayerRoleEntity()
  if cm.recordTable["30043"] == nil then
    cm.recordTable["30043"] = {}
    for i = 1, 5 do
      cm.recordTable["30043"][i] = -1
    end
  end
  cm.recordTable["30043"][self.rand_flag] = self.rand_flag
end

function bs_10167:eventFunc(killer, role, tb)
  local isCastable = false
  for i = 1, #tb do
    if tb[i] == self.rand_flag then
      isCastable = true
      break
    end
  end
  if not isCastable then
    return
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 8, 0)
  if 0 >= targetlist.Count then
    return
  end
  local target = targetlist[0].targetRole
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  if 0 < skillResult.roleList.Count then
    for i = 0, skillResult.roleList.Count - 1 do
      local role = skillResult.roleList[i]
      LuaSkillCtrl:CallRealDamage(self, role, nil, self.config.realDamageConfig, nil, true)
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_10167:OnCasterDie()
  self:PlayChipEffect()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 8, 0)
  local checkList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if 0 >= targetlist.Count or checkList.Count <= 1 then
    return
  end
  local target = targetlist[0].targetRole
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  if 0 < skillResult.roleList.Count then
    for i = 0, skillResult.roleList.Count - 1 do
      local role = skillResult.roleList[i]
      LuaSkillCtrl:CallRealDamage(self, role, nil, self.config.realDamageConfig, nil, true)
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  base.OnCasterDie(self)
end

return bs_10167
