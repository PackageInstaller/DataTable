local bs_204301 = class("bs_204301", LuaSkillBase)
local base = LuaSkillBase
bs_204301.config = {
  select_id = 14,
  select_range = 10,
  startAnimId = 1002,
  start_time = 15,
  delay_time = 15,
  buff_zhimang = 3012,
  buff_bati = 196,
  effectId = 204303,
  effectId2 = 204302,
  buff_heal = 103103,
  heal_config = {baseheal_formula = 3021}
}

function bs_204301:ctor()
end

function bs_204301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204301:PlaySkill(data, selectTargetCoord, selectRoles)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList ~= nil and targetList.Count > 0 then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_bati, 1, self.config.start_time)
    self:CallCasterWait(self.config.start_time + 15)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, 1, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  end
end

function bs_204301:OnAttackTrigger(targetList)
  local targelist_zhuanyong = targetList[0].targetRole
  if targelist_zhuanyong ~= nil and 0 < targelist_zhuanyong.hp and not targelist_zhuanyong:IsTowerLoadOff() then
    LuaSkillCtrl:CallEffect(targelist_zhuanyong, self.config.effectId, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    local circledEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, targelist_zhuanyong, targelist_zhuanyong, 100, 0, 6, collisionEnter, nil, collisionExit, nil, false, false, nil, nil)
    LuaSkillCtrl:StartTimer(nil, 90, function()
      if circledEmission == nil then
        return
      end
      circledEmission:EndAndDisposeEmission()
    end, circledEmission)
  end
end

function bs_204301:OnCollisionEnter(collider, index, entity)
  if entity.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buff_zhimang, 1, 90)
  end
  if entity.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallBuffRepeated(self, entity, self.config.buff_heal, 1, self.arglist[2], false, false, self.OnBuffExecute)
  end
end

function bs_204301:OnCollisionExit(collider, entity)
  LuaSkillCtrl:DispelBuffByMaker(self.caster, entity, self.config.buff_zhimang, 1)
  LuaSkillCtrl:DispelBuffByMaker(self.caster, entity, self.config.buff_heal, 1)
end

function bs_204301:OnBuffExecute(buff, targetRole)
  if targetRole == nil or targetRole.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_204301:OnCasterDie()
  base.OnCasterDie(self)
  local teamMates = LuaSkillCtrl:GetSelectTeamRoles(self.caster.belongNum)
  if teamMates.Count > 0 then
    for i = 0, teamMates.Count - 1 do
      local buffrole = teamMates[i]
      if 0 < buffrole.hp then
        LuaSkillCtrl:DispelBuff(buffrole, self.config.buff_heal, 1, true)
        LuaSkillCtrl:DispelBuff(buffrole, self.config.buff_zhimang, 1, true)
      end
    end
  end
end

return bs_204301
