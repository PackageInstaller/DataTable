local bs_70015 = class("bs_70015", LuaSkillBase)
local base = LuaSkillBase
bs_70015.config = {
  monsterId = 1011,
  equipmentSummonerId = 1002,
  effectId = 12024,
  effectId_start = 5002205
}

function bs_70015:ctor()
end

function bs_70015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_70015:CheckManualSkillTakeAvailable(role)
  if role ~= nil then
    return false
  end
  return base.CheckManualSkillTakeAvailable(self, role)
end

function bs_70015:PlaySkill(data, selectTargetCoord, selectRoles)
  if selectTargetCoord ~= nil then
    local targetGrid_role = LuaSkillCtrl:GetRoleWithPos(selectTargetCoord.x, selectTargetCoord.y)
    if targetGrid_role == nil then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, selectTargetCoord.x, selectTargetCoord.y)
      local roleNum = 5
      if self.caster.recordTable.roleNum ~= nil then
        roleNum = self.caster.recordTable.roleNum
      end
      if 0 < roleNum then
        local num, level = LuaSkillCtrl:GetDynPlayerChipCountAndLevelSum()
        local Finalhp = (1 + level * 150 // 1000) * 100000 // roleNum
        if self.caster.recordTable.totalHp ~= nil then
          Finalhp = (1 + level * 150 // 1000) * self.caster.recordTable.totalHp // roleNum
        end
        local Finalpow = (1 + level * 120 // 1000) * 5000 // roleNum
        if self.caster.recordTable.totalAtk ~= nil then
          Finalpow = (1 + level * 120 // 1000) * self.caster.recordTable.totalAtk // roleNum
        end
        local Finalintensity = (1 + level * 120 // 1000) * 5000 // roleNum
        if self.caster.recordTable.totalIntensity ~= nil then
          Finalintensity = (1 + level * 120 // 1000) * self.caster.recordTable.totalIntensity // roleNum
        end
        local FinalDef = 500
        if self.caster.recordTable.totalDef ~= nil then
          FinalDef = self.caster.recordTable.totalDef
        end
        local FinalRes = 500
        if self.caster.recordTable.totalMagicRes ~= nil then
          FinalRes = self.caster.recordTable.totalMagicRes
        end
        summoner:SetAttr(eHeroAttr.maxHp, Finalhp)
        summoner:SetAttr(eHeroAttr.pow, Finalpow)
        summoner:SetAttr(eHeroAttr.skill_intensity, Finalintensity)
        summoner:SetAttr(eHeroAttr.def, FinalDef // roleNum)
        summoner:SetAttr(eHeroAttr.magic_res, FinalRes // roleNum)
        summoner:SetAttr(eHeroAttr.speed, 100)
        summoner:SetAsRealEntity(1)
        local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
        self:CallSelectExecute(summonerEntity)
        LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
      end
    else
      local grid = LuaSkillCtrl:CallFindEmptyGridNearest(targetGrid_role)
      if grid == nil then
        return
      end
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, grid.x, grid.y)
      local roleNum = 5
      if self.caster.recordTable.roleNum ~= nil then
        roleNum = self.caster.recordTable.roleNum
      end
      if 0 < roleNum then
        local num, level = LuaSkillCtrl:GetDynPlayerChipCountAndLevelSum()
        local Finalhp = (1 + level * 150 // 1000) * 100000 // roleNum
        if self.caster.recordTable.totalHp ~= nil then
          Finalhp = (1 + level * 150 // 1000) * self.caster.recordTable.totalHp // roleNum
        end
        local Finalpow = (1 + level * 120 // 1000) * 5000 // roleNum
        if self.caster.recordTable.totalAtk ~= nil then
          Finalpow = (1 + level * 120 // 1000) * self.caster.recordTable.totalAtk // roleNum
        end
        local Finalintensity = (1 + level * 120 // 1000) * 5000 // roleNum
        if self.caster.recordTable.totalIntensity ~= nil then
          Finalintensity = (1 + level * 120 // 1000) * self.caster.recordTable.totalIntensity // roleNum
        end
        local FinalDef = 500
        if self.caster.recordTable.totalDef ~= nil then
          FinalDef = self.caster.recordTable.totalDef
        end
        local FinalRes = 500
        if self.caster.recordTable.totalMagicRes ~= nil then
          FinalRes = self.caster.recordTable.totalMagicRes
        end
        summoner:SetAttr(eHeroAttr.maxHp, Finalhp)
        summoner:SetAttr(eHeroAttr.pow, Finalpow)
        summoner:SetAttr(eHeroAttr.skill_intensity, Finalintensity)
        summoner:SetAttr(eHeroAttr.def, FinalDef // roleNum)
        summoner:SetAttr(eHeroAttr.magic_res, FinalRes // roleNum)
        summoner:SetAttr(eHeroAttr.speed, 100)
        summoner:SetAsRealEntity(1)
        local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
        self:CallSelectExecute(summonerEntity)
        LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_start, self)
      end
    end
    return true
  end
  return false
end

function bs_70015:CallSelectExecute(role)
  if role == nil then
    return
  end
  local existSummoner = LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(role)
  if existSummoner ~= nil then
    warn("该人形已装备了义肢")
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.equipmentSummonerId, role.x, role.y)
  summoner:SetAttr(eHeroAttr.maxHp, 1)
  summoner:SetAttr(eHeroAttr.pow, 1)
  summoner:SetAttr(eHeroAttr.intensity, 1)
  summoner:SetAttr(eHeroAttr.speed, role.speed)
  summoner:SetAsRealEntity(15)
  local key = ConfigData.buildinConfig.EquipmentSummonerKey
  local tab = {
    [key] = role
  }
  summoner:SetRecordTable(tab)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if summonerEntity ~= nil then
    LuaSkillCtrl:CallBuff(self, summonerEntity, ConfigData.buildinConfig.EquipmentSummonerInvinsibleBuffId, 1, nil)
    role.recordTable[key] = summonerEntity
    if not LuaSkillCtrl.IsInVerify then
      local trans = summonerEntity.lsObject.transform
      if not IsNull(trans) then
        trans:SetLocalScale(trans.localScale.x, trans.localScale.y, -trans.localScale.z)
      end
    end
    summonerEntity:BindHostEntity(role)
  end
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId, self)
end

function bs_70015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70015
