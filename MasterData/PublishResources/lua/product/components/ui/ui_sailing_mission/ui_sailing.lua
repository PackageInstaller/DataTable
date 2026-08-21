_class("UISailing", UIController)
UISailing = UISailing

function UISailing:Constructor()
  self._module = self:GetModule(SailingMissionModule)
  self._selectedLuaIndex = 1
  self._selectedChapterID = 1
  self._challengeLuaIndex = 1
  self._challengeChapterID = 1
  self._challengeNewFlag = false
  self._kvPool = nil
  self._kvStairPool = nil
  self._selectorPool = nil
  self._kvItemHeight = 0
  self._kvContentHeight = 0
  self._kvViewportHeight = 0
  self._bgItemHeight = 0
  self._bgContentHeight = 0
  self._bgViewportHeight = 0
  self._chapterItemHeight = 0
  self._chapterContentHeight = 0
  self._chapterViewportHeight = 0
  self._materialReq = nil
  self._material = nil
  self._atlasSailing = self:GetAsset("UISailing.spriteatlas", LoadType.SpriteAtlas)
  self._cfgEffect = Cfg.cfg_sailing_effect({ID = 1})[1]
  self._switchBtnState = {
    "n22_dhh_zjm_up1",
    "n22_dhh_zjm_up2",
    "n22_dhh_zjm_dwn1",
    "n22_dhh_zjm_dwn2"
  }
end

function UISailing:OnShow(uiParams)
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._bgScrollRect = self:GetUIComponent("ScrollRect", "kvBgScrollRect")
  self._kvScrollRect = self:GetUIComponent("ScrollRect", "kvItemScrollRect")
  self._kvContent = self:GetUIComponent("UISelectObjectPath", "kvItemContent")
  self._kvStairContent = self:GetUIComponent("UISelectObjectPath", "kvStairContent")
  self._bg = {
    self:GetUIComponent("RectTransform", "kvBG1"),
    self:GetUIComponent("RectTransform", "kvBG2")
  }
  self._historyChapterMaxValue = self:GetUIComponent("UILocalizedTMP", "historyChapterMaxValue")
  self._historyMissionMaxValue = UISailingImageNumber:New(self, "n22_dhh_num2_%d")
  self._historyMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "historyMissionMaxValue0"))
  self._historyMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "historyMissionMaxValue1"))
  self._historyMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "historyMissionMaxValue2"))
  self._redReward = self:GetUIComponent("RectTransform", "redReward")
  self._selectChapter = self:GetUIComponent("RectTransform", "selectChapter")
  self._chapterContent = self:GetUIComponent("UISelectObjectPath", "chapterContent")
  self._chapterScrollRect = self:GetUIComponent("ScrollRect", "chapterScrollRect")
  self._chapterScrollRect.onValueChanged:AddListener(function(value)
    self:OnChapterScrollRectMoved(value)
  end)
  self._materialReq = ResourceManager:GetInstance():SyncLoadAsset("ui_sailing_history_value.mat", LoadType.Mat)
  if self._materialReq and self._materialReq.Obj then
    local oldMaterial = self._historyChapterMaxValue.fontMaterial
    self._material = self._materialReq.Obj
    self._material:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
    self._historyChapterMaxValue.fontMaterial = self._material
  end
  self._upButton = self:GetUIComponent("Image", "upButton")
  self._downButton = self:GetUIComponent("Image", "downButton")
  local chapterID = self._module:GetChallengeLayerID()
  self._selectedChapterID = chapterID
  self._challengeChapterID = chapterID
  if uiParams ~= nil and 1 <= #uiParams then
    self._selectedChapterID = uiParams[1]
  end
  self:AttachEvent(GameEventType.SailingMissionLayerInfoChanged, self.OnLayerInfoChanged)
  self:AttachEvent(GameEventType.SailingGetProgressReward, self.OnSailingGetProgressReward)
  self:CreateSelectorPool()
  self:UpdateChapterLuaIndex()
  self:CreateAxisScrollRect()
  self:CreateKvContent()
  self:UpdateAxisScrollLimit()
  self:UpdateChapterContent()
  self:UpdateKvContent()
  self:UpdateCurrentChallenge()
  self:UpdateHistoryMaxValue()
  self:UpdateRewardRedPoint()
  self:InitCommonTopButton()
end

function UISailing:OnHide()
  self._axisScrollRect:Dispose()
  if self._materialReq then
    self._materialReq:Dispose()
    self._material = nil
    self._materialReq = nil
  end
end

