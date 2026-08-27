local bs_70005 = class("bs_70005", LuaSkillBase)
local base = LuaSkillBase
bs_70005.config = {buffId_god = 3009, pathBuffId = 1201}

function bs_70005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:OnAfterBattleStart()
end

function bs_70005:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_god, 1, 29, true)
end

function bs_70005:PlaySkill(data)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, 30, arriveCallBack)
end

function bs_70005:OnArriveAction()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_god, 0, true)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.pathBuffId, 0, true)
  LuaSkillCtrl:RemoveLife(self.caster.hp + 1, self, self.caster, true, nil, false, true)
end

function bs_70005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70005
