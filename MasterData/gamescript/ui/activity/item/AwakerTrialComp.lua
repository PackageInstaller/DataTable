local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local Vector2 = CS.UnityEngine.Vector2
local AwakerTrialComp, Super = System.NewClass("AwakerTrialComp", ActivityBaseComp)

function AwakerTrialComp:ctor(res, activityTid, model, subActivityTid)
  Super.ctor(self)
  self.go = res
  self.ui = UI_Events_Panel_TryResource(res)
  self.model = model
  self.activityTid = activityTid
  self.subActivityTid = nil
  self.prizeList = {}
  self.currStageTid = Vue.ref(0)
  self.currAwakerTid = Vue.ref(0)
end

function AwakerTrialComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:InitStageTid()
  binder:BindToRaw(function(childBinder, stageTid)
    if not stageTid then
      return
    end
    local config = ActivityDataUtils.GetConfig(self.subActivityTid)
    local poolId = config.ActivityPara3[1]
    local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
    local awakerImage = SummonDataUtils.GetBgImage(poolId)
    childBinder:SetImageSync(self.ui.Image_Map, poolCfg.BaseMap)
    childBinder:SetImageSync(self.ui.Image_Awaker, awakerImage)
    local poolTypeNeedShow = poolCfg.Type ~= CommonDefine.SummonPoolType.ChooseUp or not SummonDataUtils.GetChooseUpSSRItemTid(poolCfg.Type, poolId)
    CS.UnityEngine.GameObject.Destroy(self._baseMapObj)
    self._baseMapObj = nil
    if poolCfg.VXPrefab and poolTypeNeedShow then
      local prefab = self.binder:LoadAsset(poolCfg.VXPrefab)
      self._baseMapObj = self.binder:Instantiate(prefab, self.ui.Image_Map.transform)
    end
    local activityName = ActivityDataUtils.GetActivityName(self.subActivityTid)
    childBinder:SetText(self.ui.Text_Mock, activityName)
    childBinder:SetText(self.ui.Text_Title, LT.Text("TrialActivityRewardTips"))
  end, function()
    return self.currStageTid.value
  end)
  self:CreateTrialAwakerTableView()
  self.trialAwakerTableView:ReloadData()
  self:SetTableViewOffsetToSelected()
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetTrialPrizeList), System.fn(self, self._UpdatePrizeItem))
  binder:BindToImage(self.ui.Image_Positioning, System.fn(self, self._GetAwakerSchoolIcon))
  self.ui.Image_SSR:SetActive(false)
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetAwakerName))
  binder:BindButtonClick(self.ui.UI_Summon_Btn_Jump, System.fn(self, self._OnShowDetailBtnClick))
  binder:BindButtonClick(self.ui.Btn_Summon, System.fn(self, self._OnClickSummon))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1x5_Small, System.fn(self, self._OnClickGainPrize), nil, function()
    do return LT.Text end
    return LT.Text, "CommonReceive"
  end, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1, System.fn(self, self._OnClickTrial), nil, function()
    do return LT.Text end
    return LT.Text, "ActivityStartTrial"
  end)
  binder:BindToVisible(self.ui.Text_C_Fail, System.fn(self, self._ShowRunning))
  binder:BindToVisible(self.ui.UI_Common_Btn_Level1x5_Small, System.fn(self, self._ShowGainPrize))
  binder:BindToVisible(self.ui.Image_Finish, System.fn(self, self._ShowFinish))
  binder:BindEvent(EventMgr.Instance.EnterDupSuccess, System.fn(self, self.EnterDupSuccess))
  binder:BindEvent(EventMgr.Instance.OnActivityTaskComplete, System.fn(self, self._OnActivityTaskComplete))
end

function AwakerTrialComp:_OnActivityTaskComplete(activityTid)
  if table.contains(self.model.trialTidList, activityTid) then
    self.trialAwakerTableView:ReloadData()
  end
end

function AwakerTrialComp:CreateTrialAwakerTableView()
  local sizeDelta = self.ui.UI_Events_Item_Try.transform.sizeDelta
  local w, h = sizeDelta.x + 10, sizeDelta.y
  local cbinderMap = {}
  self.trialAwakerTableView = self:CreateTableview(self.ui.ScrollView_Figure, function()
    return #self.model.trialTidList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Events_Item_Try)
    local cbinder = cbinderMap[cell.gameObject]
    if cbinder then
      cbinder:teardown()
    end
    cbinder = self.binder:createChild(cell.gameObject)
    self:_UpdateTrialAwakerItem(cbinder, cell.gameObject, index)
    return cell
  end, function()
    return w, h
  end)
  local maxCount = 4
  local preOffset = self.trialAwakerTableView.cellOffset
  if maxCount <= #self.model.trialTidList then
    self.trialAwakerTableView.cellOffset = Vector2(0, preOffset.y)
  else
    local emptyCount = maxCount - #self.model.trialTidList
    local shiftX = 60
    self.trialAwakerTableView.cellOffset = Vector2(emptyCount * w - shiftX, preOffset.y)
  end
