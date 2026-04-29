_class("UIDiscoveryEnterUnlockClsBase", Object)
UIDiscoveryEnterUnlockClsBase = UIDiscoveryEnterUnlockClsBase

function UIDiscoveryEnterUnlockClsBase:Constructor(moduleID, go, tex, img)
  self._moduleId = moduleID
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._go = go
  self._tex = tex
  self._img = img
end

function UIDiscoveryEnterUnlockClsBase:IsUnlock()
  return self._roleModule:CheckModuleUnlock(self._moduleId)
end

function UIDiscoveryEnterUnlockClsBase:GameObject()
  return self._go
end

function UIDiscoveryEnterUnlockClsBase:Text()
  return self._tex
end

function UIDiscoveryEnterUnlockClsBase:Image()
  return self._img
end
