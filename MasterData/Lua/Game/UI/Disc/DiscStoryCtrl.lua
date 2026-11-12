local DiscStoryCtrl = class("DiscStoryCtrl", BaseCtrl)
DiscStoryCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_story"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_story",
    sComponentName = "Animator"
  },
  btnClose = {
    sNodeName = "snapshot_story",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  aniRoot = {sNodeName = "StoryRoot", sComponentName = "Animator"},
  btnRead = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Read"
  },
  txtStory = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtStoryName = {sComponentName = "TMP_Text"},
  btn_CloseStory = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtBtnCloseStory = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  sv = {sComponentName = "ScrollRect"}
}
DiscStoryCtrl._mapEventConfig = {OpenDiscStory = "Open"}

function DiscStoryCtrl:Open(mapDisc, mapCfg)
  self._mapNode.blur:SetActive(true)
  self._mapNode.btnRead.gameObject:SetActive(mapDisc.bRead == false)
  NovaAPI.SetText_RubyTMP(self._mapNode.txtStory, mapCfg.StoryDesc)
  NovaAPI.SetTMPText(self._mapNode.txtStoryName, mapCfg.StoryName)
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.sv, 1)
  self:PlayInAni()
end

function DiscStoryCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.aniRoot:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DiscStoryCtrl:PlayOutAni()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self._mapNode.aniRoot:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function DiscStoryCtrl:Close()
  self.gameObject:SetActive(false)
end

function DiscStoryCtrl:Awake()
end

function DiscStoryCtrl:OnEnable()
end

function DiscStoryCtrl:OnDisable()
end

function DiscStoryCtrl:OnDestroy()
end

function DiscStoryCtrl:OnBtnClick_Read()
  local function callback()
    self._mapNode.btnRead.gameObject:SetActive(false)
  end
  
  PlayerData.Disc:SendDiscReadRewardReceiveReq(self._panel.nId, AllEnum.DiscReadType.DiscStory, callback)
end

function DiscStoryCtrl:OnBtnClick_Close(btn)
  self:PlayOutAni()
end

return DiscStoryCtrl
