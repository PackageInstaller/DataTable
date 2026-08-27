local bs_100201 = require("GamePlay.SkillScripts.RoleSkill.100201_AnnaPassive")
local bs_100206 = class("bs_100206", bs_100201)
local base = bs_100201
bs_100206.config = {
  weaponLv = 3,
  effectId_Trail = 100219,
  configId_trail = 1,
  buffId_cockhourse2 = 100203,
  buffId_dizzy = 100201,
  buffId_dizzy_cha = 100202,
  time = nil,
  tier = 1,
  tier_skill = 1
}
bs_100206.config = setmetatable(bs_100206.config, {
  __index = base.config
})

function bs_100206:ctor()
end

function bs_100206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_100206_1", 1, self.OnAfterPlaySkill, self.caster)
end

function bs_100206:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isCommonAttack then
    LuaSkillCtrl:StartTimer(nil, 8, function()
      local last_target = self.caster.recordTable.lastAttackRole
      local target = last_target
      local range = self.caster.attackRange
      local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, range)
      if targetlist ~= nil and targetlist.Count > 0 then
        for i = 0, targetlist.Count - 1 do
          if targetlist[i] ~= nil and targetlist[i].targetRole ~= self.caster.recordTable.lastAttackRole and targetlist[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
            target = targetlist[i].targetRole
            break
          end
        end
      end
      LuaSkillCtrl:CallEffect(target, self.config.effectId_Trail, self, self.SkillEventFunc12)
    end)
  end
end

function bs_100206:SkillEventFunc12(effect, eventId, target)
  if effect.dataId == self.config.effectId_Trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_trail, {
      self.arglist[4]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_cockhourse2, self.config.tier, self.config.time)
  end
end

function bs_100206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100206
