local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1019012 = class("bs_1019012", base)
bs_1019012.config = {
  monsterId = 10014,
  effectId1 = 10687,
  effectId2 = 10686,
  effectId3 = 10699,
  effectId_db = 10700,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10081,
    crit_formula = 0,
    crithur_ratio = 0
  },
  buffId_229 = 22901,
  skill_time = 47,
  start_time = 27,
  actionId = 1002,
  action_speed = 1,
  audioId1 = 219,
  audioId2 = 220
}

function bs_1019012:ctor()
end

function bs_1019012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1019012_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_1019012_10", 1, self.OnRoleDie)
  self.summonerEntity = nil
end

function bs_1019012:OnAfterBattleStart()
  if LuaSkillCtrl.IsInTDBattle ~= true then
    self:PlaySkill()
  end
end

function bs_1019012:PlaySkill()
  if self.caster.hp <= 0 then
    return
  end
  local Grid = LuaSkillCtrl:FindRoleLeftEmptyGrid(self.caster, 10)
  if Grid == nil then
    Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  end
  if Grid ~= nil then
    local speed = self.caster.speed
    speed = speed + self.arglist[6]
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.skill_intensity * self.arglist[1] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.skill_intensity * self.arglist[2] // 1000)
    summoner:SetAttr(eHeroAttr.speed, speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, self.caster.moveSpeed)
    summoner:SetAttr(eHeroAttr.def, self.caster.skill_intensity * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.skill_intensity * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.lucky, self.arglist[5])
    summoner:SetAsRealEntity(1)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, self.config.start_time)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_229, 1, self.config.skill_time - 2)
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
    local maxhp = self.caster.skill_intensity * self.arglist[1] // 1000 * 10
    self.summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallBuff(self, self.summonerEntity, 270, 1, 27, true)
    LuaSkillCtrl:StartTimer(nil, 26, function()
      if self.caster == nil or self.caster.hp <= 0 then
        LuaSkillCtrl:RemoveLife(maxhp, self, self.summonerEntity, true, nil, false, true, 2)
      end
    end)
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, Grid, summoner, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleAction(self, self.config.actionId, 1)
    LuaSkillCtrl:StartTimer(nil, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
    self.effect2 = LuaSkillCtrl:CallEffect(target, self.config.effectId_db, self, nil, nil, nil, true)
  end
end

function bs_1019012:OnAttackTrigger(grid, summoner, target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  self.caster.recordTable.sum = true
  LuaSkillCtrl:StartTimer(nil, 10, function()
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
  end)
end

function bs_1019012:OnRoleDie(killer, role)
  if role == self.summonerEntity then
    self.caster.recordTable.sum = false
    self.again = LuaSkillCtrl:StartTimer(nil, self.arglist[4], function()
      if self.again ~= nil and self.again:IsOver() then
        self.again = nil
      end
      self:PlaySkill()
    end, self)
  end
end

function bs_1019012:OnCasterDie()
  base.OnCasterDie(self)
  if self.again ~= nil then
    self.again:Stop()
    self.again = nil
  end
end

function bs_1019012:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
  self.effect2 = nil
  self.summonerEntity = nil
  if self.again ~= nil then
    self.again:Stop()
    self.again = nil
  end
end

return bs_1019012
