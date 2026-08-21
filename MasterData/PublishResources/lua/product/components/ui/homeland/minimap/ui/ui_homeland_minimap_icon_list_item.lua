_class("UIHomelandMinimapIconListItem", UICustomWidget)
UIHomelandMinimapIconListItem = UIHomelandMinimapIconListItem

function UIHomelandMinimapIconListItem:OnShow()
  self._iconLoader = self:GetUIComponent("UISelectObjectPath", "IconLoader")
  self._iconTran = self:GetUIComponent("RectTransform", "IconLoader")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._nameRollingText = self:GetUIComponent("RollingText", "Name")
  self._originalPos = self._iconTran.anchoredPosition
end

function UIHomelandMinimapIconListItem:OnHide()
  self:Release()
end

function UIHomelandMinimapIconListItem:Init(iconBase, miniMap)
  self._miniMap = miniMap
  self._iconData = iconBase:GetIconData()
  self._nameLabel:SetText(iconBase:GetShowName())
  self._nameRollingText:RefreshText(iconBase:GetShowName())
  self:Release()
  self._iconLoader.dynamicInfoOfEngine:SetObjectName(self._iconData:GetPrefabName())
  self._iconWidget = self._iconLoader:SpawnObject(self._iconData:GetScriptName())
  self._iconWidget:InternalInitialize(self._iconData, miniMap, true)
  self:SetStatus(true)
  self._iconTran.anchoredPosition = self._originalPos + iconBase:GetShowIconOffset()
end

function UIHomelandMinimapIconListItem:SetStatus(status)
  self:GetGameObject():SetActive(status)
end

function UIHomelandMinimapIconListItem:Release()
  if self._iconWidget then
    self._iconWidget:Release()
    self._iconWidget = nil
  end
  if self._iconLoader.uiCustomWidgets then
    local uiCustomWidgets = self._iconLoader.uiCustomWidgets
    for i = 1, #uiCustomWidgets do
      local uiCustomWidget = uiCustomWidgets[i]
      uiCustomWidget:UnLoad()
      uiCustomWidget:Dispose()
    end
    self._iconLoader.uiCustomWidgets = {}
  end
end

function UIHomelandMinimapIconListItem:BtnOnClick()
  self._miniMap:OnSelectIcon(self._iconData)
end
