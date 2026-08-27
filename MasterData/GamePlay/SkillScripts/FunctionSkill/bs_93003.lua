local bs_93003 = class("bs_93003", LuaSkillBase)
local base = LuaSkillBase
bs_93003.config = {
  monsterId = {1011, 1014},
  equipmentSummonerId = {
    1002,
    1003,
    1004
  },
  effectId = 12024,
  effectId_start = 5002205
}

function bs_93003:ctor()
end

function bs_93003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
  self.caster.recordTable.totalHp = 0
  self.caster.recordTable.totalAtk = 0
  self.caster.recordTable.totalIntensity = 0
  self.caster.recordTable.totalDef = 0
  self.caster.recordTable.totalMagicRes = 0
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if 1 > targetlist.Count then
    return
  end
  self.caster.recordTable.roleNum = targetlist.Count
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    self.caster.recordTable.totalHp = self.caster.recordTable.totalHp + targetRole.maxHp
    self.caster.recordTable.totalAtk = self.caster.recordTable.totalAtk + targetRole.pow
    self.caster.recordTable.totalIntensity = self.caster.recordTable.totalIntensity + targetRole.skill_intensity
    self.caster.recordTable.totalDef = self.caster.recordTable.totalDef + targetRole.def
    self.caster.recordTable.totalMagicRes = self.caster.recordTable.totalMagicRes + targetRole.magic_res
  end
end

function bs_93003:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetGrid = LuaSkillCtrl:FindEmptyGrid()
  if targetGrid ~= nil then
    local index = LuaSkillCtrl:CallRange(1, 2)
    local monsterId = self.config.monsterId[index]
    local summoner = LuaSkillCtrl:CreateSummoner(self, monsterId, targetGrid.x, targetGrid.y)
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
end

function bs_93003:CallSelectExecute(role)
  if role == nil then
    return
  end
  local existSummoner = LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(role)
  if existSummoner ~= nil then
    warn("该人形已装备了义肢")
    return
  end
  local index = LuaSkillCtrl:CallRange(1, 3)
  local equipmentId = self.config.equipmentSummonerId[index]
  local summoner = LuaSkillCtrl:CreateSummoner(self, equipmentId, role.x, role.y)
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

function bs_93003:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_93003
