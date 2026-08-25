local INTRO_MAX_SHOW_CHARA = 48
local SocialRankView, Super = NewClass("SocialRankView", RankBaseView)
SocialRankView.uiResCls = UI_Social_Panel_RankResource
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TransformUtil = CS.Framework.TransformUtil
local _SetAnchoredPos = TransformUtil.SetAnchoredPos
local _GetAnchoredPos = TransformUtil.GetAnchoredPos
local _SetHeight = TransformUtil.SetHeight

function SocialRankView:ctor()
  Super.ctor(self)
  self.model = SocialExtModel.Instance
  self.controller = SocialController.Instance
  self.isFriendRank = false
  self._lastReqFriendRank = false
  self.curAwakerTid = 0
end

function SocialRankView:OnBuildView()
  self.rankScrollRect = self.ui.ScrollView_RankInfo:GetComponent(T_ScrollRect)
  self.dropdownContentTf = self.ui.Content.transform
  self:_SetFirstAwaker()
  self.rankTypeList = self.model:GetRankTypeList()
  self:_SetFirstSelectRankType()
end

function SocialRankView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.SocialSetNote, System.fn(self, self._RefreshWhenNoteChanged))
  self:_InitDropdown()
  self:_InitFriendRankToggle()
  self:AddButtonClickListener(self.ui.Btn_Change, System.fn(self, self._OnClickChangeAwaker))
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self:SetZ1Toggle(self.ui.Dropdown_RankList, false)
  end)
  self:_CreateRankTableView()
end

function SocialRankView:_RefreshWhenNoteChanged(newNote)
  self:SetText(self.ui.Text_Sign, StrUtils.TruncateChineseString(self.data.note, INTRO_MAX_SHOW_CHARA) or "")
end

function SocialRankView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnRankDataChanged, self._OnRankDataChanged, self)
  self:RegisterLocalNotify(NotifyId.OnSelectAwakerLikeRank, self._OnSelectAwakerChanged, self)
end

function SocialRankView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Group_Awaker:SetActive(false)
  self:_RefreshView(true)
end

function SocialRankView:OnExitView()
  Super.OnExitView(self)
end

function SocialRankView:_InitFriendRankToggle()
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_All, function(isOn)
    if isOn then
      self:_SetIsFriendRank(not isOn)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Friend, function(isOn)
    if isOn then
      self:_SetIsFriendRank(isOn)
    end
  end)
end

function SocialRankView:_InitDropdown()
  Logger.Debug("[sr] rankTypeList=%s", table.tostring(self.rankTypeList))
  self:AddZ1ToggleValueChangedListener(self.ui.Dropdown_RankList, function(isOn)
    self:_SetDropdownShow(isOn)
  end)
  self:_RefreshDropdown()
  self:SetZ1Toggle(self.ui.Dropdown_RankList, false)
  self:_SetDropdownShow(false)
end

function SocialRankView:_CreateRankTableView()
  self.rankTableView = self:CreateTableview(self.ui.ScrollView_RankInfo, function()
    if not self.rankList then
      return 0
    end
    return #self.rankList
  end, function(view, index)
    do return self._RankCellAtIndex, self, view end
    return self._RankCellAtIndex, self, view, index
  end)
  self:_SetupRankScroll(self.rankTableView)
end

function SocialRankView:_RankCellAtIndex(view, index)
  local rankData = self.rankList[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Social_Item_Rank)
  
  local function _OnClickAvatar()
    SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, rankData.uid)
  end
  
  self:AddViewComponentOnce(cell.gameObject, UICompSocialRankItem, rankData, self.curAwakerTid, _OnClickAvatar)
  return cell
end

function SocialRankView:_RefreshView(isReloadData)
  self:_RefreshRankList(isReloadData)
  self:_RefreshSelfRank()
  self:_RefreshEmptyState()
end

