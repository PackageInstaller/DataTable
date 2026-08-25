local PermanentActivity = DT.GetOriginalConstant("PermanentActivity")
local ActivityTabListItem, Super = System.NewClass("ActivityTabListItem", ActivityBaseComp)

function ActivityTabListItem:ctor(res, activityTid, clickFunc, selectFunc, currActivityTid, OnFinished, model)
  Super.ctor(self)
  self.ui = UI_Events_Item_TabResource(res)
  self.activityTid = activityTid
  self.clickFunc = clickFunc
  self.selectFunc = selectFunc
  self.currActivityTid = currActivityTid
  self.showFinished = OnFinished
  self.model = model
end

function ActivityTabListItem:OnBind(binder)
  self.binder = binder
  binder:BindToRaw(function()
    self:SetTabFacade()
  end, function()
    do return self._OnSelect end
    return self._OnSelect, self
  end)
  binder:BindZ1Button(self.ui.uiNode, System.fn(self, self._OnClick), nil, nil, System.fn(self, self._ShowRedDotValue), System.fn(self, self._OnSelect))
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
  if comp then
    comp:SetBtn(self.ui.uiNode)
  end
  local activityType = ActivityCfgUtils.GetCfgField("ActivityType", self.activityTid)
  local isTrialActivity = activityType == ActivityDefine.ActivityType.AwakerTrial
  local redArgs = {
    activityTid = self.activityTid,
    trialActivityTidList = isTrialActivity and self.model:GetTrialTidList() or {}
  }
  binder:BindComponent(UICompRedDotNewVue(self.ui.Red_Com, RedDotDefine.DynamicRedDotID.ActivityTabList, redArgs))
  binder:BindToVisible(self.ui.Image_Check, self.showFinished)
  binder:BindToVisible(self.ui.Image_Mark, function()
    if self.activityTid == 119694 then
      return true
    end
    return ActivityDataUtils.GetActivityMarkTitle(self.activityTid) ~= nil
  end)
  binder:BindToText(self.ui.Text_Mark, function()
    if self.activityTid == 119694 then
      do return LT.Text end
      return LT.Text, "ActivityMarkTwoYears"
    end
    return ActivityDataUtils.GetActivityMarkTitle(self.activityTid) or ""
  end)
end

function ActivityTabListItem:_GetName()
  if self.model:IsTrialActivityTid(self.activityTid) then
    do return LT.Text end
    return LT.Text, "AwakerTrialActivityTitle", self.activityTid
  else
    do return ActivityDataUtils.GetActivityName end
    return ActivityDataUtils.GetActivityName, self.activityTid, self.activityTid
  end
end

function ActivityTabListItem:_GetImage()
  if self.model:IsTrialActivityTid(self.activityTid) then
    do return ActivityDataUtils.GetTabImage end
    return ActivityDataUtils.GetTabImage, self.model.selectedTrialTid or self.activityTid, self.activityTid
  else
    do return ActivityDataUtils.GetTabImage end
    return ActivityDataUtils.GetTabImage, self.activityTid, self.activityTid
  end
end

function ActivityTabListItem:SetTabFacade()
  local isSelect = self:_OnSelect()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetName))
  binder:BindToImage(self.ui.Image_Bright, System.fn(self, self._GetImage))
  binder:BindToImage(self.ui.Image_Dark, System.fn(self, self._GetImage))
  binder:SetActive(self.ui.Hook_Bright, function()
    return self.showFinished and isSelect
  end)
  binder:SetActive(self.ui.Hook_Dark, function()
    return self.showFinished and not isSelect
  end)
  binder:SetActive(self.ui.Image_Tag, table.contains(PermanentActivity or {}, self.activityTid))
  binder:SetActive(self.ui.Text_Mark, not table.contains(PermanentActivity or {}, self.activityTid))
  binder:BindToTextColor(self.ui.Text_Name, function()
    return isSelect and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  end)
  self.binder:SetActive(self.ui.Image_Bright, isSelect)
  self.binder:SetActive(self.ui.Image_Dark, not isSelect)
  self.binder:SetActive(self.ui.Image_Selected, isSelect)
  binder:BindToRaw(function()
    local luaComp = AddLuaCompOnce(self.ui.Image_Dark, LuaUISprite2TexTexcoord)
    if luaComp then
      luaComp:Update()
    end
  end, function()
    return not isSelect
  end)
end

function ActivityTabListItem:_ShowRedDotValue()
end

function ActivityTabListItem:_OnClick()
  if self.clickFunc then
    self.clickFunc()
  end
end

function ActivityTabListItem:_OnSelect()
  if self.selectFunc then
    do return end
    return self.selectFunc
  end
  return false
end

return ActivityTabListItem
