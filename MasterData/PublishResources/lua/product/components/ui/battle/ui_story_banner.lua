_class("UIStoryBanner", UIController)
UIStoryBanner = UIStoryBanner

function UIStoryBanner:OnShow(uiParams)
  GuideHelper.GuideLoadLock(false, "UIStoryBanner")
  self._bannerID = uiParams[1]
  GameGlobal.UAReportForceGuideEvent("MissionStoryBanner", {
    self._bannerID
  }, false, true)
  self._bannerType = uiParams[2]
  self._endCallback = uiParams[3]
  self._lock = uiParams[4]
  self._rootGO = self:GetGameObject("root")
  self._headIconElement = self:GetUIComponent("RawImageLoader", "headIcon")
  self._headIcon = self:GetUIComponent("RawImage", "headIcon")
  self._text = self:GetUIComponent("UILocalizationText", "text")
  self._speakerName = self:GetUIComponent("UILocalizationText", "speakerName")
  self._bg = self:GetUIComponent("Image", "duihuakuang")
  self._halfGO = self:GetGameObject("half")
  self._halfHeadIconElement = self:GetUIComponent("RawImageLoader", "half_headIcon")
  self._halfHeadIcon = self:GetUIComponent("RawImage", "half_headIcon")
  self._halfHeadIconGO = self:GetGameObject("half_headIcon")
  self._halfHeadIconGO:SetActive(false)
  self._halfText = self:GetUIComponent("UILocalizationText", "half_text")
  self._halfSpeakerName = self:GetUIComponent("UILocalizationText", "half_speakName")
  self._halfSpeakerNameLineLeft = self:GetUIComponent("Image", "line_left")
  self._halfSpeakerNameLineRight = self:GetUIComponent("Image", "line_right")
  self._halfBg = self:GetUIComponent("Image", "half_duihuakuang")
  self._spineLoader = self:GetUIComponent("SpineLoader", "spine_loader")
  self._spineLoaderGO = self:GetGameObject("spine_loader")
  self._spineLoaderGO:SetActive(false)
  self._isSpine = false
  self._homelandGO = self:GetGameObject("homeland")
  self._hlBodyElement = self:GetUIComponent("RawImageLoader", "hl_body")
  self._hlBody = self:GetUIComponent("RawImage", "hl_body")
  self._hlContext = self:GetUIComponent("UILocalizationText", "hl_contexnt")
  self._hlName = self:GetUIComponent("UILocalizationText", "hl_name")
  self._hlBg = self:GetUIComponent("Image", "hl_duihuakuang")
  self._blackBgGO = self:GetGameObject("blackbg")
  self._blackBgGO:SetActive(false)
  if GameGlobal:GetInstance():IsCoreGameRunning() then
    local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
    self._bannerList = levelConfigData:GetStoryBannerList(self._bannerID)
  else
    self._bannerList = self:GetStoryBannerList(self._bannerID)
  end
  self._index = 1
  self._canClick = false
  self._speakerNameLine = {}
  self._speakerNameLine[1] = "thread_duihua_kuang6"
  self._speakerNameLine[2] = "thread_duihua_kuang6"
  self._colorPattern = "<color=#%x*"
  self._bannerText = {}
  self._rootGO:SetActive(false)
  self._halfGO:SetActive(false)
  self._homelandGO:SetActive(false)
  self._iconAtlas = self:GetAsset("UIInnerStoryTips.spriteatlas", LoadType.SpriteAtlas)
  self._showTextTaskID = GameGlobal.TaskManager():StartTask(self.ShowText, self, false)
  self:LockHomeLandInput(self._lock)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelChainPath)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideChainPathCancelArea)
end

function UIStoryBanner:GetStoryBannerList(bannerId)
  local bannerConfig = Cfg.cfg_story_banner[bannerId]
  local bannerList = {}
  if not bannerConfig then
    Log.fatal("bannerConfig is Nil BannerID:", bannerId)
  end
  for _, v in ipairs(bannerConfig.BannerList) do
    local bannerParam = StoryBannerParam:New(v)
    table.insert(bannerList, bannerParam)
  end
  return bannerList
