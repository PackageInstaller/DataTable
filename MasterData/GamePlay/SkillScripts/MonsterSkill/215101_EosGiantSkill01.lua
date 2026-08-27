local bs_215101 = class("bs_215101", LuaSkillBase)
local base = LuaSkillBase
bs_215101.config = {
  actionId = 1002,
  actionId_skill_time = 30,
  actionId_start_time = 15,
  action_speed = 1,
  effectId_Summon = 215104,
  effectId_loop = 215111,
  effectId_hit = 215103,
  HurtConfigID = 3,
  buffId_Boss = 3017
}

function bs_215101:ctor()
end

local SyncAttrList = {
  eHeroAttr.dodge,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.cd_reduce,
  eHeroAttr.resistance
}

function bs_215101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.SummonerTable = {
    54,
    54,
    55,
    56
  }
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_215101", 1, self.OnAfterBattleStart)
end

function bs_215101:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
end

function bs_215101:PlaySkill(data)
  local time = self.config.actionId_skill_time
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time, true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(nil, time, callnextskill)
end

function bs_215101:OnAttackTrigger(target, data)
  for i = 1, 4 do
    LuaSkillCtrl:StartTimer(self, i * 4, function()
      self:Summon(i)
    end, nil)
  end
end

function bs_215101:Summon(num)
  local Grid = LuaSkillCtrl:FindRandomEmptyGridsWithinRange(1, 1, 10, true)
  local summonerEntity
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_Summon, self)
    LuaSkillCtrl:StartTimer(nil, 8, function()
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
      local target_role = LuaSkillCtrl:GetRoleWithPos(Grid.x, Grid.y)
      if target_role ~= nil then
        local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(Grid.x, Grid.y, 10)
        if gridList ~= nil then
          LuaSkillCtrl:SetRolePos(gridList[0], target_role, true)
        end
      end
      local summoner
      summoner = LuaSkillCtrl:CreateSummoner(self, self.SummonerTable[num], Grid.x, Grid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[1] // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[2] // 1000)
      summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[2] // 1000)
      summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
      summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[3] // 1000)
      summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[3] // 1000)
      summoner:SetAttr(eHeroAttr.moveSpeed, 300)
      summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder)
      summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen)
      local hostEntity = self.caster
      if hostEntity == nil or 0 >= hostEntity.hp then
        return over
      end
      for i, v in ipairs(SyncAttrList) do
        local curValue = self.caster:GetRealProperty(v)
        summoner:SetAttr(v, curValue)
      end
      summoner:SetAsRealEntity(1)
      summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      local targetlist = LuaSkillCtrl:FindRolesAroundGrid(Grid, 1)
      if targetlist ~= nil and 0 < targetlist.Count then
        for i = targetlist.Count - 1, 0, -1 do
          local role = targetlist[i]
          if role.belongNum ~= eBattleRoleBelong.enemy then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
            LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
              self.arglist[4]
            }, true)
            skillResult:EndResult()
            LuaSkillCtrl:CallBuff(self, role, 66, 1, self.arglist[5])
          end
        end
      end
    end, nil)
  end
end

function bs_215101:EndSkillAndCallNext()
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_215101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_215101
