local UINLevelNormalNode = class("UINLevelNormalNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINLevelDetailRewardItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelDetailRewardItem")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local UINLNNInfinityLayerItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLNNInfinityLayerItem")
local UINLevelNormalBuffItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local SectorEnum = require("Game.Sector.SectorEnum")
local UINLevelChallengeTask = require("Game.Sector.SectorLevelDetail.Nodes.ChallengeTask.UINLevelChallengeTask")

function UINLevelNormalNode:OnInit()
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__ShowRewardDetail = BindCallback(self, self.ShowRewardDetail)
  self.rewardItemPool = UIItemPool.New(UINLevelDetailRewardItem, self.ui.itemWithCount)
  self.wcRankRewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.itemWithCount)
  self.emptyItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.obj_EmptyItem)
  self.ui.itemWithCount:SetActive(false)
  self.challengeTaskNode = UINLevelChallengeTask.New()
  self.challengeTaskNode:Init(self.ui.challenge)
  self.ui.Loop_InfinityLayerReardRect.onInstantiateItem = BindCallback(self, self.m_NewInfinityItem)
  self.ui.Loop_InfinityLayerReardRect.onChangeItem = BindCallback(self, self.m_ChangeInfinityItem)
  self._addActivityExRewardsFunc = BindCallback(self, self._AddActivityExRewards)
  self.linfinityLayerDataList = {}
  self.infinityLayerItemDic = {}
  self.ui.obj_LayerParent = self.ui.tex_Layer.transform.parent.gameObject
  UIUtil.AddButtonListener(self.ui.btn_periodic_ShowRank, self, self.ShowWeeklyChallengeRank)
end

