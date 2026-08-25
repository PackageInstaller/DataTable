local ArtCollectionController = NewClass("ArtCollectionController", BaseController)

function ArtCollectionController:OnInit()
  self:InitTempCheckMap()
  self.CollectTypeMap = {}
end

function ArtCollectionController:OnReset()
end

function ArtCollectionController:InitTempCheckMap()
  local tempCheckMap = {}
  local unlockType = CommonDefine.ArtCollectUnlockType.AvgFirstTrigger
  for cfgId, cfg in pairs(DT.CollectionHall) do
    if cfg.UnlockCondType == unlockType then
      for _, avgId in ipairs(cfg.UnlockCondPara) do
        local t = tempCheckMap[avgId]
        if nil == t then
          t = {}
          tempCheckMap[avgId] = t
        end
        if not table.contains(t, cfgId) then
          table.insert(t, cfgId)
        end
      end
    end
  end
  self.tempCheckMap = tempCheckMap
end

function ArtCollectionController:ReqArtCollectionData()
  ProtoManager.Instance:ReqServer("GameRequest", "OnArtCollectionOpen", function(data)
    Logger.Info("========== 请求图鉴数据成功 ==========\n", table.tostring(data or {}))
    ArtCollectionModel.Instance:SetCollectServerData(data)
  end, function(data)
    Logger.Info("========== 请求图鉴数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function ArtCollectionController:OnItemUnlock(cfgId)
  ProtoManager.Instance:ReqServer("GameRequest", "OnCollectionItemUnlock", function(data)
    Logger.Info("========== OnItemUnlock 成功==========\n", cfgId, table.tostring(data or {}))
    ArtCollectionModel.Instance:UpdateItemUnlocked(cfgId, true)
  end, function(data)
    Logger.Info("========== OnItemUnlock失败 ==========\n", table.tostring(data or {}))
  end, cfgId)
end

function ArtCollectionController:AlreadyUnlockByAvgId(avgId)
  local checkCfgIds = self.tempCheckMap[avgId] or {}
  for _, cfgId in ipairs(checkCfgIds) do
    if self:IsUnlock(cfgId) == false then
      return false
    end
  end
  return true
end

function ArtCollectionController:CollecAvgTrigger(avgId)
  if 0 == DataCenter.playerData.DRole.uid then
    return
  end
  if self:AlreadyUnlockByAvgId(avgId) then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "CollecAvgTrigger", function(data)
    Logger.Info("========== 触发Avg时，发送图鉴解锁成功 ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Info("========== 触发Avg时，发送图鉴解锁失败 ==========\n", table.tostring(data or {}))
  end, avgId)
end

function ArtCollectionController:GetDataSortListByFeature(featureType, key)
  local subCollectDatas = table.deepclone(self:GetSubCollectDatasByFeature(featureType, key))
  self:Sort(subCollectDatas, true)
  for _, groupData in ipairs(subCollectDatas) do
    self:Sort(groupData.list)
  end
  if 1 == #subCollectDatas and 0 == tonumber(subCollectDatas[1].groupId) then
    return subCollectDatas[1].list
  end
  return subCollectDatas
end

function ArtCollectionController:GetSubCollectDatasByFeature(featureType, key)
  local featureTypeT = self.CollectTypeMap[featureType]
  if nil == featureTypeT then
    featureTypeT = {}
    self.CollectTypeMap[featureType] = featureTypeT
  end
  local collectType = featureTypeT[key]
  if nil == collectType then
    collectType = self:GetCollectTypeByFeature(featureType, key)
    featureTypeT[key] = collectType
  end
  local subCollectDatas = self:_GetSubCollectDatas(collectType)
  subCollectDatas = table.deepclone(subCollectDatas)
  local serverTime = TimeUtils.GetServerTime()
  for collectDataIndex = #subCollectDatas, 1, -1 do
    local groupData = subCollectDatas[collectDataIndex]
    for itemIndex = #groupData.list, 1, -1 do
      local cfgId = groupData.list[itemIndex]
      local cfg = DT.CollectionHall[cfgId]
      if serverTime < (cfg.CollectionDisplayDate or 0) then
        table.remove(groupData.list, itemIndex)
      end
    end
    if 0 == #groupData.list then
      table.remove(subCollectDatas, collectDataIndex)
    end
  end
  return subCollectDatas
end

function ArtCollectionController:GetCollectTypeByFeature(featureType, key)
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(featureType, key)
  return featureCfg.ID
end

function ArtCollectionController:_GetSubCollectDatas(collectType)
  local subCollectDatas = ArtCollectionModel.Instance:GetSubCollectDatas(collectType)
  return subCollectDatas
end

function ArtCollectionController:Sort(list, elementIsTable)
  table.sort(list, function(av, bv)
    local a = elementIsTable and av.groupId or av
    local b = elementIsTable and bv.groupId or bv
    local aCfg = DT.CollectionHall[a]
    local bCfg = DT.CollectionHall[b]
    local sortType = aCfg.SortRule
    if CommonDefine.ArtCollectSort.Unlock == sortType then
      local aUnlock = self:IsUnlock(a) and 0 or 1
      local bUnlock = self:IsUnlock(b) and 0 or 1
      if aUnlock == bUnlock then
        return aCfg.BaseSortID < bCfg.BaseSortID
      else
        return aUnlock < bUnlock
      end
    else
      return aCfg.BaseSortID < bCfg.BaseSortID
    end
  end)
end

function ArtCollectionController:IsUnlock(cfgId)
  do return ArtCollectionModel.Instance.IsUnlock, ArtCollectionModel.Instance end
  return ArtCollectionModel.Instance.IsUnlock, ArtCollectionModel.Instance, cfgId
end

function ArtCollectionController:OpenArtCollectionView()
  UIManager.Instance:Reopen(Urls.ArtCollectionView)
end

function ArtCollectionController:GetCollectPageUnlockCount(featureType, subFeatureData)
  local finishCnt, totalCnt = 0, 0
  for _, subFeature in pairs(subFeatureData) do
    local finishSubCnt, totalSubCnt = self:CollectCnt(featureType, subFeature)
    finishCnt = finishCnt + finishSubCnt
    totalCnt = totalCnt + totalSubCnt
  end
  return finishCnt, totalCnt
end

function ArtCollectionController:GetAllCollectCnt()
  local collectDatas = ArtCollectionModel.Instance:GetCollectDatas()
  local finalFinishCnt = 0
  local finalTotalCnt = 0
  for featureTid, _ in pairs(collectDatas) do
    local featureCfg = FeatureUnlockCfgUtils.GetCfg(featureTid)
    local finishCnt, totalCnt = self:CollectCnt(featureCfg.Feature, featureCfg.Key or 0)
    finalFinishCnt = finalFinishCnt + finishCnt
    finalTotalCnt = finalTotalCnt + totalCnt
  end
  return finalFinishCnt, finalTotalCnt
end

function ArtCollectionController:CollectCnt(featureType, key)
  local subCollectDatas = self:GetSubCollectDatasByFeature(featureType, key)
  local finishCnt = 0
  local totalCnt = 0
  for _, groupData in pairs(subCollectDatas) do
    local _finishCnt, _totalCnt = self:CollectUnlockCntByTids(groupData.list)
    totalCnt = totalCnt + _totalCnt
    finishCnt = finishCnt + _finishCnt
  end
  return finishCnt, totalCnt
end

function ArtCollectionController:CollectUnlockCntByTids(collectIds)
  local totalCnt, finishCnt = 0, 0
  for _, collectId in pairs(collectIds) do
    totalCnt = totalCnt + 1
    local collectCfg = CollectionHallCfgUtils.GetCfg(collectId)
    if collectCfg.CollectionCountType and collectCfg.CollectionGroup and self:IsUnlock(collectId) and ArtCollectionModel.Instance:IsItemUnlocked(collectId) then
      finishCnt = finishCnt + 1
    end
  end
  return finishCnt, totalCnt
end

function ArtCollectionController:OpenRewardView(rewardType)
  if not rewardType then
    return
  end
  local taskCfg = ArtCollectionRewardModel.Instance:GetTaskCfg()
  if not taskCfg or not taskCfg[rewardType] then
    return
  end
  UIManager.Instance:Reopen(Urls.ArtCollectionRewardView, rewardType)
end

function ArtCollectionController:HasUnlockItemInThisLine(lineIndex, list, colsNum)
  local lineStartIdx = (lineIndex - 1) * colsNum + 1
  local maxCnt = lineStartIdx + colsNum - 1
  for i = lineStartIdx, maxCnt do
    local cfgId = list[i]
    if cfgId and ArtCollectionController.Instance:IsUnlock(cfgId) then
      return true
    end
  end
  return false
end

function ArtCollectionController:ResizeWidthAndHeight(width, height)
  local screenW = CS.UnityEngine.Screen.width
  local screenH = CS.UnityEngine.Screen.height
  local curProportion = screenW / screenH
  local defaultW = UIRootMgr.GetBGImageWidth()
  local defaultH = UIRootMgr.GetBGImageHeight()
  local bgProportion = defaultW / defaultH
  local rectTrans = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(CS.UnityEngine.RectTransform))
  local canvasScaler = rectTrans:GetComponent(typeof(CS.UnityEngine.UI.CanvasScaler))
  local referrenceProportion = canvasScaler.referenceResolution.x / canvasScaler.referenceResolution.y
  local realSizeX, realSizeY = rectTrans.sizeDelta.x, rectTrans.sizeDelta.y
  local resultW, resultH = realSizeX, realSizeY
  if curProportion > referrenceProportion and curProportion >= bgProportion then
    resultW = realSizeY / height * width
  elseif curProportion < referrenceProportion and curProportion <= bgProportion then
    local relativeHeight = canvasScaler.referenceResolution.x / screenW * screenH
    local offsetVal = relativeHeight - defaultH
    resultH = realSizeY - offsetVal
    resultW = resultH / height * width
  else
    resultW = realSizeY / height * width
  end
  return resultW, resultH
end

return ArtCollectionController