function UISailing:BtnRewardOnClick(go)
  self:ShowDialog("UISailingRewardsController")
end

function UISailing:DiscoveryBtnOnClick(go)
  if self._selectedLuaIndex > self._challengeLuaIndex then
    ToastManager.ShowToast(StringTable.Get("str_sailing_mission_toast_unlock"))
    return
  end
  local selectorItem = self._selectorPool[self._selectedLuaIndex]
  if selectorItem ~= nil then
    self:SwitchState(UIStateType.UISailingChapter, self._selectedLuaIndex, selectorItem)
  end
end

function UISailing:UpButtonOnClick(go)
  local luaIndex = self._axisScrollRect:GetSelectedLuaIndex()
  local scrollRet = self._axisScrollRect:ScrollTo(luaIndex - 1, self._cfgEffect.ButtonScrollPeriod)
  if scrollRet ~= nil then
    self:SetUpButtonState(2)
  end
end

function UISailing:DownButtonOnClick(go)
  local countChapter = #self._selectorPool
  local luaIndex = self._axisScrollRect:GetSelectedLuaIndex()
  local nextIndex = luaIndex + 1
  if countChapter > luaIndex and nextIndex > self._challengeLuaIndex then
    ToastManager.ShowToast(StringTable.Get("str_sailing_mission_toast_clear_cur"))
    return
  end
  local scrollRet = self._axisScrollRect:ScrollTo(luaIndex + 1, self._cfgEffect.ButtonScrollPeriod)
  if scrollRet ~= nil then
    self:SetDownButtonState(2)
  end
end

function UISailing:OnLayerInfoChanged(chapterID)
  local chapterID = self._module:GetChallengeLayerID()
  self._selectedChapterID = chapterID
  self._challengeChapterID = chapterID
  self:UpdateChapterLuaIndex()
  self:UpdateAxisScrollLimit()
  self:UpdateChapterContent()
  self:UpdateKvContent()
  self:UpdateCurrentChallenge()
  self:UpdateHistoryMaxValue()
  self:UpdateRewardRedPoint()
end

function UISailing:OnChapterScrollRectMoved(value)
  self:ToKvNormalizedPosition(value)
end

function UISailing:ToKvNormalizedPosition(value)
  local pastScrollValue = 1 - value.y
  pastScrollValue = math.min(pastScrollValue, 1)
  pastScrollValue = math.max(pastScrollValue, 0)
  local pastScrollHeight = pastScrollValue * (self._chapterContentHeight - self._chapterViewportHeight)
  local pastItemCount = pastScrollHeight / self._chapterItemHeight
  local needScrollHeight = pastItemCount * self._bgItemHeight
  local needScrollValue = needScrollHeight / (self._bgContentHeight - self._bgViewportHeight)
  local normalizedPosition = 1 - needScrollValue
  self._bgScrollRect.verticalNormalizedPosition = normalizedPosition
  local needScrollHeight = pastItemCount * self._kvItemHeight
  local needScrollValue = needScrollHeight / (self._kvContentHeight - self._kvViewportHeight)
  local normalizedPosition = 1 - needScrollValue
  self._kvScrollRect.verticalNormalizedPosition = normalizedPosition
  local countBg = #self._bg
  local upBound = pastItemCount * self._bgItemHeight
  local downBound = upBound + self._bgViewportHeight
  local assignPosY = -self._bgViewportHeight * 0.5
  local bgHeight = self._bg[1].rect.height
  local upBg = -assignPosY - bgHeight * 0.5
  local downBg = upBg + bgHeight
  while upBound > downBg do
    assignPosY = assignPosY - bgHeight
    upBg = -assignPosY - bgHeight * 0.5
    downBg = upBg + bgHeight
  end
  local localPosition = self._bg[1].localPosition
  localPosition.y = assignPosY
  self._bg[1].localPosition = localPosition
  local localPosition = self._bg[2].localPosition
  localPosition.y = assignPosY - bgHeight
  self._bg[2].localPosition = localPosition
end

function UISailing:UpdateHistoryMaxValue()
  local chapterMaxValue = StringTable.Get("str_sailing_mission_arg_layer", self._challengeLuaIndex)
  self._historyChapterMaxValue:SetText(chapterMaxValue)
  local progress = self._module:GetHistoryProgress()
  self._historyMissionMaxValue:SetValue(progress)
end

function UISailing:UpdateRewardRedPoint()
  local showRetPoint = self._module:IsShowRewardRedPoint()
  self._redReward.gameObject:SetActive(showRetPoint)
end

