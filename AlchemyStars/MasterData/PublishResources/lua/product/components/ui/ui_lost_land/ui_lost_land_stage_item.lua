_class("UILostLandStageItem", UICustomWidget)
UILostLandStageItem = UILostLandStageItem

function UILostLandStageItem:OnShow(uiParams)
  self._type2pos = {
    [0] = -100,
    [1] = 100
  }
  self._uiModule = GameGlobal.GetUIModule(LostAreaModule)
  self:GetComponents()
  self:AttachEvent(GameEventType.OnUILostLandStageItemClick, self.OnUILostLandStageItemClick)
end

function UILostLandStageItem:OnUILostLandStageItemClick(groupIdx, stageIdx)
  if self._groupIdx == groupIdx and self._stageIdx == stageIdx then
    self:Select(true)
  else
    self:Select(false)
  end
end

function UILostLandStageItem:Select(select)
  self._select:SetActive(select)
end

function UILostLandStageItem:SetData(groupIdx, stageIdx, groupCount, stageCount, missionId, callback, upOrDown, width)
  self._groupIdx = groupIdx
  self._stageIdx = stageIdx
  self._groupCount = groupCount
  self._stageCount = stageCount
  self._missionId = missionId
  self._callback = callback
  self._upOrDown = upOrDown
  self._width = width
  self._missionData = self._uiModule:GetMissionDataByMissionID(self._missionId)
  if self._missionData == nil then
    Log.error("###[UILostLandStageItem] ####### mission data is nil ########self._groupIdx -> ", self._groupIdx, "###self._stageIdx -> ", self._stageIdx, "###self._missionId -> ", self._missionId)
  end
  self:OnValue()
end

function UILostLandStageItem:GetComponents()
  self._go = self:GetGameObject("rect")
  self._layoutElement = self:GetUIComponent("LayoutElement", "UILostLandStageItem")
  self._layoutElementRect = self:GetUIComponent("RectTransform", "UILostLandStageItem")
  self._normalName = self:GetUIComponent("UILocalizationText", "normalName")
  self._bossName = self:GetUIComponent("UILocalizationText", "bossName")
  self._select = self:GetGameObject("select")
  self._select:SetActive(false)
  self._boss = self:GetGameObject("boss")
  self._normal = self:GetGameObject("normal")
  self._lock = self:GetGameObject("lock")
  self._lineY = self:GetGameObject("lineY")
  self._lineX1 = self:GetUIComponent("RectTransform", "lineX1")
  self._lineX2 = self:GetUIComponent("RectTransform", "lineX2")
  self._pos = self:GetUIComponent("RectTransform", "pos")
end

function UILostLandStageItem:Active(active)
  self._go:SetActive(active)
end

function UILostLandStageItem:OnValue()
  local type = self._missionData:GetType()
  local name = self._missionData:GetMissionName()
  local width = 0
  if type == UILostLandMissionType.BOSS then
    self._boss:SetActive(true)
    self._normal:SetActive(false)
    self._bossName:SetText(self._groupIdx .. "-" .. self._stageIdx .. " " .. StringTable.Get(name))
    width = self._width[2]
  else
    self._boss:SetActive(false)
    self._normal:SetActive(true)
    self._normalName:SetText(self._groupIdx .. "-" .. self._stageIdx .. " " .. StringTable.Get(name))
    width = self._width[1]
  end
  self._layoutElement.preferredWidth = width
  self._layoutElementRect.sizeDelta = Vector2(self._lineX1.sizeDelta.x, 500)
  local lock = self._missionData:GetLockType()
  if lock == UILostLandMissionLockType.LOCK then
    self._lock:SetActive(true)
  else
    self._lock:SetActive(false)
  end
  self._lineX1.sizeDelta = Vector2(width * 0.5, self._lineX1.sizeDelta.y)
  self._lineX2.sizeDelta = Vector2(width * 0.5, self._lineX1.sizeDelta.y)
  local pos = Vector2(0, self._type2pos[self._upOrDown])
  self._pos.anchoredPosition = pos
  if self._stageIdx == 1 and self._groupIdx == 1 then
    self._lineX1.gameObject:SetActive(false)
  else
    self._lineX1.gameObject:SetActive(true)
  end
  if self._stageIdx == self._stageCount and self._groupIdx == self._groupCount then
    self._lineX2.gameObject:SetActive(false)
  else
    self._lineX2.gameObject:SetActive(true)
  end
  if self._stageIdx == 1 and self._groupIdx ~= 1 then
    self._lineY:SetActive(true)
  else
    self._lineY:SetActive(false)
  end
end

function UILostLandStageItem:bgOnClick(go)
  if self._callback then
    self._callback(self._groupIdx, self._stageIdx)
  end
end
