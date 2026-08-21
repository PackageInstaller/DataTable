_class("UIActivityPetTryItem", UICustomWidget)
UIActivityPetTryItem = UIActivityPetTryItem

function UIActivityPetTryItem:OnShow(uiParams)
  self._go = self:GetGameObject("go")
end

function UIActivityPetTryItem:_GetComponents()
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._passGo = self:GetGameObject("pass")
  self._select = self:GetGameObject("select")
  self._element = self:GetUIComponent("Image", "element")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._starTab = {}
  local star1 = self:GetGameObject("star1")
  local star2 = self:GetGameObject("star2")
  local star3 = self:GetGameObject("star3")
  local star4 = self:GetGameObject("star4")
  local star5 = self:GetGameObject("star5")
  local star6 = self:GetGameObject("star6")
  self._starTab[1] = star1
  self._starTab[2] = star2
  self._starTab[3] = star3
  self._starTab[4] = star4
  self._starTab[5] = star5
  self._starTab[6] = star6
  self._rect = self:GetUIComponent("RectTransform", "go")
  self._red = self:GetGameObject("red")
  self._nameImg = self:GetUIComponent("RectTransform", "Image")
end

function UIActivityPetTryItem:SetData(index, curIdx, data, callback)
  self:_GetComponents()
  self._idx = index
  self._selected = false
  self._data = data
  self._pethead = data.pethead
  self._pass = data.pass
  self._callback = callback
  local anim = self:GetUIComponent("Animation", "_anim")
  anim.enabled = false
  anim.enabled = true
  self:_OnValue()
  self:OnSelected(curIdx)
end

function UIActivityPetTryItem:Active(active)
  self._go:SetActive(active)
end

function UIActivityPetTryItem:_OnValue()
  self._head:LoadImage(self._data.head)
  self._passGo:SetActive(self._data.pass)
  self._red:SetActive(not self._data.pass)
  self._name:SetText(self._data.name)
  local nameTr = self._name.gameObject:GetComponent("RectTransform")
  local scale = nameTr.localScale.x
  local imgWidth = 192
  if 1 <= scale then
    imgWidth = self._name.preferredWidth + 19 + 13
    if 192 < imgWidth then
      imgWidth = 192
    end
  end
  Log.fatal("######################", imgWidth)
  self._nameImg.sizeDelta = Vector2(imgWidth, 35)
  self._element.sprite = self._data.element
  for i = 1, #self._starTab do
    self._starTab[i]:SetActive(i <= self._data.star)
  end
end

function UIActivityPetTryItem:bgOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end

function UIActivityPetTryItem:OnSelected(idx)
  local select = idx == self._idx
  local animName
  if select and not self._selected then
    animName = "uieff_Activity_PetryItem_select"
  elseif not select and self._selected then
    animName = "uieff_Activity_PetryItem_unselect"
  end
  if animName then
    UIWidgetHelper.SetAnimationPlay(self, "_anim", animName)
  end
  self._selected = select
end
