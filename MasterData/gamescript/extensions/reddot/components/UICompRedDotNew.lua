local RedDotType = RedDotDefine.RedDotType
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
local UICompRedDotNew, Super = NewViewComponent("UICompRedDotNew")

function UICompRedDotNew:ctor(uiNode, view, redPointID, args)
  Super.ctor(self, uiNode, view)
  self._redPointHandleMap = {}
  self._gmEntryHandle = nil
  self.redPointID = redPointID
  self.redPointParams = args
end

function UICompRedDotNew:OnEnterComponent()
  if not self.gameObject or IsNil(self.gameObject) then
    return
  end
  self:SetActive(self.gameObject, true)
  RedDotController.Instance:OnEnterRedPointComponent(self)
  self:UpdateRedPointStatus()
end

function UICompRedDotNew:OnExitComponent()
  if self._gmEntryHandle then
    RedGameObjectMgr.RecycleRedPoint(self._gmEntryHandle)
    self._gmEntryHandle = nil
  end
  for _, handle in pairs(self._redPointHandleMap) do
    RedGameObjectMgr.RecycleRedPoint(handle)
  end
  self._redPointHandleMap = {}
  if self.gameObject and not IsNil(self.gameObject) then
    self:SetActive(self.gameObject, false)
  end
  RedDotController.Instance:OnExitRedPointComponent(self)
end

function UICompRedDotNew:InitRedData(redPointID, args)
  self.redPointID = redPointID
  self.redPointParams = args
  self:UpdateRedPointStatus()
end

function UICompRedDotNew:UpdateRedPointStatus()
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

function UICompRedDotNew:_SetRedPointType(redPointStatus)
  self._redPointType = redPointStatus
  self:_RefreshRedPointView()
end

function UICompRedDotNew:_RefreshRedPointView()
  if self._redPointType == RedDotType.None then
    for redPointType, _ in pairs(RedPointType2NodeName) do
      local handle = self:GetRedPointHandle(redPointType)
      if handle then
        handle:SetActive(false)
      end
    end
    return
  end
  if not self:GetRedPointHandle(self._redPointType) then
    self:LoadRedPoint()
    return
  end
  for redPointType, _ in pairs(RedPointType2NodeName) do
    local handle = self:GetRedPointHandle(redPointType)
    if not handle then
    else
      handle:SetActive(redPointType == self._redPointType)
    end
  end
end

function UICompRedDotNew:LoadRedPoint()
  if IsNil(self.gameObject) then
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
  self._redPointHandleMap[redPointType] = RedGameObjectMgr.FetchRedPoint(resPath, self.gameObject.transform, function(resObject)
    if resObject.gameObject and not IsNil(resObject.gameObject) then
      self.view.binder:UpdateLocalizedTextAndResouce(resObject.gameObject)
    end
    self:_RefreshRedPointView()
  end)
end

function UICompRedDotNew:GetRedPointHandle(redPointType)
  if not self.gameObject or IsNil(self.gameObject) then
    return nil
  end
  return self._redPointHandleMap[redPointType]
end

function UICompRedDotNew:_RefreshGmEntry()
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
    local btnGo = self:FindChild(self._gmEntryHandle.gameObject, "Btn_Click")
    local btnComp = self:GetButton(btnGo)
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

return UICompRedDotNew
