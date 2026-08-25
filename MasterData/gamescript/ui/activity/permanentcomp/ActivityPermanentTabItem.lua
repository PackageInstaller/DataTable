local ActivityPermanentTabItem, Super = System.NewComponent("ActivityPermanentTabItem")

function ActivityPermanentTabItem:ctor(res, viewData)
  Super.ctor(self)
  self.ui = UI_Events_Item_TabResource(res)
  self.clickCb = viewData.clickCb
  self.activityTid = viewData.activityTid
end

function ActivityPermanentTabItem:OnBind(binder)
  self.binder = binder
  self:_OnBindEvent(binder)
  self:_OnAutoAdaptionText()
  binder:SetActive(self.ui.Hook_Bright, false)
  binder:SetActive(self.ui.Hook_Dark, false)
  self:_RefreshView()
end

function ActivityPermanentTabItem:_OnBindEvent(binder)
  binder:BindZ1Button(self.ui.uiNode, System.fn(self, self._OnClick))
  binder:BindEvent(EventMgr.Instance.OnPermanentActivitySelectChanged, System.fn(self, self._OnPermanentActivitySelectChanged))
end

function ActivityPermanentTabItem:_OnPermanentActivitySelectChanged(activityTid)
  self:_RefreshView(activityTid == self.activityTid)
end

function ActivityPermanentTabItem:_OnClick()
  if self.clickCb then
    self.clickCb()
  end
end

function ActivityPermanentTabItem:_OnAutoAdaptionText()
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
  if comp then
    comp:SetBtn(self.ui.uiNode)
  end
end

function ActivityPermanentTabItem:_RefreshView(isSelect)
  local binder = self.binder
  binder:SetText(self.ui.Text_Name, LT.Text(ActivityCfgUtils.GetCfgField("ActivityName", self.activityTid)))
  binder:SetImage(self.ui.Image_Bright, ActivityDataUtils.GetTabImage(self.activityTid))
  binder:SetImage(self.ui.Image_Dark, ActivityDataUtils.GetTabImage(self.activityTid))
  binder:BindToTextColor(self.ui.Text_Name, function()
    return isSelect and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  end)
  binder:SetActive(self.ui.Image_Bright, isSelect)
  binder:SetActive(self.ui.Image_Dark, not isSelect)
  binder:SetActive(self.ui.Image_Selected, isSelect)
end

return ActivityPermanentTabItem
