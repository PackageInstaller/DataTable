local card_20027 = class("card_20027", LuaSkillBase)
local base = LuaSkillBase
card_20027.config = {
  buffId = 66,
  effectId = 10968,
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 5,
    aoe_range = 1
  },
  hurt_config = {
    hit_formula = 0,
    crit_formula = 0,
    basehurt_formula = 502
  }
}

function card_20027:ctor()
end

function card_20027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.count = 0
  self.damg = 0
  self.extradamg = 0
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_20027_1", 1, self.OnAfterBattleStart)
end

function card_20027:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function card_20027:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist ~= nil and targetlist.Count > 0 then
    for i = targetlist.Count - 1, 0, -1 do
      local target = targetlist[i]
      if target ~= nil then
        self.damg = self.damg + target.maxHp * self.arglist[2] // 1000
      end
    end
  end
  local summonList = LuaSkillCtrl:CallTargetSelect(self, 73, 10)
  if summonList ~= nil and summonList.Count > 0 then
    for i = summonList.Count - 1, 0, -1 do
      local summon = summonList[i].targetRole
      if summon ~= nil and summon.belongNum == eBattleRoleBelong.player then
        self.count = self.count + 1
      end
    end
  end
  self.extradamg = self.count * self.arglist[3]
  local targetlist1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist1 ~= nil and targetlist1.Count > 0 then
    for i = targetlist1.Count - 1, 0, -1 do
      local target1 = targetlist1[i]
      if target1 ~= nil then
        local damg = self.damg * (1000 + self.extradamg) // 1000
        LuaSkillCtrl:RemoveLife(damg, self, target1, true, nil, true, true, eHurtType.RealDmg)
      end
    end
  end
  local target2 = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target2, self.config.effectId, self)
  self.count = 0
  self.damg = 0
  self.extradamg = 0
end

function card_20027:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20027
