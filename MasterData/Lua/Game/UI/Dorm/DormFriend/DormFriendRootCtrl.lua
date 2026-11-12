local DormFriendRootCtrl = class("DormFriendRootCtrl", BaseCtrl)
DormFriendRootCtrl._mapNodeConfig = {
  imgHead = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtNameDorm = {sComponentName = "TMP_Text"},
  goHonor = {
    sNodeName = "goHonorTitle_",
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  btnHome = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DormBackHome"
  },
  btnFriendRootVisit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Friend"
  },
  btnCharacter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Elevator"
  },
  iconLike = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_LikeIcon"
  },
  btnLike = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Like"
  },
  TMPLikeCount = {sComponentName = "TMP_Text"},
  TMPiconLike = {sComponentName = "TMP_Text"},
  btnHideUIFriend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HideUI"
  },
  rtContact = {
    sCtrlName = "Game.UI.Dorm.DormContact.DormContactBtnListCtrl"
  },
  goJoystick = {
    sNodeName = "--joystick--"
  },
  txtBtnHome = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_friendRoot_GoHome"
  },
  txtBtnFriendRootVisit = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_FriendRoot_Visit"
  },
  txtBtnCharacter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_FriendRoot_Elevator"
  }
}
DormFriendRootCtrl._mapEventConfig = {
  ACTIVE_DORM_INTERACTIVE_HUD = "OnEvent_ActiveHud",
  DEACTIVE_DORM_INTERACTIVE_HUD = "OnEvent_DeactiveHud"
}
DormFriendRootCtrl._mapRedDotConfig = {}

function DormFriendRootCtrl:Awake()
end

function DormFriendRootCtrl:FadeIn()
end

function DormFriendRootCtrl:FadeOut()
end

function DormFriendRootCtrl:OnEnable()
end

function DormFriendRootCtrl:OnDisable()
end

function DormFriendRootCtrl:OnDestroy()
end

function DormFriendRootCtrl:OnRelease()
end

function DormFriendRootCtrl:Refresh(mapFriendDormDetail, mapFriendDetail)
  self.mapFriendDormDetail = mapFriendDormDetail
  self.mapFriendDetail = mapFriendDetail
  local mapCfg = ConfigTable.GetData("PlayerHead", mapFriendDetail.nHeadIconId)
  if mapCfg then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapFriendDetail.sName)
  local nLevel = PlayerData.PlayerDormData:GetHonorTitleLevel(self.mapFriendDormDetail.CollectionValue)
  self._mapNode.goHonor[1].gameObject:SetActive(true)
  self._mapNode.goHonor[1]:SetHonotTitle(140001, true, nLevel)
  self._mapNode.goHonor[2].gameObject:SetActive(false)
  self._mapNode.goHonor[3].gameObject:SetActive(false)
  local sDormName = (mapFriendDormDetail.DormName == nil or mapFriendDormDetail.DormName == "") and ConfigTable.GetUIText("Dorm_DefaultName") or mapFriendDormDetail.DormName
  NovaAPI.SetTMPText(self._mapNode.txtNameDorm, sDormName)
  self._mapNode.btnLike.gameObject:SetActive(not mapFriendDormDetail.IsLike)
  self._mapNode.iconLike.gameObject:SetActive(mapFriendDormDetail.IsLike)
  NovaAPI.SetTMPText(self._mapNode.TMPLikeCount, mapFriendDormDetail.LikeNum)
  NovaAPI.SetTMPText(self._mapNode.TMPiconLike, mapFriendDormDetail.LikeNum)
  self._mapNode.rtContact:RemoveAllInteractiveBtn()
end

function DormFriendRootCtrl:RegisterVirtualJoystick()
  NovaAPI.UnRegisterVirtualJoystick("Horizontal", "Vertical")
  NovaAPI.RegisterVirtualJoystick("Horizontal", "Vertical", self._mapNode.goJoystick)
end

function DormFriendRootCtrl:OnEvent_ActiveHud(rtTransform, nType, nDataId, nEntityId, canInteract)
  if self._panel.nCurMode ~= 3 then
    return
  end
  if nType == 1 and canInteract then
    self._mapNode.rtContact:AddInteractiveBtn(rtTransform, nType, nDataId, nEntityId)
  end
end

function DormFriendRootCtrl:OnEvent_DeactiveHud(nEntityId, nType)
  if self._panel.nCurMode ~= 3 then
    return
  end
  self._mapNode.rtContact:RemoveInteractiveBtn(nEntityId)
end

function DormFriendRootCtrl:OnBtnClick_Like()
  local function callback()
    self._mapNode.btnLike.gameObject:SetActive(false)
    
    self._mapNode.iconLike.gameObject:SetActive(true)
    self.mapFriendDormDetail.LikeNum = self.mapFriendDormDetail.LikeNum + 1
    NovaAPI.SetTMPText(self._mapNode.TMPLikeCount, self.mapFriendDormDetail.LikeNum)
    NovaAPI.SetTMPText(self._mapNode.TMPiconLike, self.mapFriendDormDetail.LikeNum)
  end
  
  PlayerData.PlayerDormData:DormFriendLike(self.mapFriendDormDetail.uid, callback)
end

function DormFriendRootCtrl:OnBtnClick_LikeIcon()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DormTips_LikeForToday"))
end

function DormFriendRootCtrl:OnBtnClick_DormBackHome()
  EventManager.Hit("DormBackHome")
end

function DormFriendRootCtrl:OnBtnClick_Elevator()
  EventManager.Hit("DormPanel_NextRoom")
end

function DormFriendRootCtrl:OnBtnClick_Friend()
  EventManager.Hit(EventId.OpenPanel, PanelId.DormFriendPanel)
end

function DormFriendRootCtrl:OnBtnClick_HideUI()
  EventManager.Hit("Dorm_HideUI")
end

return DormFriendRootCtrl