end

function UIStoryBanner:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.StoryBanner)
  if self._endCallback then
    self._endCallback()
  end
  if self._showTextTaskID and GameGlobal.TaskManager():FindTask(self._showTextTaskID) then
    GameGlobal.TaskManager():KillTask(self._showTextTaskID)
    self._showTextTaskID = nil
  end
  self:LockHomeLandInput(false)
end

function UIStoryBanner:SetObjectAlpha(object)
  object.color.a = 0
end

function UIStoryBanner:SetTextLabelAlpha(textObject)
  local text = self._bannerText
  if text == "" then
    return
  end
  local alpha = textObject.color.a
  local colorStr = string.format("%02x", math.floor(alpha * 255))
  local str = string.gsub(text, self._colorPattern, function(s)
    return s .. colorStr
  end)
  textObject:SetText(str)
end

function UIStoryBanner:_OnFadeUpdate()
end

function UIStoryBanner:_SetData(bSame)
  local banner = self._bannerList[self._index]
  if banner then
    self._blackBgGO:SetActive(banner._showBlackBg)
  else
    self._blackBgGO:SetActive(false)
  end
  local speakerNameStr = banner:GetSpeakerName()
  local go, text, headIconElement, headIcon, speakerName, bg
  if self._bannerType == StoryBannerShowType.Normal then
    go = self._rootGO
    text = self._text
    headIcon = self._headIcon
    headIconElement = self._headIconElement
    speakerName = self._speakerName
    bg = self._bg
    self._rootGO:SetActive(true)
    self._halfGO:SetActive(false)
    self._homelandGO:SetActive(false)
    if self._index ~= 1 then
      headIconElement:DestoryLastImage()
    end
    headIconElement:LoadImage(banner:GetHeadIconName())
  elseif self._bannerType == StoryBannerShowType.HalfPortrait then
    go = self._halfGO
    text = self._halfText
    headIcon = self._halfHeadIcon
    headIconElement = self._halfHeadIconElement
    speakerName = self._halfSpeakerName
    if banner:IsSpine() then
      self._isSpine = true
      self._halfHeadIconGO:SetActive(false)
      self._spineLoaderGO:SetActive(true)
      if not bSame then
        if self._spineLoader.CurrentSkeleton ~= nil then
          self._spineLoader:DestroyCurrentSpine()
        end
        self._spineLoader:LoadSpine(banner:GetSpineName())
      end
      if banner:GetSpineAnim() then
        self._spineLoader:SetAnimation(0, banner:GetSpineAnim(), true)
      end
      UICG.SetTransform(self._spineLoaderGO.transform, self:GetName(), banner:GetSpineName())
    else
      self._isSpine = false
      self._halfHeadIconGO:SetActive(true)
      self._spineLoaderGO:SetActive(false)
      if self._index ~= 1 then
        headIconElement:DestoryLastImage()
      end
      self._halfHeadIconElement:LoadImage(banner:GetHeadIconName())
    end
    bg = self._halfBg
    self._rootGO:SetActive(false)
    self._halfGO:SetActive(true)
    self._homelandGO:SetActive(false)
  elseif self._bannerType == StoryBannerShowType.HomelandGuide then
    go = self._homelandGO
    text = self._hlContext
    headIcon = self._hlBody
    headIconElement = self._hlBodyElement
    speakerName = self._hlName
    bg = self._hlBg
    self._hlBodyElement:LoadImage(banner:GetHeadIconName())
    self._rootGO:SetActive(false)
    self._halfGO:SetActive(false)
    self._homelandGO:SetActive(true)
  end
  self._bannerText = banner:GetText()
  text:SetText(banner:GetText())
  speakerName:SetText(speakerNameStr)
  self:SetObjectAlpha(headIcon)
  self:SetObjectAlpha(text)
  self:SetTextLabelAlpha(text)
  self:SetObjectAlpha(speakerName)
  self:SetObjectAlpha(bg)
  go:SetActive(true)
