local FriendAddStrangerCtrl = class("FriendAddStrangerCtrl", BaseCtrl)
FriendAddStrangerCtrl._mapNodeConfig = {
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
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goRoot = {sNodeName = "window"},
  aniRoot = {sNodeName = "window", sComponentName = "Animator"},
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  btnAgain = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Again"
  },
  againSelect = {},
  texAgainTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_LoginWarning"
  },
  txtAddTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_AddStranger"
  },
  imgHead = {sComponentName = "Image"},
  txtWorldClass = {sComponentName = "TMP_Text"},
  txtRankCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtTitle = {sComponentName = "TMP_Text"},
  txtTitleName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_TitleTag"
  },
  goHonorTitle_ = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  }
}
FriendAddStrangerCtrl._mapEventConfig = {}

function FriendAddStrangerCtrl:Open()
  self:RefreshInfo()
  self:RefreshHonorTitle()
  self:PlayInAni()
  self._mapNode.againSelect:SetActive(self.bClickAgain)
end

function FriendAddStrangerCtrl:RefreshInfo()
  local mapCfg = ConfigTable.GetData("PlayerHead", self.mapFriend.nHeadIconId)
  if mapCfg then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtWorldClass, self.mapFriend.nWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapFriend.sName)
  local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", self.mapFriend.nTitlePrefix).Desc, ConfigTable.GetData("Title", self.mapFriend.nTitleSuffix).Desc)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, self.mapFriend.nTitlePrefix == 0 and "" or sTitle)
end

function FriendAddStrangerCtrl:RefreshHonorTitle()
  for i = 1, 3 do
    local tbHonorTitle = self.mapFriend.tbHonorTitle or {}
    if tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0 then
      local honorData = ConfigTable.GetData("Honor", tbHonorTitle[i].Id)
      self._mapNode.goHonorTitle_[i]:SetHonotTitle(honorData.Id, i == 1, tbHonorTitle[i].AffinityLV)
    end
    self._mapNode.goHonorTitle_[i].gameObject:SetActive(tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0)
  end
end

function FriendAddStrangerCtrl:PlayInAni()
  self._mapNode.goRoot:SetActive(true)
  self._mapNode.aniRoot:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendAddStrangerCtrl:PlayOutAni()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.aniRoot:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    self._mapNode.goRoot:SetActive(false)
  end, true, true, true)
end

function FriendAddStrangerCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapFriend = tbParam[1]
  end
  self.bClickAgain = false
end

function FriendAddStrangerCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  self:Open()
end

function FriendAddStrangerCtrl:OnDisable()
end

function FriendAddStrangerCtrl:OnDestroy()
end

function FriendAddStrangerCtrl:OnBtnClick_Confirm()
  local nFriendNum = PlayerData.Friend:GetFriendListNum()
  if nFriendNum == ConfigTable.GetConfigNumber("FriendMax") then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_00"))
    return
  end
  
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_01"))
    self:OnBtnClick_Close()
  end
  
  PlayerData.Friend:SendAddFriendReq(self.mapFriend.nUId, callback)
end

function FriendAddStrangerCtrl:OnBtnClick_Close()
  self:PlayOutAni()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
    EventManager.Hit(EventId.ClosePanel, PanelId.FriendAddStranger)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function FriendAddStrangerCtrl:OnBtnClick_Again()
  self.bClickAgain = not self.bClickAgain
  self._mapNode.againSelect:SetActive(self.bClickAgain)
  PlayerData.Friend:SetAddStrangerWarning(not self.bClickAgain)
end

return FriendAddStrangerCtrl
