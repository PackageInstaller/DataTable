local bs_4001222 = class("bs_4001222", LuaSkillBase)
local base = LuaSkillBase
bs_4001222.config = {
  buffId = 2057,
  buffId2 = 3002,
  buffTime = 75,
  scale = 1.5
}

function bs_4001222:ctor()
end

function bs_4001222:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001222_1", 1, self.OnAfterBattleStart)
  self:AddBuffDieTrigger("bs_4001222_2", 1, self.OnBuffDie, nil, eBattleRoleBelong.player, self.config.buffId)
end

function bs_4001222:OnAfterBattleStart()
  local targetChoose = LuaSkillCtrl:CallTargetSelect(self, 69, 10)
  local flag = false
  local duration = self.arglist[4]
  if targetChoose.Count == 0 then
    return
  end
  if flag == false and targetChoose[0].targetRole == self.caster then
    local Hp_pre = targetChoose[0].targetRole.maxHp
    LuaSkillCtrl:CallBuff(self, targetChoose[0].targetRole, self.config.buffId, 1, duration)
    local Hp_ed = targetChoose[0].targetRole.maxHp
    local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    for i = 0, enemyList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, enemyList[i].targetRole, self.config.buffId2, 1, duration)
    end
    LuaSkillCtrl:CallStartLocalScale(targetChoose[0].targetRole, Vector3.New(self.config.scale, self.config.scale, self.config.scale), 0.5)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetChoose[0].targetRole)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {
      Hp_ed - Hp_pre
    }, true, true)
    flag = true
  end
end

function bs_4001222:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1), 0.5)
end

function bs_4001222:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001222
