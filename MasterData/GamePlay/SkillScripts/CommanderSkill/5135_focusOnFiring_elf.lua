local bs_5135 = class("bs_5135", LuaSkillBase)
local base = LuaSkillBase
bs_5135.config = {
  buffId = 513101,
  buffId_range = 513202,
  buffId_ex = 513201,
  effectId_line = 513102,
  effectId_target = 513101,
  selectTargetId = 2,
  buff_damageAdd = 513501,
  buff_atkSpeed = 513502,
  buffId_ex = 513201
}
bs_5135.AbandonTakeFeature = {
  eBuffFeatureType.BeatBack
}

function bs_5135:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeTargetSelect, "bs_5131_1", 1, self.BeforeSelect)
  self:AddAfterBuffRemoveTrigger("bs_5131_4", 1, self.OnAfterBuffRemove, nil, nil, self.config.buffId_ex)
  self:AddSetDeadHurtTrigger("bs_5132_2", 1, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_5131_3", 1, self.BeforeBattleEnd)
  self.onFireRole = nil
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_5135_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_5132_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_5135:BeforeSelect(cskill, sender, context)
  if sender == self.caster and cskill == self.cskill and context.Id ~= self.config.selectTargetId then
    self:ChangeNeutralBelong()
  end
end

function bs_5135:ChangeNeutralBelong()
  local readyType = CS.BattleFloorTile.BattleGridEfcType.ready
  if LuaSkillCtrl.IsInVerify then
    return
  end
  local skillInputCtrl = LuaSkillCtrl.battleCtrl.PlayerController.battleSkillInputController
  if skillInputCtrl == nil then
    return
  end
  local tileCtrl = skillInputCtrl.tileController
  if tileCtrl == nil then
    return
  end
  local neutrals = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if neutrals == nil or neutrals.Count <= 0 then
    return
  end
  for i = 0, neutrals.Count - 1 do
    local neutralRole = neutrals[i]
    if not neutralRole.unableSelect and neutralRole.belongNum ~= eBattleRoleBelong.enemy then
      local tile = tileCtrl:GetFloorTile(neutralRole.curCoord)
      if tile ~= nil then
        tile:HighlightSelectEfc(readyType)
        skillInputCtrl:ShowRoleSelectUI(tile.Coord, readyType)
        skillInputCtrl.waitSelectedRoleTiles:Add(tile)
        skillInputCtrl.waitSelectRoles:Add(neutralRole)
        if not skillInputCtrl.waitSelectRoleDict:ContainsKey(neutralRole) then
          skillInputCtrl.waitSelectRoleDict:Add(neutralRole, tile)
        end
      end
    end
  end
end

function bs_5135:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5135:CallSelectExecute(role)
  if role == nil or role.hp <= 0 then
    return
  end
  local targets = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, 10)
  if targets == nil or 0 >= targets.Count then
    return
  end
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId_ex, 1, self.arglist[1], true)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_damageAdd, 1, self.arglist[1], true)
  for i = 0, targets.Count - 1 do
    local playerRole = targets[i].targetRole
    LuaSkillCtrl:CallEffect(role, self.config.effectId_line, self, nil, playerRole)
    LuaSkillCtrl:CallBuff(self, playerRole, self.config.buffId, 1, self.arglist[1], false, role)
    if 1 < playerRole.attackRange then
      LuaSkillCtrl:CallBuff(self, playerRole, self.config.buffId_range, 1, self.arglist[1])
    end
  end
  self:RecoverRoleBelong()
  if role.belongNum == eBattleRoleBelong.neutral then
    if role.collider ~= nil then
      local skillCollisionCtrl = LuaSkillCtrl.battleCtrl.skillCollisionController
      if skillCollisionCtrl ~= nil then
        skillCollisionCtrl:RemoveCollider(role.collider, role.belong)
        role.collider:Dispose()
        role.collider = nil
      end
    end
    if role.roleType == eBattleRoleType.realSummoner then
      role.summoner.belong = CS.Belong.enemy
    else
      role._thisBelong = CS.Belong.enemy
    end
    self.onFireRole = role
  end
end

function bs_5135:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack and skill.maker.belongNum == self.caster.belongNum then
    local target = role.recordTable.lastAttackRole
    if target ~= nil and target.belongNum ~= self.caster.belongNum and target:GetBuffTier(self.config.buffId_ex) > 0 then
      LuaSkillCtrl:CallBuff(self, role, self.config.buff_atkSpeed, 1, self.arglist[4], true)
    end
  end
end

function bs_5135:OnSetHurt(context)
  if context.target.hp <= 0 or context.target:GetBuffTier(self.config.buffId_ex) < 1 then
    return
  end
  context.hurt = context.hurt * (self.arglist[5] + 1000) // 1000
end

function bs_5135:OnAfterBuffRemove(buffId, target, removeType)
  self:RecoverRoleBelong()
end

function bs_5135:OnSetDeadHurt(context)
  if context.target == self.onFireRole then
    self:RecoverRoleBelong()
  end
end

function bs_5135:BeforeBattleEnd()
  self:RecoverRoleBelong()
end

function bs_5135:LuaDispose()
  base.LuaDispose(self)
  self.onFireRole = nil
end

function bs_5135:RecoverRoleBelong()
  if self.onFireRole ~= nil then
    if self.onFireRole.roleType == eBattleRoleType.realSummoner then
      self.onFireRole.summoner.belong = CS.Belong.neutral
    else
      self.onFireRole._thisBelong = CS.Belong.neutral
    end
    self.onFireRole:InitSkillCollider()
    self.onFireRole = nil
  end
end

return bs_5135
