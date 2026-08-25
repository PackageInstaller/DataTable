local DEFAULT_SELECT_RECORD_INDEX = 1
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local Vec2_ResetScrollPos = CS.UnityEngine.Vector2(0, 1)
local TransformUtil = CS.Framework.TransformUtil
local _SetAnchoredPos = TransformUtil.SetAnchoredPos
local _GetAnchoredPos = TransformUtil.GetAnchoredPos
local CopyAbyssSettleView, Super = NewClass("CopyAbyssSettleView", CopySettleBaseView)
CopyAbyssSettleView.uiResCls = UI_Dungeons_Panel_SurveyDataResource

function CopyAbyssSettleView:ctor(data)
  self.data = data
  self.abyssExtModel = AbyssExtModel.Instance
  self._reqedIndexMap = {}
  Super.ctor(self)
end

function CopyAbyssSettleView:OnBuildView()
  self.contentTf = self.ui.Content.transform
  self.contentOriHeight = self.contentTf.sizeDelta.y
  self.scrollRect = self.ui.ScrollView_List:GetComponent(T_ScrollRect)
  self.dropdownContentTf = self.ui.Content.transform
end

function CopyAbyssSettleView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAbyssDataChanged, self._RefreshView, self)
  self:RegisterNotify(NotifyId.OnStageRecordDataChanged, self._RefreshView, self)
  self:RegisterNotify(NotifyId.OnAbyssTeamDataChanged, self._RefreshView, self)
end

function CopyAbyssSettleView:RegisterEvents()
  Super.RegisterEvents(self)
  self:_InitStageGroupDropdown()
end

function CopyAbyssSettleView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_NoTask, LT.Text("DailyChallengeEmptyTips"))
  self:SetActive(self.ui.Dropdown_Stage, true)
  self:_InitEnterRecordIndex()
end

function CopyAbyssSettleView:OnExitView()
  for _, waiter in ipairs(self.frameWaiterGroup) do
    FrameWaiter.RemoveWaiter(waiter)
  end
  self.abyssExtModel:ClearRecordCacheData()
  Super.OnExitView(self)
  TransformUtil.SetHeight(self.contentTf, self.contentOriHeight)
end

function CopyAbyssSettleView:_RefreshView()
  self:_InitStageChapter()
  if not self.selectRecordIndex then
    return
  end
  local teamData = self:GetTeamData()
  local recordStageData = self.abyssExtModel:GetRecordStageData(teamData)
  if not recordStageData then
    self:_RefreshNullBlack(true)
    self:ReqRecordStageData()
    return
  end
  if 0 == recordStageData.stageId then
    self:_RefreshNullBlack(true)
    return
  end
  if self:IsFromRank() and type(recordStageData) == "table" then
    recordStageData.playerUid = tonumber(self.data.playerUid) or recordStageData.playerUid
    if self.data.playerName and self.data.playerName ~= "" then
      recordStageData.playerName = self.data.playerName
    end
    if self.data.playerLevel and self.data.playerLevel > 0 then
      recordStageData.playerLevel = self.data.playerLevel
    end
    if self.data.playerGender ~= nil then
      recordStageData.playerGender = self.data.playerGender
    end
  end
  CopySettleModel.Instance:UpdateBySvrData({teamData = teamData, recordStageData = recordStageData})
  self:_RefreshNullBlack(false)
  self:_RefreshReplayBtn()
  if not teamData then
    self:_InitTitleUIElement()
    return
  end
  Super._RefreshView(self)
end

function CopyAbyssSettleView:_RefreshNullBlack(isNull)
  self:SetActive(self.ui.ScrollView_List, not isNull)
  self:SetActive(self.ui.Group_Null_Black, isNull)
end

