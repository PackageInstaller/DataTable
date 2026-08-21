_class("UISakuraEntryController_Review", UIController)
UISakuraEntryController_Review = UISakuraEntryController_Review

function UISakuraEntryController_Review:Constructor()
  self._componentState = {}
  self._animations = {
    show = "uieff_UISakuraEntryController_in",
    hide = "uieff_UISakuraEntryController_out"
  }
  local baseBtnImgs = {
    [true] = "legend_zhuye_btn1",
    [false] = "legend_zhuye_btn5"
  }
  local loginAwardBtnImgs = {
    [true] = "legend_zhuye_btn6",
    [false] = "legend_zhuye_btn5"
  }
  self._componentStateImg = {
    [ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY] = baseBtnImgs
  }
end

function UISakuraEntryController_Review:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._reviewData = uiModule:GetReviewData():GetActivityByType(ECampaignType.CAMPAIGN_TYPE_REVIEW_N2)
  self._reviewData:ReqDetailInfo(TT, res)
  self._campaign = self._reviewData:GetDetailInfo()
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._story_componentInfo = self._campaign:GetLocalProcess()._storyComponentInfo
end

function UISakuraEntryController_Review:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UISakuraEntryController_Review:OnShow(uiParams)
  self._rt = uiParams[1]
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:_GetComponents()
  self:_OnValue()
end

function UISakuraEntryController_Review:OnHide()
  if self.clearNewTask then
    GameGlobal.TaskManager():KillTask(self.clearNewTask)
    self.clearNewTask = nil
  end
end

function UISakuraEntryController_Review:AfterUILayerChanged()
  self:_RefreshComponentState()
  self:_RefreshBtnImgAndBtnText()
  self:_CheckRedPointAll()
end

function UISakuraEntryController_Review:_CheckCampaignClose()
  return not self._campaign:CheckCampaignOpen()
end

function UISakuraEntryController_Review:_GetComponents()
  self._bgRT = self:GetUIComponent("RawImage", "bg")
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  self._activityName = self:GetUIComponent("UILocalizationText", "ActivityName")
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._storyRedPoint = self:GetGameObject("StoryRedPoint")
  self._storyRedPointSpine = self:GetUIComponent("SpineLoader", "StoryRedPoint")
  self._taskRedPoint = self:GetGameObject("TaskRedPoint")
  self._taskRedPointSpine = self:GetUIComponent("SpineLoader", "TaskRedPoint")
  self._shopRedPoint = self:GetGameObject("ShopRedPoint")
  self._loginAwardRedPoint = self:GetGameObject("LoginAwardRedPoint")
  self._activityIntro = self:GetGameObject("ActivityIntro")
  self._activityIntrobg = self:GetUIComponent("RawImage", "ActivityIntro")
  self._activityIntroMark = self:GetUIComponent("RawImage", "ActivityIntroMark")
  self._storyBtn = self:GetGameObject("SakuraBtn")
  self._taskBtn = self:GetGameObject("TaskBtn")
  self._shopBtn = self:GetGameObject("ShopBtn")
  self._loginAwardBtn = self:GetGameObject("LoginAwardBtn")
  self._btnImg = {}
  self._btnImg[ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY] = self:GetUIComponent("RawImageLoader", "SakuraBtn")
  self._btnText = {}
  self._btnText[ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY] = self:GetUIComponent("UILocalizationText", "SakuraBtnText")
  self:_AddUIEvent(self._storyBtn)
  self:_AddUIEvent(self._taskBtn)
  self:_AddUIEvent(self._shopBtn)
  self:_AddUIEvent(self._loginAwardBtn)
  self._BtnBg = {}
  self._BtnBg[self._storyBtn.name] = self:GetUIComponent("RawImage", "SakuraBtn")
  self._BtnBg[self._taskBtn.name] = self:GetUIComponent("RawImage", "TaskBtn")
  self._BtnBg[self._shopBtn.name] = self:GetUIComponent("RawImage", "ShopBtn")
  self._BtnBg[self._loginAwardBtn.name] = self:GetUIComponent("RawImage", "LoginAwardBtn")
  self._mark = self:GetGameObject("Mark")
  self._markSmall = self:GetGameObject("MarkSmall")
  self._markGos = {}
  self._markGos[self._storyBtn.name] = self._mark
  self._markGos[self._taskBtn.name] = self._mark
  self._markGos[self._shopBtn.name] = self._mark
  self._markGos[self._loginAwardBtn.name] = self._markSmall
  self._animation = self:GetUIComponent("Animation", "uianim")
  self._haveItemText = self:GetUIComponent("UILocalizationText", "HaveItemText")
  self._obtainItemText = self:GetUIComponent("UILocalizationText", "ObtainItemText")
