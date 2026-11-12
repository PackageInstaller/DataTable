local DormFriendCtrl = class("DormFriendCtrl", BaseCtrl)
DormFriendCtrl._mapNodeConfig = {
  srSearchList = {
    sComponentName = "LoopScrollView"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  TMPEmptyHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormFriend_EmptyHint"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Friend_PanelTitle"
  },
  Animator = {
    sNodeName = "---Friend---",
    sComponentName = "Animator"
  },
  goEmpty = {},
  goContent = {
    sNodeName = "---Friend---"
  }
}
DormFriendCtrl._mapEventConfig = {
  DormFriendLikeSuc = "OnEvent_DormFriendLikeSuc",
  DormGridVisitFriendRoomClick = "OnEvent_DormGridVisitFriendRoomClick"
}
DormFriendCtrl._mapRedDotConfig = {}

function DormFriendCtrl:Awake()
end

function DormFriendCtrl:FadeIn()
end

function DormFriendCtrl:FadeOut()
end

function DormFriendCtrl:OnEnable()
  self.mapFriendDormDetailData = nil
  self.mapFriendDetailData = {}
  self.tbActiveUID = {}
  self.mapGrid = {}
  self._mapNode.srSearchList.gameObject:SetActive(false)
  self._mapNode.goEmpty:SetActive(false)
  
  local function wait()
    self._mapNode.goContent.gameObject:SetActive(false)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot.gameObject)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goContent.gameObject:SetActive(true)
    self._mapNode.Animator:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  
  local function GeFriendDormDataCallback(mapFriendDetailData)
    self.mapFriendDormDetailData = mapFriendDetailData
    self:Refresh()
  end
  
  local function GetFriendcallback()
    local tbFriendDetailData = PlayerData.Friend:GetFriendListData()
    for _, mapFriendDetailData in ipairs(tbFriendDetailData) do
      self.mapFriendDetailData[mapFriendDetailData.nUId] = mapFriendDetailData
    end
    PlayerData.PlayerDormData:DormGetFriendList(GeFriendDormDataCallback)
  end
  
  PlayerData.Friend:SendFriendListGetReq(GetFriendcallback)
  NovaAPI.DispatchEventWithData("DORM_LUA_SET_UI_HIDDEN", nil, {61})
end

function DormFriendCtrl:OnFriendGridRefresh(goGrid, nIdx)
  nIdx = nIdx + 1
  local nUid = self.tbActiveUID[nIdx]
  local instanceId = goGrid:GetInstanceID()
  if self.mapGrid[instanceId] == nil then
    self.mapGrid[instanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormFriend.DormFriendGridCtrl")
  end
  self.mapGrid[instanceId]:Refresh(self.mapFriendDormDetailData[nUid], self.mapFriendDetailData[nUid])
end

function DormFriendCtrl:Refresh()
  for nUid, mapFriendDetailData in pairs(self.mapFriendDetailData) do
    if self.mapFriendDormDetailData[nUid] ~= nil then
      table.insert(self.tbActiveUID, mapFriendDetailData.nUId)
    end
  end
  if #self.tbActiveUID > 0 then
    self._mapNode.srSearchList.gameObject:SetActive(true)
    self._mapNode.goEmpty:SetActive(false)
    self._mapNode.srSearchList:Init(#self.tbActiveUID, self, self.OnFriendGridRefresh)
  else
    self._mapNode.srSearchList.gameObject:SetActive(false)
    self._mapNode.goEmpty:SetActive(true)
  end
end

function DormFriendCtrl:OnDisable()
  for nInstanceId, mapCtrl in pairs(self.mapGrid) do
    self:UnbindCtrlByNode(mapCtrl)
    self.mapGrid[nInstanceId] = nil
  end
  self.mapGrid = {}
  NovaAPI.DispatchEventWithData("DORM_LUA_SET_UI_HIDDEN", nil, {0})
end

function DormFriendCtrl:OnDestroy()
end

function DormFriendCtrl:OnRelease()
end

function DormFriendCtrl:OnBtn_ClickClose()
  self._mapNode.Animator:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.DormFriendPanel)
  end, true, true, true, nil)
end

function DormFriendCtrl:OnEvent_DormFriendLikeSuc(nUid)
end

function DormFriendCtrl:OnEvent_DormGridVisitFriendRoomClick(nUid)
  EventManager.Hit(EventId.ClosePanel, PanelId.DormFriendPanel)
  EventManager.Hit("DormVisitFriendRoom", nUid, 701001)
end

return DormFriendCtrl
