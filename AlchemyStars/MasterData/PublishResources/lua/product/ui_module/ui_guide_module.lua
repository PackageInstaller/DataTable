_class("UIGuideModule", UIModule)

function UIGuideModule:Constructor()
  self.uiContainer = {}
  self.uiRoot = UnityEngine.GameObject.Find("Hidden").transform
end

function UIGuideModule:Dispose()
end

function UIGuideModule:CreateUICustomWidget(uiCustomWidgetName)
  local uiCustomWidget = _createInstance(uiCustomWidgetName)
  if not uiCustomWidget then
    Log.fatal("[UI] GuideModule:CreateUICustomWidget Error, No UICustomWidget of name = ", uiCustomWidgetName)
  else
    uiCustomWidget:SetName(uiCustomWidgetName)
  end
  return uiCustomWidget
end

function UIGuideModule:GetUI(name, prefab)
  local ui = table.remove(self.uiContainer, #self.uiContainer)
  if ui then
    ui:Show()
    return ui
  end
  local go = UIHelper.GetGameObject(prefab)
  local guide = self:CreateUICustomWidget(name)
  if not guide then
    Log.fatal("[UI] CreateUICustomWidget Error, ", name)
    return
  end
  local view = go:GetComponent("UIView")
  if not view then
    Log.fatal("[UI] UICustomWidget Error, View is Null ", name)
    return
  end
  guide:Load(view, self.parent)
  return guide
end

function UIGuideModule:PushUI(ui)
  table.insert(self.uiContainer, ui)
  ui:Hide()
  ui:View():GetGameObject().transform:SetParent(self.uiRoot, false)
end
