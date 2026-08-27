local bs_105111 = class("bs_105111", LuaSkillBase)
local base = LuaSkillBase
bs_105111.config = {
  buffYS = 3004,
  buffXY = 1033,
  buffId_bati = 206800,
  buffId_busi = 32
}

function bs_105111:ctor()
end

function bs_105111:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_105111_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_105111_10", 1, self.OnRoleDie)
  self:AddAfterHurtTrigger("bs_105111_3", 1, self.OnAfterHurt, nil, self.caster)
  self.isYinshen = true
  self.totalYSS = 4
  self.damageTime = 0
end

function bs_105111:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffYS, 1, 600, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffXY, 1, 600, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_bati, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_busi, 1, nil, true)
  LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s04_1", nil, nil)
end

function bs_105111:OnRoleDie(killer, role)
  if role.roleDataId == 1000034 then
    self.totalYSS = self.totalYSS - 1
    if self.totalYSS == 0 then
      self.isYinshen = false
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffXY, 0)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffYS, 0)
      LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s04_2", nil, nil)
    end
  end
end

function bs_105111:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.isYinshen == false then
    self.damageTime = self.damageTime + 1
    if self.damageTime == 4 then
      LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s04_3", nil, nil)
    elseif self.damageTime == 5 then
      LuaSkillCtrl:StartAvgWithPauseGame("cpt_imr_s04_4", nil, nil)
      local arriveCallBack2 = BindCallback(self, self.OnArriveAction2)
      LuaSkillCtrl:StartTimer(nil, 8, arriveCallBack2)
    end
  end
end

function bs_105111:OnArriveAction2()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_105111:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_105111