end

function AwakerTrialComp:SetTableViewOffsetToSelected()
  self.binder:BindTimer(0.1, 0, nil, function()
    local showCount = 3.6
    for index, subTid in ipairs(self.model.trialTidList) do
      if subTid == self.subActivityTid and index > showCount then
        local offset = (index - showCount) * 130
        print("-------------set tableview offset", offset)
        self.trialAwakerTableView:SetOffset(offset, false)
        break
      end
    end
  end)
end

function AwakerTrialComp:_ShowRunning()
  local state = self:_GetStageState()
  return state == CommonDefine.CommonState.Realy
end

function AwakerTrialComp:_ShowGainPrize()
  local state = self:_GetStageState()
  return state == CommonDefine.CommonState.GainPrize
end

function AwakerTrialComp:_ShowFinish()
  local state = self:_GetStageState()
  return state == CommonDefine.CommonState.Finish
end

function AwakerTrialComp:_GetStageState()
  local data = self.activityData
  local prizeStateList = data and data.stageList or {}
  local tid = self.currStageTid.value
  local state = prizeStateList[tid] or CommonDefine.CommonState.Realy
  return state
end

function AwakerTrialComp:_GetStageStateByTid(acTid, stageTid)
  local data = self.model:GetActivityDataClient(acTid)
  local prizeStateList = data and data.stageList
  local state = prizeStateList[stageTid] or CommonDefine.CommonState.Realy
  return state
end

function AwakerTrialComp:_GetTrialStageData(subTid)
  local config = ActivityDataUtils.GetConfig(subTid)
  if not config then
    return
  end
  local trialStageList = config.ActivityPara1
  if #trialStageList > 0 then
    return trialStageList[1]
  end
end

function AwakerTrialComp:RefreshLeftTab()
  ActivityTrialUIUtils.RefreshTrialLeftTab(self.subActivityTid)
end

function AwakerTrialComp:InitStageTid()
  local mainActivityPanel = UIManager.Instance:GetWindow(Urls.ActivityMainPanel)
  if not mainActivityPanel or not mainActivityPanel.targetActivityTid then
    self:SetStageTid(1)
    return
  end
  local targetActivityTid = mainActivityPanel.targetActivityTid
  for index, subTid in ipairs(self.model.trialTidList) do
    if subTid == targetActivityTid then
      self:SetStageTid(index)
      return
    end
  end
  self:SetStageTid(1)
end

function AwakerTrialComp:SetStageTid(subIndex)
  local subTid = self.model.trialTidList[subIndex]
  local stageTid = self:_GetTrialStageData(subTid)
  local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(stageTid)
  print("-------------set stage tid", subIndex, subTid, stageTid, self.currStageTid.value)
  if self.currStageTid.value == stageTid then
    print("--------------set stage tid same")
    return
  end
  print("--------------set stage tid diff", stageTid)
  self.currStageTid.value = stageTid
  self.currAwakerTid.value = awakerTid
  self.activityData = self.model:GetActivityDataClient(subTid)
  self.subActivityTid = subTid
  self.model:SetSelectedTrialTid(subTid)
  self.uiAnimController:PlayState("UI_Events_Panel_Try_Switch")
  self:_ClearTimer()
  self:_BindActivityTimer()
end

function AwakerTrialComp:Hide()
  Super.Hide(self)
  self:SetStageTid(1)
end

