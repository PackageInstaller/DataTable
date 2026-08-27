local bs_50001 = class("bs_50001", LuaSkillBase)
local base = LuaSkillBase
bs_50001.config = {}

function bs_50001:ctor()
end

function bs_50001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_50001_13", 1, self.OnBeforePlaySkill)
end

function bs_50001:OnBeforePlaySkill(role, context)
  if role == self.caster and context.skill ~= nil and context.skill.isCommonAttack and context.skill.moveSelectTarget ~= nil then
    if role:ContainBuffFeature(eBuffFeatureType.Bewitch) or role:ContainBuffFeature(eBuffFeatureType.Taunt) then
      return
    end
    local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 21, 10)
    if targetlist.Count < 1 then
      return
    end
    context.skill.moveSelectTarget:SetBattleTarget(targetlist[0].targetRole)
  end
end

function bs_50001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50001
