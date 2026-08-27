local bs_310702 = class("bs_310702", LuaSkillBase)
local base = LuaSkillBase
bs_310702.config = {
  buffId_doblueTower = 196,
  buffId_down = 110047,
  buffId_downDam = 110046,
  buffId_Atk1 = 110048,
  buffId_Atk2 = 110049,
  buffId_Atk3 = 110050,
  buffId_Luk = 110054,
  buffId_stun = 7,
  audioId_caijin = 104808
}

function bs_310702:ctor()
end

function bs_310702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_310702_2", 1, self.OnBuffDie)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_310702_1", 1, self.OnAfterBattleStart)
end

function bs_310702:OnRealSummonerCaster(role)
  if role ~= self.caster then
    return val
  end
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  LuaSkillCtrl:StartTimer(self, 1, function()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk1, 3, self.arglist[2], true)
  end)
end

function bs_310702:OnAfterBattleStart(role)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  LuaSkillCtrl:StartTimer(self, 1, function()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk1, 3, self.arglist[2], true)
  end)
end

function bs_310702:OnBuffDie(buff, target, removeType)
  if target ~= self.caster then
    return
  end
  if buff.dataId == self.config.buffId_Atk1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk2, 2, self.arglist[2], true)
  end
  if buff.dataId == self.config.buffId_Atk2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk3, 1, self.arglist[2], true)
  end
  if buff.dataId == self.config.buffId_Atk3 then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_caijin)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_down, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_downDam, 1, nil, true)
    LuaSkillCtrl:CallRoleAction(self.caster, 1, 1)
  end
  if buff.dataId == self.config.buffId_Luk then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_caijin)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_down, 1, nil, true)
    LuaSkillCtrl:CallRoleAction(self.caster, 1, 1)
  end
end

function bs_310702:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_310702
