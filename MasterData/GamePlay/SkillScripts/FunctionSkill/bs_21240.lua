local bs_21240 = class("bs_21240", LuaSkillBase)
local base = LuaSkillBase
bs_21240.config = {
  buffId1 = 110160,
  buffId2 = 110161,
  buffId3 = 110162
}

function bs_21240:ctor()
end

function bs_21240:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTriggerForTable("bs_21240_1", 1, self.OnAfterAddBuff, {
    target = self.caster,
    verifyId = self.config.buffId1
  })
  self:AddBeforeAddBuffTriggerForTable("bs_21240_1", 1, self.OnBeforeAddBuff, {
    target = self.caster,
    verifyId = self.config.buffId2
  })
  self:AddBeforeBuffDispelTriggerForTable("bs_21240_3", 1, self.OnBeforeBuffDispel, {
    target = self.caster,
    verifyId = self.config.buffId1
  })
end

function bs_21240:OnBeforeAddBuff(target, context)
  context.active = false
end

function bs_21240:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId1 and target == self.caster then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId3, 1, nil, true)
  end
end

function bs_21240:OnBeforeBuffDispel(target, context)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId3, 1, nil, true)
  end
end

function bs_21240:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21240
