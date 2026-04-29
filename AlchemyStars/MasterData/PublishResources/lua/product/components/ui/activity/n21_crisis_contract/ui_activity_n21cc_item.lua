_class("UIActivityN21CCItem", UICustomWidget)
UIActivityN21CCItem = UIActivityN21CCItem

function UIActivityN21CCItem:OnShow()
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._element1Loader = self:GetUIComponent("RawImageLoader", "Element1")
  self._element2Loader = self:GetUIComponent("RawImageLoader", "Element2")
  self._element1Go = self:GetGameObject("Element1")
  self._element2Go = self:GetGameObject("Element2")
  self._new = self:GetGameObject("New")
  self._red = self:GetGameObject("Red")
  self._btn = self:GetUIComponent("Image", "Btn")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN21CCItem:OnHide()
end

function UIActivityN21CCItem:PlayAnim()
  self._anim:Play("UIActivityN21CCItem_in")
end

function UIActivityN21CCItem:Refresh(levelGroupData, onlyShow, callback)
  self._levelGroupData = levelGroupData
  if not self._levelGroupData then
    self._go:SetActive(false)
    return
  end
  self._callback = callback
  self._go:SetActive(true)
  self._iconLoader:LoadImage(self._levelGroupData:GetIcon())
  self._nameLabel:SetText(self._levelGroupData:GetName())
  self._scoreLabel:SetText(self._levelGroupData:GetMaxScore())
  local elementIcon1 = self._levelGroupData:GetElementIcon1()
  if string.isnullorempty(elementIcon1) then
    self._element1Go:SetActive(false)
  else
    self._element1Go:SetActive(true)
    self._element1Loader:LoadImage(elementIcon1)
  end
  local elementIcon2 = self._levelGroupData:GetElementIcon2()
  if string.isnullorempty(elementIcon2) then
    self._element2Go:SetActive(false)
  else
    self._element2Go:SetActive(true)
    self._element2Loader:LoadImage(elementIcon2)
  end
  local isShowRed = self._levelGroupData:IsShowRed()
  local isShowNew = self._levelGroupData:IsShowNew()
  if onlyShow then
    self._new:SetActive(false)
    self._red:SetActive(false)
    self._btn.raycastTarget = false
  else
    self._btn.raycastTarget = true
    self._new:SetActive(false)
    self._red:SetActive(false)
    if isShowNew then
      self._new:SetActive(true)
    elseif isShowRed then
      self._red:SetActive(true)
    end
  end
end

function UIActivityN21CCItem:SetTransform(localPosition, angle, scale)
  local tran = self._go.transform
  tran.localPosition = localPosition
  tran.localEulerAngles = Vector3(0, 0, angle)
  tran.localScale = Vector3(scale, scale, scale)
end

function UIActivityN21CCItem:BtnOnClick()
  if self._callback then
    self._callback(self._levelGroupData)
  end
  self._new:SetActive(false)
  self._red:SetActive(false)
end

function UIActivityN21CCItem:PlayEnterAnim(count, index)
  self._anim:Play("UIActivityN21CCItem_" .. count .. "_" .. index)
end

function UIActivityN21CCItem:SetStatus(status)
  self._go:SetActive(status)
end
