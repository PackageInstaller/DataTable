_class("UISailingChapter", UIController)
UISailingChapter = UISailingChapter

function UISailingChapter:Constructor()
  self._module = self:GetModule(SailingMissionModule)
  self._chapterLuaIndex = 1
  self._chapterCfg = nil
  self._missionPool = nil
  self._missionDone = false
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UISailingChapter:OnShow(uiParams)
  if uiParams ~= nil and 2 <= #uiParams then
    self._chapterLuaIndex = uiParams[1]
    self._chapterCfg = uiParams[2]
  else
    local chapterID = self._module:GetChallengeLayerID()
    local allChapter = Cfg.cfg_sailing_layer({})
    for k, v in pairs(allChapter) do
      if v.ID == chapterID then
        self._chapterLuaIndex = k
        self._chapterCfg = v
        break
      end
    end
  end
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._curChapterValue = self:GetUIComponent("UILocalizationText", "curChapterValue")
  self._realtimeMissionMaxValue = UISailingImageNumber:New(self, "N22_dhh_xzlb_0%d")
  self._realtimeMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "realtimeMissionMaxValue0"))
  self._realtimeMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "realtimeMissionMaxValue1"))
  self._realtimeMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "realtimeMissionMaxValue2"))
  self._curChapterProgressValue1 = self:GetUIComponent("UILocalizationText", "curChapterProgressValue1")
  self._curChapterProgressValue2 = self:GetUIComponent("UILocalizationText", "curChapterProgressValue2")
  self._curChapterProgressValueC = self:GetUIComponent("UILocalizationText", "curChapterProgressValueC")
  self._redReward = self:GetUIComponent("RectTransform", "redReward")
  self._historyMissionMaxValueBg = self:GetUIComponent("UILocalizationText", "historyMissionMaxValueBg")
  self._historyMissionMaxValue = self:GetUIComponent("UILocalizedTMP", "historyMissionMaxValue")
  self._missionContent = self:GetUIComponent("UISelectObjectPath", "missionContent")
  self._missionContentLayout = self:GetUIComponent("GridLayoutGroup", "missionContent")
  self._missionScrollRect = self:GetUIComponent("ScrollRect", "missionScrollRect")
  self._missionScrollBar = self:GetUIComponent("Slider", "missionScrollbar")
  self._missionSelectedImage = self:GetUIComponent("Transform", "selectedImage")
  self._missionSelectedImageAnim = self:GetUIComponent("Animation", "selectedImageAnim")
  self._missionSelectedImage.gameObject:SetActive(false)
  self._selectedUIMissionItem = nil
  self._missionScrollRect.onValueChanged:AddListener(function(value)
    self:OnScrollRectMoved(value)
  end)
  self._missionScrollBar.onValueChanged:AddListener(function(value)
    self:OnScrollBarMoved(value)
  end)
  self:AttachEvent(GameEventType.SailingMissionLayerInfoChanged, self.OnLayerInfoChanged)
  self:AttachEvent(GameEventType.SailingGetProgressReward, self.OnSailingGetProgressReward)
  self:UpdateChapterValue()
  self:UpdateRewardRedPoint()
  self:UpdateMissionContent()
  self:UpdateMissionDefaultPosition()
  self:InitCommonTopButton()
end

function UISailingChapter:OnHide()
end

function UISailingChapter:BtnRewardOnClick(go)
  self:ShowDialog("UISailingRewardsController")
end

function UISailingChapter:OnScrollRectMoved(value)
  local content = self._missionScrollRect.content
  local contentSize = content.rect.width
  local viewport = self._missionScrollRect.viewport
  local viewportSize = viewport.rect.width
  if contentSize > viewportSize then
    self._missionScrollBar.value = value.x
  end
  if self._selectedUIMissionItem ~= nil then
    local selectedTr = self._missionSelectedImage.transform
    selectedTr.position = self._selectedUIMissionItem:View().transform.position
  end
end

function UISailingChapter:OnScrollBarMoved(value)
  local content = self._missionScrollRect.content
  local contentSize = content.rect.width
  local viewport = self._missionScrollRect.viewport
  local viewportSize = viewport.rect.width
  if contentSize > viewportSize then
    self._missionScrollRect.horizontalNormalizedPosition = value
  else
    self._missionScrollBar.value = 0
  end
end

function UISailingChapter:OnLayerInfoChanged(chapterID)
  self:UpdateChapterValue()
  self:UpdateRewardRedPoint()
  if self._chapterCfg.ID == chapterID then
    self:UpdateMissionContent()
  end
end

