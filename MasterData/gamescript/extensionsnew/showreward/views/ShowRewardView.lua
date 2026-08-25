local ShowRewardView, Super = NewClass("ShowRewardView", BaseView)
ShowRewardView.uiResCls = UI_Common_Popup_Tips_SmallResource
local DragGesture = CS.Z1Client.General.DragGesture
local Type_UIGrabPassRawImage = typeof(CS.UIGrabPassRawImage)

function ShowRewardView:ctor(title, subTitle, closeCb, statistics)
  Super.ctor(self)
  self._title = title
  self._subTitle = subTitle
  self._closeCb = closeCb
  self._statistics = statistics
  self._rewardSource = nil
  self._clearRewardsTag = true
  self._rewardListView = nil
  self._isDragScrollview = false
  self._gesture = nil
  self._fullTipsRes = nil
  self._isClosing = false
end

function ShowRewardView:OnBuildView()
  self:_CreateRewardListView()
end

function ShowRewardView:RegisterNotifications()
  self:BindEvent(EventMgr.Instance.OnShowRewardListChanged, System.fn(self, self._OnRefreshRewardListView))
end

function ShowRewardView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClose))
  self:_OnBindScrollViewGesture()
end

function ShowRewardView:OnEnterView()
  Super.OnEnterView(self)
  self:_LoadInitResource()
  self:_PlayVoice()
  self:_OnRefreshAll()
end

function ShowRewardView:OnEnterViewFinished()
end

function ShowRewardView:OnExitView()
  self:_OnClearGesture()
  if self._clearRewardsTag then
    ItemDataUtils.ClearShowRewards()
  end
  PopTipsManager.Instance:ClearCachedRewardList()
  Super.OnExitView(self)
end

function ShowRewardView:_OnBindScrollViewGesture()
  self._gesture = self.ui.ScrollView_Reward:GetComponent(typeof(DragGesture))
  if self._gesture then
    self._gesture:onDrag("+", System.fn(self, self._OnDragScrollview))
    self._gesture:onPointerDown("+", System.fn(self, self._OnPointerDownUpponScrollview))
    self._gesture:onPointerClick("+", System.fn(self, self._OnPointerClickScrollview))
  end
end

function ShowRewardView:_OnClearGesture()
  if self._gesture then
    self._gesture:onDrag("-", System.fn(self, self._OnDragScrollview))
    self._gesture:onPointerDown("-", System.fn(self, self._OnPointerDownUpponScrollview))
    self._gesture:onPointerClick("-", System.fn(self, self._OnPointerClickScrollview))
    self._gesture = nil
  end
end

function ShowRewardView:_OnPointerDownUpponScrollview()
  self._isDragScrollview = false
end

function ShowRewardView:_OnDragScrollview()
  self._isDragScrollview = true
end

function ShowRewardView:_OnPointerClickScrollview()
end

function ShowRewardView:_LoadInitResource()
  local prefab = self:LoadAsset("UI/UI_Common/UI_Common_Prefab/UI_Awaker_Effect_texiao.prefab")
  if prefab then
    GameObject.Instantiate(prefab, self.ui.Title_Bg.transform)
  end
end

function ShowRewardView:_PlayVoice()
  ItemDataUtils.PlayRewardPanelVoice()
end

function ShowRewardView:_OnRefreshAll()
  self:_OnRefreshTipsTitle()
  self:_OnRefreshRewardListView()
end

function ShowRewardView:_OnRefreshTipsTitle()
  local title = self._title
  if not title or "" == title then
    title = LT.Text("ItemGain_String_MainTitle_CHN")
  end
  if not self._fullTipsRes then
    self._fullTipsRes = UI_Common_Popup_Tips_FullResource(self.ui.UI_Common_Popup_Tips_Full)
  end
  self:SetText(self._fullTipsRes.Text_Title, title)
end

function ShowRewardView:_CreateDungeonItemInfo(data)
  local extraDescBgType = data.extraDescBgType
  local extraDesc = data.extraDesc
  local extraDescOfReason, extraDescBgTypeOfReason = ItemDataUtils.GetExtraDescByReason(data.reason)
  if nil ~= extraDescOfReason then
    extraDesc = extraDescOfReason
  end
  if nil ~= extraDescBgTypeOfReason then
    extraDescBgType = extraDescBgTypeOfReason
  end
  local itemAwardTypeDesc = data.itemAwardTypeDesc
  if not extraDesc and itemAwardTypeDesc and "" ~= itemAwardTypeDesc then
    extraDesc = itemAwardTypeDesc
    if data.awardType == CommonDefine.ItemAwardType.BonusCard then
      extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue
    else
      extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Default
    end
    itemAwardTypeDesc = nil
  end
  local rst = {
    tid = data.tid,
    uid = data.uid,
    isGot = false,
    num = data.changedNum,
    type = data.awardType,
    showName = true,
    extraOrigin = data.extraOrigin,
    extraDescFunc = data.extraDescFunc,
    extraDesc = extraDesc,
    extraDescBgType = extraDescBgType,
    itemAwardTypeDesc = data.itemAwardTypeDesc,
    overflow = data.overflow,
    reason = data.reason,
    showWeaponLevel = true
  }
  if data.extraDescFunc then
    setmetatable(rst, ReactiveFlags.SKIP)
  end
  return rst
