local bs_214001 = class("bs_214001", LuaSkillBase)
local base = LuaSkillBase
bs_214001.config = {buff_dodge = 214003, buff_dodge_neg = 214004}
local blindList = {
  108006,
  108008,
  115,
  3012,
  450000115,
  450003012,
  301201,
  1009032,
  208401
}

function bs_214001:ctor()
end

function bs_214001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_214001_1", 999, self.OnSetHurt, {
    target = self.caster,
    senderBelongNum = eBattleRoleBelong.player
  })
  self:AddAfterAddBuffTriggerForTable("bs_214001_3", 1, self.OnAfterAddBuff, {
    target = self.caster,
    senderBelongNum = eBattleRoleBelong.player,
    buffType = eBuffType.Debeneficial
  })
  self:AddAfterBuffRemoveTriggerForTable("bs_214001_4", 1, self.OnAfterBuffRemove, {
    target = self.caster,
    buffType = eBuffType.Debeneficial
  })
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_214001_5", 1, self.OnAfterBattleStart)
  self.rate_dodge = self.arglist[1]
  self.isblind = false
end

function bs_214001:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_dodge, 1)
end

function bs_214001:OnSetHurt(context)
  if context.target == self.caster and context.sender.belongNum == eBattleRoleBelong.player and LuaSkillCtrl:CallRange(1, 1000) <= self.rate_dodge and not self.isblind then
    context.hurt = 0
  end
end

function bs_214001:OnAfterAddBuff(buff, target)
  for k, v in pairs(blindList) do
    if target:GetBuffTier(v) > 0 then
      self.isblind = true
      break
    end
  end
  if self.isblind == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_dodge, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_dodge_neg, 1, 9999, true)
  end
end

function bs_214001:OnAfterBuffRemove(buff, target, removeType)
  self.isblind = false
  for k, v in pairs(blindList) do
    if target:GetBuffTier(v) > 0 then
      self.isblind = true
      break
    end
  end
  if self.isblind == false then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_dodge, 1, 9999, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_dodge_neg, 0, true)
  end
end

function bs_214001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_214001
