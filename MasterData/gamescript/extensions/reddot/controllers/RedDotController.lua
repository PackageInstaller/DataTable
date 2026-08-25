local RedDotID = RedDotDefine.RedDotID
local DynamicRedDotID = RedDotDefine.DynamicRedDotID
local ServerRedDotID = RedDotDefine.ServerRedDotID
local DeepFindChild = CS.Framework.GameObjectUtil.DeepFindChild
local RedDotController = System.NewClass("RedDotController", BaseController)
local RedDotType = RedDotDefine.RedDotType
local Vue = require("Vue.Vue")

function RedDotController:OnInit()
  EventMgr.Instance.AfterAddUIPanel:RegisterEvent(System.fn(self, self._OnViewOpening))
  EventMgr.Instance.AfterCloseUIPanel:RegisterEvent(System.fn(self, self._OnViewClosed))
  EventMgr.Instance.OnProtoMsgResponse:RegisterEvent(System.fn(self, self._OnProtoMsgData))
  EventMgr.Instance.OnProtoMsgRequest:RegisterEvent(System.fn(self, self._OnProtoMsgData))
  self:RegisterNotify(NotifyId.OnStoryReviewRedStatusChanged, self._OnStoryReviewRedStatusChanged, self)
end

function RedDotController:OnReset()
  self._redDotId2TreeFuncDict = {}
  self._redDotComponents = {}
  self._toUpdateCompComps = {}
  self:_RegisterRedDotTrees()
end

function RedDotController:_RegisterRedDotTrees()
  self:RegisterRedDotTree(RedDotID.DailyCopyEntry, RedDotTreeUtils.GetDailyCopyEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.DailyCopyTask, RedDotTreeUtils.GetDailyCopyTaskRedDotTree)
  self:RegisterRedDotTree(RedDotID.DailyCopyCareerLevel, RedDotTreeUtils.GetDailyCopyCareerLevelRedDotTree)
  self:RegisterRedDotTree(RedDotID.ActivityMainEntry, RedDotTreeUtils.GetActivityMainEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.RailWayEntry, RedDotTreeUtils.GetRailWayEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.RailWayEntryWithoutSeasonReward, RedDotTreeUtils.GetRailWayEntryRedDotTreeWithoutSeasonReward)
  self:RegisterRedDotTree(DynamicRedDotID.ActivityTabList, RedDotTreeUtils.GetActivityTabListRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ActivityTaskListGroupEntry, RedDotTreeUtils.GetTaskListActivityTaskGroupRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ActivityShopEntry, RedDotTreeUtils.GetActivityShopRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.SingleActivityEntry, RedDotTreeUtils.GetSingleActivityEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.StageGroupEntry, RedDotTreeUtils.GetStageGroupEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ActivityStageGroupEntry, RedDotTreeUtils.GetActivityStageGroupEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ActivitySubplotEntry, RedDotTreeUtils.GetActivitySubplotEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ActivityStageListCanGetReward, RedDotTreeUtils.GetRedDotActivityStageListCanGetRewardWork)
  self:RegisterRedDotTree(DynamicRedDotID.ActivityWorldBossStageGroupEntry, RedDotActivityTreeUtils.GetWorldBossRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ActivityWorldBossEntry, RedDotActivityTreeUtils.GetTwoAnniversaryWorldBossEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.GuideNoteSidebarTab, RedDotTreeUtils.GetGuideNoteSidebarRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.GuideNoteMainEntry, RedDotTreeUtils.GetGuideNoteMainEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.GuideNoteTierReward, RedDotTreeUtils.GetGuideNoteTierRewardRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.RedDotConversionRemain, RedDotTreeUtils.GetRedDotConversionRemainRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.DynamicFuncNew, RedDotTreeUtils.GetDynamicFuncNewRedDotTree)
  self:RegisterRedDotTree(RedDotID.RecallEntry, RedDotTreeUtils.GetRecallEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.GamePassportEntry, RedDotTreeUtils.GetGamePassportEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.CopyMainEntry, RedDotTreeUtils.GetCopyMainEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.StageGroupsMainChaperPageEntry, RedDotTreeUtils.GetStageGroupsMainChapterPageEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.CopySmallSubplotPageEntry, RedDotTreeUtils.GetCopySmallSubplotPageEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.CopyLargeSubplotPageEntry, RedDotTreeUtils.GetCopyLargeSubplotPageEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.CopyConfessionPageEntry, RedDotTreeUtils.GetCopyConfessionPageEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.CopySpecialSubplotPageEntry, RedDotTreeUtils.GetCopySpecialSubplotPageEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.CopyLinkageActivityPageEntry, RedDotTreeUtils.GetCopyLinkageActivityPageEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.StageGroupsMorimenChapterEntry, RedDotTreeUtils.GetStageGroupsMorimenChapterEntryRedDotTree)
  self:RegisterRedDotTree(RedDotID.StageGroupstarsCameRightChapterEntry, RedDotTreeUtils.GetStageGroupsStarsCameRightChapterEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.MainStageGroupSimpleRedDotEntry, RedDotTreeUtils.GetMainStageGroupSimpleRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.MainStageGroupHardRedDotEntry, RedDotTreeUtils.GetMainStageGroupHardRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.MainStageGroupNorNightmareRedDotEntry, RedDotTreeUtils.GetMainStageGroupNightmareRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.StageGroupRememberRedDotEntry, RedDotTreeUtils.GetStageGroupRememberRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.StageGroupRedDot, RedDotTreeUtils.GetStageGroupRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ResonanceRedDot, RedDotTreeUtils.GetResonanceRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ResonanceGroupRedDot, RedDotTreeUtils.GetResonanceGroupRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.StageGroupStarsProgRedDot, RedDotTreeUtils.GetStageGroupStarsProgRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.StageGroupArchivementRedDot, RedDotTreeUtils.GetStageGroupArchivementRedDotTree)
  self:RegisterRedDotTree(ServerRedDotID.StageNewRedDot, RedDotTreeUtils.GetStageNewRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.SubplotStageGroupRedDot, RedDotTreeUtils.GetSubplotStageGroupRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.SubplotStageRedDot, RedDotTreeUtils.GetSubplotStageRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.SubplotStageGroupEntryRedDot, RedDotTreeUtils.GetSubplotStageGroupEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ArtCollectionCGTab, RedDotTreeUtils.GetArtCollectionCGTabRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.ShopTypeTabRedDot, RedDotTreeUtils.GetShopTypeTabRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.TutorialMainTabRedDot, RedDotTreeUtils.GetTutorialMainTabRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.TutorialMainItemRedDot, RedDotTreeUtils.GetTutorialMainItemRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.TutorialMainNextPageRedDot, RedDotTreeUtils.GetTutorialMainNextPageRedDotTree)
  self:RegisterRedDotTree(RedDotID.TreasureMailEntry, RedDotTreeUtils.GetTreasureMailEntryRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.MailItemUnread, RedDotTreeUtils.GetMailItemUnreadRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.AnnouncementNoticeItem, RedDotTreeUtils.GetAnnouncementNoticeItemRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.AnnouncementPageTab, RedDotTreeUtils.GetAnnouncementPageTabRedDotTree)
  self:RegisterRedDotTree(DynamicRedDotID.AnnouncementEntrance, RedDotTreeUtils.GetAnnouncementEntranceRedDotTree)
