local bs_81030 = class("bs_81030", LuaSkillBase)
local base = LuaSkillBase
bs_81030.config = {dataId = 20117, effectId = 511101}

function bs_81030:ctor()
end

function bs_81030:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81030", 1, self.AfterBattleStart)
end

function bs_81030:AfterBattleStart()
  if self.caster.roleDataId ~= self.config.dataId then
    return
  end
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.eventFunc))
end

function bs_81030:eventFunc()
  local hurt = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:RemoveLife(hurt, self, self.caster, true, nil, true, true, eHurtType.RealDmg, true)
end

function bs_81030:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81030
