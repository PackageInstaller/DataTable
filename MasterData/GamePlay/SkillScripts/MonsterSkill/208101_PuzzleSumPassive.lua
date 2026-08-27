local bs_208101 = class("bs_208101", LuaSkillBase)
local base = LuaSkillBase
bs_208101.config = {
  buffId = 105001,
  buffId_tip = 105005,
  effectId_pass = 105016,
  effectId = 105004,
  summonerId = 88,
  buffId_3002 = 3002,
  selectId = 9,
  configId = 3
}
local SyncAttrList = {
  eHeroAttr.magic_res,
  eHeroAttr.def,
  eHeroAttr.pow,
  eHeroAttr.skill_intensity,
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.speed,
  eHeroAttr.crit,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.return_damage,
  eHeroAttr.life_steal,
  eHeroAttr.spell_life_steal,
  eHeroAttr.resistance
}

function bs_208101:ctor()
end

function bs_208101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
  self.arg1 = self.caster.recordTable.arg_1
  self.arg2 = self.caster.recordTable.arg_2
  self.arg3 = self.caster.recordTable.arg_3
  self.arg4 = self.caster.recordTable.arg_4
  self.summonerId = 88
end

function bs_208101:OnAfterBattleStart(role)
  if role == self.caster then
    LuaSkillCtrl:CallRoleAction(self.caster, 102, 1)
    self.tigger = true
    LuaSkillCtrl:StartTimer(nil, 1, function()
      self.tigger = false
    end)
    if self.effectHalo == nil then
      self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_pass, self)
    end
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
    local collisionEnter1 = BindCallback(self, self.OnCollisionEnter1)
    self.halo1 = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 175, 0, eColliderInfluenceType.Enemy, collisionEnter1, nil, nil, nil, false, false, nil, self.caster)
  end
end

function bs_208101:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId) < 1 and entity.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId, self.arg1, nil, true)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_tip, 1, nil)
  end
end

function bs_208101:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.buffId) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId, 0)
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_tip, 0)
  end
end

function bs_208101:OnCollisionEnter1(collider, index, entity)
  if self.tigger == true then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_3002, 1, self.arg2)
  end
end

function bs_208101:OnCasterDie()
  if self.arg3 ~= nil then
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    base.OnCasterDie(self)
    local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      local role = LuaSkillCtrl:GetRoleWithPos(grid.x, grid.y)
      if role ~= nil then
        grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
      end
      if grid == nil then
        grid = LuaSkillCtrl:FindEmptyGrid()
      end
      if grid == nil then
        return
      end
      if self.caster.resName == "puzzle_myth_statue" then
        self.summonerId = 90
      end
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.summonerId, grid.x, grid.y)
      summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arg3 // 1000)
      summoner:SetAttr(eHeroAttr.hp, self.caster.maxHp * self.arg3 // 1000)
      for i, v in ipairs(SyncAttrList) do
        local curValue = self.caster:GetRealProperty(v)
        summoner:SetAttr(v, curValue)
      end
      summoner:SetAsRealEntity(9)
      local arg1 = self.arg4
      local arg2 = self.caster.roleDataId
      local role = self.caster
      local arg3 = self.arg1
      local arg4 = self.arg2
      local tab = {
        arg_1 = arg1,
        arg_2 = arg2,
        role = role,
        arg_3 = arg3,
        arg_4 = arg4
      }
      summoner:SetRecordTable(tab)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    end, nil)
  else
    base.OnCasterDie(self)
  end
  if self.effectHalo ~= nil then
    self.effectHalo:Die()
    self.effectHalo = nil
  end
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
  if self.halo1 ~= nil then
    self.halo1:EndAndDisposeEmission()
    self.halo1 = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_208101:LuaDispose()
  base.LuaDispose(self)
  if self.halo ~= nil then
    self.halo:EndAndDisposeEmission()
    self.halo = nil
  end
  if self.halo1 ~= nil then
    self.halo1:EndAndDisposeEmission()
    self.halo1 = nil
  end
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.effectHalo = nil
  self.halo = nil
  self.halo1 = nil
  self.timer = nil
end

return bs_208101
