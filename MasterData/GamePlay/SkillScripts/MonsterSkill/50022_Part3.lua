local base = require("GamePlay.SkillScripts.MonsterSkill.50023_equipmentCommonSkill")
local bs_50022 = class("bs_50022", base)
bs_50022.config = {
  selectId_Portal = 10001,
  buffId_fly = 5002201,
  attack_time = 10,
  effectId_attack = 5002201,
  effectId_hit = 5002202,
  effectId_body = 5002203,
  phaseMove_unselectId = 63
}

function bs_50022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_50022_1", 1, self.AfterBuffRemove, nil, nil, self.config.phaseMove_unselectId)
end

function bs_50022:OnAfterBattleStart()
  local caster = LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(self.caster)
  self.skill = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.OnPortal, caster), nil, -1, self.arglist[1] - 3)
end

function bs_50022:OnPortal(caster)
  local target = caster.recordTable.lastAttackRole
  if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral or not LuaSkillCtrl:IsAbleAttackTarget(caster, target, 1) then
    local num = 1 - caster.attackRange
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_Portal, num, caster)
    if 0 < targetList.Count then
      target = targetList[0].targetRole
    end
  end
  if target ~= nil and target.hp > 0 and LuaSkillCtrl:IsAbleAttackTarget(caster, target, 1) then
    LuaSkillCtrl:CallRoleAction(self.caster, 1002, 1)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_attack, self)
    if target.intensity == 0 and target.belongNum == eBattleRoleBelong.neutral then
      return
    end
    LuaSkillCtrl:StartTimer(self, self.config.attack_time, function()
      if target ~= nil and target.hp > 0 then
        local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(target.x, target.y, 10, true)
        if gridList == nil then
          return
        end
        if 0 < gridList.Count then
          LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
          local grid = gridList[0]
          if grid ~= nil and not LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.CtrlImmunity) then
            LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fly, 1, 15, true)
            LuaSkillCtrl:CallPhaseMove(self, target, grid.x, grid.y, 15, self.config.phaseMove_unselectId)
            LuaSkillCtrl:CallEffect(target, self.config.effectId_body, self)
          end
        end
      end
    end)
  end
end

function bs_50022:AfterBuffRemove(buffId, target, removeType)
  LuaSkillCtrl:CallRedisplayInSkillInputCtrl(target)
end

function bs_50022:OnCasterDie()
  base.OnCasterDie(self)
  if self.skill ~= nil then
    self.skill:Stop()
    self.skill = nil
  end
end

return bs_50022
