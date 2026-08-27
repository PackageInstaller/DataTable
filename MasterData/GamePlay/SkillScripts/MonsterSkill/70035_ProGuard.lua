local bs_70035 = class("bs_70035", LuaSkillBase)
local base = LuaSkillBase
bs_70035.config = {
  timeDuration = 15,
  animID = 1002,
  animLoopTime = 30,
  formula1 = 10153,
  formula2 = 10154,
  formula3 = 10155,
  nanaka_buffId = 102603,
  buffId_endure = 198,
  buffId_cantSelect = 60501,
  buffId_slow = 60502,
  buffId_live = 3009,
  campNotBeSelectBuff = 50,
  audioId1 = 389,
  audioId2 = 390
}

function bs_70035:ctor()
end

function bs_70035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70035_1", 0, self.OnAfterBattleStart)
  self:AddSetHealTrigger("bs_70035_5", 1, self.OnSetHeal, nil, self.caster)
  self:AddBeforeAddBuffTrigger("bs_70035_6", 1, self.OnBeforeAddBuff, nil, self.caster, eBattleRoleBelong.player)
  self.caster.recordTable.IsGuardPro = true
end

function bs_70035:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_endure, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_cantSelect, 1, nil, true)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targetlist.Count <= 0 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.belongNum ~= 0 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_slow, 1, nil, true)
    end
  end
end

function bs_70035:OnSetHeal(context)
  if context.target == self.caster then
    context.heal = 0
  end
end

function bs_70035:OnSetHurt(context)
  if context.target == self.caster then
    local hurt = self.caster.maxHp // self.arglist[1] + 1
    context.hurt = hurt
  end
end

function bs_70035:OnBeforeAddBuff(target, context)
  if context.buff.maker == self.caster then
    return
  end
  context.active = false
end

function bs_70035:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:ForceEndBattle(false)
end

return bs_70035
