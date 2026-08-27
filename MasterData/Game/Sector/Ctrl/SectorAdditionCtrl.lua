local base = require("Game.Sector.Ctrl.SectorCtrlBase")
local SectorAdditionCtrl = class("SectorAdditionCtrl", base)
local cs_MessageCommon = CS.MessageCommon
local eDifficulty = require("Game.Sector.Enum.SectorLevelDetailEnum").eDifficulty
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function SectorAdditionCtrl:ctor(sectorCtrl)
  self.recommeStage = nil
end

function SectorAdditionCtrl:OpenSectorSO(sectorId, buildId)
  if not self:_CheckStrategyOverview(sectorId) then
    return
  end
  local ctrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview, true)
  ctrl:InitStOCtrl(sectorId, buildId, function()
    self:OnStrategyOverviewClose()
  end)
end

function SectorAdditionCtrl:OpenSectorCareerSO(buildId)
  if not self:_CheckStrategyOverview(nil) then
    return
  end
  local ctrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview, true)
  ctrl:InitCareerStO(buildId, function()
    self:OnStrategyOverviewClose()
  end)
end

function SectorAdditionCtrl:_CheckStrategyOverview(sectorId)
  if sectorId ~= nil then
    local isSectorUnlock = PlayerDataCenter.sectorStage:IsSectorUnlock(sectorId)
    if not isSectorUnlock then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Sector_Locked))
      return false
    end
  end
  return true
end

function SectorAdditionCtrl:OnStrategyOverviewClose()
end

function SectorAdditionCtrl:GetSectorSOReddotNum()
  local isBlue = false
  local num = 0
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  if not isUnlock then
    return isBlue, num
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview)
  if ok then
    num = node:GetRedDotCount()
    isBlue = true
    ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerRewardBuild)
    if ok and 0 < node:GetRedDotCount() then
      isBlue = false
    end
  end
  return isBlue, num
end

function SectorAdditionCtrl:RefreshRecommeStage()
  local norCfg = PlayerDataCenter.sectorStage:GetCanCompleteStage(eDifficulty.normal)
  local nightmareCfg = PlayerDataCenter.sectorStage:GetCanCompleteStage(eDifficulty.nightmare)
  local endlessCfg = PlayerDataCenter.infinityData:GetCanCompleteInfinityMinPower()
  local sectorCfg
  if norCfg == nil then
    sectorCfg = nightmareCfg
  elseif nightmareCfg == nil then
    sectorCfg = norCfg
  else
    sectorCfg = norCfg.combat <= nightmareCfg.combat and norCfg or nightmareCfg
  end
  if sectorCfg == nil and endlessCfg == nil then
    self:__SetRecommeStageInfo(false, nil)
    return
  end
  if sectorCfg == nil or endlessCfg ~= nil and endlessCfg.combat < sectorCfg.combat then
    self:__SetRecommeStageInfo(true, endlessCfg)
  else
    self:__SetRecommeStageInfo(false, sectorCfg)
  end
end

function SectorAdditionCtrl:__SetRecommeStageInfo(isEndless, cfg)
  if cfg == nil then
    self.recommeStage = nil
    return
  end
  local msg
  if isEndless then
    msg = ConfigData:GetEndlessInfoMsg(cfg, cfg.index * 10)
  elseif cfg.difficulty == eDifficulty.normal then
    msg = ConfigData:GetSectorInfoMsg(cfg.sector, cfg.num, cfg.difficulty)
  elseif cfg.difficulty == eDifficulty.nightmare then
    msg = ConfigData:GetSectorInfoMsg(cfg.sector, cfg.num, 2)
  end
  if isEndless then
    self.recommeStage = {
      stageId = cfg.id,
      msg = msg
    }
  else
    self.recommeStage = {
      stageId = cfg.id,
      msg = msg
    }
  end
end

function SectorAdditionCtrl:GetSectorRecommendStageInfo()
  return self.recommeStage
end

function SectorAdditionCtrl:Jump2RecommendLevel()
  if self.recommeStage == nil then
    return
  end
  local stageId = self.recommeStage.stageId
  PlayerDataCenter.sectorEntranceHandler:TryEnterAndOpenMainStage(stageId)
end

function SectorAdditionCtrl:OnDelete()
end

return SectorAdditionCtrl
