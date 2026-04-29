_class("UIHomelandStoryTaskSimpleContainer", UICustomWidget)
UIHomelandStoryTaskSimpleContainer = UIHomelandStoryTaskSimpleContainer

function UIHomelandStoryTaskSimpleContainer:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandStoryTaskSimpleContainer:OnHide(uiParams)
end

function UIHomelandStoryTaskSimpleContainer:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIHomelandStoryTaskSimpleContainer:SetData(datas, controller)
  self._datas = datas
  self._controller = controller
  self:_SetItems()
end

function UIHomelandStoryTaskSimpleContainer:_SetItems()
  local count = #self._datas
  if count <= 0 then
    return
  end
  self._content:SpawnObjects("UIHomelandStoryTaskSimpleItem", count)
  local items = self._content:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetData(self._datas[i], self._controller)
    items[i]:ShowAnim()
  end
end
