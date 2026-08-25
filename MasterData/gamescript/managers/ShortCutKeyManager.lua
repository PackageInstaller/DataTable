local Z1Const = CS.FrameWork.Z1Const
local supportShortCutKey = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor or CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsPlayer
local ShortCutKeyManager, Super = System.NewClass("ShortCutKeyManager", Manager, IUpdater)

function ShortCutKeyManager:ctor()
  Super.ctor(self)
end

function ShortCutKeyManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  self._shortCutsCallbacks = {}
  self.extraDealFuncs = {}
  self._shortCutsInCdMap = {}
  self.isRecordingShortCut = false
  binder:BindEvent(EventMgr.Instance.ShortCutRecording, function(isRecording)
    self.isRecordingShortCut = isRecording
  end)
  self.isSteam = false
  if Z1Const.IsSteam and Z1Const.IsSteam() then
    self.isSteam = true
  end
  CS.UnityEngine.EventSystems.EventSystem.current.sendNavigationEvents = false
end

local curShortcuts = {}

function ShortCutKeyManager:Update()
  if not supportShortCutKey then
    return
  end
  local ctrlKeys, normalKeys = ShortCutKeys.GetPressKeyCodeStrs()
  if 0 == #ctrlKeys and 0 == #normalKeys then
    return
  end
  table.clear(curShortcuts)
  for _, keyStr in ipairs(normalKeys) do
    table.insert(curShortcuts, keyStr)
    EventMgr.Instance.OnKeyDown:Dispatch(keyStr)
  end
  for _, keyStr in ipairs(ctrlKeys) do
    table.insert(curShortcuts, keyStr)
    EventMgr.Instance.OnKeyDown:Dispatch(keyStr)
  end
  if self.isRecordingShortCut then
    return
  end
  if self:IsInGmPanel() then
    return
  end
  if #ctrlKeys > 0 then
    local ctrlKeyStr = table.concat(ctrlKeys, "+")
    for _, normalKey in ipairs(normalKeys) do
      local shortcut = ctrlKeyStr .. "+" .. normalKey
      table.insert(curShortcuts, shortcut)
    end
  end
  self:ExecuteShortCuts(curShortcuts)
  self:DoExtraDealFunc(curShortcuts)
end

function ShortCutKeyManager:IsInGmPanel()
  local gmPanels = {
    Urls.GmPanel,
    Urls.GmParamPanel
  }
  for _, gmPanel in ipairs(gmPanels) do
    if UIManager.Instance:GetWindow(gmPanel) then
      return true
    end
  end
end

function ShortCutKeyManager:ExecuteShortCuts(shortcuts)
  for _, shortcut in ipairs(shortcuts) do
    local callbacks = self._shortCutsCallbacks[shortcut:upper()]
    if callbacks then
      for _, cb in ipairs(callbacks) do
        cb()
      end
    end
  end
end

function ShortCutKeyManager:TriggerShortCut(keyName, triggerFunc, shortCutComp, extraParam)
  if not keyName or not triggerFunc then
    return
  end
  if self._shortCutsInCdMap[keyName] then
    return
  end
  extraParam = extraParam or {}
  if bg.battleRender and bg.battleRender:IsBattleActionShortCutBlocked() and not extraParam.withoutForwardPanel then
    return
  end
  if not bg.isPVP_TRAIN and bg.battlePanel and not extraParam.withoutForwardPanel and not UIManager.Instance:GetWindow(Urls.BattleCardPreviewPanel) and UIManager.Instance:HaveForwardPanel(bg.battlePanel) then
    return
  end
  if shortCutComp then
    if not shortCutComp.parentGo.activeInHierarchy then
      return
    end
    if shortCutComp:IsAnyCanvasTransparent(shortCutComp:GetAllCanvasGroup()) then
      return
    end
  end
  self._shortCutsInCdMap[keyName] = true
  self.binder:BindTimer(0.2, 0, nil, function()
    self._shortCutsInCdMap[keyName] = nil
  end)
  triggerFunc()
end

function ShortCutKeyManager:DoExtraDealFunc(shortcuts)
  for func, _ in pairs(self.extraDealFuncs) do
    func(shortcuts)
  end
end

function ShortCutKeyManager:Register(keyCodeStr, callback)
  keyCodeStr = keyCodeStr:upper()
  self._shortCutsCallbacks[keyCodeStr] = self._shortCutsCallbacks[keyCodeStr] or {}
  table.insert(self._shortCutsCallbacks[keyCodeStr], callback)
end

function ShortCutKeyManager:UnRegister(keyCodeStr, callback)
  keyCodeStr = keyCodeStr:upper()
  local callbacks = self._shortCutsCallbacks[keyCodeStr] or {}
  for i, cb in ipairs(callbacks) do
    if cb == callback then
      table.remove(callbacks, i)
      break
    end
  end
  if 0 == #callbacks then
    self._shortCutsCallbacks[keyCodeStr] = nil
  end
end

function ShortCutKeyManager:RegisterExtraDealFunc(func)
  self.extraDealFuncs[func] = true
end

function ShortCutKeyManager:UnRegisterExtraDealFunc(func)
  self.extraDealFuncs[func] = nil
end

return ShortCutKeyManager