function CopyAbyssSettleView:GetTeamData()
  local recordData = self.data.recordList[self.selectRecordIndex]
  if not recordData then
    return
  end
  local stageGroupTid = recordData.stageGroupTid
  local refreshData
  if self:IsFromRank() then
    local playerUid = self.data.playerUid
    local activityTid = self.data.activityTid
    refreshData = self.abyssExtModel:GetRecordCacheData(playerUid, activityTid, stageGroupTid)
  else
    refreshData = self.abyssExtModel:GetStageGroupData(stageGroupTid)
  end
  local teamData = refreshData and refreshData.team
  if recordData.isExtra then
    teamData = refreshData and refreshData.teamExtra
  end
  return teamData
end

function CopyAbyssSettleView:ReqRecordStageData()
  if self._reqedIndexMap[self.selectRecordIndex] then
    return
  end
  self._reqedIndexMap[self.selectRecordIndex] = true
  local recordData = self.data.recordList[self.selectRecordIndex]
  if self:IsFromRank() then
    local playerUid = self.data.playerUid
    local activityTid = self.data.activityTid
    local stageGroupTid = recordData.stageGroupTid
    local score = recordData.score or 0
    AbyssExtModel.Instance:CheckUpdateRankRecordCache(playerUid, activityTid, stageGroupTid, score)
  else
    AbyssController.Instance:ReqAbyssTeamDetail(recordData.stageGroupTid, recordData.isExtra)
  end
end

function CopyAbyssSettleView:IsFromRank()
  return self.data.fromRank
end

