_class("UIWeekTowerNodeItem", UICustomWidget)
UIWeekTowerNodeItem = UIWeekTowerNodeItem

function UIWeekTowerNodeItem:OnShow(uiParams)
  self._type2pos = {
    [0] = -106,
    [1] = 106
  }
  self._type2size = {
    [1] = {
      [1] = Vector3(0.9, 0.9, 0.9),
      [2] = Vector3(1, 1, 1)
    },
    [2] = {
      [1] = Vector3(0.85, 0.85, 0.85),
      [2] = Vector3(1, 1, 1)
    }
  }
  self._uiModule = GameGlobal.GetUIModule(LostAreaModule)
  self:GetComponents()
  self:AttachEvent(GameEventType.OnUIWeekTowerNodeItemClick, self.OnUIWeekTowerNodeItemClick)
end

function UIWeekTowerNodeItem:OnUIWeekTowerNodeItemClick(index)
  if self._index == index then
    self:Select(true)
  else
    self:Select(false)
  end
end

function UIWeekTowerNodeItem:Select(select)
  if select then
    self._scale.localScale = self._type2size[self._type][2]
  else
    self._scale.localScale = self._type2size[self._type][1]
  end
end

function UIWeekTowerNodeItem:SetData(index, _missionCount, data, callback, width, open)
  self._index = index
  self._missionCount = _missionCount
  self._missionData = data
  self._callback = callback
  self._width = width
  self._open = open
  self._upOrDown = self._missionData:GetNodeUpOrDown()
  self._showLineY = self._missionData:ShowLineY()
  self:OnValue()
end

function UIWeekTowerNodeItem:GetComponents()
  self._go = self:GetGameObject("rect")
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._nameTex2 = self:GetUIComponent("UILocalizationText", "name2")
  self._lock = self:GetGameObject("lock")
  self._clean = self:GetGameObject("clean")
  self._lineY = self:GetGameObject("lineY")
  self._lineX1 = self:GetUIComponent("RectTransform", "lineX1")
  self._lineX2 = self:GetUIComponent("RectTransform", "lineX2")
  self._pos = self:GetUIComponent("RectTransform", "pos")
  self._iconMaskGo = self:GetGameObject("iconMask")
  self._scale = self:GetUIComponent("Transform", "scale")
  self._stars = {}
  self._emptyStars = {}
  for i = 1, 3 do
    self._stars[i] = self:GetGameObject("star" .. i)
    self._emptyStars[i] = self:GetGameObject("starEmpty" .. i)
  end
  self._notOpen = self:GetGameObject("notOpen")
end

function UIWeekTowerNodeItem:Active(active)
  self._go:SetActive(active)
end

function UIWeekTowerNodeItem:OnValue()
  self._type = self._missionData:GetType()
  local name = self._missionData:GetMissionName()
  self._nameTex:SetText(name)
  local name2 = self._missionData:GetMissionName2()
  self._nameTex2:SetText(name2)
  local passState = self._missionData:GetPassTime()
  self._lock:SetActive(false)
  self._notOpen:SetActive(passState == UILostLandMissionLockType.LOCK or not self._open)
  self._clean:SetActive(passState == UILostLandMissionLockType.PASS)
  self._iconMaskGo:SetActive(passState == UILostLandMissionLockType.LOCK or not self._open or passState == UILostLandMissionLockType.PASS)
  self._lineX1.sizeDelta = Vector2(self._width * 0.5, self._lineX1.sizeDelta.y)
  self._lineX2.sizeDelta = Vector2(self._width * 0.5, self._lineX1.sizeDelta.y)
  local pos = Vector2(0, self._type2pos[self._upOrDown])
  self._pos.anchoredPosition = pos
  if self._index == 1 then
    self._lineX1.gameObject:SetActive(false)
  else
    self._lineX1.gameObject:SetActive(true)
  end
  if self._index == self._missionCount then
    self._lineX2.gameObject:SetActive(false)
  else
    self._lineX2.gameObject:SetActive(true)
  end
  if self._showLineY then
    self._lineY:SetActive(true)
  else
    self._lineY:SetActive(false)
  end
  local threeStarConds = self._missionData:Get3StarConditions()
  for i = 1, 3 do
    local cond = threeStarConds[i]
    local hasStar = cond and cond.satisfy
    self._stars[i]:SetActive(hasStar)
    self._emptyStars[i]:SetActive(not hasStar)
  end
end

function UIWeekTowerNodeItem:Open()
  self._open = true
  local passState = self._missionData:GetPassTime()
  self._notOpen:SetActive(self._missionData:GetPassTime() == UILostLandMissionLockType.LOCK or not self._open)
  self._iconMaskGo:SetActive(passState == UILostLandMissionLockType.LOCK or not self._open or passState == UILostLandMissionLockType.PASS)
end

function UIWeekTowerNodeItem:bgOnClick(go)
  if self._callback then
    self._callback(self._index, not self._open)
  end
end
