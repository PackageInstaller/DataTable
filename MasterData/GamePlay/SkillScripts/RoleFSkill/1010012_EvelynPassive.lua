local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1010012 = class("bs_1010012", base)
bs_1010012.config = {
  buffId_Reduce = 10100101,
  buffId_Back = 300701,
  buffId_Stun = 300601,
  audioId1 = 101004,
  heal_config = {baseheal_formula = 3021}
}

function bs_1010012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1010012_btlStart", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_1010012_setHurt", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterAddBuffTrigger("bs_1010012_8", 1, self.OnAfterAddBuff, self.caster)
end

function bs_1010012:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Reduce, 1, nil, true)
end

function bs_1010012:OnSetHurt(context)
  if context.target == self.caster and context.sender.hp > 0 and self:IsReadyToTake() and context.sender ~= self.caster and LuaSkillCtrl:GetGridsDistance(context.sender.x, context.sender.y, self.caster.x, self.caster.y) <= 1 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and context.sender:IsUnSelect(self.caster) ~= true and LuaSkillCtrl:RoleContainsBuffFeature(context.sender, eBuffFeatureType.Exiled) ~= true then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    local targetX = context.sender.x
    local targetY = context.sender.y
    local buff = LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId_Back, 1, 3)
    if buff ~= nil and context.sender.x == targetX and context.sender.y == targetY then
      LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId_Stun, 1, self.arglist[4])
    else
      LuaSkillCtrl:StartTimer(nil, 3, function()
        LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId_Stun, 1, self.arglist[3])
      end)
    end
    self:OnSkillTake()
  end
end

function bs_1010012:OnAfterAddBuff(buff, target)
  if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Stun) and target.belongNum ~= self.caster.belongNum then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
      self.arglist[5]
    })
    skillResult:EndResult()
  end
end

function bs_1010012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1010012
