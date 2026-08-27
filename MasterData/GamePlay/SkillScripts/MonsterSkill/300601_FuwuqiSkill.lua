local bs_300601 = class("bs_300601", LuaSkillBase)
local base = LuaSkillBase
bs_300601.config = {
  buffId2 = 1033,
  buffId = 110,
  buffStun = 66,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurt_config = {basehurt_formula = 10157},
  effectId = 10504,
  effectId1 = 10507,
  effectId2 = 10508
}

function bs_300601:ctor()
end

function bs_300601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_300601_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_300601_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId)
end

function bs_300601:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:StartTimer(self, self.arglist[2], self.CallBack, self, -1, 0)
end

function bs_300601:CallBack()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
end

function bs_300601:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    skillResult:BuffResult(self.config.buffId, self.arglist[3])
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
      end
    end
    skillResult:EndResult()
  end
end

function bs_300601:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId then
    local restTier = target:GetBuffTier(self.config.buffId)
    if 6 <= restTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffStun, 1, 30, true)
      LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true)
      restTier = 0
    end
  end
end

function bs_300601:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
end

return bs_300601
