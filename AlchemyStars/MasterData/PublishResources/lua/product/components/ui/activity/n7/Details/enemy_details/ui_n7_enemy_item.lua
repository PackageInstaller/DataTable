_class("UIN7EnemyItem", UICustomWidget)
UIN7EnemyItem = UIN7EnemyItem

function UIN7EnemyDetailsController:Constructor()
  self._uiParams = nil
  self._callback = nil
  self._cfg = nil
  self._isSelect = false
  self._index = 0
end

function UIN7EnemyItem:OnShow(uiParams)
  self._uiParams = uiParams
  self:_GetComponents()
end

function UIN7EnemyItem:_GetComponents()
  self._enemyIcon = self:GetUIComponent("RawImageLoader", "enemyIcon")
  self._select = self:GetGameObject("select")
end

function UIN7EnemyItem:SetData(index, cfg, callback)
  self._index = index
  self._cfg = cfg
  self._callback = callback
  local a = self._cfg[1].ItemIcon
  self._enemyIcon:LoadImage(self._cfg[1].Head)
end

function UIN7EnemyItem:SetSelectState(state)
  self._isSelect = state
  self._select:SetActive(self._isSelect)
end

function UIN7EnemyItem:enemyIconOnClick(go)
  if self._callback then
    self._callback(self._index)
  end
end
