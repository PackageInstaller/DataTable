local DormRoomGridCtrl = class("DormRoomGridCtrl", BaseCtrl)
DormRoomGridCtrl._mapNodeConfig = {
  imgRoomIcon = {sComponentName = "Image"},
  imgCurMark = {},
  imgRoomempty = {},
  imgNameBg = {},
  imgLock = {},
  TMPRoomName = {sComponentName = "TMP_Text"},
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Go"
  },
  TMPRoomNotAvailable = {sComponentName = "TMP_Text"},
  txtBtnGoGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Go"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  btnGoGray = {sComponentName = "UIButton"},
  AnimRoot = {
    sNodeName = "AnimRootTop",
    sComponentName = "Animator"
  }
}
DormRoomGridCtrl._mapEventConfig = {}
DormRoomGridCtrl._mapRedDotConfig = {}

function DormRoomGridCtrl:Awake()
  self.nRoomId = 0
end

function DormRoomGridCtrl:FadeIn()
end

function DormRoomGridCtrl:FadeOut()
end

function DormRoomGridCtrl:OnEnable()
end

function DormRoomGridCtrl:OnDisable()
end

function DormRoomGridCtrl:OnDestroy()
end

function DormRoomGridCtrl:OnRelease()
end

function DormRoomGridCtrl:Refresh(nRoomId, nSceneId, sRoomName, bAvailable, bCurRoom, bFriend)
  self._mapNode.imgCurMark:SetActive(bCurRoom)
  self._mapNode.imgLock:SetActive(not bAvailable)
  self._mapNode.imgRoomIcon.gameObject:SetActive(bAvailable)
  self._mapNode.imgRoomempty:SetActive(false)
  self.nRoomId = nRoomId
  if nRoomId == 0 then
    self._mapNode.imgLock:SetActive(false)
    self._mapNode.imgRoomempty:SetActive(true)
    self._mapNode.imgRoomIcon.gameObject:SetActive(false)
    self._mapNode.imgNameBg:SetActive(false)
    self._mapNode.btnGo.gameObject:SetActive(false)
    self._mapNode.btnGoGray.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPRoomNotAvailable, ConfigTable.GetUIText("Dorm_RoomNotAvailable"))
    return
  end
  if bFriend then
    NovaAPI.SetTMPText(self._mapNode.TMPRoomNotAvailable, ConfigTable.GetUIText("Dorm_RoomNotOpen"))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPRoomNotAvailable, ConfigTable.GetUIText("Dorm_RoomNotAvailable_Lock"))
  end
  if bAvailable then
    NovaAPI.SetTMPText(self._mapNode.TMPRoomName, sRoomName)
    self._mapNode.imgNameBg:SetActive(true)
    self._mapNode.TMPRoomNotAvailable.gameObject:SetActive(false)
  else
    self._mapNode.imgNameBg:SetActive(false)
    self._mapNode.TMPRoomNotAvailable.gameObject:SetActive(true)
  end
  local mapSceneCfgData = ConfigTable.GetData("DormRoomScene", nSceneId)
  if mapSceneCfgData ~= nil then
    self:SetPngSprite(self._mapNode.imgRoomIcon, mapSceneCfgData.IconRes)
  else
  end
  self._mapNode.btnGo.gameObject:SetActive(bAvailable and not bCurRoom)
  self._mapNode.btnGoGray.gameObject:SetActive(bAvailable and bCurRoom)
end

function DormRoomGridCtrl:PlayAnim()
  self.nUnlockAnimRoomId = self.nRoomId
  self._mapNode.AnimRoot:Play("DormRoomSelectLock", 0, 0)
  self:SetAnimationCallback(self._mapNode.AnimRoot, "OnUnlockAnimEnd")
end

function DormRoomGridCtrl:OnUnlockAnimEnd()
  local nRoomId = self.nUnlockAnimRoomId or self.nRoomId
  self.nUnlockAnimRoomId = nil
  EventManager.Hit("DormRoomSelect_UnlockAnimEnd", nRoomId)
end

function DormRoomGridCtrl:OnBtnClick_Go(btn)
  EventManager.Hit("DormRoomSelect_ChangeRoom", self.nRoomId)
end

return DormRoomGridCtrl
