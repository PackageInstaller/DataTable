local career_10008 = class("career_10008", LuaSkillBase)
local base = LuaSkillBase
career_10008.config = {
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

function career_10008:ctor()
end

function career_10008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("career_10008_10", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.config.buffId)
  self:AddBeforeAddBuffTrigger("career_10008_20", 1, self.OnBeforeAddBuff, nil, nil, nil, eBattleRoleBelong.player, self.config.buffId)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_10008_30", 1, self.OnAfterBattleStart)
end

function career_10008:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], self.CallBack, self, -1)
end

function career_10008:OnBeforeAddBuff(target, context)
  context.buff.tier = 0
end

function career_10008:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if plist.Count < 1 then
    if self.damTimer ~= nil then
      self.damTimer:Stop()
      self.damTimer = nil
    end
    return
  end
  for i = 0, plist.Count - 1 do
    if plist[i].roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallEffect(plist[i], self.config.effectId, self, self.SkillEventFunc)
    end
  end
end

function career_10008:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    skillResult:BuffResult(self.config.buffId, self.arglist[3])
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
      end
    end
    skillResult:EndResult()
  end
end

function career_10008:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId then
    local restTier = target:GetBuffTier(self.config.buffId)
    if 6 <= restTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffStun, 1, 30, true)
      LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true)
      restTier = 0
    end
  end
end

function career_10008:OnCasterDie()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  base.OnCasterDie(self)
end

return career_10008
