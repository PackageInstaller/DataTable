local bs_40032 = class("bs_40032", LuaSkillBase)
local base = LuaSkillBase
bs_40032.config = {
  buffId_124 = 124,
  buffId_164 = 164,
  buffId_256 = 256,
  effectId1 = 10263,
  effectId2 = 10264
}

function bs_40032:ctor()
end

function bs_40032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_40032_2", 1, self.OnSetHurt, nil, self.caster, nil, nil, eBattleRoleType.character)
end

function bs_40032:OnSetHurt(context)
  if context.target == self.caster and context.sender ~= self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and context.sender.roleType == 1 and context.skill.isCommonAttack and self:IsReadyToTake() then
    self:OnSkillTake()
    context.hurt = 0
    if context.sender ~= self.caster.recordTable.lastAttackRole then
      local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
        return 0 <= x
      end)
      if grid ~= nil then
        LuaSkillCtrl:CallEffect(context.sender, self.config.effectId1, self)
        LuaSkillCtrl:SetRolePos(grid, context.sender)
        LuaSkillCtrl:CallEffect(context.sender, self.config.effectId2, self)
      end
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_164, 1, nil, true)
    if self.caster.recordTable["20039_root5arg"] then
      LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId_256, 1, nil, true)
    else
      LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId_164, 1, nil, true)
    end
    LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId_124, 1, 1, true)
  end
end

function bs_40032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40032
