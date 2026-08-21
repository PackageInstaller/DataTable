_class("UIN5ProgressItemGen", UICustomWidget)
UIN5ProgressItemGen = UIN5ProgressItemGen

function UIN5ProgressItemGen:OnShow(uiParams)
end

function UIN5ProgressItemGen:InitWidget()
  self._gens = {}
  self._gens[UIN5ProgressCellType.CELL_NPC_DETAIL] = "NpcDetailGen"
  self._gens[UIN5ProgressCellType.CELL_SIMPLE] = "SimpleGen"
  self._gens[UIN5ProgressCellType.CELL_PLAYER] = "PlayerDetailGen"
  self._widgets = {}
  self._widgets[UIN5ProgressCellType.CELL_NPC_DETAIL] = "UIN5ProgressItemNpcDetail"
  self._widgets[UIN5ProgressCellType.CELL_SIMPLE] = "UIN5ProgressItemSimple"
  self._widgets[UIN5ProgressCellType.CELL_PLAYER] = "UIN5ProgressItemPlayerDetail"
end

function UIN5ProgressItemGen:SetData(index, count, itemInfo, componentInfo, callback, itemCallBack, specificData, cmptCfgId)
  self:InitWidget()
  self._index = index
  self._count = count
  self._itemInfo = itemInfo
  self._componentInfo = componentInfo
  self._callback = callback
  self._itemCallback = itemCallBack
  self._specificData = specificData
  self._cmptCfgId = cmptCfgId
  self:_OnValue()
end

function UIN5ProgressItemGen:_OnValue()
  local genName = self._gens[self._itemInfo.cellType]
  local widgetName = self._widgets[self._itemInfo.cellType]
  if genName and widgetName then
    self:DisposeCustomWidgets()
    local gen = self:GetUIComponent("UISelectObjectPath", genName)
    if gen then
      self._widget = gen:SpawnObject(widgetName)
      if self._widget then
        self._widget:SetData(self._index, self._count, self._itemInfo, self._componentInfo, self._callback, self._itemCallback, self._specificData, self._cmptCfgId, function()
          self:_OnExpandDetail()
        end)
      end
    end
  end
end

function UIN5ProgressItemGen:_OnExpandDetail()
  self:GetGameObject().transform.parent:SetAsLastSibling()
end
