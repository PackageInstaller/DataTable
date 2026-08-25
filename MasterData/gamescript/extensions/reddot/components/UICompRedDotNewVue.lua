local RedDotType = RedDotDefine.RedDotType
local FindChild = CS.Framework.GameObjectUtil.FindChild
local GmEntryRes = CommonRes.RedPoint_Gm
local RedPointType2ResDict = {
  [RedDotType.Red] = CommonRes.RedPoint_Dot,
  [RedDotType.New] = CommonRes.RedPoint_New,
  [RedDotType.Num] = CommonRes.RedPoint_Num
}
local RedPointType2NodeName = {
  [RedDotType.Red] = "RedPoint_Dot(Clone)",
  [RedDotType.New] = "RedPoint_New(Clone)",
  [RedDotType.Num] = "RedPoint_Num(Clone)"
}
local UICompRedDotNewVue, Super = System.NewComponent("UICompRedDotNewVue")

function UICompRedDotNewVue:ctor(uiNode, redPointID, args)
  Super.ctor(self)
  self.gameObject = uiNode
  self._gmEntryHandle = nil
  self._redPointHandleMap = {}
  self.redPointID = redPointID
  self.redPointParams = args
end

function UICompRedDotNewVue:OnBind(binder)
  self.binder = binder
  self.binder:SetActive(self.gameObject, true)
  for i = self.gameObject.transform.childCount - 1, 0, -1 do
    local child = self.gameObject.transform:GetChild(i)
    for _, name in pairs(RedPointType2NodeName) do
      if child.name == name then
        CS.UnityEngine.Object.Destroy(child.gameObject)
        break
      end
    end
  end
  self:UpdateRedPointStatus()
  self.binder:BindEvent(EventMgr.Instance.OnProtoMsgResponse, System.fn(self, self._OnProtoMsgData))
  self.binder:BindEvent(EventMgr.Instance.OnProtoMsgRequest, System.fn(self, self._OnProtoMsgData))
  self.binder:BindEvent(EventMgr.Instance.OnRedDotGmStatusChanged, System.fn(self, self.UpdateRedPointStatus))
end

function UICompRedDotNewVue:_OnProtoMsgData(funcName)
  if self._unbound then
    return
  end
  if not RedDotController.Instance:IsNeedRefreshRedDotWhileMsgArrived(funcName) then
    return
  end
  CommandBufferMgr.Instance:PushCommand(self.UpdateRedPointStatus, self)
end

function UICompRedDotNewVue:InitRedData(redPointID, args)
  self.redPointID = redPointID
  self.redPointParams = args
  self:UpdateRedPointStatus()
end

function UICompRedDotNewVue:UpdateRedPointStatus()
  if self._unbound then
    return
  end
  if not self.gameObject or IsNil(self.gameObject) then
    return
  end
  self:_RefreshGmEntry()
  local redDotType = RedDotController.Instance:GetRedDotStatus(self.redPointID, self.redPointParams)
  if not redDotType then
    self:_SetRedPointType(RedDotType.None)
    return
  end
  self:_SetRedPointType(redDotType)
end

function UICompRedDotNewVue:_SetRedPointType(redPointStatus)
  self._redPointType = redPointStatus
  self:_RefreshRedPointView()
end

function UICompRedDotNewVue:_RefreshRedPointView()
  if self._redPointType == RedDotType.None then
    for redPointType, _ in pairs(RedPointType2NodeName) do
      local handle = self:_GetRedPointHandle(redPointType)
      if handle then
        handle:SetActive(false)
      end
    end
    return
  end
  if not self:_GetRedPointHandle(self._redPointType) then
    self:_LoadRedPoint()
    return
  end
  for redPointType, _ in pairs(RedPointType2NodeName) do
    local handle = self:_GetRedPointHandle(redPointType)
    if not handle then
    else
      handle:SetActive(redPointType == self._redPointType)
    end
  end
end

function UICompRedDotNewVue:_LoadRedPoint()
  if self._unbound then
    return
  end
  if not self.gameObject or IsNil(self.gameObject) then
    return
  end
  local redPointType = self._redPointType
  if self._redPointHandleMap[redPointType] then
    return
  end
  local resPath = RedPointType2ResDict[redPointType]
  if not resPath then
    return
  end
  local resObj = RedGameObjectMgr.FetchRedPoint(resPath, self.gameObject.transform, function(resObject)
    self._redPointHandleMap[redPointType] = resObject
    if resObject.gameObject and not IsNil(resObject.gameObject) then
      self.binder:UpdateLocalizedTextAndResouce(resObject.gameObject)
    end
    self:_RefreshRedPointView()
  end)
  self._redPointHandleMap[redPointType] = resObj
end

function UICompRedDotNewVue:_GetRedPointHandle(redPointType)
  if not self.gameObject or IsNil(self.gameObject) then
    return nil
  end
  return self._redPointHandleMap[redPointType]
end

function UICompRedDotNewVue:_RefreshGmEntry()
  if not self.gameObject or IsNil(self.gameObject) then
    return
  end
  if not GmClientUtils.isRedDotGmOpen then
    if self._gmEntryHandle then
      self._gmEntryHandle:SetActive(false)
    end
    return
  end
  
  local function AddGmEntryBtnListener()
    if not self._gmEntryHandle or not self._gmEntryHandle.gameObject then
      return
    end
    self._gmEntryHandle:SetActive(true)
    local btnGo = FindChild(self._gmEntryHandle.gameObject, "Btn_Click")
    local btnComp = self.binder:GetButton(btnGo)
    if btnComp then
      btnComp.onClick:RemoveAllListeners()
      btnComp.onClick:AddListener(function()
        UIManager.Instance:Reopen(Urls.RedDotGmView, self.redPointID, self.redPointParams)
      end)
    end
  end
  
  if not self._gmEntryHandle then
    self._gmEntryHandle = RedGameObjectMgr.FetchRedPoint(GmEntryRes, self.gameObject.transform, function()
      AddGmEntryBtnListener()
    end)
  end
  AddGmEntryBtnListener()
end

function UICompRedDotNewVue:OnUnbind()
  self._unbound = true
  if self._gmEntryHandle then
    RedGameObjectMgr.RecycleRedPoint(self._gmEntryHandle)
    self._gmEntryHandle = nil
  end
  for _, handle in pairs(self._redPointHandleMap) do
    RedGameObjectMgr.RecycleRedPoint(handle)
  end
  self._redPointHandleMap = {}
  if self.gameObject and not IsNil(self.gameObject) then
    self.binder:SetActive(self.gameObject, false)
  end
  Super.OnUnbind(self)
end

return UICompRedDotNewVue
