local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_209300 = class("bs_209300", bs_1)
local base = bs_1
bs_209300.config = {effectId_trail = 209301, configId = 2}
bs_209300.config = setmetatable(bs_209300.config, {
  __index = base.config
})

function bs_209300:ctor()
end

function bs_209300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_209300", 1, self.OnAfterPlaySkill)
  self.atk_num = 0
  self.arg1 = self.caster.recordTable.arg_1
end

function bs_209300:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack and self.atk_num < 10 then
    self.atk_num = self.atk_num + 1
  end
end

function bs_209300:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[1] + self.arg1 * self.atk_num
    })
    skillResult:EndResult()
  end
end

function bs_209300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209300
