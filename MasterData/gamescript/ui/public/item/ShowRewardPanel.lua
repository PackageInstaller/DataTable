local ShowReward_Num = DT.GetConstant("ShowReward_Num")
local DragGesture = CS.Z1Client.General.DragGesture
local Type_UIGrabPassRawImage = typeof(CS.UIGrabPassRawImage)
local ShowRewardPanel, Super = System.NewClass("ShowRewardPanel", UIBasePanel)
ShowRewardPanel.uiResCls = UI_Common_Popup_Tips_SmallResource

function ShowRewardPanel:ctor(title, subTitle, closeCb, statistics)
  Super.ctor(self)
  self.title = title or LT.Text("ItemGain_String_MainTitle_CHN")
  if not title or "" == title then
    self.title = LT.Text("ItemGain_String_MainTitle_CHN")
  end
  self.subTitle = subTitle
  self.closeCb = closeCb
  self.rewardItems = {}
  self.statistics = statistics
  self.rewardSource = nil
  self.clearRewardsTag = true
end

function ShowRewardPanel:OnBind(binder)
  self.binder = binder
  self.scrollRect = self.ui.ScrollView_Reward:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  self:LoadInitResource()
  self:PlayVoice()
  self:OnBindTipsComp(binder)
  self:OnBindButton(binder)
  self:OnBindScrollViewButton()
  self:_OnBindRewardListChanged(binder)
  self:_CreateRewardListView()
end

function ShowRewardPanel:AfterSetRenderTrue()
  if not (self.UI_Common_Popup_Tips_Full and self.UI_Common_Popup_Tips_Full.ui) or not self.UI_Common_Popup_Tips_Full.ui.UI_Common_Glass then
    return
  end
  local comp = self.UI_Common_Popup_Tips_Full.ui.UI_Common_Glass:GetComponentInChildren(Type_UIGrabPassRawImage, true)
  if not comp then
    return
  end
  if not comp.GrabPassRenderTexture then
    comp.enabled = false
    comp.enabled = true
  end
end

function ShowRewardPanel:OnBindScrollViewButton()
  self.gesture = self.ui.ScrollView_Reward:GetComponent(typeof(DragGesture))
  self.gesture:onDrag("+", System.fn(self, self.OnDragScrollview))
  self.gesture:onPointerDown("+", System.fn(self, self.OnPointerDownUpponScrollview))
  self.gesture:onPointerClick("+", System.fn(self, self.OnPointerClickScrollview))
end

function ShowRewardPanel:OnPointerDownUpponScrollview()
  self.isDragScrollview = false
end

function ShowRewardPanel:OnDragScrollview()
  self.isDragScrollview = true
end

function ShowRewardPanel:OnPointerClickScrollview()
  if self.isDragScrollview then
    return
  end
end

function ShowRewardPanel:OnUnbind()
  if self.gesture then
    self.gesture:onDrag("-", System.fn(self, self.OnDragScrollview))
    self.gesture:onPointerDown("-", System.fn(self, self.OnPointerDownUpponScrollview))
    self.gesture:onPointerClick("-", System.fn(self, self.OnPointerClickScrollview))
    self.gesture = nil
  end
  if self.clearRewardsTag then
    ItemDataUtils.ClearShowRewards()
  end
  PopTipsManager.Instance:ClearCachedRewardList()
end

function ShowRewardPanel:_CreateRewardListView()
  local baseGameObj = self.ui.UI_Dungeons_Item_Award_Article_Big
  local itemComps = {}
  self._displayRewards = ItemDataUtils.MovePlayerExpToEnd(ItemDataUtils.GetShowRewards())
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Reward, function()
    return #self._displayRewards
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local data = self._displayRewards[idx]
    if self.rewardSource == nil then
      self.rewardSource = data.reason
    end
    local articleData = self:_CreateDungeonItemInfo(data)
    itemComps[gameObj] = self.binder:BindComponent(DungeonItemAwardBig(gameObj, articleData))
    return cell
  end, nil, function()
    itemComps = nil
  end)
  self:_RefreshRewardListView()
end

function ShowRewardPanel:_OnBindRewardListChanged(binder)
  binder:BindToRaw(function(_, _)
    self:_RefreshRewardListView()
  end, function()
    do return end
    return ItemDataUtils.GetShowRewards, nil
  end)
  if self.ui.Text_DecomposeTips then
    binder:BindToVisible(self.ui.Text_DecomposeTips, function()
      do return self.IsHaveAutoDecompose end
      return self.IsHaveAutoDecompose, self
    end)
    binder:SetText(self.ui.Text_DecomposeTips, LT.Text("WeaponRefined_03"))
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Title.transform, 0, self:IsHaveAutoDecompose() and -16 or -34)
  end
end

function ShowRewardPanel:IsHaveAutoDecompose()
  local rewards = ItemDataUtils.GetShowRewards()
  local REASON_AUTO_DECOMPOSE = cd.ItemReason.AutoDecompose
  for i, rewardInfo in ipairs(rewards) do
    if rewardInfo.reason == REASON_AUTO_DECOMPOSE then
      return true
    end
  end
end

function ShowRewardPanel:_RefreshRewardListView()
  self._displayRewards = ItemDataUtils.MovePlayerExpToEnd(ItemDataUtils.GetShowRewards())
  local rewardList = self._displayRewards
  local isOverOneLine = #rewardList > ShowReward_Num
  self.ui.Scroll_Bg:SetActive(#rewardList > 2 * ShowReward_Num)
  if isOverOneLine then
    self.ui.Group_OneLineRewardList:SetActive(false)
    self.ui.ScrollView_Reward:SetActive(true)
    if self.rewardListView then
      self.rewardListView:ReloadData()
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
      if self.rewardSource == nil then
        self.rewardSource = data.reason
      end
      local articleData = self:_CreateDungeonItemInfo(data)
      self.binder:BindComponent(DungeonItemAwardBig(go, articleData))
    end
    for i = #rewardList + 1, cnt do
      local go = parentTs:GetChild(i - 1).gameObject
      go:SetActive(false)
    end
  end
end

function ShowRewardPanel:_CreateDungeonItemInfo(data)
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

function ShowRewardPanel:Close()
  Super.Close(self)
  if self.closeCb then
    self.closeCb()
  end
  EventMgr.Instance.CommonRewardPanelClose:Dispatch(self.rewardSource)
end

function ShowRewardPanel:OnBindTipsComp(binder)
  local CommonPopupFullTipsDataData = {
    textTitleCN = self.title,
    textTitleEN = nil
  }
  self.UI_Common_Popup_Tips_Full = binder:BindComponent(CommonPopupFullTips(self.ui.UI_Common_Popup_Tips_Full, CommonPopupFullTipsDataData))
end

function ShowRewardPanel:PlayVoice()
  ItemDataUtils.PlayRewardPanelVoice()
end

function ShowRewardPanel:OnBindButton(binder)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.Close))
end

function ShowRewardPanel:LoadInitResource()
  local prefab = self.binder:LoadAsset("UI/UI_Common/UI_Common_Prefab/UI_Awaker_Effect_texiao.prefab")
  self.binder:Instantiate(prefab, self.ui.Title_Bg.transform)
end

function ShowRewardPanel:SetClearRewardsTag(boolVal)
  self.clearRewardsTag = boolVal
end

return ShowRewardPanel
