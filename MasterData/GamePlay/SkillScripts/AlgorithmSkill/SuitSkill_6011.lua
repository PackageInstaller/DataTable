local bs_6011 = class("bs_6011", LuaSkillBase)
local base = LuaSkillBase
bs_6011.config = {}

function bs_6011:ctor()
end

function bs_6011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_6011_3", 1, self.OnSetHurt, self.caster)
end

function bs_6011:OnSetHurt(context)
  if context.sender == self.caster then
    local buffs = LuaSkillCtrl:GetRoleBuffs(context.target)
    local times = 0
    if buffs ~= nil and 0 < buffs.Count then
      for i = 0, buffs.Count - 1 do
        if buffs[i].buffType == 2 and times < self.arglist[2] then
          times = times + 1
        end
      end
    end
    if times ~= 0 then
      context.hurt = LuaSkillCtrl:CallFormulaNumberWithSkill(601101, self.caster, self.caster, self, context.hurt, times)
    end
  end
end

function bs_6011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6011
