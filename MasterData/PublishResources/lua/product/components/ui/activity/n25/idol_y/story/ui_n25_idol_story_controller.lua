_class("UIN25IdolStoryController", UIController)
UIN25IdolStoryController = UIN25IdolStoryController

function UIN25IdolStoryController:OnShow(uiParams)
  self._storyID = uiParams[1]
  Log.info("[story] start story ID:" .. tostring(self._storyID))
  GameGlobal.UAReportForceGuideEvent("StoryStart", {
    self._storyID
  })
  self._endCallback = uiParams[2]
  self.onlyReview = uiParams[3]
  self._needCloseSelf = true
  self._revertBGM = true
  self._debugMode = false
  self._ignoreBreak = false
  self._skipToOptions = true
  self._cancelHideButton = self:GetGameObject("CancelHideButton")
  self._cancelAutoButton = self:GetGameObject("CancelAutoButton")
  self._dialogReviewScrollView = self:GetUIComponent("UIDynamicScrollView", "ReviewPanel")
  self._autoStateGO = self:GetGameObject("AutoState")
  self._uiAtlas = self:GetAsset("UIStory.spriteatlas", LoadType.SpriteAtlas)
  self._topBlackSide = self:GetGameObject("Top")
  self._bottomBlackSide = self:GetGameObject("Bottom")
  self._leftBlackSide = self:GetGameObject("Left")
  self._rightBlackSide = self:GetGameObject("Right")
  self._affinityWnd = self:GetGameObject("AffinityWnd")
  self._affinityPetHead = self:GetUIComponent("RawImageLoader", "Icon")
  self._petNameTxt = self:GetUIComponent("UILocalizationText", "PetName")
  self._affinityTxt = self:GetUIComponent("UILocalizationText", "Affinity")
  self._uiCanvasRect = self:GetUIComponent("RectTransform", "UICanvas")
  self._skipLock = true
  self._fullScreenAnchor = self:GetUIComponent("RectTransform", "FullScreenAnchor")
  local bands = ResolutionManager.BangWidth()
  Log.info("UIN25IdolStoryController FullScreenAnchor " .. bands)
  self._fullScreenAnchor.sizeDelta = Vector2(bands * 2, 0)
  self._storyManager = StoryManager:New(self, self._storyID, self._revertBGM, self._ignoreBreak)
  self._dialogReviewScrollView:InitListView(0, function(scrollview, index)
    return self:_OnGetReviewDialogItem(scrollview, index)
  end)
  
  function self._dialogReviewScrollView.mOnDragingAction()
    self._reviewDragged = true
  end
  
  if self._debugMode then
  end
  self._storyManager:Init(self._debugMode, self._entityInfo)
  self._closed = false
  self._reviewDragged = false
  self._dialogSpeakerBGBlue = "plot_juqing_xian4"
  self._dialogSpeakerBGRed = "plot_juqing_xian5"
  self._skipLock = false
  if EditorGlobal.IsEditorMode() then
    EditorGlobal.SetStroyController(self)
    EditorGlobal.SetStroyManager(self._storyManager)
  end
  GameGlobal.UIStateManager():SetBlackSideVisible(false)
end

function UIN25IdolStoryController:OnUpdate(deltaTimeMS)
  if not self._storyManager then
    return
  end
  self._storyManager:Update(deltaTimeMS)
  if self._debugMode then
  end
  if self._storyManager:IsEnd() and not self._closed then
    self:_EndStory()
  end
end

function UIN25IdolStoryController:OnHide()
  self._storyManager:Destroy()
  self._storyManager = nil
  if self._tweenQueue then
    self._tweenQueue:Complete(false)
    self._tweenQueue = nil
  end
  local login_module = GameGlobal.GetModule(LoginModule)
  GameGlobal.UAReportForceGuideEvent("StoryEnd", {
    self._storyID
  })
end

function UIN25IdolStoryController:SetBlackSideSize(width, height)
  self._topBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._bottomBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._topBlackSide:SetActive(0 < height)
  self._bottomBlackSide:SetActive(0 < height)
  self._leftBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._rightBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._leftBlackSide:SetActive(0 < width)
  self._rightBlackSide:SetActive(0 < width)
end

function UIN25IdolStoryController:GetCanvasSize()
  return self._uiCanvasRect.sizeDelta.x, self._uiCanvasRect.sizeDelta.y
end

function UIN25IdolStoryController:FillDebugInfo()
  self._paragraphText.text = self._storyManager:GetCurParagraphID()
  self._sectionText.text = self._storyManager:GetCurSectionIndex()
  self._timeText.text = string.format("%.1f", self._storyManager:GetCurrentTime())
end

function UIN25IdolStoryController:_EndStory()
  Log.sys("关闭剧情界面")
  if self._endCallback then
    self._endCallback()
  end
  if self._needCloseSelf == nil or self._needCloseSelf == true then
    self:CloseDialog()
  end
  self._closed = true
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
end

function UIN25IdolStoryController:_OnGetReviewDialogItem(scrollview, index)
  local dialogRecord = self._storyManager:GetDialogRecord()
  local item = scrollview:NewListViewItem("ReviewContent")
  local luaIndex = index + 1
  if luaIndex <= #dialogRecord then
    local speakerName = dialogRecord[luaIndex][1]
    local content = dialogRecord[luaIndex][2]
    item.transform:Find("SpeakerPlaceHolder/Speaker"):GetComponent(typeof(UILocalizationText)):SetText(speakerName)
    item.transform:Find("Content"):GetComponent(typeof(UILocalizationText)):SetText(content)
    local speakerBG = item.transform:Find("SpeakerPlaceHolder/SpeakerBG").gameObject
    if string.len(speakerName) > 0 then
      speakerBG:SetActive(true)
      local speakerBGColor = dialogRecord[luaIndex][3]
      local isPlayer = dialogRecord[luaIndex][4]
      if isPlayer or speakerBGColor == "blue" then
        speakerBG:GetComponent("Image").sprite = self._uiAtlas:GetSprite(self._dialogSpeakerBGBlue)
      else
        speakerBG:GetComponent("Image").sprite = self._uiAtlas:GetSprite(self._dialogSpeakerBGRed)
      end
    else
      speakerBG:SetActive(false)
    end
    UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
    return item
  else
    return nil
  end
