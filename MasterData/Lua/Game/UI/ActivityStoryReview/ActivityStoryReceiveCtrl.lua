local ActivityStoryReceiveCtrl = class("ActivityStoryReceiveCtrl", BaseCtrl)
ActivityStoryReceiveCtrl._mapNodeConfig = {
  btnReceiveCG = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveCG"
  },
  goOn = {},
  goOff = {},
  txtBtnReceive = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_Btn_ReceiveCG"
  },
  reddotGift = {},
  goSafeArea = {
    sNodeName = "----SafeAreaRoot----"
  },
  goProgress = {},
  txtProgress = {sComponentName = "TMP_Text"},
  goReceived = {},
  txtReceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_CGReceived"
  },
  txtReceiveTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_ReceiveCGSuc"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePopup"
  },
  goComplete = {
    sNodeName = "--Complete--"
  },
  aniComplete = {
    sNodeName = "--Complete--",
    sComponentName = "Animator"
  }
}
ActivityStoryReceiveCtrl._mapEventConfig = {
  Story_Done = "OnEvent_Story_Done",
  ActivityStoryReceive_SetVisible = "OnEvent_SetVisible"
}
ActivityStoryReceiveCtrl._mapRedDotConfig = {}
local State = {
  Lock = 1,
  CanReceive = 2,
  Received = 3
}

function ActivityStoryReceiveCtrl:SetState(nState)
  self.nState = nState
  local bReceived = nState == State.Received
  self._mapNode.btnReceiveCG.gameObject:SetActive(not bReceived)
  self._mapNode.goOn:SetActive(nState == State.CanReceive)
  self._mapNode.goOff:SetActive(nState == State.Lock)
  self._mapNode.reddotGift:SetActive(nState == State.CanReceive)
  self._mapNode.goProgress:SetActive(not bReceived)
  self._mapNode.goReceived:SetActive(bReceived)
end

function ActivityStoryReceiveCtrl:SetProgress(nRead, nTotal)
  local sFormat = ConfigTable.GetUIText("StoryReview_ReadProgress") or ""
  NovaAPI.SetTMPText(self._mapNode.txtProgress, orderedFormat(sFormat, nRead or 0, nTotal or 0))
end

function ActivityStoryReceiveCtrl:RefreshState()
  local nRead, nTotal = PlayerData.StoryReview:GetChapterReadProgress(self.nChapterId)
  self:SetProgress(nRead, nTotal)
  if PlayerData.StoryReview:IsChapterReadByHandbook(self.nChapterId) then
    self:SetState(State.Received)
  elseif 0 < nTotal and nTotal <= nRead then
    self:SetState(State.CanReceive)
  else
    self:SetState(State.Lock)
  end
end

function ActivityStoryReceiveCtrl:ShowPopup()
  self._mapNode.blur:SetActive(true)
  self._mapNode.goComplete:SetActive(true)
  self._mapNode.aniComplete:Play("ActivityStoryReceivePanel_tips_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function ActivityStoryReceiveCtrl:HidePopup()
  self._mapNode.aniComplete:Play("ActivityStoryReceivePanel_tips_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.33, function()
    if self._mapNode == nil then
      return
    end
    self._mapNode.goComplete:SetActive(false)
    self._mapNode.blur:SetActive(false)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.33)
end

function ActivityStoryReceiveCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.bReview = param[2] == true
  end
  local mapCfg = ConfigTable.GetData("ActivityStoryChapter", self.nActId)
  self.nChapterId = mapCfg ~= nil and mapCfg.ChapterId or 0
end

function ActivityStoryReceiveCtrl:OnEnable()
  if not self.bReview then
    self.gameObject:SetActive(false)
    return
  end
  self._mapNode.goSafeArea:SetActive(true)
  self:RefreshState()
end

function ActivityStoryReceiveCtrl:OnDisable()
end

function ActivityStoryReceiveCtrl:OnDestroy()
end

function ActivityStoryReceiveCtrl:OnBtnClick_ReceiveCG(btn)
  if self.nState ~= State.CanReceive then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StoryReview_ReceiveLockTip"))
    return
  end
  PlayerData.StoryReview:SendChapterPass(self.nChapterId, function()
    if self._mapNode == nil then
      return
    end
    self:RefreshState()
    self:ShowPopup()
  end)
end

function ActivityStoryReceiveCtrl:OnEvent_Story_Done(bHasReward)
  if not self.bReview then
    return
  end
  self:RefreshState()
end

function ActivityStoryReceiveCtrl:OnEvent_SetVisible(bShow)
  if not self.bReview then
    return
  end
  self.bWantShow = bShow == true
  if self.bWantShow then
    self._mapNode.goSafeArea:SetActive(true)
    return
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._mapNode == nil or self.bWantShow then
      return
    end
    self._mapNode.goSafeArea:SetActive(false)
  end
  
  cs_coroutine.start(wait)
end

function ActivityStoryReceiveCtrl:OnBtnClick_ClosePopup(btn)
  self:HidePopup()
end

return ActivityStoryReceiveCtrl
