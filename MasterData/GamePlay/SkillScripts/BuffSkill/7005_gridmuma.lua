local bs_7005 = class("bs_7005", LuaSkillBase)
local base = LuaSkillBase
bs_7005.config = {
  buffId = 3010,
  buffStun = 66,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId = 10504,
  effectId2 = 10508
}

function bs_7005:ctor()
end

function bs_7005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1)
  self:AddAfterAddBuffTrigger("bs_7005_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId)
  self:AddBeforeAddBuffTrigger("bs_7005_2", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, self.config.buffId)
end

function bs_7005:OnBeforeAddBuff(target, context)
  if target == self.caster then
    context.buff.tier = 0
  end
end

function bs_7005:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  if self.caster == nil then
    if self.damTimer ~= nil then
      self.damTimer:Stop()
      self.damTimer = nil
    end
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
end

function bs_7005:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    skillResult:BuffResult(self.config.buffId, 2)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
      end
    end
    skillResult:EndResult()
  end
end

function bs_7005:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId then
    local restTier = target:GetBuffTier(self.config.buffId)
    if 6 <= restTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffStun, 1, 30, true)
      LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true)
      restTier = 0
    end
  end
end

function bs_7005:OnCasterDie()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_7005
