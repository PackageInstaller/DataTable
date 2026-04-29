_class("UIActiveTaskAwardShowIContent", UICustomWidget)
UIActiveTaskAwardShowIContent = UIActiveTaskAwardShowIContent

function UIActiveTaskAwardShowIContent:OnShow()
  self._gridSize = Vector2(135, 135)
  self:_GetComponent()
end

function UIActiveTaskAwardShowIContent:OnHide()
end

function UIActiveTaskAwardShowIContent:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._itemContent = self:GetUIComponent("UISelectObjectPath", "itemContent")
  self._itemContentLayout = self:GetUIComponent("GridLayoutGroup", "itemContent")
end

function UIActiveTaskAwardShowIContent:SetData(data, level, clickCallback)
  self._data = data
  self._level = level
  self._clickCallback = clickCallback
  self:InitCompoent()
end

function UIActiveTaskAwardShowIContent:InitCompoent()
  local titleTxt = "str_n32_turn_card_prize" .. self._level
  self._title:SetText(StringTable.Get(titleTxt))
  local height = self._gridSize.y
  local width = self._gridSize.x
  if self._level == 1 then
    height = self._gridSize.y * 2
    width = self._gridSize.x * 2
    self._itemContentLayout.cellSize = Vector2(270, 270)
  elseif self._level == 2 then
    width = self._gridSize.x * 2
    self._itemContentLayout.cellSize = Vector2(270, 135)
  elseif self._level == 3 then
    self._itemContentLayout.cellSize = Vector2(135, 135)
    self._itemContentLayout.constraintCount = 5
  end
  self._itemContentLayout.cellSize = Vector2(width, height + 50)
  self._items = self._itemContent:SpawnObjects("UIActiveTaskAwardShowItem", table.count(self._data))
  local idx = 1
  for i, v in pairs(self._data) do
    self._items[idx]:SetData(i, v, self._clickCallback)
    idx = idx + 1
  end
end

function UIActiveTaskAwardShowIContent:Close()
  for _, v in pairs(self._items) do
    v:Close()
  end
end