function UINLevelNormalNode:InitInfoNode(LevelDtail)
  self.LevelDtail = LevelDtail
  self.__levelDetailExtrData = LevelDtail.__levelDetailExtrData
  self.ui.obj_EmptyItem:SetActive(false)
  self.ui.obj_infinity:SetActive(false)
  self.ui.obj_normal:SetActive(false)
  self.ui.obj_reward:SetActive(false)
  self.ui.tips_relation:SetActive(false)
  self.challengeTaskNode:Hide()
  if LevelDtail.detailType == eDetailType.Stage then
    local stageCfg = LevelDtail.stageCfg
    self.ui.obj_normal:SetActive(true)
    self.ui.obj_reward:SetActive(true)
    self.ui.tex_LevelName:SetIndex(0, LanguageUtil.GetLocaleText(stageCfg.name))
    self.ui.tex_LevelInfo.gameObject:SetActive(true)
    self.ui.tex_LevelInfo.text = LanguageUtil.GetLocaleText(stageCfg.introduce)
    local sectorId = ConfigData:GetSectorIdShow(stageCfg.sector)
    if stageCfg.exTitleName ~= nil then
      self.ui.tex_IdName:SetIndex(4, stageCfg.exTitleName)
    elseif ConfigData.sector.onlyShowStageIdSectorDic[stageCfg.sector] then
      self.ui.tex_IdName:SetIndex(3, tostring(stageCfg.num))
    else
      self.ui.tex_IdName:SetIndex(0, tostring(sectorId), tostring(stageCfg.num))
    end
    local isWeeklyChallengeSector = table.contain(ConfigData.game_config.weeklyChallengeSectorIds, stageCfg.sector)
    if isWeeklyChallengeSector then
      self.ui.tex_IdName.gameObject:SetActive(false)
    end
    local layerCount = #stageCfg.exploration_list or 1
    self.ui.obj_LayerParent:SetActive(true)
    self.ui.tex_Layer.gameObject:SetActive(true)
    self.ui.tex_Layer:SetIndex(0, tostring(layerCount))
    self.ui.obj_periodic:SetActive(false)
    self:RefreshLevelReward(stageCfg)
    if LevelDtail:LvDetailIsChallengeMode() then
    end
  elseif LevelDtail.detailType == eDetailType.Avg then
    self.ui.obj_normal:SetActive(true)
    self.ui.obj_reward:SetActive(true)
    local avgCfg = LevelDtail.avgCfg
    self.ui.tex_LevelName:SetIndex(0, LanguageUtil.GetLocaleText(avgCfg.name))
    self.ui.tex_LevelInfo.gameObject:SetActive(true)
    self.ui.tex_LevelInfo.text = LanguageUtil.GetLocaleText(avgCfg.describe)
    local spTitleName = self.__levelDetailExtrData ~= nil and self.__levelDetailExtrData:Get_SpecialLevelIdName()
    if spTitleName then
      self.ui.tex_IdName:SetIndex(4, spTitleName)
    else
      self.ui.tex_IdName:SetIndex(1, tostring(avgCfg.number))
    end
    self.ui.obj_LayerParent:SetActive(false)
    self.ui.tex_Layer.gameObject:SetActive(false)
    self.ui.obj_periodic:SetActive(false)
    self:RefreshAvgReward(avgCfg)
  elseif LevelDtail.detailType == eDetailType.Infinity then
    local infinityCfg = LevelDtail.levelData.cfg
    local levelData = LevelDtail.levelData
    self.ui.obj_infinity:SetActive(true)
    self.ui.obj_reward:SetActive(true)
    self.ui.tex_LevelName:SetIndex(1, tostring(infinityCfg.index * 10))
    self.ui.tex_LevelInfo.gameObject:SetActive(false)
    self.ui.tex_IdName:SetIndex(2, "?", tostring(#infinityCfg.layer))
    self.ui.obj_periodic:SetActive(false)
    self:RefreshInfinityReward(levelData)
    self:RefreshInfinityLevelReward(levelData)
  elseif LevelDtail.detailType == eDetailType.PeriodicChallenge then
    local eChallengeType = LevelDtail.eChallengeType
    local challengeId = LevelDtail.challengeId
    local challengeCfg = ConfigData.daily_challenge[challengeId]
    if challengeCfg == nil then
      error("can't read challengeCfg with id:" .. tostring(challengeId))
    end
    self.ui.obj_normal:SetActive(true)
    self.ui.obj_reward:SetActive(true)
    self.ui.tex_LevelName:SetIndex(0, LanguageUtil.GetLocaleText(challengeCfg.name))
    self.ui.tex_LevelInfo.gameObject:SetActive(true)
    self.ui.tex_LevelInfo.text = LanguageUtil.GetLocaleText(challengeCfg.introduce)
    self.ui.tex_IdName.gameObject:SetActive(false)
    local layerCount = "3"
    self.ui.obj_LayerParent:SetActive(true)
    self.ui.tex_Layer.gameObject:SetActive(true)
    self.ui.tex_Layer:SetIndex(0, tostring(layerCount))
    self.ui.obj_periodic:SetActive(false)
    self:RefreshPeriodicChallengeReward(challengeCfg, eChallengeType)
  elseif LevelDtail.detailType == eDetailType.WeeklyChallenge then
    local challengeId = LevelDtail.challengeId
    local WCData = PlayerDataCenter.allWeeklyChallengeData:GetWeeklyChallengeDataByDungeonId(challengeId)
    local challengeCfg = WCData:GetWCConfig()
    self.ui.obj_normal:SetActive(true)
    self.ui.obj_reward:SetActive(false)
    self.ui.tex_LevelName:SetIndex(0, LanguageUtil.GetLocaleText(challengeCfg.name))
    self.ui.tex_LevelInfo.gameObject:SetActive(true)
    self.ui.tex_LevelInfo.text = LanguageUtil.GetLocaleText(challengeCfg.introduce)
    self.ui.tex_IdName.gameObject:SetActive(false)
    local layerCount = "3"
    self.ui.obj_LayerParent:SetActive(true)
    self.ui.tex_Layer.gameObject:SetActive(true)
    self.ui.tex_Layer:SetIndex(0, tostring(layerCount))
    self.ui.obj_rankNode:SetActive(WCData:GetIsHaveRankList())
    self.ui.obj_periodic:SetActive(true)
    self:RefreshWeeklyChallengeInfo(WCData)
  elseif LevelDtail.detailType == eDetailType.Warchess then
    local stageCfg = LevelDtail.stageCfg
    self.ui.obj_normal:SetActive(true)
    self.ui.obj_reward:SetActive(true)
    self.ui.tex_LevelName:SetIndex(0, LanguageUtil.GetLocaleText(stageCfg.name))
    self.ui.tex_LevelInfo.gameObject:SetActive(true)
    self.ui.tex_LevelInfo.text = LanguageUtil.GetLocaleText(stageCfg.introduce)
    local sectorId = ConfigData:GetSectorIdShow(stageCfg.sector)
    if ConfigData.sector.onlyShowStageIdSectorDic[stageCfg.sector] then
      self.ui.tex_IdName:SetIndex(3, tostring(stageCfg.num))
    else
      self.ui.tex_IdName:SetIndex(0, tostring(sectorId), tostring(stageCfg.num))
    end
    local actSector3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII)
    if actSector3Ctrl ~= nil then
      local rankId = actSector3Ctrl:GetHardLevelRankId(LevelDtail.challengeId)
      local rankCfg = ConfigData.common_ranklist[rankId]
      if rankCfg ~= nil then
        self.ui.tex_periodic_name.text = LanguageUtil.GetLocaleText(rankCfg.option_name)
        self.ui.obj_periodic:SetActive(true)
        local score = actSector3Ctrl:GetHardLevelScore(LevelDtail.challengeId)
        if rankCfg.option_show_type == 1 then
          self.ui.tex_periodic_Scoure.text = BattleUtil.FrameToTimeString(score)
        else
          self.ui.tex_periodic_Scoure.text = tostring(score)
        end
      else
        self.ui.obj_periodic:SetActive(false)
      end
    else
      self.ui.obj_periodic:SetActive(false)
    end
    self.ui.obj_LayerParent:SetActive(false)
    self:RefreshWarchessDrop(stageCfg)
  elseif LevelDtail.detailType == eDetailType.Brotato then
    local stageCfg = LevelDtail.stageCfg
    self.ui.obj_normal:SetActive(true)
    self.ui.obj_reward:SetActive(true)
    self.ui.tex_LevelName:SetIndex(0, LanguageUtil.GetLocaleText(stageCfg.name))
    self.ui.tex_LevelInfo.gameObject:SetActive(true)
    self.ui.tex_LevelInfo.text = LanguageUtil.GetLocaleText(stageCfg.introduce)
    local sectorId = ConfigData:GetSectorIdShow(stageCfg.sector)
    if ConfigData.sector.onlyShowStageIdSectorDic[stageCfg.sector] then
      self.ui.tex_IdName:SetIndex(3, tostring(stageCfg.num))
    else
      self.ui.tex_IdName:SetIndex(0, tostring(sectorId), tostring(stageCfg.num))
    end
    local layerCount = #stageCfg.exploration_list or 1
    self.ui.obj_LayerParent:SetActive(true)
    self.ui.tex_Layer.gameObject:SetActive(true)
    self.ui.tex_Layer:SetIndex(0, tostring(layerCount))
    self.ui.obj_periodic:SetActive(false)
    self:RefreshLevelReward(stageCfg)
  end
  self:ForceRefresh()
end

function UINLevelNormalNode:ForceRefresh()
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.normalList)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.maybeList)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.rect)
end

