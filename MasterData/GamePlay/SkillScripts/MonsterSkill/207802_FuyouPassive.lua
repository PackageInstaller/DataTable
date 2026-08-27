local bs_207802 = class("bs_207802", LuaSkillBase)
local base = LuaSkillBase
bs_207802.config = {
  effectId_trail = 207800,
  buffIdBJ = 207801,
  buffIdHD = 207802,
  effectId_start = 207801,
  effectId_trail2 = 207803,
  effectId_bd = 207805,
  start_time = 9
}

function bs_207802:ctor()
end

function bs_207802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_207802_1", 1, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_207802_2", 1, self.OnBreakShield)
  self.caster.recordTable.skill_intensity_up = self.arglist[1]
  self.caster.recordTable.maxHp = self.arglist[2]
end

function bs_207802:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack and skill.maker == self.caster then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 14, 6)
    if targetList.Count ~= 0 then
      local target = targetList[0].targetRole
      self.caster:LookAtTarget(target)
      LuaSkillCtrl:StartTimer(nil, self.config.start_time, function()
        if target ~= self.caster then
          LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bd, self)
          LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self)
        end
        local value1 = self.caster.skill_intensity * self.arglist[1] // 1000
        local value2 = self.caster.maxHp * self.arglist[2] // 1000
        local value3 = value1 + value2
        LuaSkillCtrl:StartTimer(nil, 3, function()
          if 0 < value3 then
            LuaSkillCtrl:AddRoleShield(target, eShieldType.normal, value3)
            local buff = LuaSkillCtrl:GetRoleBuffById(target, self.config.buffIdHD)
            if buff == nil then
              LuaSkillCtrl:CallBuff(self, target, self.config.buffIdHD, 1, nil, true)
            end
          end
        end)
      end)
    end
  end
end

function bs_207802:OnBreakShield(shieldType, sender, target)
  if target.belongNum == self.caster.belongNum then
    local buff = LuaSkillCtrl:GetRoleBuffById(target, self.config.buffIdHD)
    if buff ~= nil then
      LuaSkillCtrl:DispelBuff(target, self.config.buffIdHD, 1)
    end
  end
end

function bs_207802:OnCasterDie()
  self:KillEquipmentSummoner()
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
  self:RemoveAllHaleEmission()
end

return bs_207802
