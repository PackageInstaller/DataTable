local FriendSearchCtrl = class("FriendSearchCtrl", BaseCtrl)
FriendSearchCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_SearchTitle"
  },
  srSearchList = {
    sComponentName = "LoopScrollView"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  }
}
FriendSearchCtrl._mapEventConfig = {}

function FriendSearchCtrl:Open(mapData)
  self:Refresh(mapData)
  self:PlayInAni()
end

function FriendSearchCtrl:Refresh(mapData)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._panel.tbAddCache = {}
  self.tbFriendSearch = mapData
  local nNum = #self.tbFriendSearch
  self._mapNode.srSearchList:Init(nNum, self, self.OnGridRefresh)
end

function FriendSearchCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapFriend = self.tbFriendSearch[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.FriendEx.FriendGridCtrl")
    self.tbGridCtrl[nInstanceID]:SetType(3)
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapFriend)
end

function FriendSearchCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendSearchCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendSearchCtrl:Close()
  self.gameObject:SetActive(false)
  EventManager.Hit("FriendClearSearch")
end

function FriendSearchCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.tbGridCtrl = {}
end

function FriendSearchCtrl:OnEnable()
end

function FriendSearchCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function FriendSearchCtrl:OnDestroy()
end

function FriendSearchCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

return FriendSearchCtrl