function AwakerTrialComp:_UpdateTrialAwakerItem(childBinder, go, index)
  local subTid = self.model.trialTidList[index]
  local stageTid = self:_GetTrialStageData(subTid)
  local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(stageTid)
  local awakerImage = AwakerDataUtils.GetAwakerBust(awakerTid, nil, true)
  local awakerQualityImage = AwakerDataUtils.GetAwakerQualityColor(awakerTid)
  local itemUI = UI_Events_Item_TryResource(go)
  childBinder:SetImage(itemUI.Image_Awaker, awakerImage)
  childBinder:SetImage(itemUI.Image_D_Quality_Color, awakerQualityImage)
  childBinder:BindComponent(UICompRedDotNewVue(itemUI.Com_RedDot, RedDotDefine.DynamicRedDotID.ActivityStageListCanGetReward, {
    activityTid = subTid,
    stageTidList = {stageTid}
  }))
  childBinder:SetActive(itemUI.Com_RedDot, self:_GetStageStateByTid(subTid, stageTid) == CommonDefine.CommonState.GainPrize and #self.model.trialTidList > 1)
  childBinder:SetActive(itemUI.Image_Select, self.currStageTid.value == stageTid and #self.model.trialTidList > 1)
  childBinder:SetActive(itemUI.Image_Check, self:_GetStageStateByTid(subTid, stageTid) == CommonDefine.CommonState.Finish)
  childBinder:BindButtonClick(itemUI.Btn_Click, function()
    self:_OnClickTrialAwaker(index)
  end)
end

function AwakerTrialComp:_OnClickTrialAwaker(index)
  self:SetStageTid(index)
  self.trialAwakerTableView:ReloadData()
end

function AwakerTrialComp:_GetTrialPrizeList()
  local stageTid = self.currStageTid.value
  local awakerTrialActivityData = self.activityData
  self.prizeList = self:_GetPrizeList(stageTid, awakerTrialActivityData)
  return self.prizeList
end

function AwakerTrialComp:_GetPrizeList(stageTid, data)
  local config = MainCopyDataUtils.GetStageConfig(stageTid)
  local prizeStateList = data and data.stageList
  local prizeList = {}
  if config and config.TrialActivityRewards then
    for i = 1, #config.TrialActivityRewards, 2 do
      local tid = config.TrialActivityRewards[i]
      local num = config.TrialActivityRewards[i + 1]
      if num and tid then
        local state = prizeStateList[tid] or CommonDefine.CommonState.Realy
        table.insert(prizeList, {
          tid = tid,
          num = num,
          state = state
        })
      end
    end
  end
  return prizeList
end

function AwakerTrialComp:_UpdatePrizeItem(childBinder, go, index)
  local prizeData = self.prizeList[index]
  local itemData = {
    itemTid = prizeData.tid,
    itemCount = prizeData.num
  }
  childBinder:BindComponent(CommonIconItemType2(go, itemData))
end

function AwakerTrialComp:_CheckAwakerValid()
  local awakerTid = self.currAwakerTid.value
  if not awakerTid or 0 == awakerTid then
    return false
  end
  return true
end

function AwakerTrialComp:_GetAwakerSchoolIcon()
  if not self:_CheckAwakerValid() then
    return
  end
  local config = AwakerDataUtils.GetAwakerConfig(self.currAwakerTid.value)
  if not config then
    return
  end
  do return AwakerDataUtils.GetSchoolIcon end
  return AwakerDataUtils.GetSchoolIcon, config.School
end

function AwakerTrialComp:_GetAwakerQualityIcon()
  if not self:_CheckAwakerValid() then
    return
  end
  do return AwakerDataUtils.GetAwakerQualityIcon end
  return AwakerDataUtils.GetAwakerQualityIcon, self.currAwakerTid.value
end

function AwakerTrialComp:_GetAwakerName()
  if not self:_CheckAwakerValid() then
    return
  end
  do return AwakerDataUtils.GetAwakerName end
  return AwakerDataUtils.GetAwakerName, self.currAwakerTid.value
end

function AwakerTrialComp:_OnClickGainPrize()
  local awakerTrialActivityData = self.activityData
  local awakerTrialActivityBaseData = awakerTrialActivityData and awakerTrialActivityData.base
  if awakerTrialActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  local state = self:_GetStageState()
  if state ~= CommonDefine.CommonState.GainPrize then
    return
  end
  local stageTid = self.currStageTid.value
  
  local function ToReqGainAward(extraParams, onRequestCallback)
    ActivityDataUtils.ReqGainAward(self.subActivityTid, stageTid, extraParams, function(result)
      if result then
        awakerTrialActivityData.stageList[stageTid] = CommonDefine.CommonState.Finish
        ActivityManager.Instance.model:UpdateFinishState(self.subActivityTid)
        if onRequestCallback then
          onRequestCallback()
        end
      end
    end)
  end
  
  ToReqGainAward()
end

function AwakerTrialComp:EnterDupSuccess()
  self.InEntering = nil
end

function AwakerTrialComp:_OnClickTrial()
  if self.InEntering then
    return
  else
    self.InEntering = true
  end
  local stageTid = self.currStageTid.value
  
  local function _OnTrialFinished()
    StageExitPanelManager.Instance:PushWhenActivityTrialExit(self.subActivityTid)
  end
  
  WorldStageManager.Instance:CheckOpen(stageTid, _OnTrialFinished, nil, self.subActivityTid)
end

function AwakerTrialComp:_OnShowDetailBtnClick()
  if not self:_CheckAwakerValid() then
    return
  end
  AwakerDataUtils.JumpToSingleAwakerPanel(CommonDefine.AwakerPage.Detail, self.currAwakerTid.value)
end

function AwakerTrialComp:_OnClickSummon()
  local config = ActivityDataUtils.GetConfig(self.subActivityTid)
  if not config then
    return
  end
  local poolId = config.ActivityPara3[1]
  if poolId then
    SummonDataUtils.OpenSummonPanel(poolId)
  end
end

function AwakerTrialComp:OnUnbind()
end

function AwakerTrialComp:OnOpenAnim(callback)
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView)
  self.uiAnimController:PlayState("UI_Events_Panel_Try_Open", callback)
end

function AwakerTrialComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Try_Close", callback)
end

return AwakerTrialComp
