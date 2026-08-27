local bs_209201 = class("bs_209201", LuaSkillBase)
local base = LuaSkillBase
bs_209201.config = {buffId = 209201, buffId_Boss = 3017}

function bs_209201:ctor()
end

function bs_209201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_209201_1", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_209201_2", 1, self.OnAfterBattleStart)
end

function bs_209201:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
  self:addBuffStart()
end

function bs_209201:OnRealSummonerCaster(summonerEntity)
  if summonerEntity.belongNum == self.caster.belongNum then
    self:addBuff()
  end
end

function bs_209201:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum then
    self:deleteBuff()
  end
end

function bs_209201:addBuffStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  local targetsNum = targetList.Count
  if 0 < targetsNum then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, targetsNum)
  end
end

function bs_209201:addBuff()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_209201:deleteBuff()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
end

function bs_209201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209201
