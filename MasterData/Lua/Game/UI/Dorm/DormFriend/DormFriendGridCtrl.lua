local DormFriendGridCtrl = class("DormFriendGridCtrl", BaseCtrl)
DormFriendGridCtrl._mapNodeConfig = {
  btnLike = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Like"
  },
  iconLike = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_iconLike"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtNameDorm = {sComponentName = "TMP_Text"},
  TMPLikeCount = {sComponentName = "TMP_Text"},
  TMPiconLike = {sComponentName = "TMP_Text"},
  goHonor = {
    sNodeName = "goHonorTitle_",
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  btnVisit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Visit"
  },
  imgHead = {sComponentName = "Image"},
  TMPBtnVisit = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_Visit"
  }
}
DormFriendGridCtrl._mapEventConfig = {}
DormFriendGridCtrl._mapRedDotConfig = {}

function DormFriendGridCtrl:Awake()
end

function DormFriendGridCtrl:FadeIn()
end

function DormFriendGridCtrl:FadeOut()
end

function DormFriendGridCtrl:OnEnable()
end

function DormFriendGridCtrl:OnDisable()
end

function DormFriendGridCtrl:OnDestroy()
end

function DormFriendGridCtrl:OnRelease()
end

function DormFriendGridCtrl:Refresh(mapFriendDormDetail, mapFriendDetail)
  self.mapFriendDormDetail = mapFriendDormDetail
  self.mapFriendDetail = mapFriendDetail
  local mapCfg = ConfigTable.GetData("PlayerHead", mapFriendDetail.nHeadIconId)
  if mapCfg then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapFriendDetail.sName)
  local tbHonorTitle = mapFriendDetail.tbHonorTitle or {}
  local nLevel = PlayerData.PlayerDormData:GetHonorTitleLevel(self.mapFriendDormDetail.CollectionValue)
  self._mapNode.goHonor[1].gameObject:SetActive(true)
  self._mapNode.goHonor[1]:SetHonotTitle(140001, true, nLevel)
  local sDormName = (mapFriendDormDetail.DormName == nil or mapFriendDormDetail.DormName == "") and ConfigTable.GetUIText("Dorm_DefaultName") or mapFriendDormDetail.DormName
  NovaAPI.SetTMPText(self._mapNode.txtNameDorm, sDormName)
  self._mapNode.btnLike.gameObject:SetActive(not mapFriendDormDetail.IsLike)
  self._mapNode.iconLike.gameObject:SetActive(mapFriendDormDetail.IsLike)
  NovaAPI.SetTMPText(self._mapNode.TMPLikeCount, mapFriendDormDetail.LikeNum)
  NovaAPI.SetTMPText(self._mapNode.TMPiconLike, mapFriendDormDetail.LikeNum)
end

function DormFriendGridCtrl:OnBtnClick_Like()
  local function callback()
    self._mapNode.btnLike.gameObject:SetActive(false)
    
    self._mapNode.iconLike.gameObject:SetActive(true)
    self.mapFriendDormDetail.LikeNum = self.mapFriendDormDetail.LikeNum + 1
    NovaAPI.SetTMPText(self._mapNode.TMPLikeCount, self.mapFriendDormDetail.LikeNum)
    NovaAPI.SetTMPText(self._mapNode.TMPiconLike, self.mapFriendDormDetail.LikeNum)
  end
  
  PlayerData.PlayerDormData:DormFriendLike(self.mapFriendDormDetail.uid, callback)
end

function DormFriendGridCtrl:OnBtnClick_iconLike()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DormTips_LikeForToday"))
end

function DormFriendGridCtrl:OnBtnClick_Visit()
  EventManager.Hit("DormGridVisitFriendRoomClick", self.mapFriendDormDetail.uid)
end

return DormFriendGridCtrl
