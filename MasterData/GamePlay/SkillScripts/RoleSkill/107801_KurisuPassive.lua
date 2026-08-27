local bs_107801 = class("bs_107801", LuaSkillBase)
local base = LuaSkillBase
bs_107801.config = {
  monsterId = 79,
  effect_self = 107803,
  effect_castend = 107804,
  buffid_counter = 107801,
  buffid_wudi = 107802,
  buffid_attack = 107804,
  max_cookTier = 5,
  buffFeature_ignoreDie = 6,
  buffId_63 = 63
}

function bs_107801:ctor()
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

function bs_107801:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_107801_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffid_counter)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self.OnKurisuSummonerSkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, self.OnKurisuSummonerHurt)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_107801_1", 1, self.BeforeEndBattle)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRecoverHeal, self.OnRecoverHeal)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107801_2", 2, self.OnAfterBattleStart)
  self.energyNum = 0
  self.energyP1 = self.arglist[1]
  self.energyP2 = self.arglist[2]
  self.energyPow = self.arglist[3] + self.arglist[2]
  self.attackChange = 0
  self.caster.recordTable.first_attack = self.arglist[5]
  self.caster.recordTable.tanshe_attack = self.arglist[6]
  self.table = {}
end

function bs_107801:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(self, 150, function()
    local tempTable = {}
    if self.table == nil and #self.table == 0 then
      return
    elseif self.table ~= nil then
      for j = 1, #self.table do
        local role = self.table[j]
        local targetList = LuaSkillCtrl:FindRolesAroundRole(role)
        if targetList ~= nil and targetList.Count ~= 0 then
          for i = 0, targetList.Count - 1 do
            if targetList[i].belongNum == 2 then
              local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 3)
              if grids ~= nil then
                for i = 0, grids.Count - 1 do
                  local grid = grids[i]
                  local pos = BattleUtil.XYCoord2Pos(grid.x, grid.y)
                  if tempTable[pos] == nil then
                    tempTable[pos] = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, role.x, role.y)
                  end
                end
                local resultGridPos
                local minDis = 99
                for k, v in pairs(tempTable) do
                  if v ~= nil then
                    if v == 3 then
                      resultGridPos = k
                      minDis = v
                      break
                    elseif resultGridPos == nil or v < minDis then
                      resultGridPos = k
                      minDis = v
                    end
                  end
                end
                if resultGridPos ~= nil then
                  local coordX, coordY = BattleUtil.Pos2XYCoord(resultGridPos)
                  local resultGrid = LuaSkillCtrl:GetGridWithPos(coordX, coordY)
                  LuaSkillCtrl:SetRolePos(resultGrid, role, true)
                  LuaSkillCtrl:CallEffect(role, self.config.effect_castend, self)
                  LuaSkillCtrl:StartTimer(self, 5, function()
                    if role.recordTable.lastAttackRole ~= nil then
                      role:LookAtTarget(role.recordTable.lastAttackRole)
                    end
                  end, self)
                end
                break
              end
            end
          end
        end
      end
    end
  end, self, -1)
end

function bs_107801:Summon()
  self:CallCasterWait(10)
  LuaSkillCtrl:CallRoleAction(self.caster, 1020, 1)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_self, self)
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  end
  if Grid ~= nil then
    self:doSummon(Grid)
  end
end

function bs_107801:doSummon(Grid)
  local tab = {}
  local summonerEntity
  local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
  summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
  summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
  summoner:SetAttr(eHeroAttr.moveSpeed, 0)
  local hostEntity = self.caster
  if hostEntity == nil or 0 >= hostEntity.hp then
    return
  end
  for i, v in ipairs(SyncAttrList) do
    local curValue = self.caster:GetRealProperty(v)
    summoner:SetAttr(v, curValue)
  end
  summoner:SetAsRealEntity(9)
  summoner:SetRecordTable(tab)
  summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if self.table[1] == nil or self.table[1].hp == 0 then
    self.table[1] = summonerEntity
  elseif self.table[2] == nil or self.table[2].hp == 0 then
    self.table[2] = summonerEntity
  end
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effect_castend, self)
  LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffid_wudi, 1, nil, false)
end

function bs_107801:OnAfterAddBuff(buff, target)
  if target ~= self.caster or self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local tempattacktype = self.attackChange
  self.energyNum = self.caster:GetBuffTier(self.config.buffid_counter)
  self:CheckEnergyNum(self.energyNum)
  if self.energyNum >= self.energyPow then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlayChang, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid_counter, self.arglist[3])
  elseif self.energyNum >= self.energyP2 then
    self.attackChange = 2
  elseif self.energyNum >= self.energyP1 then
    self.attackChange = 1
  end
  if tempattacktype ~= self.attackChange then
    self:Summon()
  end
end

function bs_107801:ShowEnergyCounting(nowCount, phase)
  if nowCount == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  if phase == 0 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.config.max_cookTier)
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
    return
  end
  if phase == 1 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.config.max_cookTier)
    LuaSkillCtrl:SetCountingColor(self.caster, 0, 203, 250, 255)
    return
  end
  if phase == 2 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.config.max_cookTier)
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 0, 0, 255)
    return
  end
end

function bs_107801:CheckEnergyNum(EnergyNum)
  local nowCount = EnergyNum % 10 // 2
  local phase = 0
  if 20 <= EnergyNum then
    phase = 2
  elseif 10 < EnergyNum then
    phase = 1
  else
    phase = 0
  end
  self:ShowEnergyCounting(nowCount, phase)
end

function bs_107801:OnRecoverHeal(role)
  if role == self.caster or role.roleDataId == 79 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_counter, self.arglist[7], nil, false)
  end
end

function bs_107801:BeforeEndBattle()
  self:ShowEnergyCounting(0, 0)
end

function bs_107801:OnCasterDie()
  base.OnCasterDie(self)
  self:ShowEnergyCounting(0, 0)
  self.table = nil
end

return bs_107801
