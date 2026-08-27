local bs_4013 = class("bs_4013", LuaSkillBase)
local base = LuaSkillBase
bs_4013.config = {buff_id = 40131}

function bs_4013:ctor()
end

function bs_4013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4013_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTriggerForTable("bs_4013_2", 2, self.OnAfterHurt, {
    target = self.caster,
    extraArg3 = true
  })
end

function bs_4013:OnAfterBattleStart()
  self.caster:AddRoleProperty(eHeroAttr.dodge, self.arglist[1], eHeroAttrType.Extra)
end

function bs_4013:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true and target ~= nil and target.hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_id, 1, self.arglist[3])
  end
end

function bs_4013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4013