end

function UISakuraEntryController_Review:_AddUIEvent(btn)
  UIEventTriggerListener.Get(btn).onDown = function(go)
    self:_OnPressDown(go)
  end
  UIEventTriggerListener.Get(btn).onUp = function(go)
    self:_OnPressUp(go)
  end
end

function UISakuraEntryController_Review:_SwitchActivityIntroClickState(btn)
  UIEventTriggerListener.Get(btn).onDown = function(go)
    self._activityIntrobg.enabled = false
    self._activityIntroMark.enabled = true
  end
  UIEventTriggerListener.Get(btn).onUp = function(go)
    self._activityIntrobg.enabled = true
    self._activityIntroMark.enabled = false
  end
end

function UISakuraEntryController_Review:HideBtnOnClick()
  local right = self:GetGameObject("Right")
  right:SetActive(false)
  local topLeft = self:GetGameObject("TopLeft")
  topLeft:SetActive(false)
  local topRight = self:GetGameObject("TopRight")
  topRight:SetActive(false)
  local bottomRight = self:GetGameObject("BottomRight")
  bottomRight:SetActive(false)
  local bottomLeft = self:GetGameObject("BottomLeft")
  bottomLeft:SetActive(false)
  local showBtn = self:GetGameObject("ShowBtn")
  showBtn:SetActive(true)
end

function UISakuraEntryController_Review:ShowBtnOnClick()
  local right = self:GetGameObject("Right")
  right:SetActive(true)
  local topLeft = self:GetGameObject("TopLeft")
  topLeft:SetActive(true)
  local topRight = self:GetGameObject("TopRight")
  topRight:SetActive(true)
  local bottomRight = self:GetGameObject("BottomRight")
  bottomRight:SetActive(true)
  local bottomLeft = self:GetGameObject("BottomLeft")
  bottomLeft:SetActive(true)
  local showBtn = self:GetGameObject("ShowBtn")
  showBtn:SetActive(false)
end

function UISakuraEntryController_Review:_OnValue()
  self._bgRT.texture = self._rt
  self._activityName:SetText(StringTable.Get(self._cfg_campaign.CampaignName))
  self._activityIntroMark.enabled = false
  self._mark:SetActive(false)
  self._markSmall:SetActive(false)
  self._animation:Play(self._animations.show)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.OpenSakura)
  self:_PlayRedPointAnimation(self._storyRedPoint, self._storyRedPointSpine)
  self:_PlayRedPointAnimation(self._taskRedPoint, self._taskRedPointSpine)
  self:_PlayStory()
  self:Lock("UISakuraEntryController_Review:OnShow")
  self:StartTask(function(TT)
    YIELD(TT, 2567)
    self:UnLock("UISakuraEntryController_Review:OnShow")
  end)
end

function UISakuraEntryController_Review:_PlayRedPointAnimation(redpoint, redpointspine)
  if redpointspine then
    GameGlobal.Timer():AddEvent(2567, function()
      if redpoint.activeSelf then
        redpointspine:SetAnimation(0, "appear", false)
        GameGlobal.Timer():AddEvent(433, function()
          redpointspine:SetAnimation(0, "idle", true)
        end)
      end
    end)
  end
end

function UISakuraEntryController_Review:_CheckRedPointAll()
  self:_CheckRedPoint(self._storyRedPoint, ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY)
