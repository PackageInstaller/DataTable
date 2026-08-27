local bs_21252 = class("bs_21252", LuaSkillBase)
local base = LuaSkillBase
bs_21252.config = {
  buffId1 = 2207,
  buffId2 = 2208,
  buffId3 = 214004,
  effect1 = 105703
}
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

function bs_21252:ctor()
end

function bs_21252:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21252_2", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_21252_1", 1, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, nil)
  self:AddAfterAddBuffTriggerForTable("bs_21252_2", 1, self.OnAfterAddBuff, {
    target = self.caster,
    senderBelongNum = eBattleRoleBelong.player,
    buffType = eBuffType.Debeneficial
  })
  self.isblind = false
end

function bs_21252:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true, nil, true)
end

function bs_21252:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss and sender == self.caster then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, self.arglist[3], true, self.caster, true)
end

function bs_21252:OnAfterAddBuff(buff, target)
  for k, v in pairs(blindList) do
    if target:GetBuffTier(v) > 0 then
      self.isblind = true
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, self.arglist[4], true)
      break
    end
  end
end

function bs_21252:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21252
