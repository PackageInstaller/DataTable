local DormInteractiveCtrl = class("DormInteractiveCtrl", BaseCtrl)
DormInteractiveCtrl._mapNodeConfig = {
  rtObserve = {},
  rtOperate = {},
  rtDormLevelRoot = {},
  TMPCharCountTitle = {sComponentName = "TMP_Text"},
  btnSelectChar = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectChar"
  },
  txtDormName = {sComponentName = "TMP_Text"},
  btnFullScene = {sComponentName = "UIButton"},
  btnEditMode = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EditMode"
  },
  btnOperate = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Operate"
  },
  btnObserve = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Observe"
  },
  btnNextRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextRoom"
  },
  rtListHideRoot = {},
  rtContact = {
    sCtrlName = "Game.UI.Dorm.DormContact.DormContactBtnListCtrl"
  },
  rtHudPool = {},
  rtHud = {},
  goCharHud = {}
}
DormInteractiveCtrl._mapEventConfig = {
  ACTIVE_DORM_INTERACTIVE_HUD = "OnEvent_ActiveHud",
  DEACTIVE_DORM_INTERACTIVE_HUD = "OnEvent_DeactiveHud",
  DORM_CS2LUA_CLOSE_INTERACTIVE_ICON = "OnEvent_CloseContactHud",
  DormCharSelectResult = "OnEvent_DormCharSelectResult",
  DormContactBtnClick = "OnEvent_DormContactBtnClick"
}
DormInteractiveCtrl._mapRedDotConfig = {}

function DormInteractiveCtrl:Awake()
end

function DormInteractiveCtrl:FadeIn()
end

function DormInteractiveCtrl:FadeOut()
end

function DormInteractiveCtrl:OnEnable()
  self.mapHudCtrls = {}
  self.tbHudPool = {}
  self.gameObject:SetActive(true)
  if NovaAPI.GetCurrentModuleName() == "DormModuleScene" then
    NovaAPI.DispatchEventWithData("DormJoystickPrefabLoadComplete")
  end
end

function DormInteractiveCtrl:OnDisable()
end

function DormInteractiveCtrl:OnDestroy()
  self:RemoveAllHUD()
end

function DormInteractiveCtrl:OnRelease()
end

function DormInteractiveCtrl:RemoveAllHUD()
  for _, mapCtrl in pairs(self.mapHudCtrls) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapHudCtrls = {}
  for _, mapCtrl in ipairs(self.tbHudPool) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapHudCtrls = {}
end

function DormInteractiveCtrl:SetMode(nState)
  self.nCurState = nState
  self._mapNode.rtOperate:SetActive(nState == 0)
  self._mapNode.rtObserve:SetActive(nState == 1)
end

function DormInteractiveCtrl:GetInteractiveHudCtrl()
  if #self.tbHudPool == 0 then
    local goHud = instantiate(self._mapNode.goCharHud, self._mapNode.rtHud.transform)
    local mapCtrl = self:BindCtrlByNode(goHud, "Game.UI.Dorm.InteractiveHUDCtrl")
    mapCtrl.gameObject:SetActive(true)
    return mapCtrl
  else
    local mapCtrl = table.remove(self.tbHudPool, 1)
    mapCtrl.gameObject.transform:SetParent(self._mapNode.rtHud.transform)
    mapCtrl.gameObject:SetActive(true)
    return mapCtrl
  end
end

function DormInteractiveCtrl:RecycleInteractiveHudCtrl(nUid)
  local mapCtrl = self.mapHudCtrls[nUid]
  if mapCtrl == nil then
    return
  end
  self.mapHudCtrls[nUid] = nil
  mapCtrl:Hide()
  mapCtrl.gameObject.transform:SetParent(self._mapNode.rtHudPool.transform)
  mapCtrl.gameObject:SetActive(false)
  table.insert(self.tbHudPool, mapCtrl)
end

function DormInteractiveCtrl:RecycleAllInteractiveHudCtrl()
  local tbUids = {}
  for nUid, _ in pairs(self.mapHudCtrls) do
    table.insert(tbUids, nUid)
  end
  for _, nUid in ipairs(tbUids) do
    self:RecycleInteractiveHudCtrl(nUid)
  end
end

function DormInteractiveCtrl:OnEvent_ActiveHud(rtTransform, nType, nDataId, nEntityId)
  self._mapNode.rtContact:AddInteractiveBtn(rtTransform, nType, nDataId, nEntityId)
end

function DormInteractiveCtrl:SetShowBtns(bShow)
  self._mapNode.rtListHideRoot:SetActive(bShow)
end

function DormInteractiveCtrl:OnEvent_DeactiveHud(nEntityId, nType)
  self._mapNode.rtContact:RemoveInteractiveBtn(nEntityId)
end

function DormInteractiveCtrl:OnBtnClick_Operate()
  EventManager.Hit("DormPanel_BtnClickOperate")
end

function DormInteractiveCtrl:OnBtnClick_Observe()
  EventManager.Hit("DormPanel_BtnClickObserve")
end

function DormInteractiveCtrl:OnBtnClick_EditMode()
  EventManager.Hit("DormPanel_BtnClickEdit")
end

function DormInteractiveCtrl:OnBtnClick_NextRoom()
  self:RecycleAllInteractiveHudCtrl()
  EventManager.Hit("DormPanel_NextRoom")
end

function DormInteractiveCtrl:OnBtnClick_SelectChar()
  EventManager.Hit("DormPanel_OpenSelectChar")
end

function DormInteractiveCtrl:OnEvent_DormCharSelectResult()
end

function DormInteractiveCtrl:OnEvent_DormContactBtnClick(nEntityId, nType)
  if nType == 1 then
    NovaAPI.DispatchEventWithData("BUTTON_DORM_INTERACTIVE_HUD", nil, {nEntityId, nType})
  else
    NovaAPI.DispatchEventWithData("DORM_LUA_SELECT_ACTOR_CALLBACK", nil, {nEntityId})
    self._mapNode.rtContact:EnterCharActive(nEntityId)
  end
end

return DormInteractiveCtrl
