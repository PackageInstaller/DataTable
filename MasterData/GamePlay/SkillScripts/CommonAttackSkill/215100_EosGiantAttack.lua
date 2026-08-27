local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_215100 = class("bs_215100", bs_1)
local base = bs_1
bs_215100.config = {
  effectId_hit_target = 215102,
  action1 = 1001,
  action2 = 1001
}
bs_215100.config = setmetatable(bs_215100.config, {
  __index = base.config
})

function bs_215100:ctor()
end

function bs_215100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_215100:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, 8, function()
      if configData.audioId5 ~= nil then
        LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
      end
      if configData.Imp == true then
        LuaSkillCtrl:PlayAuHit(self, target)
      end
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
      skillResult:EndResult()
    end, nil)
  end
end

function bs_215100:OnCasterDie()
  base.OnCasterDie(self)
  CS.BattleManager.Instance.CurEffectController:KillRoleEffect(self.caster)
end

return bs_215100
