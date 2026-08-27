local bs_15093 = class("bs_15093", LuaSkillBase)
local base = LuaSkillBase
bs_15093.config = {effectId = 12052}

function bs_15093:ctor()
end

function bs_15093:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15093_1", 1, self.OnAfterBattleStart)
  self:AddAfterBuffRemoveTrigger("bs_15093_2", 4, self.AfterBuffRemove, self.caster, nil, nil, nil, eBuffFeatureType.Stun)
  self:AddAfterAddBuffTrigger("bs_15093_3", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, nil, nil, eBuffFeatureType.Stun)
  self.effect = nil
  self.damTimer = nil
end

function bs_15093:OnAfterBattleStart()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 15, self.CallBack, self, -1, 15)
end

function bs_15093:CallBack()
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if 0 < count then
        for i = 0, count - 1 do
          local curCd = -self.arglist[1]
          if not skills[i].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
          end
        end
      end
    end
  end
end

function bs_15093:AfterBuffRemove(buffId, target, removeType)
  if target == self.caster and not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) and self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_15093:OnAfterAddBuff(buff, target)
  if self.effect == nil then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
end

function bs_15093:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_15093
