local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_106300 = class("bs_106300", bs_1)
local base = bs_1
bs_106300.config = {
  effectId_trail_1 = 106301,
  effectId_trail_2 = 106303,
  effectId_trail_3 = 106305,
  HurtConfigID = 10
}
bs_106300.config = setmetatable(bs_106300.config, {
  __index = base.config
})

function bs_106300:ctor()
end

function bs_106300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106300:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  local colorId = self.caster.recordTable.beforeAttackColor
  if colorId == 1 then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_1, self, nil, false, self.SkillEventFunc, data)
  elseif colorId == 2 then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_2, self, nil, false, self.SkillEventFunc, data)
  else
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail_3, self, nil, false, self.SkillEventFunc, data)
  end
end

function bs_106300:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId_trail_1 then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.caster.recordTable.RedAtkDam
    })
    skillResult:EndResult()
  end
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId_trail_2 then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
  end
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId_trail_3 then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.caster.recordTable.YellowAtkDam
    })
    skillResult:EndResult()
  end
end

function bs_106300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106300
