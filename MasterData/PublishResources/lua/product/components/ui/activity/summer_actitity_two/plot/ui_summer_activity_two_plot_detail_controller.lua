_class("UISummerActivityTwoPlotDetailController", UIController)
UISummerActivityTwoPlotDetailController = UISummerActivityTwoPlotDetailController

function UISummerActivityTwoPlotDetailController:LoadDataOnEnter(TT, res, uiParams)
  local _campaignTypeId = uiParams[1]
  local _componentTypeId = uiParams[2]
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, _campaignTypeId, _componentTypeId)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    Log.error("###[UISummerActivityTwoPlotDetailController] res and not res:GetSucc() !")
    return
  end
  self._story_component = self._campaign:GetLocalProcess()._storyComponent
  self._story_componentinfo = self._campaign:GetLocalProcess()._storyComponentInfo
  self._componentID = self._story_component:GetComponetCfgId(self._campaign._id, self._story_componentinfo.m_component_id)
end

function UISummerActivityTwoPlotDetailController:OnShow(uiParams)
  self._itemCountPerRow = 1
  self._idx = 0
  self._missionCount = 1
  self._animClips = {
    [1] = "uieff_Summer2_Detail_In",
    [2] = "uieff_Summer2_Detail_Out"
  }
  self:_GetComponents()
  self._currentStoryId = uiParams[3] or nil
  if not self._componentID then
    Log.error("###[UISummerActivityTwoPlotDetailController] self._componentID is nil !")
    return
  end
  self:CreateData()
  if self._idx == 0 then
    self._idx = 1
  end
  self:_OnValue()
  self:PlayAnim()
end

function UISummerActivityTwoPlotDetailController:PlayAnim()
  if self._anim then
    self:Lock("self._anim:Play1")
    GameGlobal.Timer():AddEvent(667, function()
      self:UnLock("self._anim:Play1")
    end)
  end
end

function UISummerActivityTwoPlotDetailController:CreateData()
  local cfg_component_story = Cfg.cfg_component_story[self._componentID]
  if not cfg_component_story then
    Log.error("###[UISummerActivityTwoPlotDetailController] cfg_component_story is nil ! id --> ", self._componentID)
    return
  end
  self._plotData = {}
  local storyIDList = cfg_component_story.StoryID
  local idx_get = false
  for i = 1, #storyIDList do
    local data = {}
    local storyid = storyIDList[i]
    if self._currentStoryId and self._idx == 0 and storyid == self._currentStoryId then
      self._idx = i
    end
    local cfg_campaign_story = Cfg.cfg_campaign_story[storyid]
    if not cfg_campaign_story then
      Log.error("###[UISummerActivityTwoPlotDetailController] cfg_campaign_story is nil ! id --> ", storyid)
      return
    end
    data.storyid = storyid
    data.title = cfg_campaign_story.Title
    data.desc = cfg_campaign_story.Des
    data.cg = cfg_campaign_story.Icon
    data.name = cfg_campaign_story.Title
    data.awardList = cfg_campaign_story.RewardList
    local unLock, condition = self:CheckBeforePlot(storyid)
    data.unlock = unLock
    data.condition = condition
    local red = false
    if unLock then
      local missionUnLock = self:CheckMissionCondition(storyid)
      if missionUnLock then
        if idx_get == false then
          self._idx = i
        end
        local recv_list = self._story_component:GetAlreadyReceivedStoryIdList()
        local got = table.icontains(recv_list, storyid)
        red = not got
        if red then
          idx_get = true
        end
      end
    end
    data.red = red
    table.insert(self._plotData, data)
  end
end

function UISummerActivityTwoPlotDetailController:CheckBeforePlot(storyid)
  local unlock = false
  local condition
  local cfg_campaign_story = Cfg.cfg_campaign_story[storyid]
  local lockStoryID
  if cfg_campaign_story.PreStoryID then
    lockStoryID = cfg_campaign_story.PreStoryID
    local recv_list = self._story_component:GetAlreadyReceivedStoryIdList()
    if table.icontains(recv_list, cfg_campaign_story.PreStoryID) then
      unlock = true
    end
  else
    unlock = true
  end
  if unlock == false then
    local storyName = Cfg.cfg_campaign_story[lockStoryID]
    if not storyName then
      Log.error("###[UISummerActivityTwoPlotDetailController] cfg_campaign_story is nil ! id --> ", lockStoryID)
    end
    condition = StringTable.Get("str_summer_activity_two_plot_unlock_plot_condition", StringTable.Get(storyName.Title))
  end
  return unlock, condition
