local bs_17200 = class("bs_17200", LuaSkillBase)
local base = LuaSkillBase
bs_17200.config = {
  role_mode_tag = 1,
  summontag = 3,
  roletag = 2
}

function bs_17200:ctor()
end

function bs_17200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Kurisu_Mode = self.config.role_mode_tag
  self:AddOnRoleDieTriggerForTable("bs_17200_1", 1, self.OnRoleDie, {
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy
  })
  self:AddSetHurtTrigger("bs_17200_3", 1, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self.rolekill = 0
  self.summonkill = 0
  self.kill_target = nil
  self.roleTag = nil
end

function bs_17200:OnRoleDie(killer, role)
  if role == self.kill_target and role.hp <= 0 and role ~= nil then
    if self.roleTag == self.config.roletag then
      self.rolekill = self.rolekill + 1
    end
    if self.roleTag == self.config.summontag then
      self.summonkill = self.summonkill + 1
    end
  end
end

function bs_17200:OnSetHurt(context)
  self.kill_target = context.target
  if context.hurt_tag == self.config.summontag then
    context.hurt = context.hurt * (1000 + self.rolekill // self.arglist[1] * self.arglist[2]) // 1000
    self.roleTag = self.config.summontag
  else
    context.hurt = context.hurt * (1000 + self.summonkill // self.arglist[3] * self.arglist[4]) // 1000
    self.roleTag = self.config.roletag
  end
end

function bs_17200:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_17200:LuaDispose()
  base.LuaDispose(self)
  self.kill_target = nil
end

return bs_17200
