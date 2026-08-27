local bs_17040 = class("bs_17040", LuaSkillBase)
local base = LuaSkillBase
bs_17040.config = {
  effectId = 60617,
  effectIdAttack = 60616,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17040:ctor()
end

function bs_17040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_17040_3", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.attackNum = 0
  self.typenum = 2
  self.flag = 1
end

function bs_17040:OnAfterPlaySkill(battleSkill, role)
  if self:IsReadyToTake() then
    local targetL = self.caster.recordTable.lastAttackRole
    self.attackNum = self.attackNum + 1
    self:CheckAndAddBuffToTarget(role, targetL)
  end
end

function bs_17040:CheckAndAddBuffToTarget(sender, target)
  if sender ~= nil and sender.hp > 0 and self.attackNum >= self.arglist[2] then
    local belongNum = 2
    local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(belongNum)
    if grid ~= nil then
      local targetL = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
      if targetL ~= nil then
        LuaSkillCtrl:CallEffect(targetL, self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
    self.attackNum = 0
  end
end

function bs_17040:SkillEventFunc(effect, eventId, target)
  local targetL = LuaSkillCtrl:GetRoleWithPos(target.x, target.y)
  if eventId == eBattleEffectEvent.Trigger and targetL ~= nil and targetL.belongNum == 2 then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, targetL)
    LuaSkillCtrl:CallEffect(targetL, self.config.effectId, self, nil)
    local tar = targetL
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, tar, self.typenum, self.arglist[1], true)
    if self.caster.recordTable["25211_Flag"] == true then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.caster.recordTable["25211_arg"] + self.arglist[1]
      }, true)
    else
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[1]
      }, true)
    end
    skillResult:EndResult()
  end
end

function bs_17040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17040