end

function UISummerActivityTwoPlotDetailController:CheckMissionCondition(storyid)
  local unlock = true
  local lockData = {}
  local cfg_campaign_story = Cfg.cfg_campaign_story[storyid]
  if not cfg_campaign_story then
    Log.error("###[UISummerActivityTwoPlotDetailController] cfg_campaign_story is nil ! id --> ", storyid)
  end
  if cfg_campaign_story and cfg_campaign_story.ComponentID then
    local com = self._campaignModule:GetComponentByComponentId(cfg_campaign_story.ComponentID)
    if com then
      local missionList = {}
      for i = 1, #cfg_campaign_story.NeedMissionList do
        local missionid = cfg_campaign_story.NeedMissionList[i]
        local pass = com:IsPassCamMissionID(missionid)
        if not pass and unlock then
          unlock = false
        end
        local missionData = {}
        missionData.missionid = missionid
        missionData.pass = pass
        table.insert(lockData, missionData)
      end
    else
      unlock = false
      for i = 1, #cfg_campaign_story.NeedMissionList do
        local missionData = {}
        missionData.missionid = cfg_campaign_story.NeedMissionList[i]
        missionData.pass = false
        table.insert(lockData, missionData)
      end
    end
  end
  return unlock, lockData
end

function UISummerActivityTwoPlotDetailController:OnHide()
end

function UISummerActivityTwoPlotDetailController:_GetComponents()
  self._anim = self:GetUIComponent("Animation", "UISummerActivityTwoPlotDetailController")
  self._plotTitle = self:GetUIComponent("UILocalizationText", "plotTitle")
  self._plotDesc = self:GetUIComponent("UILocalizationText", "plotDesc")
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "awardPool")
  self._plotList = self:GetUIComponent("UIDynamicScrollView", "plotList")
  self._plotCg = self:GetUIComponent("RawImageLoader", "plotCg")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
  self._openBtnGo = self:GetGameObject("openBtn")
  self._lockMissionGo = self:GetGameObject("lockMission")
  self._missionPool = self:GetUIComponent("UISelectObjectPath", "missionPool")
  self._missionPool:SpawnObjects("UISummerTwoPlotLockMissionItem", self._missionCount)
  self._gotGo = self:GetGameObject("got")
  self._red = self:GetGameObject("red")
  self._openBtnClick = self:GetGameObject("openBtnClick")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._openBtnGo), UIEvent.Press, function(go)
    self._openBtnClick:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._openBtnGo), UIEvent.Release, function(go)
    self._openBtnClick:SetActive(false)
  end)
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._anim then
      self:Lock("self._anim:Play2")
      GameGlobal.Timer():AddEvent(500, function()
        self:UnLock("self._anim:Play2")
        self:CloseDialog()
      end)
      self._anim:Play(self._animClips[2])
    else
      self:CloseDialog()
    end
  end, nil, nil, true)
end

function UISummerActivityTwoPlotDetailController:_OnValue()
  self:_InitPlotList()
  self:_ShowPlotInfo()
end

function UISummerActivityTwoPlotDetailController:_ShowPlotInfo()
  self:_InitAwardPool()
  local got = self:CheckStoryGotAwards(self._idx)
  self._gotGo:SetActive(got)
  local title = self._plotData[self._idx].title
  self._plotTitle:SetText(StringTable.Get(title))
  local desc = self._plotData[self._idx].desc
  self._plotDesc:SetText(StringTable.Get(desc))
  self:SetMissionPassData()
end

function UISummerActivityTwoPlotDetailController:SetMissionPassData()
  local unlock, lockData = self:CheckMissionCondition(self._plotData[self._idx].storyid)
  self._openBtnGo:SetActive(unlock)
  if unlock then
    local got = self:CheckStoryGotAwards(self._idx)
    self._red:SetActive(not got)
  end
  self._lockMissionGo:SetActive(not unlock)
  if not unlock then
    local pools = self._missionPool:GetAllSpawnList()
    for i = 1, #pools do
      local missionData = lockData[i]
      if missionData then
        pools[i]:SetData(i, missionData)
        pools[i]:SetActive(true)
      else
        pools[i]:SetActive(false)
      end
    end
  end
end

function UISummerActivityTwoPlotDetailController:_InitPlotList()
  self._plotCount = #self._plotData
  self._plotList:InitListView(self._plotCount, function(scrollView, index)
    return self:_InitListView(scrollView, index)
  end)
  local moveIdx = math.max(self._idx - 1, 0)
  self._plotList:MovePanelToItemIndex(moveIdx, 0)
