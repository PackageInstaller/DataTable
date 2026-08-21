require("skill_effect_result_base")
_class("SkillEffectResult_SwapSan2TeamHp", SkillEffectResultBase)
SkillEffectResult_SwapSan2TeamHp = SkillEffectResult_SwapSan2TeamHp

function SkillEffectResult_SwapSan2TeamHp:Constructor(sanPercent, teamHpPercent)
  self._sanPercent = sanPercent
  self._teamHpPercent = teamHpPercent
  self._curSan = 0
  self._oldSan = 0
  self._deltaSan = 0
  self._modifyTimes = 0
  self._mazeDamageList = {}
end

function SkillEffectResult_SwapSan2TeamHp:GetSanPercent()
  return self._sanPercent
end

function SkillEffectResult_SwapSan2TeamHp:GetTeamHpPercent()
  return self._teamHpPercent
end

function SkillEffectResult_SwapSan2TeamHp:GetEffectType()
  return SkillEffectType.SwapSan2TeamHp
end

function SkillEffectResult_SwapSan2TeamHp:SetCurSan(curSan)
  self._curSan = curSan
end

function SkillEffectResult_SwapSan2TeamHp:GetCurSan()
  return self._curSan
end

function SkillEffectResult_SwapSan2TeamHp:SetOldSan(oldSan)
  self._oldSan = oldSan
end

function SkillEffectResult_SwapSan2TeamHp:GetOldSan()
  return self._oldSan
end

function SkillEffectResult_SwapSan2TeamHp:SetDeltaSan(deltaSan)
  self._deltaSan = deltaSan
end

function SkillEffectResult_SwapSan2TeamHp:GetDeltaSan()
  return self._deltaSan
end

function SkillEffectResult_SwapSan2TeamHp:SetModifyTimes(modifyTimes)
  self._modifyTimes = modifyTimes
end

function SkillEffectResult_SwapSan2TeamHp:GetModifyTimes()
  return self._modifyTimes
end

function SkillEffectResult_SwapSan2TeamHp:AddMazeDamage(id, value)
  self._mazeDamageList[id] = value
end

function SkillEffectResult_SwapSan2TeamHp:GetMazeDamage()
  return self._mazeDamageList
end