end

function ShowRewardView:_IsHaveAutoDecompose()
  local rewards = ItemDataUtils.GetShowRewards()
  local REASON_AUTO_DECOMPOSE = cd.ItemReason.AutoDecompose
  for _, rewardInfo in ipairs(rewards) do
    if rewardInfo.reason == REASON_AUTO_DECOMPOSE then
      return true
    end
  end
end

function ShowRewardView:_CreateRewardListView()
  self._displayRewards = ItemDataUtils.MovePlayerExpToEnd(ItemDataUtils.GetShowRewards())
  self._rewardListView = self:CreateTableview(self.ui.ScrollView_Reward, function()
    return #self._displayRewards
  end, function(view, idx)
    do return self._OnRewardCellAtIndex, self, view end
    return self._OnRewardCellAtIndex, self, view, idx
  end, nil, nil)
end

function ShowRewardView:_OnRewardCellAtIndex(view, idx)
  local baseGameObj = self.ui.UI_Dungeons_Item_Award_Article_Big
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(baseGameObj)
  local rewards = self._displayRewards
  local data = rewards and rewards[idx]
  if data and self._rewardSource == nil then
    self._rewardSource = data.reason
  end
  local articleData = data and self:_CreateDungeonItemInfo(data)
  if articleData then
    self:AddViewComponentOnce(cell.gameObject, CompPublicDungeonAwardBigItem, articleData)
  end
  return cell
end

function ShowRewardView:_OnRefreshRewardListView()
  if self._isClosing then
    return
  end
  self._displayRewards = ItemDataUtils.MovePlayerExpToEnd(ItemDataUtils.GetShowRewards())
  local rewardList = self._displayRewards
  local ShowReward_Num = DT.GetConstant("ShowReward_Num")
  local isOverOneLine = ShowReward_Num < #rewardList
  self.ui.Scroll_Bg:SetActive(#rewardList > 2 * ShowReward_Num)
  if isOverOneLine then
    self.ui.Group_OneLineRewardList:SetActive(false)
    self.ui.ScrollView_Reward:SetActive(true)
    if self._rewardListView then
      self._rewardListView:ReloadData()
    end
  elseif #rewardList > 0 then
    self.ui.Group_OneLineRewardList:SetActive(true)
    self.ui.ScrollView_Reward:SetActive(false)
    local parentTs = self.ui.Group_OneLineRewardList.transform
    local cnt = self:ReserveChildren(parentTs, #rewardList)
    for i = 1, #rewardList do
      local go = parentTs:GetChild(i - 1).gameObject
      go:SetActive(true)
      local data = rewardList[i]
      if self._rewardSource == nil then
        self._rewardSource = data.reason
      end
      local articleData = self:_CreateDungeonItemInfo(data)
      self:AddViewComponentOnce(go, CompPublicDungeonAwardBigItem, articleData)
    end
    for i = #rewardList + 1, cnt do
      local go = parentTs:GetChild(i - 1).gameObject
      go:SetActive(false)
    end
  end
  if self.ui.Text_DecomposeTips then
    local isHaveDecompose = self:_IsHaveAutoDecompose()
    self.ui.Text_DecomposeTips:SetActive(isHaveDecompose)
    self:SetText(self.ui.Text_DecomposeTips, LT.Text("WeaponRefined_03"))
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Title.transform, 0, isHaveDecompose and -16 or -34)
  end
end

function ShowRewardView:_OnClose()
  self._isClosing = true
  if self._clearRewardsTag then
    local ok, err = pcall(ItemDataUtils.ClearShowRewards)
    if not ok then
      Logger.Warn("ShowRewardView:_OnClose ClearShowRewards error:", err)
    end
  end
  Super.Close(self)
  if self._closeCb then
    self._closeCb()
  end
  EventMgr.Instance.CommonRewardPanelClose:Dispatch(self._rewardSource)
end

function ShowRewardView:SetClearRewardsTag(boolVal)
  self._clearRewardsTag = boolVal
end

function ShowRewardView:SetTitle(title)
  self._title = title
  self:_OnRefreshTipsTitle()
end

function ShowRewardView:AfterSetRenderTrue()
  if not self._fullTipsRes then
    self._fullTipsRes = UI_Common_Popup_Tips_FullResource(self.ui.UI_Common_Popup_Tips_Full)
  end
  local glass = self._fullTipsRes.UI_Common_Glass
  if not glass then
    return
  end
  local comp = glass:GetComponentInChildren(Type_UIGrabPassRawImage, true)
  if not comp then
    return
  end
  if not comp.GrabPassRenderTexture then
    comp.enabled = false
    comp.enabled = true
  end
end

return ShowRewardView