function UINLevelNormalNode:RefreshLevelReward(stageCfg)
  self.ui.normalList.gameObject:SetActive(true)
  self.ui.maybeList.gameObject:SetActive(true)
  self.ui.txtInfo_firsRewardList:SetIndex(0)
  self.ui.txt_maybeRewardList:SetIndex(0)
  self.ui.specialList.gameObject:SetActive(false)
  self.rewardItemPool:HideAll()
  local isPicked = false
  local stageState = PlayerDataCenter.sectorStage:GetStageState(stageCfg.id)
  if stageState == proto_object_DungeonStageState.DungeonStageStateNone then
  elseif stageState == proto_object_DungeonStageState.DungeonStageStateCompleted then
    self.sectorNetworkCtrl:Send_SECTOR_BattleFirstRewardPick(stageCfg.id)
    isPicked = true
  elseif stageState == proto_object_DungeonStageState.DungeonStageStatePicked then
    isPicked = true
  end
  local firstDropItemLimt = self.ui.firstDropItemLimt or 4
  local rewardCount = 0
  local sectorCfg = ConfigData.sector[stageCfg.sector]
  if sectorCfg == nil then
    error(" sectorCfg  is \tNIL")
    return
  end
  if sectorCfg.reward_show_type == SectorEnum.SectorRewardShowType.FixedReward then
    self.ui.txtInfo_firsRewardList:SetIndex(3)
    for i, rewardId in ipairs(stageCfg.reward_ids) do
      local rewardNum = stageCfg.reward_nums[i]
      rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum)
    end
  elseif sectorCfg.reward_show_type == SectorEnum.SectorRewardShowType.HideReward then
  else
    for index, rewardId in ipairs(stageCfg.first_reward_ids) do
      local rewardNum = stageCfg.first_reward_nums[index]
      rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, isPicked, false)
    end
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    local extraIds, extraNums = activityFrameCtrl:GetExtraSectorStageFirstReward(stageCfg.id)
    if extraIds ~= nil then
      for index, rewardId in ipairs(extraIds) do
        local rewardNum = extraNums[index]
        rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, isPicked, false)
      end
    end
    if self.__levelDetailExtrData ~= nil then
      local extrFirstRewardList = self.__levelDetailExtrData:Get_AdditionalFirstClearRewardList()
      if extrFirstRewardList ~= nil then
        for index, idNumPair in ipairs(extrFirstRewardList) do
          local itemId = idNumPair.id
          local itemNum = idNumPair.num
          local __isPicked = idNumPair.isForcePicked
          rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, itemId, itemNum, isPicked or __isPicked, true)
        end
      end
    end
    rewardCount = self._addActivityExRewardsFunc(rewardCount, stageCfg)
  end
  self.emptyItemPool:HideAll()
  if firstDropItemLimt > rewardCount then
    for i = 1, firstDropItemLimt - rewardCount do
      local emptyGo = self.emptyItemPool:GetOne(true)
      emptyGo.transform:SetParent(self.ui.normalList)
    end
  end
  if rewardCount == 0 then
    self.ui.obj_reward:SetActive(false)
  end
  local normalCount = #stageCfg.normal_drop
  self.ui.maybeList.gameObject:SetActive(0 < normalCount)
  for k, itemId in ipairs(stageCfg.normal_drop) do
    if k > (self.ui.mayDropItemLimt or 3) then
      break
    end
    local itemCfg = ConfigData.item[itemId]
    local rewardItem = self.rewardItemPool:GetOne()
    rewardItem.transform:SetParent(self.ui.maybeList)
    rewardItem:InitItemWithCount(itemCfg, nil, self.__ShowRewardDetail)
  end
  if isPicked then
    self.ui.normalList:SetAsLastSibling()
  else
    self.ui.maybeList:SetAsLastSibling()
  end
