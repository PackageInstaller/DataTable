local bs_30043 = class("bs_30043", LuaSkillBase)
local base = LuaSkillBase
bs_30043.config = {
  buffId = 2171,
  buffId_live = 3009,
  effect_revenge = 12096,
  effect_live = 1047,
  effect_loop = 1020
}

function bs_30043:ctor()
end

function bs_30043:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_30043_10", 1, self.OnRoleDie)
  self:AddSetDeadHurtTrigger("bs_30043_1", 2, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.character)
  self.isLastOne = false
  self.isFirstTime = true
end

function bs_30043:OnRoleDie(killer, role)
  if role.belongNum ~= eBattleRoleBelong.player or role.roleType ~= eBattleRoleType.character or self.isFirstTime == false then
    return
  end
  local roles = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, roles.Count - 1 do
    if roles[i].roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffId, 1, nil, true)
    end
  end
  self:checkRolesCount()
end

function bs_30043:checkRolesCount()
  local checkList = LuaSkillCtrl:CallTargetSelect(self, 501101, 10)
  if checkList.Count == 1 then
    local role = checkList[0].targetRole
    if role.roleType == eBattleRoleType.character and role:GetBuffTier(self.config.buffId) ~= nil and 0 < role:GetBuffTier(self.config.buffId) then
      self.isLastOne = true
      self.effect = LuaSkillCtrl:CallEffect(checkList[0].targetRole, self.config.effect_loop, self)
    end
  end
end

function bs_30043:OnSetDeadHurt(context)
  local tier = context.target:GetBuffTier(self.config.buffId)
  if self.isLastOne and tier ~= nil and 0 < tier then
    local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
    if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and 0 >= context.target:GetBuffTier(self.config.nanaka_buffId) and self.isFirstTime == true and NoDeath == false then
      self.isFirstTime = false
      LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 15, true)
    end
    local killer = context.sender
    local role = context.target
    local selectTable = {}
    local originTable = self.caster.recordTable["30043"]
    for k, v in ipairs(originTable) do
      if v ~= -1 then
        selectTable[#selectTable + 1] = v
      end
    end
    local randTable = {}
    for i = 1, tier do
      local rand = LuaSkillCtrl:CallRange(1, #selectTable)
      randTable[#randTable + 1] = selectTable[rand]
      table.remove(selectTable, rand)
    end
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnRevengeCall, killer, role, randTable)
    LuaSkillCtrl:CallEffect(context.target, self.config.effect_live, self, nil, context.target)
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end
end

function bs_30043:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_30043:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_30043
