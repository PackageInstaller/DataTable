local DormRoomSelectCtrl = class("DormRoomSelectCtrl", BaseCtrl)
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
DormRoomSelectCtrl._mapNodeConfig = {
  snapshot = {},
  CharListRoot = {},
  svRoomList = {
    sComponentName = "LoopScrollView"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  }
}
DormRoomSelectCtrl._mapEventConfig = {
  DormRoomSelect_ChangeRoom = "OnEvent_ChangeRoom",
  [EventId.UIBackConfirm] = "OnEvent_Back"
}
DormRoomSelectCtrl._mapRedDotConfig = {}

function DormRoomSelectCtrl:Awake()
end

function DormRoomSelectCtrl:FadeIn()
end

function DormRoomSelectCtrl:FadeOut()
end

function DormRoomSelectCtrl:OnEnable()
  DormGuideUI.BindOverlay("roomSelect", self)
  
  local function wait()
    self._mapNode.CharListRoot.gameObject:SetActive(false)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot.gameObject)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.CharListRoot.gameObject:SetActive(true)
    local tbParam = self:GetPanelParam()
    local mapRoom = tbParam[1]
    local nCurRoomId = tbParam[2]
    self.bElevator = tbParam[3]
    self.bFriend = tbParam[4]
    self.tbAllRoom = {}
    self.mapGridCtrl = {}
    
    local function forEachRoom(mapData)
      table.insert(self.tbAllRoom, mapData)
    end
    
    ForEachTableLine(DataTable.DormRoom, forEachRoom)
    
    local function sort(a, b)
      return a.Id < b.Id
    end
    
    table.sort(self.tbAllRoom, sort)
    self.tbNewRoom = PlayerData.PlayerDormData:GetNewRoom()
    self.mapRoomData = mapRoom
    self.nCurRoomId = nCurRoomId
    self._mapNode.svRoomList:SetAnim(0.08)
    local nSum = #self.tbAllRoom >= 6 and 0 or 1
    self._mapNode.svRoomList:Init(#self.tbAllRoom + nSum, self, self.OnGridRefresh)
  end
  
  cs_coroutine.start(wait)
end

function DormRoomSelectCtrl:IsRoomAvailable(nRoomId)
  return self.mapRoomData ~= nil and self.mapRoomData[nRoomId] ~= nil
end

function DormRoomSelectCtrl:OnDisable()
  DormGuideUI.UnbindOverlay("roomSelect", self)
  for nInstanceId, objCtrl in pairs(self.mapGridCtrl or {}) do
    self:UnbindCtrlByNode(objCtrl)
  end
  self.mapGridCtrl = {}
end

function DormRoomSelectCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapRoomCfgData = self.tbAllRoom[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.mapGridCtrl[nInstanceID] then
    self.mapGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormRoomSelectPanel.DormRoomGridCtrl")
  end
  if mapRoomCfgData == nil then
    self.mapGridCtrl[nInstanceID]:Refresh(0, 0, "", false, false, self.bFriend)
    return
  end
  local mapRoomData = self.mapRoomData[mapRoomCfgData.Id]
  local bAvailable = mapRoomData ~= nil
  local bCurRoom = mapRoomCfgData.Id == self.nCurRoomId
  local nSceneId = mapRoomData == nil and 0 or mapRoomData.RoomScene
  if nSceneId == 0 then
    nSceneId = mapRoomCfgData.SceneRes
  end
  local sRoomName = mapRoomData == nil or mapRoomData.RoomName == nil or mapRoomData.RoomName == "" and mapRoomCfgData.DefaultName or mapRoomData.RoomName
  self.mapGridCtrl[nInstanceID]:Refresh(mapRoomCfgData.Id, nSceneId, sRoomName, bAvailable, bCurRoom, self.bFriend)
  local nIdx = table.indexof(self.tbNewRoom, mapRoomCfgData.Id)
  local bNewRoom = 0 < nIdx
  if bNewRoom then
    table.remove(self.tbNewRoom, nIdx)
    self.mapGridCtrl[nInstanceID]:PlayAnim()
  elseif self.mapGridCtrl[nInstanceID].nUnlockAnimRoomId ~= mapRoomCfgData.Id then
    EventManager.Hit("DormRoomSelect_UnlockAnimEnd", mapRoomCfgData.Id)
  end
end

function DormRoomSelectCtrl:OnDestroy()
end

function DormRoomSelectCtrl:OnRelease()
end

function DormRoomSelectCtrl:OnEvent_ChangeRoom(nRoomId)
  EventManager.Hit(EventId.ClosePanel, PanelId.DormRoomSelectPanel)
  EventManager.Hit("DormRoomSelect_ChangeRoomResult", true, nRoomId, self.bElevator)
end

function DormRoomSelectCtrl:OnEvent_Back()
  EventManager.Hit(EventId.ClosePanel, PanelId.DormRoomSelectPanel)
  EventManager.Hit("DormRoomSelect_ChangeRoomResult", false, 0, self.bElevator)
end

return DormRoomSelectCtrl
