local bs_208401 = class("bs_208401", LuaSkillBase)
local base = LuaSkillBase
bs_208401.config = {
  effectId_kaisi = 208403,
  skill_time = 24,
  start_time = 9,
  actionId = 1002,
  act_speed = 1,
  buffID_jiaoXie = 208401,
  hurtConfig = {
    hit_formula = 10201,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_208401:ctor()
end

function bs_208401:InitSkill(isMidwaySkill)
end

function bs_208401:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  local skillTrigger = BindCallback(self, self.OnSkillTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, skillTrigger)
end

function bs_208401:OnSkillTrigger()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_kaisi, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  for i = 0, targetList.Count - 1 do
    local role = targetList[i].targetRole
    if role ~= nil and 0 < role.hp and role.belongNum == eBattleRoleBelong.player then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[1]
      })
      skillResult:EndResult()
      LuaSkillCtrl:CallBuff(self, role, self.config.buffID_jiaoXie, 1, self.arglist[2])
    end
  end
end

function bs_208401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208401
