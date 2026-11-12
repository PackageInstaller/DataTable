local FriendCarteCtrl = class("FriendCarteCtrl", BaseCtrl)
FriendCarteCtrl._mapNodeConfig = {
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
    sLanguageId = "Friend_Title_Carte"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goRoot = {
    sNodeName = "---Carte---"
  },
  aniRoot = {
    sNodeName = "---Carte---",
    sComponentName = "Animator"
  },
  imgPlayerHead = {sComponentName = "Image"},
  txtWorldClass = {sComponentName = "TMP_Text"},
  txtRankCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtFriendTitle = {sComponentName = "TMP_Text"},
  txtFriendTitleName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_TitleTag"
  },
  txtUIDCn = {sComponentName = "TMP_Text", sLanguageId = "Friend_UID"},
  txtUID = {sComponentName = "TMP_Text"},
  txtSign = {sComponentName = "TMP_Text"},
  txtTitleChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_CoreMember"
  },
  goChar = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  imgEmpty = {nCount = 3},
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  txtBtnAdd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Add"
  },
  btnDel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Del"
  },
  txtBtnDel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Del"
  },
  btnDone = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Done"
  },
  txtBtnDone = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_HasRequested"
  },
  goHonorTitle = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  }
}
FriendCarteCtrl._mapEventConfig = {}

function FriendCarteCtrl:Open()
  self:RefreshButton()
  self:RefreshInfo()
  self:RefreshMember()
  self:RefreshHonorTitle()
  self:PlayInAni()
end

function FriendCarteCtrl:RefreshButton()
  local bFriend = PlayerData.Friend:JudgeIsFriend(self.mapFriend.nUId)
  if bFriend then
    self._mapNode.btnAdd.gameObject:SetActive(false)
    self._mapNode.btnDone.gameObject:SetActive(false)
    self._mapNode.btnDel.gameObject:SetActive(true)
  else
    self._mapNode.btnAdd.gameObject:SetActive(self.bDone == false and self.nType == 3 or self.nType == 2)
    self._mapNode.btnDone.gameObject:SetActive(self.bDone == true)
    self._mapNode.btnDel.gameObject:SetActive(false)
  end
end

function FriendCarteCtrl:RefreshInfo()
  local mapCfg = ConfigTable.GetData("PlayerHead", self.mapFriend.nHeadIconId)
  if mapCfg then
    self:SetPngSprite(self._mapNode.imgPlayerHead, mapCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtWorldClass, self.mapFriend.nWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapFriend.sName)
  local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", self.mapFriend.nTitlePrefix).Desc, ConfigTable.GetData("Title", self.mapFriend.nTitleSuffix).Desc)
  NovaAPI.SetTMPText(self._mapNode.txtFriendTitle, self.mapFriend.nTitlePrefix == 0 and "" or sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtUID, self.mapFriend.nUId)
  NovaAPI.SetTMPText(self._mapNode.txtSign, self.mapFriend.sSign == "" and ConfigTable.GetUIText("Friend_DefaultSign") or self.mapFriend.sSign)
end

function FriendCarteCtrl:RefreshMember()
  local tbChar = {}
  if self.mapFriend.tbChar then
    for i = 1, 3 do
      if not self.mapFriend.tbChar[i] then
        tbChar[i] = {CharId = 0}
      else
        tbChar[i] = self.mapFriend.tbChar[i]
      end
    end
  end
  for i = 1, 3 do
    self._mapNode.imgEmpty[i]:SetActive(tbChar[i].CharId == 0)
    self._mapNode.goChar[i].gameObject:SetActive(tbChar[i].CharId ~= 0)
    if tbChar[i].CharId ~= 0 then
      self._mapNode.goChar[i]:SetSpecificChar(tbChar[i].CharId, tbChar[i].Level, tbChar[i].Skin)
    end
  end
end

function FriendCarteCtrl:RefreshHonorTitle()
  for i = 1, 3 do
    local tbHonorTitle = self.mapFriend.tbHonorTitle or {}
    if tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0 then
      local honorData = ConfigTable.GetData("Honor", tbHonorTitle[i].Id)
      self._mapNode.goHonorTitle[i]:SetHonotTitle(honorData.Id, i == 1, tbHonorTitle[i].AffinityLV)
    end
    self._mapNode.goHonorTitle[i].gameObject:SetActive(tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0)
  end
end

function FriendCarteCtrl:PlayInAni()
  self._mapNode.goRoot:SetActive(true)
  self._mapNode.aniRoot:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendCarteCtrl:PlayOutAni()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.aniRoot:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    self._mapNode.goRoot:SetActive(false)
  end, true, true, true)
end

function FriendCarteCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapFriend = tbParam[1]
    self.nType = tbParam[2]
    self.bDone = tbParam[3]
    self.callback = tbParam[4]
  end
end

function FriendCarteCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  self:Open()
end

function FriendCarteCtrl:OnDisable()
end

function FriendCarteCtrl:OnDestroy()
end

function FriendCarteCtrl:OnBtnClick_Add()
  local nFriendNum = PlayerData.Friend:GetFriendListNum()
  if nFriendNum == ConfigTable.GetConfigNumber("FriendMax") then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_00"))
    return
  end
  if self.nType == 2 then
    local function callback()
      self:OnBtnClick_Close()
      
      EventManager.Hit("FriendRefreshRequest")
    end
    
    PlayerData.Friend:SendFriendAddAgreeReq(self.mapFriend.nUId, callback)
  elseif self.nType == 3 then
    local function callback()
      self.callback()
      
      self._mapNode.btnAdd.gameObject:SetActive(false)
      self._mapNode.btnDone.gameObject:SetActive(true)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_01"))
    end
    
    PlayerData.Friend:SendAddFriendReq(self.mapFriend.nUId, callback)
  end
end

function FriendCarteCtrl:OnBtnClick_Del()
  local function confirmCallback()
    local function callback()
      self:OnBtnClick_Close()
      
      EventManager.Hit("FriendRefreshList")
    end
    
    PlayerData.Friend:SendFriendDeleteReq(self.mapFriend.nUId, callback)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Friend_DeleteHint"),
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function FriendCarteCtrl:OnBtnClick_Done()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_GraySend"))
end

function FriendCarteCtrl:OnBtnClick_Close()
  self:PlayOutAni()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
    EventManager.Hit(EventId.ClosePanel, PanelId.FriendCarte)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

return FriendCarteCtrl
