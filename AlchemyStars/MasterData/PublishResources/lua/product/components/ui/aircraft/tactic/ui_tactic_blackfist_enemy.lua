_class("UIBlackfistEnemyItem", UICustomWidget)
UIBlackfistEnemyItem = UIBlackfistEnemyItem

function UIBlackfistEnemyItem:OnShow(uiParams)
  self:InitWidget()
end

function UIBlackfistEnemyItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.att1 = self:GetUIComponent("Image", "att1")
  self.att2 = self:GetUIComponent("Image", "att2")
  self._rect = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
end

function UIBlackfistEnemyItem:SetData(idx, datas)
  local data = datas[idx]
  self.att1.sprite = data.elemt1
  if data.elemt2 then
    self.att2.sprite = data.elemt2
    self.att2.gameObject:SetActive(true)
  else
    self.att2.gameObject:SetActive(false)
  end
  self.icon:LoadImage(data.skin)
  if idx == 1 then
    self._rect.sizeDelta = Vector2(277, 525)
  else
    self._rect.sizeDelta = Vector2(177, 525)
  end
  self._datas = datas
  self._idx = idx
end

function UIBlackfistEnemyItem:ImageOnClick(go)
  self:ShowDialog("UIN7EnemyDetailsController", self._datas, self._idx)
end
