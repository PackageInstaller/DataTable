_class("UIActivityPetTryPlusItem", UICustomWidget)
UIActivityPetTryPlusItem = UIActivityPetTryPlusItem

function UIActivityPetTryPlusItem:OnShow(uiParams)
  self._go = self:GetGameObject("go")
end

function UIActivityPetTryPlusItem:_GetComponents()
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._headRawImage = self:GetUIComponent("RawImage", "head")
  self._decorate = self:GetUIComponent("Transform", "decorate")
  self._element = self:GetUIComponent("Image", "element")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._offsetPos = self:GetGameObject("_offsetPos")
  self._belong = self:GetUIComponent("RawImageLoader", "_belong")
  self._starTab = {}
  for i = 1, 6 do
    local star = self:GetGameObject("star" .. i)
    self._starTab[i] = star
  end
  self._rect = self:GetUIComponent("RectTransform", "go")
end

function UIActivityPetTryPlusItem:SetData(index, data, offset, isShowBelong)
  self:_GetComponents()
  self._idx = index
  self._data = data
  self._pethead = data.pethead
  self._pass = data.pass
  self._offset = offset
  self._isShowBelong = isShowBelong
  self:_OnValue()
  self:AttachEvent(GameEventType.OnSummerTwoPetTryItemClick, self.OnSummerTwoPetTryItemClick)
end

function UIActivityPetTryPlusItem:Active(active)
  self._go:SetActive(active)
end

function UIActivityPetTryPlusItem:_OnValue()
  self._belong.gameObject:SetActive(self._isShowBelong)
  self._belong:LoadImage(self._data.logo)
  if not self._isShowBelong or self._data.icon then
  end
  self._head:LoadImage(self._data.cg)
  local cfg = Cfg.pet_cg_transform({
    ResName = self._data.cg,
    UIName = "UIBattleResultComplete"
  })
  if cfg then
    cfg = cfg[1]
    self._head.transform.localPosition = Vector3(cfg.CGTransform[1] - 40, cfg.CGTransform[2] - 100, 0)
    self._head.transform.localScale = Vector3(cfg.CGTransform[3], cfg.CGTransform[3], cfg.CGTransform[3])
  end
  local clipAngle = 0.4445
  self._headRawImage.material:SetFloat("_ClipAngle", clipAngle)
  for i = 0, self._decorate.childCount - 1 do
    self._decorate:GetChild(i):GetComponent(typeof(UnityEngine.UI.Image)).material:SetFloat("_ClipAngle", clipAngle)
  end
  self._name:SetText(self._data.name)
  if self._offset then
    local offset = self._offset
    self._offsetPos.transform.localPosition = Vector3(offset[1], offset[2], 0)
  end
  self._element.sprite = self._data.element
  for i = 1, #self._starTab do
    self._starTab[i]:SetActive(i <= self._data.star)
  end
end

function UIActivityPetTryPlusItem:detailsbtnOnClick(go)
  local id = self._data.petid
  self:ShowDialog("UIShopPetDetailController", id)
end