end

function RedDotController:RegisterRedDotTree(redDotId, redTreeFunc)
  self._redDotId2TreeFuncDict[redDotId] = redTreeFunc
end

function RedDotController:UnregisterRedPointFunc(redDotID)
  self._redDotId2TreeFuncDict[redDotID] = nil
end

function RedDotController:_OnViewOpening(url)
  local redDotCfg = RedDotDefine.RedDotConfigs[url]
  if not redDotCfg then
    return
  end
  local tmpView = UIManager.Instance:GetWindow(url)
  if not tmpView or not tmpView.ui then
    return
  end
  for redNodeName, redCfg in pairs(redDotCfg) do
    local redNode = tmpView.ui[redNodeName]
    if not redNode and tmpView.ui.uiNode then
      redNode = DeepFindChild(tmpView.ui.uiNode.transform, redNodeName)
      redNode = redNode and redNode.gameObject or nil
    end
    if not redNode then
      Logger.Error("RedNode not found, url: ", url, " redNodeName: ", redNodeName)
    else
      local redDotParamsFunc = redCfg.redDotParamsFunc
      local redDotID = redCfg.redDotID
      local param = redDotParamsFunc and redDotParamsFunc(redDotID) or nil
      self:AddRedPointCompnent(tmpView, redNode, redDotID, param)
    end
  end
end

function RedDotController:_OnViewClosed(url)
  local redDotComponents = self:GetPanelRedPointCompnents(url)
  if not redDotComponents then
    return
  end
  self._redDotComponents[url] = nil
end

function RedDotController:_OnProtoMsgData(funcName)
  if not self:IsNeedRefreshRedDotWhileMsgArrived(funcName) then
    return
  end
  CommandBufferMgr.Instance:PushCommand(self.RefreshAllRedDots, self)
