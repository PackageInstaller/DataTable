local bs_40034 = class("bs_40034", LuaSkillBase)
local base = LuaSkillBase
bs_40034.config = {
  effectId = 10235,
  buffId_163 = 163,
  audioId1 = 89,
  audioId2 = 90,
  buffID_1158 = 1158,
  FloatTextId = 7,
  startAnimID = 1028,
  loopAnimID = 1029,
  debuffId = 1157
}

function bs_40034:InitSkill(isMidwaySkill)
  self.loop = nil
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_40034_1", 1, self.OnSetHurt, nil, self.caster)
  self.totalHurt = 0
end

function bs_40034:PlaySkill(data)
  self:CallCasterWait(999)
  self:AbandonSkillCdAutoReset(true)
  local buffAction = BindCallback(self, self.OnbuffActionTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, 1, 13, buffAction)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1, nil, true)
end

function bs_40034:OnbuffActionTrigger()
  if self.loop == nil then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, false)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_163, self.arglist[2])
  if self.caster.recordTable["20035_root1arg"] ~= 0 and self.caster.recordTable["20035_root1arg"] ~= nil then
    local exNum = self.caster.recordTable["20035_root1arg"]
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_163, exNum, nil, true)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.loopAnimID)
end

function bs_40034:OnSetHurt(context)
  if context.target == self.caster and self.caster:GetBuffTier(self.config.buffId_163) > 0 and context.sender ~= self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_163, 1)
    self.totalHurt = self.totalHurt + context.hurt
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, self.config.FloatTextId)
    if self.caster:GetBuffTier(self.config.buffId_163) == 0 and self.loop ~= nil then
      self:CancleCasterWait()
      self:CallNextBossSkill()
      self.loop:Die()
      self.loop = nil
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
      local hurt = self.totalHurt * self.arglist[3] // 1000
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      if 0 < targetlist.Count then
        for i = 0, targetlist.Count - 1 do
          LuaSkillCtrl:RemoveLife(hurt, self, targetlist[i].targetRole, false, nil, true, false, eHurtType.RealDmg)
          self.totalHurt = 0
        end
      end
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.debuffId, 1, self.arglist[4], true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
    end
  end
end

function bs_40034:OnCasterDie()
  base.OnCasterDie(self)
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
end

function bs_40034:LuaDispose()
  base.LuaDispose(self)
  self.loop = nil
end

return bs_40034
