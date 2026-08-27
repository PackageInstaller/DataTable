local HeroEnterDataUtil = class("HeroEnterDataUtil")
local valueFuncTable = {
  [eLogicType.ResourceLimit] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = levelBuffCfg.buff_para1[index]
    local para2 = math.floor(levelBuffCfg.buff_para2[index] * heroScoreRate)
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceLimit)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceLimit, para1, para2, para3)
    end
  end,
  [eLogicType.ResourceOutput] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = levelBuffCfg.buff_para1[index]
    local speed = levelBuffCfg.buff_para2[index] * 36 // 1000
    local para2 = math.floor(speed * heroScoreRate)
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceOutput)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceOutput, para1, para2, para3)
    end
  end,
  [eLogicType.CampBuff] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = levelBuffCfg.buff_para1[index]
    local para2 = levelBuffCfg.buff_para2[index]
    local attrValue = levelBuffCfg.buff_para3[index]
    local para3 = math.floor(attrValue * heroScoreRate)
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CampBuff)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CampBuff, para1, para2, para3)
    end
  end,
  [eLogicType.CareerBuff] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = levelBuffCfg.buff_para1[index]
    local para2 = levelBuffCfg.buff_para2[index]
    local attrValue = levelBuffCfg.buff_para3[index]
    local para3 = math.floor(attrValue * heroScoreRate)
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CareerBuff)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CareerBuff, para1, para2, para3)
    end
  end,
  [eLogicType.FactoryPipelie] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = math.floor(levelBuffCfg.buff_para1[index] * heroScoreRate)
    local para2 = levelBuffCfg.buff_para2[index]
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.FactoryPipelie)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.FactoryPipelie, para1, para2, para3)
    end
  end,
  [eLogicType.GlobalExpCeiling] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local expLimt = levelBuffCfg.buff_para1[index]
    local para1 = math.floor(expLimt * heroScoreRate)
    local para2 = levelBuffCfg.buff_para2[index]
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpCeiling)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpCeiling, para1, para2, para3)
    end
  end,
  [eLogicType.StaminaCeiling] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local staminaLimt = levelBuffCfg.buff_para1[index]
    local para1 = math.floor(staminaLimt * heroScoreRate)
    local para2 = levelBuffCfg.buff_para2[index]
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaCeiling)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaCeiling, para1, para2, para3)
    end
  end,
  [eLogicType.StaminaOutput] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local speed = levelBuffCfg.buff_para1[index] * 0.036
    local para1 = math.floor(speed * heroScoreRate)
    local para2 = levelBuffCfg.buff_para2[index]
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaOutput)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaOutput, para1, para2, para3)
    end
  end,
  [eLogicType.ResOutputEfficiency] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = levelBuffCfg.buff_para1[index]
    local para2 = math.floor(levelBuffCfg.buff_para2[index] * heroScoreRate)
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResOutputEfficiency)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResOutputEfficiency, para1, para2, para3)
    end
  end,
  [eLogicType.BuildQueue] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = levelBuffCfg.buff_para1[index]
    local para2 = math.floor(levelBuffCfg.buff_para2[index] * heroScoreRate)
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildQueue)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildQueue, para1, para2, para3)
    end
  end,
  [eLogicType.BuildSpeed] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = math.floor(levelBuffCfg.buff_para1[index] * heroScoreRate)
    local para2 = levelBuffCfg.buff_para2[index]
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildSpeed)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildSpeed, para1, para2, para3)
    end
  end,
  [eLogicType.GlobalExpRatio] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = math.floor(levelBuffCfg.buff_para1[index] * heroScoreRate)
    local para2 = levelBuffCfg.buff_para2[index]
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpRatio)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpRatio, para1, para2, para3)
    end
  end,
  [eLogicType.AllHeroBuff] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
    local para1 = levelBuffCfg.buff_para1[index]
    local para2 = math.floor(levelBuffCfg.buff_para2[index] * heroScoreRate)
    local para3 = levelBuffCfg.buff_para3[index]
    if isRemove then
      PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.AllHeroBuff)
    else
      PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.AllHeroBuff, para1, para2, para3)
    end
  end
}

function HeroEnterDataUtil:ctor()
end

function HeroEnterDataUtil:InitMsgListern()
  self.__OnBuildingLevelChange = BindCallback(self, self.OnBuildingLevelChange)
  MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__OnBuildingLevelChange)
end

function HeroEnterDataUtil:InitBuff(allEnterData)
  for buildingId, data in pairs(allEnterData) do
    for heroId, _ in pairs(data.data) do
      self:AddBuff(heroId, buildingId)
    end
  end
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
end

function HeroEnterDataUtil:AddBuff(heroId, buildingId, manualRate)
  local level = PlayerDataCenter.AllBuildingData.oasisBuilt[buildingId].level
  local levelBuffCfg = ConfigData.buildingLevel[buildingId][level]
  local heroData = PlayerDataCenter.heroDic[heroId]
  for i, logic in ipairs(levelBuffCfg.buff_logic) do
    if manualRate ~= nil then
      valueFuncTable[logic](manualRate, levelBuffCfg, i, nil, buildingId)
    else
      valueFuncTable[logic](self:CalRate(heroData), levelBuffCfg, i, nil, buildingId)
    end
  end
  local skillDic = heroData.skillDic
  for key, skilldata in pairs(skillDic) do
    if skilldata.type == eHeroSkillType.LifeSkill then
      self:AddSkillBuff(skilldata, heroId)
    end
  end
