local bs_17209 = class("bs_17209", LuaSkillBase)
local base = LuaSkillBase
bs_17209.config = {
  buffId = 2202,
  summontag = 3,
  roletag = 2
}

function bs_17209:ctor()
end

function bs_17209:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_17209_1", 2, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddSetHurtTrigger("bs_17209_3", 1, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self.killnum = 0
  self.kill_target = nil
  self.roleTag = nil
end

function bs_17209:OnRoleDie(killer, role)
  if self.roleTag == self.config.roletag and role.belongNum == eBattleRoleBelong.enemy and role == self.kill_target and role.hp <= 0 then
    self.killnum = self.killnum + 1
    self:CheckAndAddBuffToTarget(killer, role)
  end
end

function bs_17209:OnSetHurt(context)
  if context.hurt_tag == self.config.roletag then
    self.roleTag = self.config.roletag
    self.kill_target = context.target
  end
end

function bs_17209:CheckAndAddBuffToTarget(sender, target)
  if sender ~= nil and sender.hp > 0 and self.killnum >= self.arglist[2] then
    self.killnum = 0
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_17209:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_17209:LuaDispose()
  base.LuaDispose(self)
  self.kill_target = nil
end

return bs_17209
