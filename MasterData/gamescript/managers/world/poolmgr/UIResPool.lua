local table = _ENV.table
local CSInstantiate = CS.UnityEngine.Object.Instantiate
local CSObjectDestroy = CS.UnityEngine.Object.Destroy
local UIResPool, Super = System.NewClass("UIResPool")

function UIResPool:ctor(poolConfig)
  Super.ctor(self)
  self.maxCount = poolConfig.maxCount
  self.releaseTime = poolConfig.releaseTime
  self.uiResList = {}
  self.clearTimer = nil
end

function UIResPool:Get(res)
  for index = #self.uiResList, 1, -1 do
    local ui = self.uiResList[index]
    if ui.assetPath == res.assetPath then
      table.remove(self.uiResList, index)
      return ui
    end
  end
  local prefab = ResLoadMgr.LoadAsset(res.assetPath, self)
  local uiNode = CSInstantiate(prefab)
  local ui = res(uiNode)
  return ui
end

function UIResPool:Free(ui, OnRecycleFunc)
  if 0 == self.maxCount then
    self:ClearItem(ui)
    return
  end
  if #self.uiResList >= self.maxCount then
    local firstUI = table.remove(self.uiResList, 1)
    self:ClearItem(firstUI)
  end
  table.insert(self.uiResList, ui)
  if OnRecycleFunc then
    OnRecycleFunc(ui)
  end
  self:ResetClearTimer()
end

function UIResPool:Clear()
  for _, ui in ipairs(self.uiResList) do
    self:ClearItem(ui)
  end
  self.uiResList = {}
end

function UIResPool:ClearItem(ui)
  CSObjectDestroy(ui.uiNode)
  ResLoadMgr.SubRef(ui.assetPath, self, true)
end

function UIResPool:ResetClearTimer()
  if self.clearTimer then
    TimerManager.Instance:StopTimer(self.clearTimer)
  end
  if self.releaseTime and self.releaseTime > 0 then
    self.clearTimer = TimerManager.Instance:CreateTimer(self.releaseTime, 0, nil, System.fn(self, self.Clear))
  end
end

return UIResPool
