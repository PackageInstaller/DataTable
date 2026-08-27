local bs_4009 = class("bs_4009", LuaSkillBase)
local base = LuaSkillBase
bs_4009.config = {}

function bs_4009:ctor()
end

function bs_4009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4009", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_4009_5", 1, self.OnAfterHeal)
  self.pow_pool = 0
  self.pow_origin = 0
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4009_3", 999, self.OnAfterBattleStart)
end

function bs_4009:OnAfterBattleStart()
  self:AddEffect()
end

function bs_4009:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  self:AddEffect()
end

function bs_4009:OnAfterHeal()
  self:AddEffect()
end

function bs_4009:AddEffect()
  local hprate = self.caster._curHp * 1000 // self.caster.maxHp
  if hprate <= self.arglist[1] then
    hprate = self.arglist[1]
  end
  local originAttrList = self.caster.originAttrList
  self.pow_origin = originAttrList[eHeroAttr.pow]
  if self.pow_pool == 0 then
    self.pow_pool = self.pow_origin * (1000 - hprate) // 1000
    self.caster:AddRoleProperty(eHeroAttr.pow, self.pow_pool, eHeroAttrType.Extra)
  else
    self.caster:AddRoleProperty(eHeroAttr.pow, -self.pow_pool, eHeroAttrType.Extra)
    self.pow_pool = self.pow_origin * (1000 - hprate) // 1000
    self.caster:AddRoleProperty(eHeroAttr.pow, self.pow_pool, eHeroAttrType.Extra)
  end
end

function bs_4009:LuaDispose()
  base.LuaDispose(self)
end

function bs_4009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4009