function SocialRankView:_RefreshDropdown()
  local cnt = #self.rankTypeList
  local childCount = self.dropdownContentTf.childCount
  while cnt > childCount do
    Instantiate(self.ui.UI_Dungeons_Item_Rank, self.dropdownContentTf)
    childCount = childCount + 1
    Logger.Debug("[sr] childCount =%s, cnt=%s", childCount, cnt)
  end
  local objHeight = self.ui.UI_Dungeons_Item_Rank.transform.sizeDelta.y
  for idx = 1, cnt do
    local go = self.dropdownContentTf:GetChild(idx - 1).gameObject
    go:SetActive(true)
    local rankType = self.rankTypeList[idx]
    local uiRes = UI_Dungeons_Item_RankSeasonResource(go)
    self:AddButtonClickListener(uiRes.Btn_Click, function()
      if rankType == self.curRankType then
        self:SetZ1Toggle(self.ui.Dropdown_RankList, false)
        return
      end
      self:_SetCurRankType(rankType)
      self:SetZ1Toggle(self.ui.Dropdown_RankList, false)
      self:SetZ1Toggle(uiRes.uiNode, true)
      self:_RefreshDropdown()
    end)
    local isSelected = self.curRankType == rankType
    local textColorType = CommonDefine.ColorType.Dark
    local btnState = CommonDefine.Z1ButtonState.Normal
    if isSelected then
      textColorType = CommonDefine.ColorType.Light
      btnState = CommonDefine.Z1ButtonState.High
    end
    local pos_x, _ = _GetAnchoredPos(go.transform)
    local pos_y = -(idx - 1) * objHeight
    _SetAnchoredPos(go.transform, pos_x, pos_y)
    local rankTypeText = self.model:GetRankTypeText(rankType)
    self:SetText(uiRes.Text_Drop_Item_Tips, rankTypeText)
    self:SetTextColorType(uiRes.Text_Drop_Item_Tips, textColorType)
    self:SetButtonState(uiRes.Btn_Click, btnState)
    self:SetZ1Toggle(uiRes.uiNode, isSelected)
  end
  for i = cnt + 1, childCount do
    local go = self.dropdownContentTf:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  _SetHeight(self.dropdownContentTf, objHeight * cnt)
end

function SocialRankView:_SetDropdownShow(show)
  self.ui.ScrollView_RankList:SetActive(show)
end

function SocialRankView:_OpenCopySettleView(playerUid, abyssChallenge)
  local seasonData
  if abyssChallenge and abyssChallenge.activityId2Data then
    seasonData = abyssChallenge.activityId2Data[self.selectActivityTid]
  end
  local recordList = AbyssExtModel.Instance:CalcRecordDataListByServer(self.selectActivityTid, seasonData and seasonData.stageGroups)
  local viewData = {
    recordList = recordList,
    playerUid = playerUid,
    activityTid = self.selectActivityTid,
    fromRank = true
  }
  CopyController.Instance:OnOpenCopyAbyssSettleView(viewData)
end

function SocialRankView:_RefreshRankList(isReloadData)
  if not self.rankTableView then
    return
  end
  if isReloadData then
    self.rankList = self.model:GetRankList(self.curRankType, self.isFriendRank, self.curAwakerTid)
    self.rankTableView:ReloadData()
  else
    self.rankTableView:Refresh()
  end
end

function SocialRankView:_RefreshSelfRank()
  local serverRankType = self.model:GetReqRankType(self.curRankType, self.isFriendRank)
  local rankData = RankModel.Instance:GetSelfRankData(serverRankType) or {}
  local headIcon = rankData.icon or DataCenter.playerData.DRole.icon
  local avatarFrame = rankData.avatarFrame or DataCenter.playerData.DRole.avatarFrame
  self:AddViewComponentOnce(self.ui.UI_Common_Head, CompHeadItem, {
    headIcon = ItemDataUtils.GetAvatarIcon(headIcon),
    frameIcon = ItemDataUtils.GetItemIcon(avatarFrame),
    clickCb = System.fn(self, self._OnClickAvatar)
  })
  self:SetText(self.ui.Text_Name, rankData.name or PlayerDataUtils.GetName())
  self:SetText(self.ui.Text_Sign, string.isempty(rankData.note) and LT.Text("SocialSystemIntroductionNone") or StrUtils.TruncateChineseString(rankData.note, INTRO_MAX_SHOW_CHARA))
  self:SetText(self.ui.Text_Uid, rankData.uid or PlayerDataUtils.GetPlayerUid())
  self:SetText(self.ui.Text_Rank, RankDataUtils.GetRankText(rankData))
  local score = self.model:GetScoreShowText(rankData, self.curRankType)
  self:SetText(self.ui.Text_LikeCount, score)
end

function SocialRankView:_RefreshEmptyState()
  local isEmptyShow = not self.rankList or #self.rankList <= 0
  self.ui.Group_Null_Black:SetActive(isEmptyShow)
