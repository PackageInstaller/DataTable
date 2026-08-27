local bs_102101 = class("bs_102101", LuaSkillBase)
local base = LuaSkillBase
bs_102101.config = {
  effectId_Grid = 10709,
  buffId_lockCD = 170,
  audioId1 = 77,
  AOE = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 10
  },
  weaponLv = 0,
  buffId_dodge_weapon = 102103,
  buffId_hot_weapon = 102101,
  effectId_hot_weapon = 102107,
  effectId_all_weapon = 102105,
  buffId_ys = 102107
}

function bs_102101:ctor()
end

function bs_102101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102101_3", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum, nil, eBattleRoleType.character)
end

function bs_102101:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss and target.roleType == eBattleRoleType.character and target.belongNum == self.caster.belongNum then
    if self.config.weaponLv >= 2 then
      LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[1] + self.arglist[2])
    elseif self.caster:GetBuffTier(self.config.buffId_lockCD) == 0 then
      LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[1])
    end
    if self.config.weaponLv >= 3 then
      LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_ys, 1, self.arglist[4])
    end
  end
end

function bs_102101:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_102101:LuaDispose()
  base.LuaDispose(self)
end

return bs_102101
