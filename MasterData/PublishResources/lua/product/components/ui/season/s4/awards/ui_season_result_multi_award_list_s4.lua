_class("UISeasonResultMultiAwardListS4", UICustomWidget)
UISeasonResultMultiAwardListS4 = UISeasonResultMultiAwardListS4

function UISeasonResultMultiAwardListS4:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonResultMultiAwardListS4:InitWidget()
  self._seasonAwardGen = self:GetUIComponent("UISelectObjectPath", "Content")
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UISeasonResultMultiAwardListS4:OnHide()
end

function UISeasonResultMultiAwardListS4:SetData(matchRes, seasonMissionInfo)
  local firstDiff = UISeasonLevelDiff.Hard
  local secondDiff = UISeasonLevelDiff.Normal
  local missionId = seasonMissionInfo.mission_id
  local secondMissionId = 0
  if missionId then
    local useMissionCfg = Cfg.cfg_season_mission[missionId]
    if useMissionCfg then
      firstDiff = useMissionCfg.OrderID
      local secondMissionCfg
      local missionGroupId = useMissionCfg.GroupID
      local missionGroupCfgs = Cfg.cfg_season_mission({GroupID = missionGroupId})
      if 0 < #missionGroupCfgs then
        for index, value in ipairs(missionGroupCfgs) do
          if value.OrderID ~= useMissionCfg.OrderID then
            secondMissionCfg = value
            secondMissionId = value.ID
            secondDiff = value.OrderID
            break
          end
        end
      end
    end
  end
  local normalRewards = matchRes.m_vecAwardNormal
  local starRewards = matchRes.m_vecAwardPerfect
  local firstPassRawrds = matchRes.m_vecFirstPassAward
  local extStarRewards = matchRes.m_ext_star_rewards[secondMissionId] or {}
  local extFirstPassRewards = matchRes.m_ext_first_rewards[secondMissionId] or {}
  local activityRewards = matchRes.m_activity_rewards
  local extReward = matchRes.m_vecExtAward
  local doubleExtReward = matchRes.m_vecDoubleExtAward
  local backRewards = matchRes.m_back_rewards or {}
  local recommendReward = {}
  local collectionList = {}
  normalRewards = self:ProcessCollectionItem(normalRewards, collectionList)
  starRewards = self:ProcessCollectionItem(starRewards, collectionList)
  firstPassRawrds = self:ProcessCollectionItem(firstPassRawrds, collectionList)
  extStarRewards = self:ProcessCollectionItem(extStarRewards, collectionList)
  extFirstPassRewards = self:ProcessCollectionItem(extFirstPassRewards, collectionList)
  local itemModule = GameGlobal.GetModule(ItemModule)
  if 1 < #recommendReward then
    itemModule:BattleResultSortAsset(recommendReward)
  end
  if 1 < #doubleExtReward then
    itemModule:BattleResultSortAsset(doubleExtReward)
  end
  if 1 < #starRewards then
    itemModule:BattleResultSortAsset(starRewards)
  end
  if 1 < #extStarRewards then
    itemModule:BattleResultSortAsset(extStarRewards)
  end
  if 1 < #firstPassRawrds then
    itemModule:BattleResultSortAsset(firstPassRawrds)
  end
  if 1 < #extFirstPassRewards then
    itemModule:BattleResultSortAsset(extFirstPassRewards)
  end
  if 1 < #normalRewards then
    self:BattleNormalResultSortAsset(normalRewards)
  end
  if 1 < #extReward then
    itemModule:BattleResultSortAsset(extReward)
  end
  if 1 < #backRewards then
    itemModule:BattleResultSortAsset(backRewards)
  end
  local multiAwardList = {}
  local firstList = {}
  local firstCellCount = #starRewards + #firstPassRawrds + #normalRewards
  firstList.levelDiff = firstDiff
  firstList.cellCount = firstCellCount
  firstList.starRewards = starRewards
  firstList.firstPassRawrds = firstPassRawrds
  firstList.normalRewards = normalRewards
  table.insert(multiAwardList, firstList)
  if 0 < #extStarRewards or 0 < #extFirstPassRewards then
    local secondList = {}
    local secondCellCount = #extStarRewards + #extFirstPassRewards
    secondList.levelDiff = secondDiff
    secondList.cellCount = secondCellCount
    secondList.extStarRewards = extStarRewards
    secondList.extFirstPassRewards = extFirstPassRewards
    table.insert(multiAwardList, secondList)
  end
  self._multiAwardList = multiAwardList
  local count = #self._multiAwardList
  self._seasonAwardGen:SpawnObjects("UISeasonResultSingleAwardListS4", count)
  local list = self._seasonAwardGen:GetAllSpawnList()
  for i, v in ipairs(list) do
    v:SetData(self._multiAwardList[i])
  end
  self:ResetScrollPos()
  if collectionList and 0 < #collectionList then
    local seasonModule = self:GetModule(SeasonModule)
    if seasonModule then
      for index, value in ipairs(collectionList) do
        seasonModule:AppendWaitShowCollectionRewards(value)
      end
    end
  end
end

function UISeasonResultMultiAwardListS4:ProcessCollectionItem(awardList, collectionList)
  local retList = {}
  for i = 1, #awardList do
    local roleAsset = awardList[i]
    local isCollection = UISeasonHelper.IsSeasonCollectionItem(roleAsset.assetid)
    if isCollection then
      table.insert(collectionList, roleAsset)
    else
      table.insert(retList, roleAsset)
    end
  end
  return retList
end

function UISeasonResultMultiAwardListS4:ResetScrollPos()
  self._sr.horizontalNormalizedPosition = 0
end

function UISeasonResultMultiAwardListS4:_GetItemCount(vecItem)
  local nItemCount = 0
  if vecItem then
    for i = 1, #vecItem do
      local roleAsset = vecItem[i]
      if roleAsset.assetid ~= RoleAssetID.RoleAssetExp then
        nItemCount = nItemCount + 1
      end
    end
  end
  return nItemCount
end

function UISeasonResultMultiAwardListS4:BattleNormalResultSortAsset(assets)
  local dataList = self:GetPassAward()
  table.sort(assets, function(a, b)
    local ta = Cfg.cfg_item[a.assetid]
    local tb = Cfg.cfg_item[b.assetid]
    if ta == nil then
      Log.error(" Cfg.cfg_item cant find assetid ", a.assetid)
    end
    if tb == nil then
      Log.error(" Cfg.cfg_item cant find assetid ", b.assetid)
    end
    local aNormal = self:HasItem(dataList, ta.ID)
    local bNormal = self:HasItem(dataList, tb.ID)
    if aNormal == bNormal then
      if ta.Color == tb.Color then
        return ta.ID < tb.ID
      else
        return ta.Color > tb.Color
      end
    else
      return aNormal > bNormal
    end
  end)
  return assets
end

function UISeasonResultMultiAwardListS4:GetPassAward()
  local awardHeadType, cfgId
  return UICommonHelper:GetInstance():GetPassAward(awardHeadType, cfgId)
end

function UISeasonResultMultiAwardListS4:HasItem(dataList, itemId)
  local isNormal = 0
  if dataList then
    for i, v in ipairs(dataList) do
      if v.ItemID == itemId then
        isNormal = 1
        break
      end
    end
  end
  return isNormal
end
