local bs_4017 = class("bs_4017", LuaSkillBase)
local base = LuaSkillBase
bs_4017.config = {}

function bs_4017:ctor()
end

function bs_4017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_4017_01", 1, self.OnSetHurt, {
    extraArg3 = false,
    senderBelongNum = eBattleRoleBelong.player,
    targetBelongNum = eBattleRoleBelong.enemy
  })
  self:AddOnRoleDieTriggerForTable("bs_4017_02", 1, self.OnRoleDie, {
    senderBelongNum = eBattleRoleBelong.player,
    targetBelongNum = eBattleRoleBelong.enemy
  })
end

function bs_4017:OnSetHurt(context)
  if context.skill.isCommonAttack == false and context.hurt ~= 0 then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  end
end

function bs_4017:OnRoleDie(killer, role)
  if killer.isDead == false then
    LuaSkillCtrl:CallResetCDNumForRole(killer, self.arglist[2])
  end
end

function bs_4017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4017
