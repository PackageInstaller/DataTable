local bs_106601 = class("bs_106601", LuaSkillBase)
local base = LuaSkillBase
bs_106601.config = {
  configId = 2,
  buffId_Back = 106602,
  buffId_ding = 106603
}

function bs_106601:ctor()
end

function bs_106601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnErikaAttackEx, self.OnErikaAttack, self)
  self.caster.recordTable.arglist1 = self.arglist[1]
end

function bs_106601:OnErikaAttack(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[2]
  })
  skillResult:EndResult()
  local x = target.x
  local y = target.y
  LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_Back, 1, 3)
  LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_ding, 1, 20)
  if target.x == x and target.y == y then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[3]
    })
    skillResult:EndResult()
  end
end

function bs_106601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106601