end

function UINLevelNormalNode:RefreshAvgReward(avgCfg)
  self.emptyItemPool:HideAll()
  self.ui.txtInfo_firsRewardList:SetIndex(1)
  self.ui.maybeList.gameObject:SetActive(false)
  self.ui.specialList.gameObject:SetActive(false)
  self.rewardItemPool:HideAll()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local played = avgPlayCtrl:IsAvgPlayed(avgCfg.id)
  local rewardDic = {}
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actCtrl:GetActivityFrameData(avgCfg.activity_id)
  if actFrameData ~= nil and actFrameData:IsActivityOpen() and not actFrameData:IsActivityRunningTimeout() then
    for i, itemId in ipairs(avgCfg.activityRewardIds) do
      local count = rewardDic[itemId] or 0
      rewardDic[itemId] = count + avgCfg.activityRewardNums[i]
    end
  end
  for k, itemId in ipairs(avgCfg.rewardIds) do
    local count = rewardDic[itemId] or 0
    rewardDic[itemId] = count + avgCfg.rewardNums[k]
  end
  if self.__levelDetailExtrData ~= nil then
    local extrFirstRewardList = self.__levelDetailExtrData:Get_AdditionalFirstClearRewardList()
    if extrFirstRewardList ~= nil then
      for index, idNumPair in ipairs(extrFirstRewardList) do
        local itemId = idNumPair.id
        local itemNum = idNumPair.num
        rewardDic[itemId] = (rewardDic[itemId] or 0) + itemNum
      end
    end
  end
  local isShow = 0 < table.count(rewardDic)
  self.ui.obj_reward:SetActive(isShow)
  if not isShow then
    return
  end
  local rewardCount = 0
  local rewardCountMax = self.ui.AvgDropItemLimt or 5
  for itemId, itemNum in pairs(rewardDic) do
    if rewardCount >= rewardCountMax then
      break
    end
    rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, itemId, itemNum, played, false)
  end
end

