local career_10009 = class("career_10009", LuaSkillBase)
local base = LuaSkillBase
career_10009.config = {buffId = 1252, effectId = 10942}

function career_10009:ctor()
end

function career_10009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTriggerForTable("career_10009_10", 999, self.OnSetDeadHurt, {
    targetBelongNum = eBattleRoleBelong.player
  })
  self.shiled = self.arglist[1]
end

function career_10009:OnSetDeadHurt(context)
  if context.sender.belongNum == context.target.belongNum then
    return
  end
  if context.target.belongNum == eBattleRoleBelong.player then
    local targetListMax = LuaSkillCtrl:CallTargetSelect(self, 68, 10)
    if targetListMax.Count > 0 then
      local target = targetListMax[0].targetRole
      if target.hp > 1 and target ~= context.target then
        LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, 1, 1, true)
        LuaSkillCtrl:RemoveLife(1, self, target, true, nil, true, true, eHurtType.RealDmg)
        if 0 < self.shiled then
          LuaSkillCtrl:AddRoleShield(context.target, eShieldType.Normal, 1, nil, true)
          self.shiled = self.shiled - 1
        end
      end
    end
  end
end

function career_10009:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10009
