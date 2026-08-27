local bs_21020 = class("bs_21020", LuaSkillBase)
local base = LuaSkillBase
bs_21020.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10077,
    crit_formula = 0
  },
  buffId = 65,
  effectId = 10946
}

function bs_21020:ctor()
end

function bs_21020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21020_1", 1, self.OnAfterBattleStart)
  self.hurtTimer = nil
end

function bs_21020:OnAfterBattleStart()
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
  local callback = BindCallback(self, self.FunSkill)
  self.hurtTime = LuaSkillCtrl:StartTimer(nil, self.arglist[1], callback, nil, -1, self.arglist[1])
end

function bs_21020:FunSkill()
  local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetlist.Count > 0 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    for i = 0, targetlist.Count - 1 do
      local role = targetlist[i]
      if role.belongNum ~= eBattleRoleBelong.player then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, 1)
      end
    end
  end
end

function bs_21020:OnCasterDie()
  base.OnCasterDie(self)
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
end

function bs_21020:LuaDispose()
  base.LuaDispose(self)
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
end

return bs_21020