function UINLevelNormalNode:RefreshInfinityReward(levelData)
  local infinityCfg = levelData.cfg
  self.emptyItemPool:HideAll()
  self.rewardItemPool:HideAll()
  self.ui.txtInfo_firsRewardList:SetIndex(2)
  self.ui.specialList.gameObject:SetActive(false)
  self.ui.normalList.gameObject:SetActive(#infinityCfg.clear_reward_itemIds > 0)
  for index, rewardId in ipairs(infinityCfg.clear_reward_itemIds) do
    local rewardNum = infinityCfg.clear_reward_itemNums[index]
    local itemCfg = ConfigData.item[rewardId]
    local rewardItem = self.rewardItemPool:GetOne()
    rewardItem.transform:SetParent(self.ui.normalList)
    rewardItem:InitItemWithCount(itemCfg, rewardNum, self.__ShowRewardDetail, levelData.isComplete)
  end
  if levelData.isComplete then
    self.ui.txt_maybeRewardList:SetIndex(0)
    self.ui.maybeList.gameObject:SetActive(0 < #infinityCfg.normal_drop)
    for k, itemId in ipairs(infinityCfg.normal_drop) do
      local itemCfg = ConfigData.item[itemId]
      if itemCfg == nil then
        error("can't get itemCfg withId:" .. tostring(itemId))
      end
      local rewardItem = self.rewardItemPool:GetOne()
      rewardItem.transform:SetParent(self.ui.maybeList)
      rewardItem:InitItemWithCount(itemCfg, nil, self.__ShowRewardDetail)
    end
    self.ui.maybeList:SetAsFirstSibling()
  else
    self.ui.maybeList.gameObject:SetActive(false)
  end
end

function UINLevelNormalNode:RefreshInfinityLevelReward(levelData)
  local infinityCfg = levelData.cfg
  self.linfinityLayerDataList = {}
  for index, layerId in ipairs(infinityCfg.layer) do
    local isPass = false
    if levelData.isComplete or index <= levelData.passNum then
      isPass = true
    end
    table.insert(self.linfinityLayerDataList, {
      id = layerId,
      index = index,
      isPass = isPass
    })
  end
  local num = #self.linfinityLayerDataList
  self.ui.Loop_InfinityLayerReardRect.totalCount = num
  self.ui.Loop_InfinityLayerReardRect:RefillCells()
end

function UINLevelNormalNode:RefreshPeriodicChallengeReward(challengeCfg, eChallengeType)
  self.ui.maybeList.gameObject:SetActive(false)
  self.ui.specialList.gameObject:SetActive(false)
  self.emptyItemPool:HideAll()
  self.rewardItemPool:HideAll()
  if eChallengeType == PeridicChallengeEnum.eChallengeType.daliy then
    self.ui.normalList.gameObject:SetActive(#challengeCfg.daily_dropIds > 0)
    for index, rewardId in ipairs(challengeCfg.daily_dropIds) do
      local rewardNum = challengeCfg.daily_dropNums[index]
      local itemCfg = ConfigData.item[rewardId]
      local rewardItem = self.rewardItemPool:GetOne()
      rewardItem.transform:SetParent(self.ui.normalList)
      rewardItem:InitItemWithCount(itemCfg, rewardNum, self.__ShowRewardDetail, PlayerDataCenter.periodicChallengeData:GetIsDailyChallengeFished(), false)
    end
  end
end

function UINLevelNormalNode:RefreshWarchessDrop(stageCfg)
  self.ui.txtInfo_firsRewardList:SetIndex(0)
  self.ui.txt_maybeRewardList:SetIndex(0)
  self.rewardItemPool:HideAll()
  self.emptyItemPool:HideAll()
  self.ui.obj_reward:SetActive(false)
  
  local function func_showReward(recordDic, boxCfgs)
    if IsNull(self.transform) then
      return
    end
    local rewardShowCount = 0
    local isFirstPicked
    local stageState = PlayerDataCenter.sectorStage:GetStageState(stageCfg.id)
    if stageState == proto_object_DungeonStageState.DungeonStageStateNone then
    elseif stageState == proto_object_DungeonStageState.DungeonStageStateCompleted then
      self.sectorNetworkCtrl:Send_SECTOR_BattleFirstRewardPick(stageCfg.id)
      isFirstPicked = true
    elseif stageState == proto_object_DungeonStageState.DungeonStageStatePicked then
      isFirstPicked = true
    end
    for index, rewardId in ipairs(stageCfg.first_reward_ids) do
      local rewardNum = stageCfg.first_reward_nums[index]
      rewardShowCount = self:__CreateDetailRewardItem(rewardShowCount, self.ui.normalList, rewardId, rewardNum, isFirstPicked, false)
    end
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local extraIds, extraNums = activityFrameCtrl:GetExtraSectorStageFirstReward(stageCfg.id)
    if extraIds ~= nil then
      for index, rewardId in ipairs(extraIds) do
        local rewardNum = extraNums[index]
        rewardShowCount = self:__CreateDetailRewardItem(rewardShowCount, self.ui.normalList, rewardId, rewardNum, isFirstPicked, false)
      end
    end
    rewardShowCount = self._addActivityExRewardsFunc(rewardShowCount, stageCfg)
    self.ui.normalList.gameObject:SetActive(0 < rewardShowCount)
    local specialCount = 0
    if boxCfgs ~= nil then
      for boxId, boxCfg in pairs(boxCfgs) do
        local isPicked = recordDic ~= nil and recordDic[boxId] ~= nil
        for index, itemId in ipairs(boxCfg.reward_ids) do
          local itemNum = boxCfg.reward_nums[index]
          specialCount = self:__CreateDetailRewardItem(specialCount, self.ui.specialList, itemId, itemNum, isPicked, false)
        end
      end
    end
    self.ui.specialList.gameObject:SetActive(0 < specialCount)
    local normalShowCount = #stageCfg.normal_drop
    if 0 < normalShowCount then
      for k, itemId in ipairs(stageCfg.normal_drop) do
        if k > (self.ui.mayDropItemLimt or 3) then
          break
        end
        self:__CreateDetailRewardItem(normalShowCount, self.ui.maybeList, itemId, nil)
      end
      if isFirstPicked then
        self.ui.maybeList:SetAsLastSibling()
        self.ui.specialList:SetAsLastSibling()
        self.ui.normalList:SetAsLastSibling()
      else
        self.ui.normalList:SetAsLastSibling()
        self.ui.maybeList:SetAsLastSibling()
        self.ui.specialList:SetAsLastSibling()
      end
    end
    self.ui.maybeList.gameObject:SetActive(0 < normalShowCount)
    if specialCount == 0 and rewardShowCount == 0 and normalShowCount == 0 then
      self.ui.obj_reward:SetActive(false)
      return
    end
    self.ui.obj_reward:SetActive(true)
    self:ForceRefresh()
  end
  
  local warchessId = stageCfg.exploration_list[1]
  local boxCfgs = ConfigData.warchess_level_real_rewards[warchessId]
  if boxCfgs == nil then
    func_showReward(nil, nil)
    return
  end
  local warchessNet = NetworkManager:GetNetwork(NetworkTypeID.WarChess)
  warchessNet:CS_WarChess_UniqueRewardBrief(warchessId, function(objList)
    if IsNull(self.transform) then
      return
    end
    if objList == nil or objList.Count == 0 then
      return
    end
    local records = objList[0]
    func_showReward(records, boxCfgs)
  end)
end

local actExpandRewardsDic = {
  [ActivityFrameEnum.eActivityType.SectorI] = function(self, rewardCount, stageCfg, actId)
    local _, data, inRuning = PlayerDataCenter.allActivitySectorIData:GetDataBySectorIdRunning(stageCfg.sector)
    local relationCfg = data:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil then
      self.ui.tips_relation:SetActive(true)
      local relationStageState = PlayerDataCenter.sectorStage:GetStageState(relationCfg.id)
      local relationPick = relationStageState == proto_object_DungeonStageState.DungeonStageStatePicked
      for index, rewardId in ipairs(relationCfg.first_reward_ids) do
        local rewardNum = relationCfg.first_reward_nums[index]
        rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, relationPick, true)
      end
    end
    return rewardCount
  end,
  [ActivityFrameEnum.eActivityType.Winter23] = function(self, rewardCount, stageCfg, actId)
    local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    local activityData = win23Ctrl:GetWinter23DataByActId(actId)
    local relationCfg = activityData:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil then
      local relationStageState = PlayerDataCenter.sectorStage:GetStageState(relationCfg.id)
      local relationPick = relationStageState == proto_object_DungeonStageState.DungeonStageStatePicked
      for index, rewardId in ipairs(relationCfg.first_reward_ids) do
        local rewardNum = relationCfg.first_reward_nums[index]
        rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, relationPick, true)
      end
    end
    return rewardCount
  end,
  [ActivityFrameEnum.eActivityType.ActivityCarnival23] = function(self, rewardCount, stageCfg, actId)
    local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
    local activityData = carnival23Ctrl:GetCarnival23DataByActId(actId)
    local relationCfg = activityData:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil then
      local relationStageState = PlayerDataCenter.sectorStage:GetStageState(relationCfg.id)
      local relationPick = relationStageState == proto_object_DungeonStageState.DungeonStageStatePicked
      for index, rewardId in ipairs(relationCfg.first_reward_ids) do
        local rewardNum = relationCfg.first_reward_nums[index]
        rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, relationPick, true)
      end
    end
    return rewardCount
  end,
  [ActivityFrameEnum.eActivityType.ActAnniversary24] = function(self, rewardCount, stageCfg, actId)
    local anni24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    local activityData = anni24Ctrl:GetActDataByActId(actId)
    local relationCfg = activityData:GetRelationStage(stageCfg.id)
    if relationCfg ~= nil then
      local relationStageState = PlayerDataCenter.sectorStage:GetStageState(relationCfg.id)
      local relationPick = relationStageState == proto_object_DungeonStageState.DungeonStageStatePicked
      for index, rewardId in ipairs(relationCfg.first_reward_ids) do
        local rewardNum = relationCfg.first_reward_nums[index]
        rewardCount = self:__CreateDetailRewardItem(rewardCount, self.ui.normalList, rewardId, rewardNum, relationPick, true)
      end
    end
    return rewardCount
  end
}

