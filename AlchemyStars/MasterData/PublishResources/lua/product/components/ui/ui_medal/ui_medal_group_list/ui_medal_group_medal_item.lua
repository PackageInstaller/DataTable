_class("UIMedalGroupMedalItem", UICustomWidget)
UIMedalGroupMedalItem = UIMedalGroupMedalItem

function UIMedalGroupMedalItem:Constructor()
end

function UIMedalGroupMedalItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIMedalGroupMedalItem:_GetComponents()
  self.medalIcon = self:GetUIComponent("Image", "Icon")
  self.medalIconGo = self:GetGameObject("Icon")
  self.medalRect = self:GetUIComponent("RectTransform", "Icon")
  self.root = self:GetUIComponent("RectTransform", "root")
end

function UIMedalGroupMedalItem:SetData(data, sprite, collect, width, editData)
  self._id = data[1]
  local x = data[2]
  local y = data[3]
  local r = data[4]
  self.medalIconGo:SetActive(collect)
  self._collect = collect
  local cfg = Cfg.cfg_item_medal[self._id]
  if not cfg then
    Log.error("###[UIMedalGroupMedalItem] cfg medal is nil ! id --> ", self._id)
  end
  self.medalIcon.sprite = sprite
  local realPos = editData:GetScaledPos(width, Vector2(x, y))
  self.root.anchoredPosition = realPos
  local qua = Quaternion.Euler(0, 0, r)
  self.root.rotation = qua
  local rect = self.medalIcon.sprite.rect
  self.root.sizeDelta = Vector2(rect.width, rect.height) * 0.36 * editData:GetScaleTimes(width)
end

function UIMedalGroupMedalItem:RootOnClick(go)
  self:ShowDialog("UIMedalGroupTipsController", self._id, false, self._collect)
end
