local bs_212301 = class("bs_212301", LuaSkillBase)
local base = LuaSkillBase
bs_212301.config = {
  Aoe_1 = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  Aoe_2 = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  buffID_hurt = 212301,
  effectId_hit = 212304,
  buffID_rage = 212302
}

function bs_212301:ctor()
end

function bs_212301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_212301", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddAfterAddBuffTrigger("bs_212301_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.buffID_hurt)
  self.caster.recordTable.AOEDamage = self.arglist[1]
  self.caster.recordTable.hurt_buff_dam = self.arglist[3]
  self.caster.recordTable.hurt_buff_time = self.arglist[4]
  self.caster.recordTable.hurt_buff_exdam = self.arglist[6]
end

function bs_212301:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and isMiss == false then
    local AOE_range
    local buffcount_hurt = 1
    local buffcount_hurt_param = 1
    if self.caster:GetBuffTier(self.config.buffID_rage) > 0 then
      buffcount_hurt = 2
    else
      buffcount_hurt = 1
    end
    LuaSkillCtrl:CallBuff(self, target, self.config.buffID_hurt, buffcount_hurt, self.caster.recordTable.hurt_buff_time)
  end
end

function bs_212301:OnAfterAddBuff(buff, target)
  if target.hp <= 0 or target.recordTable.WillowPic == true then
    return
  end
  if buff.dataId == self.config.buffID_hurt then
    local buffnum = target:GetBuffTier(self.config.buffID_hurt)
    local dambase = self.caster.recordTable.hurt_buff_dam
    if target.roleType == 4 then
      dambase = self.caster.recordTable.hurt_buff_dam + self.caster.recordTable.hurt_buff_dam * self.caster.recordTable.hurt_buff_exdam // 1000
    end
    local hurt = target.maxHp * dambase // 1000 * buffnum
    LuaSkillCtrl:RemoveLife(hurt, self, target, true, nil, true, false, eHurtType.RealDmg)
  end
end

function bs_212301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212301