function UINLevelNormalNode:_AddActivityExRewards(rewardCount, stageCfg)
  local actType, actId, actData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(stageCfg.sector)
  if actData and not actData:IsActivityRunningTimeout() and actExpandRewardsDic[actType] then
    rewardCount = actExpandRewardsDic[actType](self, rewardCount, stageCfg, actId)
  end
  return rewardCount
end

function UINLevelNormalNode:m_NewInfinityItem(go)
  local layerItem = UINLNNInfinityLayerItem.New()
  layerItem:Init(go)
  self.infinityLayerItemDic[go] = layerItem
end

function UINLevelNormalNode:m_ChangeInfinityItem(go, index)
  local layerItem = self.infinityLayerItemDic[go]
  if layerItem == nil then
    error("Can't find layerItem by gameObject")
    return
  end
  local LayerData = self.linfinityLayerDataList[index + 1]
  if LayerData == nil then
    error("Can't find LayerData by index, index = " .. tonumber(index))
  end
  layerItem:InitNodeInfinityLevel(LayerData)
end

function UINLevelNormalNode:ShowRewardDetail(itemCfg)
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end)
end

function UINLevelNormalNode:RefreshWeeklyChallengeInfo(WCData)
  self.ui.tex_periodic_Scoure.text = tostring(WCData:GetCurrentMaxScore())