end

function UIN25IdolStoryController:ButtonHideOnClick(go)
  self._storyManager:HideUI(true)
  self._cancelHideButton:SetActive(true)
  self._autoStateGO:SetActive(true)
end

function UIN25IdolStoryController:CancelHideButtonOnClick(go)
  self._storyManager:HideUI(false)
  self._cancelHideButton:SetActive(false)
  self._autoStateGO:SetActive(false)
end

function UIN25IdolStoryController:ButtonReviewOnClick(go)
  GameGlobal.UAReportForceGuideEvent("StoryReplay", {
    self._storyID,
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex()
  })
  self._dialogReviewScrollView.gameObject:SetActive(true)
  local dialogRecord = self._storyManager:GetDialogRecord()
  self._dialogReviewScrollView:SetListItemCount(#dialogRecord, true)
  self._dialogReviewScrollView:MovePanelToItemIndex(#dialogRecord - 1, 0)
end

function UIN25IdolStoryController:ReviewPanelOnClick()
  if self._reviewDragged then
    self._reviewDragged = false
  else
    self._dialogReviewScrollView.gameObject:SetActive(false)
  end
end

function UIN25IdolStoryController:ButtonAutoOnClick(go)
  local login_module = GameGlobal.GetModule(LoginModule)
  if login_module:IsInFirstStory() then
    GameGlobal.ReportCustomEvent("CreateRole", "AutoPlayBtn")
  end
  GameGlobal.UAReportForceGuideEvent("StoryAuto", {
    self._storyID,
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex()
  })
  self._storyManager:SetAuto(true)
  self._cancelAutoButton:SetActive(true)
end

function UIN25IdolStoryController:CancelAutoButtonOnClick(go)
  GameGlobal.UAReportForceGuideEvent("StoryCancelAuto", {
    self._storyID,
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex()
  })
  self._storyManager:SetAuto(false)
  self._cancelAutoButton:SetActive(false)
end

function UIN25IdolStoryController:ButtonSkipOnClick(go)
  if self._skipLock then
    return
  end
  if self._skipToOptions then
    self.key = "JumpStoryNextOptions"
    GameGlobal.UIStateManager():Lock(self.key)
    local lastParagraphId, lastSectionIdx = -1, -1
    local dialogRet = self._storyManager:JumpTo(lastParagraphId, lastSectionIdx)
    if dialogRet then
      dialogRet:FullScreenBtnOnClick()
    end
    GameGlobal.UIStateManager():UnLock(self.key)
    return
  end
  local skip_confirm_str_id = "str_story_skip_confirm"
  if not self:GetModule(StoryModule):IsFinish(self._storyID) then
    skip_confirm_str_id = "str_story_skip_affinity_confirm"
  end
  self._skipLock = true
  local login_module = GameGlobal.GetModule(LoginModule)
  if login_module:IsInFirstStory() then
    GameGlobal.ReportCustomEvent("CreateRole", "SkipAnimBtn")
  end
  GameGlobal.UAReportForceGuideEvent("StorySkip", {
    self._storyID,
    self._storyManager:GetCurParagraphID(),
    self._storyManager:GetCurSectionIndex()
  })
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get(skip_confirm_str_id), function()
    Log.sys("开始跳过剧情")
    if not self._storyManager then
      Log.warn("storyManager在确认跳过前已被置空")
      Log.sys("结束跳过剧情")
      return
    end
    self._storyManager:SkipParagraph()
    self._skipLock = false
    Log.sys("结束跳过剧情")
  end, nil, function()
    self._skipLock = false
  end)
end

function UIN25IdolStoryController:ShowAddAffinity(petID, affinity)
  Log.fatal("宝宝:" .. petID .. " +" .. affinity)
  local pet = self:GetModule(PetModule):GetPetByTemplateId(petID)
  if not pet then
    Log.fatal("[story] missing pet info, tplid:" .. petID)
    return
  end
  if self._affinityPetHead then
    self._affinityPetHead:LoadImage(pet:GetPetHead(PetSkinEffectPath.HEAD_ICON_STORY))
  end
  self._petNameTxt:SetText(StringTable.Get(pet:GetPetName()))
  self._affinityTxt:SetText(StringTable.Get("str_story_add_affinity", affinity))
  self._affinityWnd:SetActive(true)
  if self._tweenQueue then
    self._tweenQueue:Complete(false)
    self._tweenQueue = nil
  end
  self._tweenQueue = DG.Tweening.DOTween.Sequence()
  self._tweenQueue:Append(self._affinityWnd.transform:DOLocalMoveX(-498, 0.2))
  self._tweenQueue:AppendInterval(3)
  self._tweenQueue:Append(self._affinityWnd.transform:DOLocalMoveX(498, 0.2)):AppendCallback(function()
    self._affinityWnd:SetActive(false)
    self._tweenQueue = nil
  end)
end

function UIN25IdolStoryController:GetOnlyReview()
  return self.onlyReview
end

function UIN25IdolStoryController:SetOnlyReview(onlyReview)
  self.onlyReview = onlyReview
end
