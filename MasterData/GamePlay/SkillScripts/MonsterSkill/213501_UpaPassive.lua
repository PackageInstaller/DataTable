local bs_213501 = class("bs_213501", LuaSkillBase)
local base = LuaSkillBase
bs_213501.config = {
  effectId_1 = 213406,
  effectId_2 = 213407,
  buffId_Boss = 3017
}

function bs_213501:ctor()
end

function bs_213501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
  self.arg1 = self.caster.recordTable.arg_1
end

function bs_213501:OnAfterBattleStart(summonerEntity)
  if summonerEntity == self.caster then
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arg1)
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_1, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
end

function bs_213501:OnCasterDie()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_2, self, nil)
  LuaSkillCtrl:SetRoleVisible(self.caster, false)
  base.OnCasterDie(self)
end

function bs_213501:LuaDispose()
  base.LuaDispose(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_213501
