local FriendRecommendCtrl = class("FriendRecommendCtrl", BaseCtrl)
FriendRecommendCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_RecommendTitle"
  },
  srRecommend = {
    sComponentName = "LoopScrollView"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnRefresh = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Research"
  },
  txtBtnRefresh = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Refresh"
  }
}
FriendRecommendCtrl._mapEventConfig = {}

function FriendRecommendCtrl:Open(mapData)
  self:Refresh(mapData)
  self:PlayInAni()
end

function FriendRecommendCtrl:Refresh(mapData)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._panel.tbAddCache = {}
  self.tbFriendSearch = mapData
  local nNum = #self.tbFriendSearch
  self._mapNode.srRecommend:Init(nNum, self, self.OnGridRefresh)
end

function FriendRecommendCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapFriend = self.tbFriendSearch[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.FriendEx.FriendGridCtrl")
    self.tbGridCtrl[nInstanceID]:SetType(3)
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapFriend)
end

function FriendRecommendCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendRecommendCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendRecommendCtrl:Close()
  self.gameObject:SetActive(false)
  EventManager.Hit("FriendClearSearch")
end

function FriendRecommendCtrl:SetTimer()
  self.bCd = true
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  self.timer = self:AddTimer(1, 5, function()
    self.bCd = false
  end, true, true, false)
end

function FriendRecommendCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.tbGridCtrl = {}
end

function FriendRecommendCtrl:OnEnable()
end

function FriendRecommendCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function FriendRecommendCtrl:OnDestroy()
end

function FriendRecommendCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendRecommendCtrl:OnBtnClick_Research(btn)
  if self.bCd then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_RefreshLimit"))
    return
  end
  
  local function callback(mapData)
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      bPositive = true,
      sContent = ConfigTable.GetUIText("Friend_RefreshSuc")
    })
    self:Refresh(mapData)
    self:SetTimer()
  end
  
  PlayerData.Friend:SendFriendRecommendationGetReq(callback)
end

return FriendRecommendCtrl
