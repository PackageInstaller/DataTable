_class("UIHomelandMinimapArrow", UICustomWidget)
UIHomelandMinimapArrow = UIHomelandMinimapArrow

function UIHomelandMinimapArrow:OnShow()
  self._go = self:GetGameObject("Arrow")
  self._arrowTran = self:GetUIComponent("RectTransform", "Arrow")
  self._iconArrowTran = self:GetUIComponent("RectTransform", "Icons")
  self._playerArrow = self:GetGameObject("PlayerArrow")
  self._otherArrow = self:GetGameObject("OtherArrow")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconTran = self:GetUIComponent("RectTransform", "Icon")
end

function UIHomelandMinimapArrow:OnHide()
end

function UIHomelandMinimapArrow:Update()
  if not self._iconData then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(false)
  local container = self._iconData:GetIconContainer()
  local position = container:GetIconPosition()
  if self._iconData:GetMinimapStatus() == MinimapStatus.Big then
    if not self._iconData:CanShow(self._iconData:GetMapScale()) then
      self._go:SetActive(false)
      return
    end
    local width, height = self._iconData:GetScreenInfo()
    local minBorderPos = Vector2(-width / 2, -height / 2)
    local maxBorderPos = Vector2(width / 2, height / 2)
    local iconWidth = 40
    if position.x < minBorderPos.x - iconWidth / 2 or position.x > maxBorderPos.x + iconWidth / 2 or position.y < minBorderPos.y - iconWidth / 2 or position.y > maxBorderPos.y + iconWidth / 2 then
      self._go:SetActive(true)
      self:GetGameObject("Bg"):SetActive(true)
      self._otherArrow:SetActive(true)
      local pos = Vector2()
      local tan1 = height / width
      local tan2 = math.abs(position.y) / math.abs(position.x)
      if tan1 < tan2 then
        pos.y = position.y / math.abs(position.y) * height / 2
        pos.x = pos.y / position.y * position.x
      elseif tan1 >= tan2 then
        pos.x = position.x / math.abs(position.x) * width / 2
        pos.y = pos.x / position.x * position.y
      end
      self._arrowTran.anchoredPosition = pos
      local rot = Quaternion.FromToRotation(Vector3.up, container:GetIconWorldPosition() - self._arrowTran.position)
      self._arrowTran.rotation = rot
      if self._iconData:IsArrowIconRotation() then
        self._iconArrowTran.eulerAngles = container:GetIconRotation()
      else
        self._iconArrowTran.eulerAngles = Vector3(0, 0, 0)
      end
      self._iconTran.anchoredPosition = self._iconData:GetArrowIconOffset()
      self._iconTran.sizeDelta = self._iconData:GetArrowIconSize()
    else
      self._go:SetActive(false)
    end
  end
  if self._iconData:GetMinimapStatus() == MinimapStatus.Mini and self._iconData:GetId() == HomelandMapIconType.TracePoint then
    if not self._iconData:CanShow(self._iconData:GetMapScale()) then
      self._go:SetActive(false)
      return
    end
    local width, height = self._iconData:GetScreenInfo()
    local iconWidth = 40
    if position.x * position.x + position.y * position.y > iconWidth / 2 * (iconWidth / 2) then
      self._go:SetActive(true)
      self:GetGameObject("Bg"):SetActive(false)
      self._otherArrow:SetActive(false)
      local rw = width / 2
      local rh = height / 2
      local pos = position.normalized
      if pos then
        pos.y = pos.y * rw
        pos.x = pos.x * rh
      end
      self._arrowTran.anchoredPosition = pos
      local rot = Quaternion.FromToRotation(Vector3.up, container:GetIconWorldPosition() - self._arrowTran.position)
      self._arrowTran.rotation = rot
      if self._iconData:IsArrowIconRotation() then
        self._iconArrowTran.eulerAngles = container:GetIconRotation()
      else
        self._iconArrowTran.eulerAngles = Vector3(0, 0, 0)
      end
      self._iconTran.anchoredPosition = self._iconData:GetArrowIconOffset()
      self._iconTran.sizeDelta = self._iconData:GetArrowIconSize()
    else
      self._go:SetActive(false)
    end
  end
end

function UIHomelandMinimapArrow:Refresh(iconData)
  self._iconData = iconData
  if self._iconData:IsPlayer() then
    self._playerArrow:SetActive(true)
    self._otherArrow:SetActive(false)
  else
    self._playerArrow:SetActive(false)
    self._otherArrow:SetActive(true)
  end
  self._iconLoader:LoadImage(self._iconData:GetArrowIcon())
end

function UIHomelandMinimapArrow:SetStatus(status)
  self._go:SetActive(status)
end
