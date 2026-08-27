local bs_215001 = class("bs_215001", LuaSkillBase)
local base = LuaSkillBase
bs_215001.config = {
  buffId_Boss = 3017,
  buffid1 = 215004,
  effectId_show = 215003,
  effectId_hide = 215003,
  effectId_summon = 215004,
  actionId = 1059,
  action_time = 51,
  actionId_start = 1048,
  action_start_time = 30,
  effect_trail02 = 215024
}

function bs_215001:ctor()
end

local SyncAttrList = {
  eHeroAttr.moveSpeed,
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

function bs_215001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_215001_1", 1999, self.OnSetDeadHurt, nil, self.caster, nil, nil)
  self.SummonerTable = {
    101,
    102,
    103,
    104,
    105
  }
  self.table = {}
  self.Count = 0
  self.isInDeading = false
  self:AddOnRoleDieTrigger("bs_215001_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
end

function bs_215001:OnSetDeadHurt(context)
  if self.isInDeading then
    return
  end
  if context.target == self.caster then
    local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
    if NoDeath == false then
      self:CallCasterWait(self.config.action_start_time)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start, 1)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid1, 1, nil, true)
      LuaSkillCtrl:StartTimer(nil, self.config.action_start_time, function()
        LuaSkillCtrl:SetRoleVisible(self.caster, false)
        LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, nil, true)
      end, nil)
      for i = 1, 5 do
        LuaSkillCtrl:StartTimer(self, i * 4, function()
          self:Summon(i)
        end, nil)
      end
      self.isInDeading = true
    end
  end
end

function bs_215001:Summon(num)
  local Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  if Grid == nil then
    Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  end
  local summonerEntity
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_summon, self)
    local summoner
    summoner = LuaSkillCtrl:CreateSummoner(self, self.SummonerTable[num], Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[1] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[2] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[2] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, self.caster.moveSpeed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.lucky, self.lucky)
    summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder)
    summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen)
    local hostEntity = self.caster
    if hostEntity == nil or hostEntity.hp <= 0 then
      return over
    end
    for i, v in ipairs(SyncAttrList) do
      local curValue = self.caster:GetRealProperty(v)
      summoner:SetAttr(v, curValue)
    end
    summoner:SetAsRealEntity(1)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.table[num] = summonerEntity
    self.Count = self.Count + 1
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffid1, 1, 4 * (6 - num), true)
  end
end

function bs_215001:OnRoleDie(killer, role)
  if role == self.table[1] then
    self.table[1] = nil
    self.Count = self.Count - 1
  elseif role == self.table[2] then
    self.table[2] = nil
    self.Count = self.Count - 1
  elseif role == self.table[3] then
    self.table[3] = nil
    self.Count = self.Count - 1
  elseif role == self.table[4] then
    self.table[4] = nil
    self.Count = self.Count - 1
  elseif role == self.table[5] then
    self.table[5] = nil
    self.Count = self.Count - 1
  end
  if self.Count == 0 and self.isInDeading then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:SetRoleVisible(self.caster, true)
    local time = self.config.action_time + 35
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, 1)
    LuaSkillCtrl:StartTimer(nil, self.config.action_time, function()
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnEosPassive01)
    end, nil)
    LuaSkillCtrl:StartTimer(nil, self.config.action_time + 24, function()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid1, 1)
      LuaSkillCtrl:DispelBuff(self.caster, 170, 1)
    end, nil)
  end
end

function bs_215001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_215001
