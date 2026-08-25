local unpack = table.unpack
local UnityTime = CS.UnityEngine.Time
local DelayAutoDestroyTime = 5
local UIAsyncLoadPanel, Super = NewClass("UIAsyncLoadPanel", UIAsyncPanelBridge)
UIAsyncLoadPanel.MockAsyncTime = 0

function UIAsyncLoadPanel:ctor(url)
  Super.ctor(self)
  self.___isOpened = false
  self.___url = url
  self.___resourceCache = nil
  self.___timeToDestroyed = 0
  self.___assetPath = nil
  self.___gameObject = nil
  self.___tempDependenciesResLoader = nil
  self.___waitingTempResourcedLoaded = nil
  self.___isTempResourcedLoaded = nil
  self.___openParams = nil
  self.___isReopened = false
  self.___isPrecreating = false
end

function UIAsyncLoadPanel:IsOpened()
  return self.___isOpened
end

function UIAsyncLoadPanel:GetGameObject()
  return self.___gameObject
end

function UIAsyncLoadPanel:Precreate()
  self.___isPrecreating = true
  self:LoadResource()
end

function UIAsyncLoadPanel:Open(...)
  self.___isReopened = false
  self:_Open(...)
end

function UIAsyncLoadPanel:_Open(...)
  local uiCfg = UIAsyncUrls[self.___url]
  WaitingView.Instance:Show(self, WaitingView.Flag_LoadingView)
  self.___openParams = {
    ...
  }
  self.___isOpened = true
  local uiCls = require("GameScript." .. self.___url)
  if not self.___isTempResourcedLoaded and uiCls.GetTempDependenciesResources then
    local panel = uiCls(...)
    self:LoadTempDependenciesResources(panel)
  else
    self.___isTempResourcedLoaded = true
    self.___waitingTempResourcedLoaded = nil
  end
  self:LoadResource()
end

function UIAsyncLoadPanel:Reopen(...)
  self.___isReopened = true
  self:_Open(...)
end

function UIAsyncLoadPanel:Close()
  self.___isOpened = false
  self:___ClearHandlers()
  self.panelInstance = nil
  self:SetVisible(false)
  self.___waitingTempResourcedLoaded = nil
  self.___isTempResourcedLoaded = nil
  WaitingView.Instance:Hide(self, WaitingView.Flag_LoadingView)
  TimerManager.Instance:StopTimer(self.mockAsyncTimer)
  self:ClearTempDependenciesResources()
  if self.___gameObject and self.___resourceCache then
    self.___resourceCache:ReturnGameObject(self.___gameObject)
    self.___gameObject = nil
  end
  if self.___resourceCache then
    self.___resourceCache:ClearCallback()
  end
  self.___openParams = nil
  self.___isReopened = false
  self:CalAutoDestroyTime()
end

function UIAsyncLoadPanel:CalAutoDestroyTime()
  local destroyTime = UIAsyncUrls[self.___url].autoDestroyTime or DelayAutoDestroyTime
  if destroyTime < 0 then
    self.___timeToDestroyed = 0
  else
    self.___timeToDestroyed = UnityTime.time + destroyTime
  end
end

function UIAsyncLoadPanel:SetVisible(visible)
  if self.___gameObject then
    self.___gameObject:SetActive(visible or false)
  end
end

function UIAsyncLoadPanel:TryDestroy()
  if 0 == self.___timeToDestroyed then
    return false
  end
  if UnityTime.time >= self.___timeToDestroyed then
    self:Destroy()
    return true
  end
  return false
end

function UIAsyncLoadPanel:Destroy()
  self:Close()
  self.___timeToDestroyed = 0
  self.___isOpened = false
  self.___isPrecreating = false
  if self.___resourceCache then
    self.___resourceCache:UnloadResource()
    self.___resourceCache = nil
  end
end

function UIAsyncLoadPanel:LoadResource()
  local uiCls = require("GameScript." .. self.___url)
  self.___assetPath = UIManager.GetUIResObj(uiCls.uiResCls).assetPath
  if not self.___resourceCache then
    self.___resourceCache = UIGameObject(self.___assetPath)
  end
  if self.___gameObject then
    self:OnResourcesLoaded()
  else
    local uiCfg = UIAsyncUrls[self.___url]
    self.___resourceCache:LoadResource(function()
      if not self.___isOpened and not self.___isPrecreating then
        return
      end
      self:OnResourcesLoaded()
    end, uiCfg.forceSync)
  end
end

function UIAsyncLoadPanel:LoadTempDependenciesResources(panel)
  self:ClearTempDependenciesResources()
  local resList = panel:GetTempDependenciesResources()
  if not resList or 0 == #resList then
    self.___waitingTempResourcedLoaded = nil
    self.___isTempResourcedLoaded = true
    return
  end
  local uiCfg = UIAsyncUrls[self.___url]
  self.___waitingTempResourcedLoaded = true
  self.___tempDependenciesResLoader = MultiResourcesLoader()
  self.___tempDependenciesResLoader:Load(resList, function()
    self:OnTempDependenciesResourcesLoaded()
  end, uiCfg.forceSync)
end

function UIAsyncLoadPanel:ClearTempDependenciesResources()
  self.___isTempResourcedLoaded = nil
  if self.___tempDependenciesResLoader then
    self.___tempDependenciesResLoader:Clear()
    self.___tempDependenciesResLoader = nil
  end
end

function UIAsyncLoadPanel:OnResourcesLoaded()
  if 0 == UIAsyncLoadPanel.MockAsyncTime then
    self:_OnResoucesLoaded()
  else
    self.mockAsyncTimer = TimerManager.Instance:CreateTimer(UIAsyncLoadPanel.MockAsyncTime, 0, nil, function()
      self:_OnResoucesLoaded()
    end)
  end
end

function UIAsyncLoadPanel:_OnResoucesLoaded()
  if not self.___gameObject then
    self.___gameObject = self.___resourceCache:FetchGameObject()
  end
  local isPrecreating = self.___isPrecreating
  self.___isPrecreating = false
  if self.___isOpened then
    self:_OpenPanelSync()
  elseif isPrecreating then
    self.___gameObject:SetActive(false)
  end
end

function UIAsyncLoadPanel:OnTempDependenciesResourcesLoaded()
  self.___waitingTempResourcedLoaded = nil
  self.___isTempResourcedLoaded = true
  self:_OpenPanelSync()
end

function UIAsyncLoadPanel:_OpenPanelSync()
  if not self.panelInstance and self.___isOpened and not self.___isPrecreating and self.___gameObject and self.___isTempResourcedLoaded then
    WaitingView.Instance:Hide(self, WaitingView.Flag_LoadingView)
    if not self.___isReopened then
      self.panelInstance = UIManager.Instance:ShowSync(self.___url, unpack(self.___openParams))
    else
      self.panelInstance = UIManager.Instance:ReopenSync(self.___url, unpack(self.___openParams))
    end
    self:___CallAllBridges()
  end
end

return UIAsyncLoadPanel
