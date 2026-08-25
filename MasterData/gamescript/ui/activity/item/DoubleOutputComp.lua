local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local DoubleOutputComp, Super = System.NewClass("DoubleOutputComp", ActivityBaseComp)

function DoubleOutputComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Panel_DoubleDropResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.stageGroupList = {}
end

function DoubleOutputComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:_BindActivityTimer()
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetStageGroupList), System.fn(self, self._UpdateStageGroupItem))
  binder:BindToRaw(function()
    self.activityData = self.model:GetActivityDataClient(self.activityTid)
    self:_RefreshView()
  end, function()
    local activityDatas = DataCenter.activityData and DataCenter.activityData.activityDatas
    return activityDatas and activityDatas[self.activityTid]
  end)
  self:_RefreshView()
  self:_BindPortraitComp()
  self:_BindLoadVXFx()
end

function DoubleOutputComp:_RefreshView()
  self.ui.Text_Progress_Prohibit:SetActive(false)
  binder:BindToImageSync(self.ui.Image_Map, System.fn(self, self._GetBgImage))
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  binder:SetText(self.ui.Text_Double, activityName)
  binder:BindToText(self.ui.Text_Title, System.fn(self, self._GetCountTitleText))
  binder:BindToText(self.ui.Text_Title_Prohibit, System.fn(self, self._GetCountTitleText))
  binder:BindToText(self.ui.Text_Progress_Prohibit, function()
    return ""
  end)
  binder:BindToTextColor(self.ui.Text_Title, System.fn(self, self._GetCountTextColor))
  binder:BindToImageColor(self.ui.Image_Task, System.fn(self, self._GetTitleImageColor))
  binder:SetActive(self.ui.Image_Task, not self:_HasDoubleDropCount())
  binder:SetActive(self.ui.Image_Task_Active, self:_HasDoubleDropCount())
  binder:SetActive(self.ui.Image_Prohibit, not self:_HasDoubleDropCount())
  self.binder:BindToText(self.ui.Text_Progress, System.fn(self, self._GetCountText))
  self.binder:BindToTextColor(self.ui.Text_Progress, System.fn(self, self._GetCountTextColor))
end

function DoubleOutputComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function DoubleOutputComp:_GetStageGroupList()
  local config = ActivityDataUtils.GetConfig(self.activityTid)
  if not config then
    return {}
  end
  self.stageGroupList = config.ActivityPara1 or {}
  return self.stageGroupList
end

function DoubleOutputComp:_UpdateStageGroupItem(childBinder, go, index)
  local stageGroupTid = self.stageGroupList[index]
  local stageGroupConfig = DT.StageGroup[stageGroupTid]
  local itemUI = UI_Events_Item_DoubleDropResource(go)
  
  local function _OnClickLocation()
    local jumpTid = stageGroupConfig and stageGroupConfig.StageGroupJumpID
    if not jumpTid then
      return
    end
    FuncJumpManager.Instance:JumpFunc(jumpTid)
  end
  
  childBinder:SetText(itemUI.Text_Title, stageGroupConfig.Name)
  childBinder:SetText(itemUI.Text_Task, stageGroupConfig.StageGroupRewardDescription)
  childBinder:BindButtonClick(itemUI.Image_Location, _OnClickLocation)
end

function DoubleOutputComp:_GetCountTitleText()
  local doubleOutputData = self.activityData
  local leftCount = doubleOutputData.count or 0
  local bonusNum = ActivityDataUtils.GetDoubleOutputBonus(self.activityTid)
  if not leftCount or leftCount <= 0 then
    do return LT.Text end
    return LT.Text, "DoubleOutputActivityTimesRunOut", nil
  end
  do return LT.Textf, "DoubleOutputActivityTimesHead" end
  return LT.Textf, "DoubleOutputActivityTimesHead", bonusNum
end

function DoubleOutputComp:_GetCountText()
  local doubleOutputData = self.activityData
  local leftCount = doubleOutputData and doubleOutputData.count or 0
  local isUnlimited = ActivityDataUtils.CheckDoubleOutputTotalCountUnlimited(self.activityTid)
  if isUnlimited then
    do return LT.Text end
    return LT.Text, "ActivityExtraDropTimes", nil
  end
  if 0 == leftCount then
    return ""
  end
  do return LT.Textf, "StoreRenewTimes" end
  return LT.Textf, "StoreRenewTimes", leftCount
end

function DoubleOutputComp:_HasDoubleDropCount()
  local doubleOutputData = self.activityData
  if not doubleOutputData then
    return false
  end
  local leftCount = doubleOutputData.count or 0
  return leftCount > 0
end

function DoubleOutputComp:_GetCountTextColor()
  return CommonDefine.ColorType.Light
end

function DoubleOutputComp:_GetTitleImageColor()
  local doubleOutputData = self.activityData
  local darkColor = ColorUtils.GetColorHexCode("UXDouble", CommonDefine.ColorType.Dark)
  if not doubleOutputData then
    return darkColor
  end
  local leftCount = doubleOutputData.count or 0
  if leftCount <= 0 then
    return darkColor
  end
  local lightColor = ColorUtils.GetColorHexCode("UXDouble", CommonDefine.ColorType.Light)
  return lightColor
end

function DoubleOutputComp:OnUnbind()
  self:_ClearTimer()
end

function DoubleOutputComp:OnOpenAnim(callback)
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView)
  self.uiAnimController:PlayState("UI_Events_Panel_DoubleDrop_Open", callback)
end

function DoubleOutputComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_DoubleDrop_Close", callback)
end

return DoubleOutputComp
