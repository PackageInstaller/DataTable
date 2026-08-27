local bs_4037 = class("bs_4037", LuaSkillBase)
local base = LuaSkillBase
bs_4037.config = {
  HurtConfig = 17,
  buffId_csbuff = 207901,
  buffId_ksbuff = 207902,
  effectId_line = 207906,
  effectId_trail = 207906,
  effectId_line2 = 207908,
  effectId_trail2 = 207908,
  selectId = 10001,
  selectRange = 10,
  selectId2 = 34,
  time_hurt = 3
}

function bs_4037:ctor()
end

function bs_4037:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4037_2", 1, self.OnAfterPlaySkill)
end

function bs_4037:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isUltSkill then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
    if targetList.Count ~= 0 then
      self:RealPlaySkill(nil, targetList[0].targetRole, 1)
    end
  end
end

function bs_4037:RealPlaySkill(sender, target, JNId)
  if sender == nil then
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, false, false, self.SkillEventFunc, JNId)
  elseif JNId <= 1 then
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, sender, false, false, self.SkillEventFunc, JNId)
    end)
  else
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail2, self, sender, false, false, self.SkillEventFunc, JNId)
    end)
  end
  if sender == nil and target == self.caster then
    return
  end
end

function bs_4037:SkillEventFunc(JNId, effect, eventId, target)
  if (effect.dataId == self.config.effectId_trail or effect.dataId == self.config.effectId_trail2) and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, BindCallback(self, self.CallBack, target.targetRole))
    if JNId <= self.arglist[2] then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId2, self.config.selectRange, target.targetRole)
      if targetList.Count == 0 then
        return
      end
      if 2 <= targetList.Count then
        for i = 0, targetList.Count - 1 do
          if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target.targetRole then
            self:RealPlaySkill(target.targetRole, targetList[i].targetRole, JNId + 1)
            break
          end
        end
      elseif targetList[0].targetRole ~= nil and targetList[0].targetRole ~= target.targetRole then
        self:RealPlaySkill(target.targetRole, targetList[0].targetRole, JNId + 1)
      end
    end
  end
end

function bs_4037:CallBack(targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
    self.arglist[1]
  }, false, false)
  skillResult:EndResult()
end

function bs_4037:LuaDispose()
  base.LuaDispose(self)
end

function bs_4037:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4037
