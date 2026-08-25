local UIAnimationController = CS.Z1Client.UIAnimationController
local ActivityDoubleExpComp, Super = System.NewClass("ActivityDoubleExpComp", ActivityBaseComp)

function ActivityDoubleExpComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Panel_AwardResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
end

function ActivityDoubleExpComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:_BindActivityTimer()
  binder:BindToImageSync(self.ui.Image_Map, System.fn(self, self._GetBgImage))
  self.ui.AwakerMask:SetActive(false)
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  binder:SetText(self.ui.Text_Mock, activityName)
  local activityPlotInfo = ActivityDataUtils.GetActivityPlot(self.activityTid)
  binder:SetText(self.ui.Text_Info, activityPlotInfo)
  binder:BindComponent(ActivityDoubleExpItem(self.ui.UI_Events_Item_DoubleDrop_1, function()
    FuncJumpManager.Instance:JumpToDailyChallenge(nil, CommonDefine.FeatureId.DailyChallenge)
  end))
  binder:BindComponent(ActivityDoubleExpItem(self.ui.UI_Events_Item_DoubleDrop_2, function()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.PVP, 0)
    if not unlocked then
      PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.PVP, 0)
      return
    else
      UIManager.Instance:Reopen(Urls.MainPanelPVP)
    end
  end))
  local dayExp = PlayerDataUtils.GetRoleData().dayExp or 0
  local dayLimit = PlayerDataUtils.GetRoleDayExpLimit()
  local state = dayExp < dayLimit
  self.ui.Image_Quality_1:SetActive(not state)
  self.ui.Image_Quality_2:SetActive(state)
  binder:SetText(self.ui.Text_Quantity, string.format("%s/%s", dayExp, dayLimit))
  binder:SetText(self.ui.Text_Quantity_Ash, string.format("%s/%s", dayExp, dayLimit))
  self:_BindPortraitComp()
end

function ActivityDoubleExpComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function ActivityDoubleExpComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Award_Open", callback)
end

function ActivityDoubleExpComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Award_Close", callback)
end

return ActivityDoubleExpComp