end

function HeroEnterDataUtil:RemoveBuff(heroId, levelBuffCfg, manualRate, buildingId)
  local levelBuffCfg = levelBuffCfg
  if levelBuffCfg == nil then
    levelBuffCfg = self:GetHeroEnteredBuildingCfgById(heroId)
  end
  local heroData = PlayerDataCenter.heroDic[heroId]
  for i, logic in ipairs(levelBuffCfg.buff_logic) do
    if manualRate ~= nil then
      valueFuncTable[logic](manualRate, levelBuffCfg, i, true, buildingId)
    else
      valueFuncTable[logic](self:CalRate(heroData), levelBuffCfg, i, true, buildingId)
    end
  end
  local skillDic = heroData.skillDic
  for key, skilldata in pairs(skillDic) do
    if skilldata.type == eHeroSkillType.LifeSkill then
      self:RemoveSkillBuff(skilldata, heroId)
    end
  end
end

function HeroEnterDataUtil:AddSkillBuff(skilldata, heroId)
  local skillLevel = skilldata.level
  local cfg = skilldata.lifeSkillCfg[skillLevel]
  for index, logic in ipairs(cfg.logic) do
    local para1 = cfg.para1[index]
    local para2 = cfg.para2[index]
    local para3 = cfg.para3[index]
    PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_LifeSkill, heroId, logic, para1, para2, para3)
  end
end

function HeroEnterDataUtil:RemoveSkillBuff(skilldata, oldLevel, heroId)
  local skillLevel = oldLevel or skilldata.level
  local cfg = skilldata.lifeSkillCfg[skillLevel]
  for index, logic in ipairs(cfg.logic) do
    local para1 = cfg.para1[index]
    local para2 = cfg.para2[index]
    local para3 = cfg.para3[index]
    PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_LifeSkill, heroId, logic)
  end
end

function HeroEnterDataUtil:GetHeroEnteredBuildingCfgById(heroId)
  local allEnterData = PlayerDataCenter.allEnterData
  for buildingId, data in pairs(allEnterData) do
    for allDtatHeroId, _ in pairs(data.data) do
      if allDtatHeroId == heroId then
        local level = PlayerDataCenter.AllBuildingData.oasisBuilt[buildingId].level
        local levelBuffCfg = ConfigData.buildingLevel[buildingId][level]
        return levelBuffCfg
      end
    end
  end
  return nil
end

function HeroEnterDataUtil:CalRate(heroData, manualRank, manualLevel)
  if heroData == nil then
    return 0
  end
  local rank = manualRank or heroData.rank
  local level = manualLevel or heroData.level
  local score = ConfigData.star_score[rank].score + level
  local scoreRate = score / ConfigData.game_config.heroEnterScoreDenominator
  return scoreRate
end

function HeroEnterDataUtil:CalRateById(heroId, manualRank, manualLevel)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return 0
  end
  return self:CalRate(heroData, manualRank, manualLevel)
end

function HeroEnterDataUtil:OnHeroRankChange(oldRanK, newRank, heroId)
  local buildingId
  for dataBuildingId, data in pairs(PlayerDataCenter.allEnterData) do
    for dataHeroId, _ in pairs(data.data) do
      if dataHeroId == heroId then
        buildingId = dataBuildingId
      end
    end
  end
  if buildingId == nil then
    return
  end
  local heroData = PlayerDataCenter.heroDic[heroId]
  local oldRate = self:CalRate(heroData, oldRanK, nil)
  local newRate = self:CalRate(heroData, newRank, nil)
  self:AddBuff(heroId, buildingId, newRate)
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
end

function HeroEnterDataUtil:OnHeroLevelChange(oldLevel, newLevel, heroId)
  local buildingId
  for dataBuildingId, data in pairs(PlayerDataCenter.allEnterData) do
    for dataHeroId, _ in pairs(data.data) do
      if dataHeroId == heroId then
        buildingId = dataBuildingId
      end
    end
  end
  if buildingId == nil then
    return
  end
  local heroData = PlayerDataCenter.heroDic[heroId]
  local oldRate = self:CalRate(heroData, nil, oldLevel)
  local newRate = self:CalRate(heroData, nil, newLevel)
  self:AddBuff(heroId, buildingId, newRate)
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
end

function HeroEnterDataUtil:OnBuildingLevelChange(buildingId)
  for dataBuildingId, data in pairs(PlayerDataCenter.allEnterData) do
    if dataBuildingId == buildingId then
      for heroId, _ in pairs(data.data) do
        local level = PlayerDataCenter.AllBuildingData.oasisBuilt[buildingId].level
        local oldLevelCfg = ConfigData.buildingLevel[buildingId][level - 1]
        self:AddBuff(heroId, buildingId)
      end
    end
  end
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
end

function HeroEnterDataUtil:OnLifeSkillLevelUp(newskillData)
  for dataBuildingId, data in pairs(PlayerDataCenter.allEnterData) do
    for heroId, _ in pairs(data.data) do
      if heroId == newskillData.heroData.dataId then
        self:AddSkillBuff(newskillData, heroId)
      end
    end
  end
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
end

return HeroEnterDataUtil
