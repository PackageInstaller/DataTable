local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_533 = class("bs_533", bs_1)
local base = bs_1
bs_533.config = {
  effectId_start1 = 10683,
  effectId_start2 = 10684,
  effectId_trail = 10796,
  atkDirectionRange = 10
}
bs_533.config = setmetatable(bs_533.config, {
  __index = base.config
})

function bs_533:ctor()
end

function bs_533:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_533:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.FernDragonHurt, target, false)
  end
end

function bs_533:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_533