end

function UINLevelNormalNode:ShowWeeklyChallengeRank()
  if self.LevelDtail.detailType == eDetailType.Warchess then
    local actSector3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII)
    if actSector3Ctrl ~= nil then
      local rankId = actSector3Ctrl:GetHardLevelRankId(self.LevelDtail.challengeId)
      if rankId ~= nil then
        UIUtil.ForceOnClickBack()
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
          if rankWindow == nil then
            return
          end
          rankWindow:InitCommonRank(rankId)
        end)
      end
    end
  else
    local challengeId = self.LevelDtail.challengeId
    UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
    UIManager:ShowWindowAsync(UIWindowTypeID.WeeklyChallengeRank, function(win)
      if win ~= nil then
        win:GenWCRPageTogs(challengeId)
      end
    end)
  end
end

function UINLevelNormalNode:__CreateDetailRewardItem(oriCount, parentTr, itemId, itemNum, isPick, showTag)
  local rewardItem = self.rewardItemPool:GetOne()
  rewardItem.transform:SetParent(parentTr)
  local itemCfg = ConfigData.item[itemId]
  rewardItem:InitItemWithCount(itemCfg, itemNum, self.__ShowRewardDetail, isPick, showTag)
  return (oriCount or 0) + 1
end

function UINLevelNormalNode:ShowLvNormalChallengeTask(show, stageCfg)
  if show then
  else
    self.challengeTaskNode:Hide()
  end
end

function UINLevelNormalNode:OnDelete()
  self.challengeTaskNode:Delete()
  base.OnDelete(self)
end

return UINLevelNormalNode
