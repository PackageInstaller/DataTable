local bs_10213 = class("bs_10213", LuaSkillBase)
local base = LuaSkillBase
bs_10213.config = {checkBuffId = 26, buffId = 1063}

function bs_10213:ctor()
end

function bs_10213:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10213_2", 1, self.OnSetHurt, self.caster)
end

function bs_10213:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:RoleContainsCtrlBuff(context.target) then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local target = targetList[i].targetRole
        local preTier = target:GetBuffTier(self.config.buffId)
        local tier = 1
        if preTier >= self.arglist[3] then
          LuaSkillCtrl:DispelBuff(target, self.config.buffId, tier, true)
        end
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId, tier, nil, true)
      end
    end
  end
end

function bs_10213:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10213
