local bs_93025 = class("bs_93025", LuaSkillBase)
local base = LuaSkillBase
bs_93025.config = {}

function bs_93025:ctor()
end

function bs_93025:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_93025_1", 1, self.OnAfterHurt, nil, self.caster)
  self.dodge_Num = 0
end

function bs_93025:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss then
    self.dodge_Num = self.dodge_Num + 1
    if self.dodge_Num == self.arglist[1] then
      self.dodge_Num = 0
      local value = math.max(0, 50000 - LuaSkillCtrl:GetUltHMp())
      self:PlayChipEffect()
      LuaSkillCtrl:CallAddPlayerHmp(value)
    end
  end
end

function bs_93025:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93025