end

function UISummerActivityTwoPlotDetailController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISummerActivityTwoPlotDetailItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowItem(heartItem, itemIndex)
  end
  return item
end

function UISummerActivityTwoPlotDetailController:_ShowItem(heartItem, index)
  if heartItem ~= nil then
    heartItem:GetGameObject():SetActive(true)
    heartItem:SetData(index, self._idx, self._plotData[index], function(idx)
      self:_PlotItemClick(idx)
    end)
  end
end

function UISummerActivityTwoPlotDetailController:_PlotItemClick(idx)
  if self._idx == idx then
    return
  end
  local unlcok = self._plotData[idx].unlock
  if not unlcok then
    ToastManager.ShowToast(StringTable.Get("str_summer_activity_two_plot_lock"))
    return
  end
  self._idx = idx
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSummerActivityPlotSelect, self._idx)
  self:_ShowPlotInfo()
end

function UISummerActivityTwoPlotDetailController:GetPlotAward()
  if not self:CheckStoryGotAwards(self._idx) then
    self:Lock("UISummerActivityTwoPlotDetailController:GetPlotAward")
    GameGlobal.TaskManager():StartTask(self.OnGetPlotAward, self)
  end
end

function UISummerActivityTwoPlotDetailController:OnGetPlotAward(TT)
  local request = AsyncRequestRes:New()
  local rewards = self._story_component:HandleStoryTake(TT, request, self._plotData[self._idx].storyid)
  self:UnLock("UISummerActivityTwoPlotDetailController:GetPlotAward")
  if request:GetSucc() then
    self:ShowDialog("UIGetItemController", rewards)
    self:RefreshValue()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SummerTwoPlotRed)
  else
    self._campaignModule:CheckErrorCode(request.m_result, self._campaign._id, function()
      self:RefreshValue()
    end, function()
      self:CloseDialog()
    end)
  end
end

function UISummerActivityTwoPlotDetailController:RefreshValue()
  self:CreateData()
  self:RefreshList()
  self:_ShowPlotInfo()
end

function UISummerActivityTwoPlotDetailController:RefreshList()
  local contentPos = self._plotList.ScrollRect.content.localPosition
  self._plotList:SetListItemCount(#self._plotData)
  self._plotList:MovePanelToItemIndex(0, 0)
  self._plotList.ScrollRect.content.localPosition = contentPos
end

function UISummerActivityTwoPlotDetailController:openBtnOnClick()
  local storyid = self._plotData[self._idx].storyid
  self:ShowDialog("UIStoryController", storyid, function()
    self:GetPlotAward()
  end)
end

function UISummerActivityTwoPlotDetailController:CheckStoryGotAwards(idx)
  local recv_list = self._story_component:GetAlreadyReceivedStoryIdList()
  return table.icontains(recv_list, self._plotData[idx].storyid)
end

function UISummerActivityTwoPlotDetailController:_InitAwardPool()
  local awardList = self._plotData[self._idx].awardList
  self._awardPool:SpawnObjects("UISummerActivityTwoPlotDetailAwardItem", #awardList)
  local awardPool = self._awardPool:GetAllSpawnList()
  for i = 1, #awardList do
    local item = awardPool[i]
    local dataID = awardList[i][1]
    local dataCount = awardList[i][2]
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = dataID
    roleAsset.count = dataCount
    item:SetData(i, roleAsset, function(id, pos)
      self:_ClickAwardItem(id, pos)
    end)
  end
end

function UISummerActivityTwoPlotDetailController:_ClickAwardItem(id, pos)
  self._selectInfo:SetData(id, pos)
end

function UISummerActivityTwoPlotDetailController:RedTotal()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  if not campaignModule then
    return false
  end
  local isCmptOpened = false
  local sampleInfo = campaignModule.m_campaign_manager:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN)
  if not sampleInfo then
    return false
  end
  if sampleInfo.is_open then
    isCmptOpened = true
  end
  if not isCmptOpened then
    return false
  end
  local complateFlag = sampleInfo.m_extend_info[CampainExtendKey.E_CAMPAIGN_EXTEND_KEY_CUMULATIVE_LOGIN_COMPLATE]
  if complateFlag and complateFlag == 1 then
    return false
  end
  return true
end

function UISummerActivityTwoPlotDetailController:RedPlot()
  return true
end
