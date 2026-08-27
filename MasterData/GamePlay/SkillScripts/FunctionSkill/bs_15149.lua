local bs_15149 = class("bs_15149", LuaSkillBase)
local base = LuaSkillBase
bs_15149.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10182,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  effectId = 10936,
  ysBuff = 1227,
  ysBuffDuration = 90
}

function bs_15149:ctor()
end

function bs_15149:InitSkill(isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_15149_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_15149:OnRoleDie(killer, role)
  if killer.belongNum ~= eBattleRoleBelong.enemy then
    return
  end
  self:PlayChipEffect()
  self:OnSkillTake()
  local arriveCallBack = BindCallback(self, self.OnArriveAction, killer)
  LuaSkillCtrl:StartTimer(nil, 15, arriveCallBack)
  LuaSkillCtrl:CallEffect(killer, self.config.effectId, self)
end

function bs_15149:OnArriveAction(role)
  self:findMax()
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
  if skillResult.roleList.Count > 0 then
    for i = 0, skillResult.roleList.Count - 1 do
      local targetRole = skillResult.roleList[i]
      local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 14, {
        self.damageNum
      }, true, true)
      skillResult1:EndResult()
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.ysBuff, 1, self.config.ysBuffDuration)
    end
  end
  skillResult:EndResult()
end

function bs_15149:findMax()
  local role, baseDamage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  if role ~= nil then
    self.damageNum = baseDamage * self.arglist[1] // 1000
  end
end

function bs_15149:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15149