end

function UIStoryBanner:_DoHideAnimation(TT)
  local sequence = DG.Tweening.DOTween.Sequence()
  if self._bannerType == StoryBannerShowType.Normal then
    sequence:Append(self._bg:DOFade(0, 0.1))
    sequence:Join(self._headIcon:DOFade(0, 0.1))
    sequence:Join(self._speakerName:DOFade(0, 0.1))
    sequence:Join(self._text:DOFade(0, 0.1):OnUpdate(function()
      self:SetTextLabelAlpha(self._text)
    end))
    YIELD(TT, 100)
  elseif self._bannerType == StoryBannerShowType.HalfPortrait then
    if self._isSpine then
      sequence:Append(self._halfBg:DOFade(0, 0.1))
      sequence:Join(self._halfSpeakerNameLineLeft:DOFade(0, 0.1))
      sequence:Join(self._halfSpeakerNameLineRight:DOFade(0, 0.1))
      sequence:Join(self._halfSpeakerName:DOFade(0, 0.1))
      sequence:Join(self._halfText:DOFade(0, 0.1):OnUpdate(function()
        self:SetTextLabelAlpha(self._halfText)
      end))
      local count = 0
      while count < 3 do
        self:SetSpineAlpha(1 - count / 3)
        count = count + 1
        YIELD(TT, 33)
      end
      self:SetSpineAlpha(0)
    else
      sequence:Append(self._halfHeadIcon:DOFade(0, 0.1))
      sequence:Join(self._halfBg:DOFade(0, 0.1))
      sequence:Join(self._halfSpeakerNameLineLeft:DOFade(0, 0.1))
      sequence:Join(self._halfSpeakerNameLineRight:DOFade(0, 0.1))
      sequence:Join(self._halfSpeakerName:DOFade(0, 0.1))
      sequence:Join(self._halfText:DOFade(0, 0.1):OnUpdate(function()
        self:SetTextLabelAlpha(self._halfText)
      end))
      YIELD(TT, 100)
    end
  elseif self._bannerType == StoryBannerShowType.HomelandGuide then
    sequence:Append(self._hlBody:DOFade(0, 0.1))
    sequence:Join(self._hlBg:DOFade(0, 0.1))
    sequence:Join(self._hlName:DOFade(0, 0.1))
    sequence:Join(self._hlContext:DOFade(0, 0.1):OnUpdate(function()
      self:SetTextLabelAlpha(self._hlContext)
    end))
    YIELD(TT, 100)
  end
end

