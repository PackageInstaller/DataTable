local base = ControllerBase
local StrategyOverviewController = class("UIStrategyOverviewController", base)
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildEnum = require("Game.Oasis.Data.BuildingEnum")
local cs_MessageCommon = CS.MessageCommon

function StrategyOverviewController:OnInit()
  self.buildingNetwork = NetworkManager:GetNetwork(NetworkTypeID.Building)
end

function StrategyOverviewController:InitStOCtrl(sectorId, buildId, closeFunc)
  self.closeFunc = closeFunc
  local techDataList = self:GetTechDataList(sectorId, buildId)
  UIManager:ShowWindowAsync(UIWindowTypeID.StrategyOverview, function(window)
    if window == nil then
      return
    end
    window:InitUIStO(self, techDataList)
  end)
end

function StrategyOverviewController:InitCareerStO(buildId, closeFunc)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1))
    return
  end
  self.closeFunc = closeFunc
  local techDataList = self:GetCareerMaster(buildId)
  UIManager:ShowWindowAsync(UIWindowTypeID.StrategyOverview, function(window)
    if window == nil then
      return
    end
    window:InitCareerStO(self, techDataList)
  end)
end

function StrategyOverviewController:GetTechDataList(defaultSectorId, defaultBuildId)
  if defaultSectorId == nil then
    defaultSectorId = 1
  end
  defaultBuildId = defaultBuildId ~= nil and defaultBuildId or ConfigData.game_config.defaultStOBuild
  local techDataList = {}
  local hasSelect = false
  for k, sectorId in ipairs(ConfigData.sector.id_sort_list) do
    local sectorCfg = ConfigData.sector[sectorId]
    if sectorCfg == nil then
      error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    else
      for k2, buildId in ipairs(sectorCfg.building) do
        local buildingData = PlayerDataCenter.AllBuildingData.built[buildId]
        if buildingData == nil then
          local data = PlayerDataCenter.AllBuildingData.unbuilt[buildId]
          buildingData = BuildingData.New()
          buildingData:InitializeWithDynData(nil, data)
        end
        local selected = false
        if defaultSectorId == sectorId then
          if (defaultBuildId or 0) == buildId then
            selected = true
            hasSelect = true
          elseif k2 == #sectorCfg.building and not hasSelect then
            selected = true
          end
        end
        local techData = {
          buildingData = buildingData,
          sectorId = sectorId,
          selected = selected
        }
        table.insert(techDataList, techData)
      end
    end
  end
  return techDataList
end

function StrategyOverviewController:GetCareerMaster(defaultBuildId)
  local techDataList = {}
  for _, buildId in ipairs(ConfigData.building.careerBuilds) do
    local buildingData = PlayerDataCenter.AllBuildingData.built[buildId]
    if buildingData == nil then
      local data = PlayerDataCenter.AllBuildingData.unbuilt[buildId]
      buildingData = BuildingData.New()
      buildingData:InitializeWithDynData(nil, data)
    end
    local techData = {
      buildingData = buildingData,
      selected = defaultBuildId == buildId
    }
    table.insert(techDataList, techData)
  end
  return techDataList
end

function StrategyOverviewController:StOTechUpgrade(buildingData)
  if PlayerDataCenter.AllBuildingData:FullSectorBuildQue() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
    return
  end
  self.upgradeBuidingId = buildingData.id
  if self._OnStOTechUpgradeFunc == nil then
    self._OnStOTechUpgradeFunc = BindCallback(self, self._OnStOTechUpgrade)
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  if buildingData.isBuild then
    local nextLevel = buildingData.level + 1
    if nextLevel > buildingData.maxLevel then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_LevelFull))
      return
    end
    if not buildingData:CanUpgrade() then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
      return
    end
    self.buildingNetwork:SendBuildingUpgrade(buildingData.id, self._OnStOTechUpgradeFunc)
  else
    if not buildingData.dynData:CanBuild() then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
      return
    end
    self.buildingNetwork:SendBuildingConstruct(buildingData.id, nil, nil, self._OnStOTechUpgradeFunc)
  end
end

function StrategyOverviewController:_OnStOTechUpgrade(dataList)
  local window = UIManager:GetWindow(UIWindowTypeID.StrategyOverview)
  if window ~= nil then
    local buildingData = PlayerDataCenter.AllBuildingData.built[self.upgradeBuidingId]
    window:OnStOBuildUpgradeComplete(buildingData)
  end
  if dataList.Count <= 0 then
    return
  end
  local reward = dataList[0]
  if reward ~= nil and 0 < table.count(reward) then
    local rewardIds = {}
    local rewardCounts = {}
    local heroIdSnapShoot = self._heroIdSnapShoot
    for id, count in pairs(reward) do
      table.insert(rewardIds, id)
      table.insert(rewardCounts, count)
    end
    local window = UIManager:GetWindow(UIWindowTypeID.CommonReward)
    if window ~= nil then
      window:Hide()
      window:Show()
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardCounts):SetCRHeroSnapshoot(heroIdSnapShoot)
      window:AddAndTryShowReward(CRData)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardCounts):SetCRHeroSnapshoot(heroIdSnapShoot)
        window:AddAndTryShowReward(CRData)
      end)
    end
  end
end

function StrategyOverviewController:UpdateStOBuilding(buildingId)
  local buildingData = PlayerDataCenter.AllBuildingData.built[buildingId]
  if buildingData == nil then
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.StrategyOverview)
  if window ~= nil then
    window:UpdateUIStOBuilding(buildingData)
  end
end

function StrategyOverviewController:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.StrategyOverview)
  if self.closeFunc ~= nil then
    self.closeFunc()
  end
  base.OnDelete(self)
end

return StrategyOverviewController
