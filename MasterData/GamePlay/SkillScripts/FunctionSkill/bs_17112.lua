local bs_17112 = class("bs_17112", LuaSkillBase)
local base = LuaSkillBase
bs_17112.config = {
  hurtConfig = 2,
  effectId = 10967,
  buffId = 1513
}

function bs_17112:ctor()
end

function bs_17112:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.count = 0
  self:AddAfterPlaySkillTrigger("bs_17112_01", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.NormalSkill)
end

function bs_17112:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isNormalSkill then
    self.count = self.count + 1
    if self.count == self.arglist[1] then
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
      if targetlist.Count == 0 then
        return
      end
      local target = targetlist[0].targetRole
      if target == nil then
        return
      end
      local damg = skill.maker.pow * self.arglist[2] // 1000
      if damg ~= 0 and targetlist.Count > 0 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
          self.arglist[2]
        }, true)
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 150, true)
        LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
        self.count = 0
      end
    end
  end
end

function bs_17112:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17112