function UISailingChapter:UpdateChapterValue()
  local cfgMissionList = self._chapterCfg.SailingMissionList
  local countMission = #cfgMissionList
  local completeMission = 0
  local progressInfo = self._module:GetLayerInfo(self._chapterCfg.ID)
  if progressInfo == nil then
    completeMission = 0
  elseif progressInfo.status == 1 then
    completeMission = countMission
  else
    completeMission = #progressInfo.mission_infos
  end
  self._missionDone = completeMission == countMission
  self._curChapterProgressValue1.gameObject:SetActive(not self._missionDone)
  self._curChapterProgressValue2.gameObject:SetActive(not self._missionDone)
  self._curChapterProgressValueC.gameObject:SetActive(self._missionDone)
  if self._missionDone then
    local doneValue = StringTable.Get("str_sailing_mission_curlayer_done")
    self._curChapterProgressValueC:SetText(doneValue)
  else
    local progressValue = string.format("/%d", countMission)
    self._curChapterProgressValue1:SetText(tostring(completeMission))
    self._curChapterProgressValue2:SetText(progressValue)
  end
  local chapterValue = StringTable.Get("str_sailing_mission_arg_layer", self._chapterLuaIndex)
  self._curChapterValue:SetText(chapterValue)
  local currentProgress = self._module:GetCurrentProgress()
  local historyProgress = self._module:GetHistoryProgress()
  self._realtimeMissionMaxValue:SetValue(currentProgress)
  local historyProgressStr = tostring(historyProgress)
  self._historyMissionMaxValueBg:SetText(historyProgressStr)
  self._historyMissionMaxValue:SetText(historyProgressStr)
end

function UISailingChapter:UpdateRewardRedPoint()
  local fnUpdateRewardRedPoint = UISailing.UpdateRewardRedPoint
  fnUpdateRewardRedPoint(self)
end

function UISailingChapter:UpdateMissionContent()
  local cfgMissionList = self._chapterCfg.SailingMissionList
  local countMission = #cfgMissionList
  self._missionPool = self._missionContent:SpawnObjects("UISailingMissionItem", countMission)
  local dicMission = {}
  local progressInfo = self._module:GetLayerInfo(self._chapterCfg.ID)
  if progressInfo ~= nil then
    for _, v in pairs(progressInfo.mission_infos) do
      dicMission[v.mission_id] = v
    end
  end
  for i = 1, countMission do
    local uiItem = self._missionPool[i]
    local missionId = cfgMissionList[i]
    local cfgMission = Cfg.cfg_sailing_mission({ID = missionId})
    uiItem:Init(i, cfgMission[1], dicMission[missionId])
  end
end

function UISailingChapter:UpdateMissionDefaultPosition()
  local scrollValue = 0
  if self._missionDone then
    scrollValue = 0
  else
    local layoutCellSize = self._missionContentLayout.cellSize
    local layoutSpacing = self._missionContentLayout.spacing
    local itemWidth = layoutCellSize.x + layoutSpacing.x
    local viewport = self._missionScrollRect.viewport
    local viewportWidth = viewport.rect.width
    local content = self._missionScrollRect.content
    local contentWidth = content.rect.width
    local countMission = #self._missionPool
    contentWidth = itemWidth * countMission - layoutSpacing.x
    local totalScrollWidth = contentWidth - viewportWidth
    local luaIndex = 1
    local lastID = LocalDB.GetInt(UISailing:ChallengeMissionKey(), 0)
    for i = 1, countMission do
      local uiItem = self._missionPool[i]
      if uiItem:GetMissionCfg().ID == lastID then
        luaIndex = i
        break
      end
    end
    local targetPosition = viewportWidth * 0.5
    local currentPosition = (luaIndex - 1) * itemWidth + layoutCellSize.x * 0.5
    local needScrollWidth = currentPosition - targetPosition
    if totalScrollWidth <= 0 or needScrollWidth <= 0 then
      scrollValue = 0
    else
      scrollValue = needScrollWidth / totalScrollWidth
      scrollValue = math.min(scrollValue, 1)
      scrollValue = math.max(scrollValue, 0)
    end
  end
  self._missionScrollRect.horizontalNormalizedPosition = scrollValue
  self._missionScrollBar.value = scrollValue
end

function UISailingChapter:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UISailingMain, self._chapterCfg.ID)
  end, function()
    self:ShowDialog("UIHelpController", "UISailingChapter")
  end, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UISailingChapter:OnSailingGetProgressReward(cfgIDList)
  self:UpdateRewardRedPoint()
end

function UISailingChapter:MissionItemOnPress(uiMissionItem, eventData)
  self._selectedUIMissionItem = uiMissionItem
  local selectedTr = self._missionSelectedImage.transform
  selectedTr.gameObject:SetActive(true)
  selectedTr.position = uiMissionItem:View().transform.position
  self._missionSelectedImageAnim:Play("uieff_UISailingChapter_kuang")
end

function UISailingChapter:MissionItemOnBeginDrag(uiMissionItem, eventData)
  self._missionScrollRect:OnBeginDrag(eventData)
end

function UISailingChapter:MissionItemOnDrag(uiMissionItem, eventData)
  self._missionScrollRect:OnDrag(eventData)
end

function UISailingChapter:MissionItemOnEndDrag(uiMissionItem, eventData)
  self._missionScrollRect:OnEndDrag(eventData)
end

function UISailingChapter:GetAtlasProperty()
  return self._atlasProperty
end

function UISailingChapter:GetChapterCfg()
  return self._chapterCfg
end

function UISailingChapter:GetGuideArea()
  return self._missionPool[1]:GetGuideArea()
end
