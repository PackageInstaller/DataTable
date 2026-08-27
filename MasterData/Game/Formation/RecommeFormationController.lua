local RecommeFormationController = class("RecommeFormationController", ControllerBase)
local base = ControllerBase
local CS_MessageCommon = CS.MessageCommon
local RecommeFormationData = require("Game.Formation.Data.RecommeFormationData")
local RecommeFormationNewData = require("Game.Formation.Data.RecommeFormationNewData")

function RecommeFormationController:OnInit()
  self.isRecommeSortForCount = false
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
end

function RecommeFormationController:IsCanReqRecomme(stageId, isShowTip)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend) then
    if isShowTip then
      CS_MessageCommon.ShowMessageTipsWithErrorSound(FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend))
    end
    return false
  end
  local unlockCfg = ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend]
  if stageId <= unlockCfg.pre_para1[1] then
    if isShowTip then
      CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Recomme_Forbid))
    end
    return false
  end
  return true
end

function RecommeFormationController:ReqRecommeFormation(stageId, isOpenFormationCopy)
  if not self:IsCanReqRecomme(stageId, true) then
    return
  end
  self.isOpenFormationCopy = isOpenFormationCopy or false
  self.reqRecordStageId = stageId
  if self.recommeFormationCache ~= nil and self.recommeFormationCache.stageId == stageId and self.recommeFormationCache.refreshTime > PlayerDataCenter.timestamp then
    UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormation, function(window)
      window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCache, self)
    end)
  else
    self.heroNetwork:CS_RECOMMANDFORMATION_Detail(self.reqRecordStageId)
  end
end

function RecommeFormationController:ReceiveRecommeFormation(msg)
  self.recommeFormationCache = RecommeFormationData.CreateRecommeData(self.reqRecordStageId)
  self.recommeFormationCache:GenRecommeSingleData(msg)
  if #self.recommeFormationCache.list == 0 then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Recomme_Empty))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormation, function(window)
    window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCache, self)
  end)
end

function RecommeFormationController:ReqDunRecommeFormation(dungeonId, isOpenFormationCopy)
  self.isOpenFormationCopy = isOpenFormationCopy or false
  self.reqRecordStageId = dungeonId
  self.heroNetwork:CS_RECOMMANDFORMATION_DungeonDetail(self.reqRecordStageId)
end

function RecommeFormationController:ReceiveDunRecommeFormation(msg)
  local recommeFormationCache = RecommeFormationData.CreateRecommeData(self.reqRecordStageId)
  recommeFormationCache:SetAsDungeonRecomme()
  local dungeonStageCfg = ConfigData.battle_dungeon[self.reqRecordStageId]
  if dungeonStageCfg.module_id == proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower then
    local towerLevelCfg = ConfigData.dungeon_tower[self.reqRecordStageId]
    local supportChip = #towerLevelCfg.chip_pool > 0 or 0 < #dungeonStageCfg.enter_chip_select
    recommeFormationCache:SetRecommeSupportChip(supportChip)
    local ruleId = ConfigData.dungeon_tower_type[towerLevelCfg.tower_type].formation_rule
    recommeFormationCache:SetFormationRuleId(ruleId)
  elseif dungeonStageCfg.module_id == proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower then
    local towerLevelCfg = ConfigData.env_dungeon_tower_dungeon_detail[self.reqRecordStageId]
    recommeFormationCache:SetRecommeSupportChip(false)
    local ruleId = ConfigData.env_dungeon_tower[towerLevelCfg.tower_id].formation_rule
    recommeFormationCache:SetFormationRuleId(ruleId)
  end
  recommeFormationCache:GenRecommeSingleData(msg)
  if #recommeFormationCache.list == 0 then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Recomme_Empty))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormation, function(window)
    window:InitRecommeFormation(self.isOpenFormationCopy, recommeFormationCache, self)
  end)
end

function RecommeFormationController:ExitRecommeFormation(singleData)
  if singleData == nil then
    return
  end
  local formationCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if formationCtrl ~= nil then
    local newHeroDic = singleData:CopyFormation()
    local isChange = formationCtrl:UpdateFormationHero(newHeroDic)
    if isChange then
      if table.count(newHeroDic) == singleData:GetHaveCount() then
        CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Recomme_SuccessAll))
      else
        CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Recomme_SuccessPart))
      end
    else
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Recomme_Sample))
    end
  end
end

function RecommeFormationController:ReqRecommeFormationNew(stageId, isOpenFormationCopy)
  if not self:IsCanReqRecomme(stageId, true) then
    return
  end
  self.isOpenFormationCopy = isOpenFormationCopy or false
  self.reqRecordStageId = stageId
  if self.recommeFormationCacheNew ~= nil and self.recommeFormationCacheNew.stageId == stageId and self.recommeFormationCacheNew.refreshTime > PlayerDataCenter.timestamp then
    UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormationNew, function(window)
      window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCacheNew, self)
    end)
  else
    self.heroNetwork:CS_RECOMMANDFORMATION_Detail(self.reqRecordStageId)
  end
end

function RecommeFormationController:ReceiveRecommeFormationNew(msg)
  self.recommeFormationCacheNew = RecommeFormationNewData.CreateRecommeData(self.reqRecordStageId)
  self.recommeFormationCacheNew:GenRecommeSingleData(msg)
  if #self.recommeFormationCacheNew.list == 0 then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Recomme_Empty))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormationNew, function(window)
    window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCacheNew, self)
    window:SetTopStatusClose(self.topStatusIsHide)
  end)
end

function RecommeFormationController:ReqDunRecommeFormationNew(dungeonId, isOpenFormationCopy)
  self.isOpenFormationCopy = isOpenFormationCopy or false
  self.reqRecordStageId = dungeonId
  self.heroNetwork:CS_RECOMMANDFORMATION_DungeonDetail(self.reqRecordStageId)
end

function RecommeFormationController:ReceiveDunRecommeFormationNew(msg)
  local recommeFormationCacheNew = RecommeFormationNewData.CreateRecommeData(self.reqRecordStageId)
  recommeFormationCacheNew:SetAsDungeonRecomme()
  local dungeonStageCfg = ConfigData.battle_dungeon[self.reqRecordStageId]
  if dungeonStageCfg.module_id == proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower then
    local towerLevelCfg = ConfigData.dungeon_tower[self.reqRecordStageId]
    local ruleId = ConfigData.dungeon_tower_type[towerLevelCfg.tower_type].formation_rule
    recommeFormationCacheNew:SetFormationRuleId(ruleId)
  elseif dungeonStageCfg.module_id == proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower then
    local towerLevelCfg = ConfigData.env_dungeon_tower_dungeon_detail[self.reqRecordStageId]
    local ruleId = ConfigData.env_dungeon_tower[towerLevelCfg.tower_id].formation_rule
    recommeFormationCacheNew:SetFormationRuleId(ruleId)
  end
  recommeFormationCacheNew:GenRecommeSingleData(msg)
  if #recommeFormationCacheNew.list == 0 then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Recomme_Empty))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormationNew, function(window)
    window:InitRecommeFormation(self.isOpenFormationCopy, recommeFormationCacheNew, self)
    window:SetTopStatusClose(self.topStatusIsHide)
  end)
end

function RecommeFormationController:SetTopStatusHide(bool)
  self.topStatusIsHide = bool
end

return RecommeFormationController