end

function UISakuraEntryController_Review:SakuraBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SakuraCommonClick)
  self:_ShowChildUI(ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY, "UISakuraController_Review")
end

function UISakuraEntryController_Review:_ShowChildUI(componentid, uiName, ...)
  self:ShowDialog(uiName, ...)
end

function UISakuraEntryController_Review:_OnPressDown(go)
  local rawimage = self._BtnBg[go.name]
  rawimage.enabled = false
  local mark = self._markGos[go.name]
  if mark then
    mark.transform.position = go.transform.position
    mark:SetActive(true)
  end
end

function UISakuraEntryController_Review:_OnPressUp(go)
  local rawimage = self._BtnBg[go.name]
  rawimage.enabled = true
  local mark = self._markGos[go.name]
  if mark then
    mark:SetActive(false)
  end
end

function UISakuraEntryController_Review:_Close()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
  self:Lock("UISakuraEntryController_Review:OnHide")
  self._animation:Play(self._animations.hide)
  self:StartTask(function(TT)
    YIELD(TT, 700)
    self:UnLock("UISakuraEntryController_Review:OnHide")
    self:SwitchState(UIStateType.UIActivityReview)
  end, self)
end

function UISakuraEntryController_Review:_ShowActivityIntro(show)
  self._activityIntro:SetActive(show)
end

function UISakuraEntryController_Review:_SetRemainTime(pre_remaining, remaintime)
  self._remainTime:SetText(pre_remaining .. self:_GetRemainTime(remaintime))
end

function UISakuraEntryController_Review:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UISakuraEntryController_Review:ActivityIntroOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SakuraCommonClick)
  self:ShowDialog("UIActivityIntroController", "UISakuraController")
end

function UISakuraEntryController_Review:_CheckRedPoint(redpoint, ...)
  local args = {
    ...
  }
  for key, value in pairs(args) do
    if self._componentState[value] ~= nil and not self._componentState[value] then
      redpoint:SetActive(false)
      return
    end
  end
  local show = self._campaign:CheckComponentOpen(...) and self._campaign:CheckComponentRed(...)
  redpoint:SetActive(show)
end

local ComponentStateImg = {
  [true] = "legend_zhuye_btn1",
  [false] = "legend_zhuye_btn5"
}
_enum("ComponentStateImg", ComponentStateImg)
local ComponentStateTextColor = {
  [true] = Color.white,
  [false] = Color(0.3, 0.3, 0.33, 1)
}
_enum("ComponentStateTextColor", ComponentStateTextColor)

function UISakuraEntryController_Review:_RefreshComponentState()
  self._componentState[ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY] = self:_GetComponentState(ECampaignReviewHiiroComponentID.ECAMPAIGN_REVIEW_HIIRO_STORY)
end

function UISakuraEntryController_Review:_RefreshBtnImgAndBtnText()
  for key, value in pairs(self._componentState) do
    local rawimgloader = self._btnImg[key]
    rawimgloader:LoadImage(self._componentStateImg[key][value])
    local text = self._btnText[key]
    if not value then
      text:SetText(StringTable.Get("str_activity_common_end"))
    end
    text.color = ComponentStateTextColor[value]
  end
end

function UISakuraEntryController_Review:_PlayStory()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    return
  end
  if self._cfg_campaign ~= nil then
    if self._cfg_campaign.FirstEnterStoryID ~= nil and self._cfg_campaign.FirstEnterStoryID[1] ~= nil then
      GameGlobal.GetModule(StoryModule):StartStory(self._cfg_campaign.FirstEnterStoryID[1], function()
        self.clearNewTask = self:StartTask(function(TT)
          local res = AsyncRequestRes:New()
          GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
          if res:GetSucc() then
            Log.info("ui_sakura_entry_controller play first enter story succ.")
          end
        end, self)
      end, true)
    else
      self.clearNewTask = self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
        if res:GetSucc() then
          Log.info("ui_sakura_entry_controller clear new succ.")
        end
      end, self)
    end
  end
end
