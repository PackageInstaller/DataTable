local bs_108301 = class("bs_108301", LuaSkillBase)
local base = LuaSkillBase
bs_108301.config = {
  buffId_kaiji = 108301,
  buffId_qiyou = 108302,
  buffId_ranjie = 107101,
  buffId_biaoji = 108306,
  buffId_DamageUp = 108307,
  effect_kaijia = 108304,
  selectId = 6
}

function bs_108301:ctor()
end

function bs_108301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108301_01", 1, self.OnAfterBattleStart)
  self:AddSetHurtTriggerForTable("bs_108301_02", 2, self.OnSetHurt, {extraArg2 = false, extraArg3 = false})
  self:AddOnRoleDieTrigger("bs_108301_03", 3, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddAfterAddBuffTrigger("bs_108301_04", 4, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.config.buffId_ranjie)
  self:AddBeforeBuffDispelTrigger("bs_108301_05", 5, self.OnBeforBuffDispel, nil, eBattleRoleBelong.enemy, self.config.buffId_ranjie)
  self:AddBuffDieTrigger("bs_108301_06", 6, self.OnBuffDie, nil, eBattleRoleBelong.enemy, self.config.buffId_ranjie)
  self:AddLuaTrigger(eSkillLuaTrigger.OnShaleBuffAdd, self.OnShaleBuffAdd)
  self.DamageSum = 0
  self.buffStartAdding = false
  self.buffKaiJNum = 0
end

function bs_108301:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_DamageUp, 1)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    if self.caster.recordTable.lastAttackRole ~= nil then
      local target = self.caster.recordTable.lastAttackRole
      local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 1, target)
      for i = targetList.Count - 1, 0, -1 do
        LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_qiyou, 1, self.arglist[2])
      end
    end
  end, nil, -1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_kaiji, 5)
  self:OnCheckBuffNum()
end

function bs_108301:OnSetHurt(context)
  if context.target == self.caster and self.caster:GetBuffTier(self.config.buffId_kaiji) > 0 then
    local limitNum = self.arglist[4] * self.caster.skill_intensity // 1000
    if limitNum > context.hurt then
      self.DamageSum = self.DamageSum + context.hurt
    end
    if limitNum <= context.hurt or limitNum <= self.DamageSum then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_kaiji, 1)
      self.DamageSum = 0
      self:OnCheckBuffNum()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effect_kaijia, self)
    end
  end
  if context.target ~= nil and 0 < context.target.hp and not context.isTriggerSet and context.target.belongNum == eBattleRoleBelong.enemy and 0 < context.target:GetBuffTier(self.config.buffId_qiyou) and context.sender.roleType == eBattleRoleType.character and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[7] then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_ranjie, 1, 75)
  end
end

function bs_108301:OnCheckBuffNum()
  if self.caster:GetBuffTier(self.config.buffId_kaiji) == 10 then
    if self.buffadd ~= nil then
      self.buffadd:Stop()
      self.buffadd = nil
    end
    self.buffStartAdding = false
  else
    self:StartBuffAdding()
  end
end

function bs_108301:StartBuffAdding()
  if self.buffStartAdding then
    return
  end
  self.buffStartAdding = true
  self.buffadd = LuaSkillCtrl:StartTimer(nil, self.arglist[5], function()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_kaiji, 1)
    self:OnCheckBuffNum()
  end, nil, -1, 0)
end

function bs_108301:OnAfterAddBuff(buff, target)
  if target ~= nil and target.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_biaoji, 1, nil, true)
    self.buffKaiJNum = self.buffKaiJNum + 1
    if self.buffKaiJNum >= self.arglist[9] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_kaiji, 1)
      self.buffKaiJNum = 0
    end
  end
end

function bs_108301:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_ranjie and target ~= nil and target.belongNum ~= eBattleRoleBelong.neutral and target.hp > 0 and target:GetBuffTier(self.config.buffId_biaoji) >= 1 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_biaoji, 0)
  end
end

function bs_108301:OnBeforBuffDispel(target, context)
  if context.buffId == self.config.buffId_ranjie and target ~= nil and target.belongNum ~= eBattleRoleBelong.neutral and target:GetBuffTier(self.config.buffId_biaoji) >= 1 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_biaoji, 0)
  end
end

function bs_108301:OnRoleDie(killer, role)
  if role:GetBuffTier(self.config.buffId_biaoji) ~= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_kaiji, 5)
    self:OnCheckBuffNum()
  end
end

function bs_108301:OnShaleBuffAdd(target, time)
  if time then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_qiyou, 1, self.arglist[2])
  else
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_qiyou, 1)
  end
end

function bs_108301:OnCasterDie()
  if self.buffadd ~= nil then
    self.buffadd:Stop()
    self.buffadd = nil
  end
  base.OnCasterDie(self)
end

function bs_108301:LuaDispose()
  base.LuaDispose(self)
end

return bs_108301