function UISailing:CreateSelectorPool()
  local allChapter = Cfg.cfg_sailing_layer({})
  local countChapter = #allChapter
  self._selectorPool = allChapter
end

function UISailing:UpdateChapterLuaIndex()
  local countChapter = #self._selectorPool
  for i = 1, countChapter do
    local cfgItem = self._selectorPool[i]
    if cfgItem.ID == self._selectedChapterID then
      self._selectedLuaIndex = i
    end
    if cfgItem.ID == self._challengeChapterID then
      self._challengeLuaIndex = i
    end
  end
end

function UISailing:CreateAxisScrollRect()
  self._axisScrollRect = UIAxisScrollRect:New()
  self._axisScrollRect:Create(self, "chapterScrollRect", "chapterContent", 12)
  self._axisScrollRect:AddScaleRuler(0, 0, 0)
  self._axisScrollRect:AddScaleRuler(0.5, 1.4, 1.336)
  self._axisScrollRect:AddScaleRuler(0.866, 1, 0.946)
  self._axisScrollRect:AddScaleRuler(1, 1, 0.95)
  goto lbl_61
  self._axisScrollRect:AddScaleRuler(0, 0, 0)
  self._axisScrollRect:AddScaleRuler(0.5, 1.192, 1.192)
  self._axisScrollRect:AddScaleRuler(0.866, 1, 1)
  self._axisScrollRect:AddScaleRuler(1, 1, 1)
  ::lbl_61::
  self._axisScrollRect:SpawnObjects("UISailingSelectorItem", Vector2(408, 146), 0, true)
  self._axisScrollRect:SetDataCount(#self._selectorPool, self._selectedLuaIndex, false)
  self._axisScrollRect:SetAutoAdsorb(true, self._cfgEffect.AutoAdsorbPeriod)
  self._axisScrollRect:AddContentChangedListener(function(itemWidget, luaIndex)
    local selectedIndex = self._axisScrollRect:GetSelectedLuaIndex()
    local offsetIndex = math.abs(luaIndex - selectedIndex)
    offsetIndex = math.min(offsetIndex, 2)
    local cfgItem = self._selectorPool[luaIndex]
    itemWidget:Init(luaIndex, cfgItem)
    itemWidget:SetBackGround(offsetIndex)
    itemWidget:SetShadow(luaIndex > selectedIndex, offsetIndex)
    itemWidget:SetLocked(luaIndex > self._challengeLuaIndex, offsetIndex)
    itemWidget:SetRedDot(luaIndex == self._challengeLuaIndex and self._challengeNewFlag)
  end)
  self._axisScrollRect:AddSelectChangedListener(function(oldLuaIndex, newLuaIndex, oldUI, newUI)
    self._selectedLuaIndex = newLuaIndex
    self._selectedChapterID = self._selectorPool[newLuaIndex].ID
    self._axisScrollRect:FireUpdateItemLayout()
    self:UpdateKvSelection()
  end)
  self._axisScrollRect:AddScrollChangedListener(function(value)
    self:OnChapterScrollRectMoved(value)
    self._axisScrollPosition = value
  end)
  self._axisScrollRect:AddEndScrollEventListener(function(value)
    self:SetUpButtonState(1)
    self:SetDownButtonState(1)
  end)
  self._axisScrollPosition = self._axisScrollRect:GetRawScrollRect().normalizedPosition
end

function UISailing:UpdateAxisScrollLimit()
  self._axisScrollRect:SetScrollLimit(-1, self._challengeLuaIndex)
end

function UISailing:UpdateChapterContent()
  local allChapter = Cfg.cfg_sailing_layer({})
  local challengeCfg = allChapter[self._challengeLuaIndex]
  local cfgMissionList = challengeCfg.SailingMissionList
  local countMission = #cfgMissionList
  local completeMission = 0
  local progressInfo = self._module:GetLayerInfo(self._challengeChapterID)
  if progressInfo == nil then
    completeMission = 0
  elseif progressInfo.status == 1 then
    completeMission = countMission
  else
    completeMission = #progressInfo.mission_infos
  end
  self._challengeNewFlag = false
  if completeMission == 0 and LocalDB.GetInt(self:ChapterIDKey(self._challengeChapterID), 0) == 0 then
    self._challengeNewFlag = true
  end
  self._axisScrollRect:FireUpdateItemLayout()
end

function UISailing:CreateKvContent()
  local countKvItem = #self._selectorPool
  self._kvPool = self._kvContent:SpawnObjects("UISailingKvItem", countKvItem)
  self._kvStairPool = self._kvStairContent:SpawnObjects("UISailingKvItem", countKvItem)
end

function UISailing:UpdateKvContent()
  local countKvItem = #self._selectorPool
  for i = 1, countKvItem do
    local selectorItem = self._selectorPool[i]
    local uiItem = self._kvPool[i]
    local view = uiItem:View()
    local rt = view.transform
    rt.pivot = Vector2.one * 0.5
    rt.localScale = Vector3.one
    rt.anchorMin = Vector2(0.5, 1.0)
    rt.anchorMax = Vector2(0.5, 1.0)
    rt.sizeDelta = Vector2(415, 397)
    rt.anchoredPosition = Vector2.zero
    uiItem:Init(i, selectorItem)
    uiItem:SetLocked(i > self._challengeLuaIndex)
    uiItem:SetSelected(i == self._selectedLuaIndex)
    local uiItem = self._kvStairPool[i]
    local view = uiItem:View()
    local rt = view.transform
    rt.pivot = Vector2.one * 0.5
    rt.localScale = Vector3.one
    rt.anchorMin = Vector2(0.5, 1.0)
    rt.anchorMax = Vector2(0.5, 1.0)
    rt.sizeDelta = Vector2(415, 397)
    rt.anchoredPosition = Vector2.zero
    uiItem:InitStair(i, selectorItem)
    uiItem:SetLocked(false)
    uiItem:SetSelected(false)
  end
  local viewport = self._kvScrollRect.viewport
  self._kvItemHeight = self._cfgEffect.WayHeight
  self._kvViewportHeight = viewport.rect.height
  self._kvContentHeight = self._kvViewportHeight + (countKvItem - 1) * self._kvItemHeight
  local content = self._kvScrollRect.content
  local sizeDelta = content.sizeDelta
  sizeDelta.y = self._kvContentHeight
  content.sizeDelta = sizeDelta
  local viewport = self._bgScrollRect.viewport
  self._bgItemHeight = self._cfgEffect.BackGroundHeight
  self._bgViewportHeight = viewport.rect.height
  self._bgContentHeight = self._bgViewportHeight + (countKvItem - 1) * self._bgItemHeight
  local content = self._bgScrollRect.content
  local sizeDelta = content.sizeDelta
  sizeDelta.y = self._bgContentHeight
  content.sizeDelta = sizeDelta
end

function UISailing:UpdateCurrentChallenge()
  local layoutCellSize = self._axisScrollRect:GetItemSize()
  local layoutSpacing = self._axisScrollRect:GetItemSpacing()
  self._chapterItemHeight = layoutCellSize + layoutSpacing
  local viewport = self._chapterScrollRect.viewport
  self._chapterViewportHeight = viewport.rect.height
  local content = self._chapterScrollRect.content
  local contentHeight = content.rect.height
  local countChapter = #self._selectorPool
  local emptyCount = self._axisScrollRect:GetEmptyCount()
  self._chapterContentHeight = self._chapterItemHeight * (countChapter + emptyCount)
  local scrollValue = self._axisScrollRect:ScrollTo(self._selectedLuaIndex, nil)
  self:ToKvNormalizedPosition(Vector2(0, scrollValue))
end

function UISailing:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIDiscovery)
  end, function()
    self:ShowDialog("UIHelpController", "UISailing")
  end, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UISailing:UpdateKvSelection()
  local countKvItem = #self._kvPool
  for i = 1, countKvItem do
    local uiItem = self._kvPool[i]
    uiItem:SetSelected(i == self._selectedLuaIndex)
  end
end

function UISailing:EnterKey()
  local key = "SailingEnterKey"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UISailing:ChapterIDKey(chapterID)
  local key = string.format("SailingChapterID:%d", chapterID)
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UISailing:ChallengeMissionKey()
  local key = "SailingChallengeMissionID"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UISailing:GetAtlasSailing()
  return self._atlasSailing
end

function UISailing:OnSailingGetProgressReward(cfgIDList)
  self:UpdateRewardRedPoint()
end

function UISailing:SetUpButtonState(stateIndex)
  local spriteName = self._switchBtnState[stateIndex]
  local atlasSailing = self:GetAtlasSailing()
  self._upButton.sprite = atlasSailing:GetSprite(spriteName)
end

function UISailing:SetDownButtonState(stateIndex)
  local spriteName = self._switchBtnState[2 + stateIndex]
  local atlasSailing = self:GetAtlasSailing()
  self._downButton.sprite = atlasSailing:GetSprite(spriteName)
end