end

function SocialRankView:_SetFirstSelectRankType()
  self:_SetCurRankType(self.rankTypeList[1])
end

function SocialRankView:_SetCurRankType(rankType)
  if not rankType then
    return
  end
  local reqRankType = self.model:GetReqRankType(rankType, self.isFriendRank)
  local curReqRankType = self.model:GetReqRankType(self.curRankType, self._lastReqFriendRank)
  Logger.Debug("[sr] rankType=%s, reqRankType=%s, self.curRankType=%s, awakerTid=%s", rankType, reqRankType, self.curRankType, self.curAwakerTid)
  if reqRankType == curReqRankType then
    return
  end
  local rankTypeText = self.model:GetRankTypeText(rankType)
  local rankTypeTitleText = self.model:GetRankTypeTitleText(rankType)
  self:SetText(self.ui.Text_Cur, rankTypeText)
  self:SetText(self.ui.Text_DataName, rankTypeTitleText)
  self.curRankType = rankType
  self._lastReqFriendRank = self.isFriendRank
  self:_ResetRankPagination()
  self:_ClearRank()
  self:_RequestRankPage()
  self:_RefreshView(true)
  self:_ResetRankScroll(self.rankTableView)
end

function SocialRankView:_SetFirstAwaker()
  local cacheAwakerTid = SocialExtModel.Instance:GetAwakerLikeRankTid()
  if cacheAwakerTid and 0 ~= cacheAwakerTid then
    self:_SetCurAwaker(cacheAwakerTid, true)
    return
  end
  local list = self.model:GetAwakerLikeRankList()
  if not list or table.next(list) == nil then
    return
  end
  self:_SetCurAwaker(list[1], true)
end

function SocialRankView:_SetCurAwaker(awakerTid, skipRefresh)
  if not awakerTid then
    return
  end
  self.curAwakerTid = awakerTid
  if skipRefresh then
    return
  end
  self:_ResetRankPagination()
  self:_ClearRank()
  self:_RequestRankPage()
  if self.rankTableView then
    self.rankTableView:ReloadData()
    self:_ResetRankScroll(self.rankTableView)
  end
end

function SocialRankView:_SetIsFriendRank(isFriendRank)
  if isFriendRank == self.isFriendRank then
    return
  end
  self.isFriendRank = isFriendRank
  self:_SetCurRankType(self.curRankType)
end

function SocialRankView:_OnRankDataChanged(rankType)
  Logger.Debug("[sr] On rank data changed=%s", rankType)
  local needRefreshView = false
  for _, oriRankType in ipairs(self.rankTypeList) do
    Logger.Debug("[sr] oriRankType=%s", oriRankType)
    if string.contains(rankType, oriRankType) then
      needRefreshView = true
      break
    end
  end
  Logger.Debug("[sr] needRefreshView=%s", needRefreshView)
  if not needRefreshView then
    return
  end
  self:_RefreshView(true)
end

function SocialRankView:_OnSelectAwakerChanged(awakerTid)
  if not awakerTid then
    return
  end
  self:_SetCurAwaker(awakerTid)
end

function SocialRankView:_ClearRank()
  local reqRankType = self.model:GetReqRankType(self.curRankType, self.isFriendRank)
  if reqRankType then
    RankModel.Instance:ClearRank(reqRankType)
  end
end

function SocialRankView:_DoRequestRankData(startIndex, count, onSuccess, onFail)
  NetBlockMgr.Instance:CancelBlocked(true)
  local reqRankType = self.model:GetReqRankType(self.curRankType, self.isFriendRank)
  self.controller:ReqSocialRankData(reqRankType, startIndex, count, function()
    onSuccess()
  end, function()
    onFail()
  end)
  NetBlockMgr.Instance:CancelBlocked(false)
end

function SocialRankView:_GetRankListCount()
  return self.rankList and #self.rankList or 0
end

function SocialRankView:_OnRankPageSuccess()
  if self.ui then
    self:_RefreshView(true)
  end
end

function SocialRankView:_OnClickAvatar()
  local selfUid = PlayerDataUtils.GetPlayerUid()
  SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, selfUid)
end

function SocialRankView:_OnClickChangeAwaker()
  UIManager.Instance:Reopen(Urls.SocialAwakerChooseView)
end

function SocialRankView:_OnClickClose()
  self:Close()
end

return SocialRankView