function CopyAbyssSettleView:_InitStageGroupDropdown()
  self.dropdownOptionList = {}
  for index, stageGroupData in ipairs(self.data.recordList) do
    local optionData = {
      key = index,
      isExtra = stageGroupData.isExtra,
      text = stageGroupData.showName
    }
    table.insert(self.dropdownOptionList, optionData)
  end
  self:AddZ1ToggleValueChangedListener(self.ui.Dropdown_Stage, function(isOn)
    self:_SetDropdownShow(isOn)
  end)
  local objHeight = self.ui.UI_Dungeons_Item_RankSeason.transform.sizeDelta.y
  TransformUtil.SetHeight(self.dropdownContentTf, objHeight * #self.dropdownOptionList)
  self:_RefreshDropdown()
  self:SetZ1Toggle(self.ui.Dropdown_Stage, false)
  self:_SetDropdownShow(false)
end

function CopyAbyssSettleView:_RefreshDropdown()
  local cnt = #self.dropdownOptionList
  local childCount = self.dropdownContentTf.childCount
  while cnt > childCount do
    Instantiate(self.ui.UI_Dungeons_Item_RankSeason, self.dropdownContentTf)
    childCount = childCount + 1
  end
  local objHeight = self.ui.UI_Dungeons_Item_RankSeason.transform.sizeDelta.y
  for idx = 1, cnt do
    local go = self.dropdownContentTf:GetChild(idx - 1).gameObject
    self:SetActive(go, true)
    local optionData = self.dropdownOptionList[idx]
    local uiRes = UI_Dungeons_Item_RankSeasonResource(go)
    self:AddButtonClickListener(uiRes.Btn_Click, function()
      if optionData.key == self.selectRecordIndex then
        self:SetZ1Toggle(self.ui.UI_Dungeons_Item_RankSeason, false)
        return
      end
      self:_OnSelectStageGroupChanged(idx)
      self:SetZ1Toggle(self.ui.Dropdown_Stage, false)
      self:SetZ1Toggle(uiRes.uiNode, true)
      self:_RefreshDropdown()
    end)
    local isSelected = self.selectRecordIndex == optionData.key
    local textColorType = CommonDefine.ColorType.Dark
    local btnState = CommonDefine.Z1ButtonState.Normal
    if isSelected then
      textColorType = CommonDefine.ColorType.Light
      btnState = CommonDefine.Z1ButtonState.High
    end
    local pos_x, _ = _GetAnchoredPos(go.transform)
    local pos_y = -(idx - 1) * objHeight
    _SetAnchoredPos(go.transform, pos_x, pos_y)
    self:SetText(uiRes.Text_Drop_Item_Tips, optionData.text)
    self:SetTextColorType(uiRes.Text_Drop_Item_Tips, textColorType)
    self:SetButtonState(uiRes.Btn_Click, btnState)
    self:SetZ1Toggle(uiRes.uiNode, isSelected)
  end
  for i = cnt + 1, childCount do
    local go = self.dropdownContentTf:GetChild(i - 1).gameObject
    self:SetActive(go, false)
  end
end

function CopyAbyssSettleView:_SetDropdownShow(show)
  self:SetActive(self.ui.ScrollView_Stage, show)
end

function CopyAbyssSettleView:_InitCardItem(colNum, rowNum, cardData)
  local cardGO = self:_GetCardObj()
  if not cardGO then
    return
  end
  TransformUtil.SetLocalPos(cardGO.transform, self:GetCardLocalPos(colNum, rowNum))
  local skillTid = cardData.tid
  local awakerTid = CardDataUtils.GetSkillCfgByField("AwakerID", skillTid)
  local awakerData = self.model:GetAwakerDataByAwakerTid(awakerTid)
  local runes = cardData.runes or {}
  local runeTid = runes[1] or 0
  local skillLevel = tonumber(cardData.level)
  if not skillLevel or skillLevel <= 0 then
    skillLevel = AwakerDataUtils.GetSkillLevelFromAwakerData(awakerData, skillTid)
  end
  local cardItem = self.binder:BindComponent(CardBaseComponent(cardGO, nil, skillTid, nil, nil, nil, nil, nil, skillLevel, {
    awakerData = awakerData,
    curSkin = awakerData and awakerData.curSkin or cd.DefaultSkinTid,
    runeTid = 0 ~= runeTid and runeTid or nil,
    stateList = cardData.stateList,
    useBattleDesc = false
  }))
  cardItem:SetSkipAutoKeywordTips(true)
  cardItem:SetClickCallback(function()
    local panelData = {
      cardTid = skillTid,
      imageBgHideFlag = false,
      cardDesc = cardItem:GetCardDesc(),
      cardLevel = skillLevel,
      awakerData = awakerData,
      runeTid = 0 ~= runeTid and runeTid or nil,
      stateList = cardData.stateList
    }
    UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
  end)
  return cardItem
end

function CopyAbyssSettleView:RefreshOnRendered()
end

function CopyAbyssSettleView:OnEnterViewFinished()
end

function CopyAbyssSettleView:_RefreshEmptyTips(waitingResponse)
  local tipsText = LT.Text("DailyChallengeEmptyTips")
  if waitingResponse then
    tipsText = LT.Text("DataTransmissionTips")
  end
  self:SetActive(self.ui.Text_Time, not waitingResponse)
  self:SetText(self.ui.Text_NoTask, tipsText)
end

function CopyAbyssSettleView:_InitEnterRecordIndex()
  local recordList = self.data.recordList
  local firstIndex
  for idx, stageGroupData in ipairs(recordList) do
    if self.data.firstStageGroupTid then
      if stageGroupData.stageGroupTid == self.data.firstStageGroupTid and self.data.isExtra == stageGroupData.isExtra then
        firstIndex = idx
        break
      end
    elseif stageGroupData and stageGroupData.score and stageGroupData.score > 0 then
      firstIndex = idx
      break
    end
  end
  firstIndex = firstIndex or DEFAULT_SELECT_RECORD_INDEX
  self:_SetSelectRecordIndex(firstIndex)
end

function CopyAbyssSettleView:_SetSelectRecordIndex(index)
  self.selectRecordIndex = index
  self.scrollRect.normalizedPosition = Vec2_ResetScrollPos
  if self.dropdownOptionList[self.selectRecordIndex] then
    local title = self.dropdownOptionList[self.selectRecordIndex].text
    self:SetText(self.ui.Text_Cur, title)
  end
  self:_RefreshView()
end

function CopyAbyssSettleView:_OnSelectStageGroupChanged(index)
  if not index then
    return
  end
  if self.selectRecordIndex == index then
    return
  end
  self:_SetSelectRecordIndex(index)
end

return CopyAbyssSettleView
