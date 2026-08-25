local CanvasGroup = CS.UnityEngine.CanvasGroup
local ShortCutComp, Super = System.NewComponent("ShortCutComp")

function ShortCutComp:ctor(textGo, uName, triggerFunc, extraParam)
  Super.ctor(self)
  self.textGo = textGo
  self.uName = Vue.ref(uName)
  self.triggerFunc = triggerFunc
  self.parentGo = textGo.transform.parent.gameObject
  self.extraParam = extraParam or {}
end

function ShortCutComp:OnBind(binder)
  self.binder = binder
  self:_OnBindEvent(binder)
  binder:BindToVisible(self.textGo, function()
    return DataCenter.gameData.IsShowShortCut
  end)
  binder:BindToText(self.textGo, function()
    do return SettingManager.Instance.GetShortCutByUName, SettingManager.Instance end
    return SettingManager.Instance.GetShortCutByUName, SettingManager.Instance, self.uName.value
  end)
end

function ShortCutComp:_OnBindEvent(binder)
  binder:BindEvent(EventMgr.Instance.SettingShortCut, System.fn(self, self.OnTriggerShortCut))
  binder:BindEvent(EventMgr.Instance.ShortCutChange, function(_, uName, shortCut)
    if uName == self.uName.value then
      self.binder:SetText(self.textGo, shortCut)
    end
  end)
end

function ShortCutComp:OnUnbind()
  Super.OnUnbind(self)
end

function ShortCutComp:GetAllCanvasGroup()
  local canvasGroups = {}
  local parent = self.parentGo.transform
  while parent do
    local canvasGroup = parent:GetComponent(typeof(CanvasGroup))
    if canvasGroup then
      table.insert(canvasGroups, canvasGroup)
    end
    parent = parent.parent
  end
  return canvasGroups
end

function ShortCutComp:IsAnyCanvasTransparent(canvasGroups)
  for i, v in ipairs(canvasGroups) do
    if v.alpha < 1 then
      return true
    end
  end
end

function ShortCutComp:OnTriggerShortCut(uName)
  if uName == self.uName.value and self.triggerFunc then
    ShortCutKeyManager.Instance:TriggerShortCut(uName, self.triggerFunc, self, self.extraParam)
  end
end

return ShortCutComp
