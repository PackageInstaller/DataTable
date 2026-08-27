local bs_4021 = class("bs_4021", LuaSkillBase)
local base = LuaSkillBase
bs_4021.config = {}

function bs_4021:ctor()
end

function bs_4021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4021_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTriggerForTable("bs_4021_2", 1, self.OnSetHurt, {
    target = self.caster,
    extraArg1 = eSkillTag.commonAttack
  })
end

function bs_4021:OnAfterBattleStart()
  local originAttrList = self.caster.originAttrList
  self.pow_origin = originAttrList[eHeroAttr.maxHp]
  self.pow_pool = self.pow_origin * self.arglist[1] // 1000
  self.caster:AddRoleProperty(eHeroAttr.maxHp, self.pow_pool, eHeroAttrType.Extra)
  LuaSkillCtrl:CallHeal(self.pow_pool, self, self.caster, true)
end

function bs_4021:OnSetHurt(context)
  if context.target == self.caster and context.skill.isCommonAttack and context.hurt > 0 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    context.hurt = context.hurt * (1000 - self.arglist[3]) // 1000
  end
end

function bs_4021:LuaDispose()
  base.LuaDispose(self)
end

function bs_4021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4021
