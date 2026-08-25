local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TIMER_DURATION = DT.GetConstant("ActivityBannerShowTime")
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local MainPanelSummonBannerComp, Super = System.NewComponent("MainPanelSummonBannerComp")

function MainPanelSummonBannerComp:ctor(uiNode, mainPanel)
  Super.ctor(self)
  self.ui = UI_Main_Panel_1Resource(uiNode)
  self.mainPanel = mainPanel
  self.dotObjList = {}
end

function MainPanelSummonBannerComp:InitViewData()
  self.oriBannerList = self:_GetOriBannerList()
  self.curBannerIdx = 1
end

function MainPanelSummonBannerComp:Get_curBannerIdx(numVal)
  return self.curBannerIdx
end

function MainPanelSummonBannerComp:Set_curBannerIdx(numVal)
  if self.curBannerIdx == numVal then
    return
  end
  self.curBannerIdx = numVal
  self:_RefreshView()
end

function MainPanelSummonBannerComp:_InitBannerGroupGroupView()
  local cellRT = self.ui.UI_Main_SummonBanner_Item:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.bannerGroupView = self:CreateTableview(self.ui.ScrollView_SummonAdvertise, function()
    if not self.oriBannerList then
      return 0
    end
    return #self.oriBannerList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Main_SummonBanner_Item)
    self:_AddBannerItemComp(cell.gameObject, index)
    return cell
  end, function()
    return width, height
  end)
  self.bannerGroupView.alignedOnStopMoving = true
  
  function self.bannerGroupView.onScrollValueChanged()
    local curIndex = self.bannerGroupView:GetCurrentIndex()
    self:Set_curBannerIdx(curIndex + 1)
  end
  
  local scrollRect = self.ui.ScrollView_SummonAdvertise:GetComponent(T_ScrollRect)
  scrollRect.horizontal = #self.oriBannerList > 1
  local haveBanner = #self.oriBannerList > 0
  self.ui.bg_Recruit:SetActive(not haveBanner)
  self.ui.Group_SummonBanner:SetActive(haveBanner)
  self.ui.Content_Roll_Advertise.transform.anchoredPosition = CS.UnityEngine.Vector2(0, self.ui.Content_Roll_SummonAdvertise.transform.anchoredPosition.y)
end

function MainPanelSummonBannerComp:_AddBannerItemComp(item, index)
  local itemObj = UI_Main_SummonBanner_ItemResource(item)
  local poolId = self.oriBannerList[index].tid
  if not poolId then
    return
  end
  self.binder:SetImage(itemObj.Image_Banner, self:GetBannerPic(poolId))
  self.binder:BindButtonClick(itemObj.Btn_Click, function()
    SummonDataUtils.OpenSummonPanel(poolId, true)
  end)
end

function MainPanelSummonBannerComp:GetBannerPic(poolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  local bannerPic = poolCfg.BannerResources
  if bannerPic and string.contains(bannerPic, ";") then
    local picList = string.split(bannerPic, ";")
    if PlayerDataUtils.IsMale() then
      return picList[1]
    end
    return picList[2]
  end
  return bannerPic
end

function MainPanelSummonBannerComp:OnBind(binder)
  self.binder = binder
  GlobalDispatcher:AddListener(NotifyId.OnActivityFinished, self._OnActivityFinished, self)
  self:OnEnterComp()
end

function MainPanelSummonBannerComp:OnEnterComp()
  self:InitViewData()
  self:_InitTimer()
  self:_InitEvent()
  self:_InitBannerGroupGroupView()
  self:_RefreshView()
end

function MainPanelSummonBannerComp:_InitEvent()
  self.binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnTouchBegin))
  self.binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self.OnTouchEnd))
  self.binder:BindEvent(EventMgr.Instance.OnSummonPoolClosed, System.fn(self, self._RefreshView))
end

function MainPanelSummonBannerComp:_InitTimer()
  if self.timer then
    return
  end
  self.timer = self.binder:BindTimer(TIMER_DURATION, -1, function()
    if self._isTouch then
      return
    end
    self:RollBanner(self:Get_curBannerIdx() + 1)
  end)
end

function MainPanelSummonBannerComp:OnTouchBegin()
  self._isTouch = true
end

function MainPanelSummonBannerComp:OnTouchEnd()
  self._isTouch = false
end

function MainPanelSummonBannerComp:_RefreshView()
  local haveBanner = #self.oriBannerList > 0
  self.ui.bg_Recruit:SetActive(not haveBanner)
  if not haveBanner then
    self.ui.Group_SummonBanner:SetActive(false)
    return
  end
  self.bannerGroupView:ReloadData()
  self:_RefreshDotGroup()
end

function MainPanelSummonBannerComp:_RefreshDotGroup()
  local bannerNum = 0
  for idx, poolData in ipairs(self.oriBannerList) do
    bannerNum = bannerNum + 1
    local dotObj = self.dotObjList[idx]
    if not dotObj or IsNil(dotObj) then
      dotObj = self.binder:Instantiate(self.ui.Dark, self.ui.Group_SummonDot.transform)
      self.dotObjList[idx] = dotObj
    end
    dotObj:SetActive(#self.oriBannerList > 1)
    local brightGo = CS.Framework.GameObjectUtil.FindChildByPath(dotObj, "Bright")
    brightGo:SetActive(self:Get_curBannerIdx() == idx)
  end
  if bannerNum < #self.dotObjList then
    for idx = bannerNum + 1, #self.dotObjList do
      local dotObj = self.dotObjList[idx]
      dotObj:SetActive(false)
    end
  end
end

function MainPanelSummonBannerComp:_GetOriBannerList()
  do return end
  return SummonDataUtils.GetDisplayBannerList
end

function MainPanelSummonBannerComp:RollBanner(idx)
  if not GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
    return
  end
  if 0 == #self.oriBannerList then
    return
  end
  if self.mainPanel and not self.mainPanel:IsRendering() then
    return
  end
  local moveWithSpring = true
  if 1 == idx or idx > #self.oriBannerList then
    idx = 1
    moveWithSpring = false
  end
  self:JumpBanner(idx, moveWithSpring)
  self:Set_curBannerIdx(idx)
end

function MainPanelSummonBannerComp:JumpBanner(targetIdx, moveWithSpring)
  local offset = self.bannerGroupView:GetOffsetByIndex(targetIdx - 1)
  self.bannerGroupView:SetOffset(offset, moveWithSpring)
end

function MainPanelSummonBannerComp:OnUnbind()
  GlobalDispatcher:RemoveListener(NotifyId.OnActivityFinished, self._OnActivityFinished, self)
  Super.OnUnbind(self)
  self:ClearRes()
end

function MainPanelSummonBannerComp:ClearRes()
  for _, obj in pairs(self.dotObjList) do
    GameObject.Destroy(obj)
  end
  self.dotObjList = {}
end

function MainPanelSummonBannerComp:_OnActivityFinished(activityTid)
  local isHited = false
  if self.oriBannerList then
    for i = 1, #self.oriBannerList do
      if self.oriBannerList[i] == activityTid then
        table.remove(self.oriBannerList, i)
        self.curBannerIdx = 1
        isHited = true
        break
      end
    end
  end
  if isHited then
    self:_RefreshView()
  end
end

return MainPanelSummonBannerComp
