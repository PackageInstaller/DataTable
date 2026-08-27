local bs_213201 = class("bs_213201", LuaSkillBase)
local base = LuaSkillBase
bs_213201.config = {
  effectId_bomb_loop = 203202,
  effectId_bomb = 203201,
  effectId_hurt = 203203,
  time_count = 15,
  buffid_boom = 213202,
  buffid_red = 213201,
  buff_weak = 213301,
  ready_actionId = 1007,
  action_speed = 1,
  select_id = 5,
  select_range = 0,
  HurtConfig = {
    hit_formula = 0,
    crit_formula = 0,
    basehurt_formula = 3000
  }
}

function bs_213201:ctor()
end

function bs_213201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.SummonerCaster)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_213201_1", 1, self.OnBeforeBattleEnd)
  self.arg_timer_ready = self.arglist[1]
  self.arg_timer_boom = self.arglist[2]
  self.arg_dam = self.arglist[3]
end

function bs_213201:SummonerCaster(summonerEntity)
  local boomtimer = BindCallback(self, self.Boomtimer)
  if summonerEntity == self.caster then
    self.issummon = true
    self.arg_timer_ready = self.caster.recordTable.arg_timer_ready
    self.arg_timer_boom = self.caster.recordTable.arg_timer_boom
    self.arg_dam = self.caster.recordTable.arg_dam
    self:CallCasterWait(self.arg_timer_ready)
    self.readytimer = LuaSkillCtrl:StartTimer(nil, self.arg_timer_ready, boomtimer, nil, 0, 0)
  end
end

function bs_213201:Boomtimer()
  local skill_left = 0
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_red, 1)
  self.timer_boom_effct = LuaSkillCtrl:StartTimer(nil, self.config.time_count, function()
    self.boom_effect_loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bomb_loop, self)
    local Scalefix = math.min(1 + skill_left ^ 2 * 200 // 1000, 2)
    if not self.caster.isDead == true then
      LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(Scalefix, Scalefix, Scalefix), 15)
    end
    LuaSkillCtrl:EffectSetCountValue(self.boom_effect_loop, skill_left)
    if (skill_left + 1) * self.config.time_count > self.arg_timer_boom and self.caster.hp > 0 then
      LuaSkillCtrl:RemoveLife(self.caster.hp, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    end
    skill_left = skill_left + 1
  end, nil, -1, self.config.time_count)
end

function bs_213201:Boom()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_bomb, self)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
      local dam = self.arg_dam
      if self.issummon and 0 < targetList[i]:GetBuffTier(self.config.buff_weak) then
        self.arg_dam_plus = self.caster.recordTable.arg_dam_plus
        local buffTier = targetList[i]:GetBuffTier(self.config.buff_weak)
        dam = dam * (1000 + self.arg_dam_plus * buffTier) // 1000
      end
      LuaSkillCtrl:CallEffect(targetList[i], self.config.effectId_hurt, self)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {dam})
      skillResult:EndResult()
      if not LuaSkillCtrl:RoleContainsBuffFeature(targetList[i], eBuffFeatureType.NotBeSelected) then
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffid_boom, 1)
      end
    end
  end
end

function bs_213201:OnBeforeBattleEnd()
  self.caster.lsObject:ResetScaleTween()
end

function bs_213201:OnCasterDie()
  if self.timer_boom_effct ~= nil then
    self:Boom()
  end
  if self.boom_effect_loop ~= nil then
    self.boom_effect_loop:Die()
    self.boom_effect_loop = nil
  end
  if self.timer_boom_effct ~= nil then
    self.timer_boom_effct:Stop()
    self.timer_boom_effct = nil
  end
  if self.readytimer ~= nil then
    self.readytimer:Stop()
    self.readytimer = nil
  end
  base.OnCasterDie(self)
end

function bs_213201:LuaDispose()
  if self.boom_effect_loop ~= nil then
    self.boom_effect_loop:Die()
    self.boom_effect_loop = nil
  end
  if self.timer_boom_effct ~= nil then
    self.timer_boom_effct:Stop()
    self.timer_boom_effct = nil
  end
  if self.readytimer ~= nil then
    self.readytimer:Stop()
    self.readytimer = nil
  end
  if self.timer_boom ~= nil then
    self.timer_boom:Stop()
    self.timer_boom = nil
  end
  base.LuaDispose(self)
end

return bs_213201