function UIStoryBanner:_DoShowAnimation(TT)
  local sequence = DG.Tweening.DOTween.Sequence()
  if self._bannerType == StoryBannerShowType.Normal then
    sequence:Append(self._bg:DOFade(1, 0.2))
    sequence:Append(self._headIcon:DOFade(1, 0.1))
    sequence:Join(self._speakerName:DOFade(1, 0.1))
    sequence:Append(self._text:DOFade(1, 0.1):OnUpdate(function()
      self:SetTextLabelAlpha(self._text)
    end))
    YIELD(TT, 400)
  elseif self._bannerType == StoryBannerShowType.HalfPortrait then
    if self._isSpine then
      self:SetSpineAlpha(0)
      self._halfBg:DOFade(1, 0.2)
      local count = 0
      while count < 3 do
        self:SetSpineAlpha(count / 3)
        count = count + 1
        YIELD(TT, 33)
      end
      self:SetSpineAlpha(1)
      sequence:Append(self._halfSpeakerNameLineLeft:DOFade(1, 0.1))
      sequence:Append(self._halfSpeakerNameLineRight:DOFade(1, 0.1))
      sequence:Join(self._halfSpeakerName:DOFade(1, 0.1))
      sequence:Append(self._halfText:DOFade(1, 0.1):OnUpdate(function()
        self:SetTextLabelAlpha(self._halfText)
      end))
      YIELD(TT, 200)
    else
      sequence:Append(self._halfHeadIcon:DOFade(1, 0.2))
      sequence:Join(self._halfBg:DOFade(1, 0.2))
      sequence:Append(self._halfSpeakerNameLineLeft:DOFade(1, 0.1))
      sequence:Append(self._halfSpeakerNameLineRight:DOFade(1, 0.1))
      sequence:Join(self._halfSpeakerName:DOFade(1, 0.1))
      sequence:Append(self._halfText:DOFade(1, 0.1):OnUpdate(function()
        self:SetTextLabelAlpha(self._halfText)
      end))
      YIELD(TT, 400)
    end
  elseif self._bannerType == StoryBannerShowType.HomelandGuide then
    sequence:Append(self._hlBg:DOFade(1, 0.2))
    sequence:Append(self._hlBody:DOFade(1, 0.1))
    sequence:Join(self._hlName:DOFade(1, 0.1))
    sequence:Append(self._hlContext:DOFade(1, 0.1):OnUpdate(function()
      self:SetTextLabelAlpha(self._hlContext)
    end))
    YIELD(TT, 400)
  end
end

function UIStoryBanner:ShowText(TT, bSame)
  if not self._bannerList then
    self:CloseDialog()
    Log.fatal("BannerID is invalid ID:", self._bannerID)
  end
  if bSame then
    local text
    local sequence = DG.Tweening.DOTween.Sequence()
    if self._bannerType == StoryBannerShowType.Normal then
      text = self._text
    elseif self._bannerType == StoryBannerShowType.HalfPortrait then
      text = self._halfText
    elseif self._bannerType == StoryBannerShowType.HomelandGuide then
      text = self._hlContext
    else
      Log.error("UIStoryBanner:ShowText error bannerType ", self._bannerType)
    end
    text:SetText("")
    self:_SetData(bSame)
    self:SetObjectAlpha(text)
    self:SetTextLabelAlpha(text)
    YIELD(TT, 100)
    sequence:Append(text:DOFade(1, 0.1):OnUpdate(function()
      self:SetTextLabelAlpha(text)
    end))
  else
    self:_DoHideAnimation(TT)
    self:_SetData(bSame)
    self:_DoShowAnimation(TT)
  end
  self._canClick = true
end

function UIStoryBanner:bgOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIStoryBanner",
    input = "bgOnClick",
    args = {}
  })
  if self._canClick == false then
    return
  else
    self._canClick = false
  end
  if self._index == #self._bannerList then
    self:CloseDialog()
  else
    self._index = self._index + 1
    local preBanner = self._bannerList[self._index - 1]
    local curBanner = self._bannerList[self._index]
    local bSame = false
    if preBanner:IsSameSpeaker(curBanner:GetSpeaker()) then
      bSame = true
    else
      bSame = false
    end
    self._showTextTaskID = GameGlobal.TaskManager():StartTask(self.ShowText, self, bSame)
  end
end

function UIStoryBanner:SetSpineAlpha(alpha)
  self._spineSke = self._spineLoaderGO:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
  self._spineSkeMultipleTex = self._spineLoaderGO:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
  if self._spineSke then
    local color = self._spineSke.color
    color.a = alpha
    self._spineSke.color = color
  elseif self._spineSkeMultipleTex and self._spineSkeMultipleTex.Skeleton then
    self._spineSkeMultipleTex.Skeleton.A = alpha
  end
end

function UIStoryBanner:LockHomeLandInput(Lock)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  if homelandClient then
    homelandClient:InputManager():GetControllerChar():SetGuideLock(Lock)
    homelandClient:InputManager():GetControllerBuild():SetGuideLock(Lock)
  end
end