end

function RedDotController:OnEnterRedPointComponent(comp)
  local uiNode = comp.gameObject
  local url = comp.view.url
  self._redDotComponents = self._redDotComponents or {}
  self._redDotComponents[url] = self._redDotComponents[url] or {}
  self._redDotComponents[url][uiNode] = comp
end

function RedDotController:OnExitRedPointComponent(comp)
  local uiNode = comp.gameObject
  self._toUpdateCompComps[comp] = nil
  local url = comp.view.url
  if self._redDotComponents[url] then
    self._redDotComponents[url][uiNode] = nil
  end
end

function RedDotController:IsNeedRefreshRedDotWhileMsgArrived(funcName)
  if bg.battleScene ~= nil or WorldStageManager.Instance:IsInStage() then
    return false
  end
  if "OnSyncCard" == funcName or "OnSyncRelic" == funcName or "OnSyncStateData" == funcName then
    return false
  end
  return true
end

function RedDotController:LateUpdate()
  if not self._toUpdateCompComps then
    return
  end
  RedGameObjectMgr.LateUpdate()
  local comp = next(self._toUpdateCompComps)
  if comp then
    comp:UpdateRedPointStatus()
    self._toUpdateCompComps[comp] = nil
  end
end

function RedDotController:AddRedPointCompnent(view, uiNode, redDotID, args)
  self:RemoveRedPointCompnent(view, uiNode)
  local comp = view:AddRedPoint(uiNode, redDotID, args)
  return comp
end

function RedDotController:RemoveRedPointCompnent(view, uiNode)
  local redDotComponents = self:GetPanelRedPointCompnents(view.url)
  if not redDotComponents then
    return
  end
  if redDotComponents[uiNode] then
    local comp = view:RemoveViewComponent(uiNode, UICompRedDotNew)
    redDotComponents[uiNode] = nil
    self._toUpdateCompComps[comp] = nil
  end
end

function RedDotController:GetUINodeRedPointCompnent(view, uiNode)
  local redDotComponents = self:GetPanelRedPointCompnents(view.url)
  if not redDotComponents then
    return
  end
  return redDotComponents[uiNode]
end

function RedDotController:GetPanelRedPointCompnents(url)
  return self._redDotComponents and self._redDotComponents[url] or nil
end

function RedDotController:RefreshAllRedDots(immediately)
  table.clear(self._toUpdateCompComps)
  if immediately then
    Vue.pauseTracking()
    if self._redDotComponents then
      for _, redCompCfgs in pairs(self._redDotComponents) do
        for _, redComp in pairs(redCompCfgs) do
          redComp:UpdateRedPointStatus()
        end
      end
    end
    Vue.resetTracking()
  elseif self._redDotComponents then
    for _, redCompCfgs in pairs(self._redDotComponents) do
      for _, redComp in pairs(redCompCfgs) do
        self._toUpdateCompComps[redComp] = true
      end
    end
  end
end

function RedDotController:RefreshRedDot(redDotId, args)
  if self._redDotComponents then
    for _, redCompCfgs in pairs(self._redDotComponents) do
      for _, redComp in pairs(redCompCfgs) do
        if redComp.redPointID == redDotId then
          redComp:InitRedData(redDotId, args)
        end
      end
    end
  end
end

function RedDotController:GetRedDotTree(redDotId, args)
  local redTreeFunc = self._redDotId2TreeFuncDict[redDotId]
  if redTreeFunc then
    do return redTreeFunc end
    return redTreeFunc, args
  end
  return nil
end

function RedDotController:GetRedDotStatus(redDotId, args)
  local redDotTree = self:GetRedDotTree(redDotId, args)
  if redDotTree then
    local redStatus = redDotTree:Execute()
    redDotTree:Release()
    if type(redStatus) == "boolean" then
      return redStatus and RedDotType.Red or RedDotType.None
    end
    return redStatus or false
  end
  return false
end

function RedDotController:OnRemoveRedPoint(redType, tid, keyType)
  ProtoManager.Instance:ReqServer("GameRequest", "OnRemoveRedPoint", function(data)
    Logger.Info("OnRemoveRedPoint Successful")
  end, function(data)
    Logger.Info("OnRemoveRedPoint Failed")
  end, redType, tid, keyType)
end

function RedDotController:_OnStoryReviewRedStatusChanged()
  self:RefreshRedDot(RedDotDefine.RedDotID.StageGroupRememberRedDotEntry)
  self:RefreshRedDot(RedDotDefine.RedDotID.CopyMainEntry)
end

return RedDotController
