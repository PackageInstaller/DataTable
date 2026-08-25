local MainCGView, Super = NewClass("MainCGView", CGBaseView)
MainCGView.uiResCls = UI_Collection_Item_CGResource
local UnityInput = CS.UnityEngine.Input
local gcInterval = 10
local UnityTime = CS.UnityEngine.Time

function MainCGView:ctor(subFeature)
  Super.ctor(self, subFeature)
end

function MainCGView:OnBuildView()
  Super.OnBuildView(self)
end

function MainCGView:OnEnterViewFinished()
  Super.OnEnterViewFinished(self)
  if not ApplicationUtils.IsEditor() then
    self._gcTimer = self:BindTimer(0, -1, System.fn(self, self._TryGc))
    self._lastGcTime = UnityTime.time
  end
end

function MainCGView:OnExitView()
  if self._gcTimer then
    self:StopTimer(self._gcTimer)
    self._gcTimer = nil
  end
  Super.OnExitView(self)
end

function MainCGView:_IsTouching()
  if ApplicationUtils.IsWindows() or ApplicationUtils.IsEditor() then
    for i = 0, 2 do
      if UnityInput.GetMouseButton(i) then
        return true
      end
    end
    return false
  end
  return UnityInput.touchCount > 0
end

function MainCGView:_TryGc()
  if self:_IsTouching() then
    return
  end
  if self._needCSGC then
    CS.System.GC.Collect()
    collectgarbage("collect")
    self._needCSGC = false
  end
  local time = UnityTime.time
  if time - self._lastGcTime > gcInterval then
    ResGcMgr.Instance:UnloadUnusedAssets()
    self._needCSGC = true
    self._lastGcTime = time
  end
end

return MainCGView
