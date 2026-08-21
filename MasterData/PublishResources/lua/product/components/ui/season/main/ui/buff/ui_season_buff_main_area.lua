_class("UISeasonBuffMainArea", UICustomWidget)
UISeasonBuffMainArea = UISeasonBuffMainArea

function UISeasonBuffMainArea:OnShow(uiParams)
  self.levelText = self:GetUIComponent("UILocalizationText", "Lv")
  self.fullAreaGo = self:GetGameObject("FullArea")
  self.fullAreaGo:SetActive(false)
  self.progressCellsRect = self:GetUIComponent("RectTransform", "ProgressCells")
  self.progressCellsGo = self:GetGameObject("ProgressCells")
  self.progressCellsGo:SetActive(true)
  self.progressCellsGen = self:GetUIComponent("UISelectObjectPath", "ProgressCells")
  self.btnRect = self:GetUIComponent("RectTransform", "DetailBtn")
  self.bgRect = self:GetUIComponent("RectTransform", "Bg")
  self._baseBgWidth = self.bgRect.sizeDelta.x
  self._baseBtnWidthWidth = self.btnRect.sizeDelta.x
  self._basePosX = self.btnRect.anchoredPosition.x
  self._progressAreaLayout = self:GetUIComponent("LayoutElement", "ProgressArea")
end

function UISeasonBuffMainArea:DetailBtnOnClick()
  local uiMoudle = GameGlobal.GetUIModule(SeasonModule)
  if uiMoudle:SeasonManager():LockUI() then
    return
  end
  uiMoudle:SeasonManager():SeasonPlayerManager():GetPlayer():Stop(false)
  GameGlobal.UIStateManager():ShowDialog("UISeasonBuffMainInfo", self.componentID, self._curLevel, self._curProgress, self._isMaxLevel, self._curMaxProgress)
end

function UISeasonBuffMainArea:SetData(obj)
  self._seasonObj = obj
  self._progressCells = self.progressCellsGen:SpawnObject("UISeasonBuffProgressCells")
  self:RefreshInfo()
end

function UISeasonBuffMainArea:RefreshInfo()
  self.componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  local curLevel, curProgress, maxLevel, isMaxLevel, curMaxProgress = UISeasonHelper.CalcBuffLevel(self.componentID)
  self._curLevel = curLevel
  self._curProgress = curProgress
  self._isMaxLevel = isMaxLevel
  self._curMaxProgress = curMaxProgress
  self.levelText:SetText(StringTable.Get("str_season_buff_level", tostring(curLevel)))
  self.fullAreaGo:SetActive(isMaxLevel)
  self.progressCellsGo:SetActive(not isMaxLevel)
  if self._progressCells then
    self._progressCells:SetData(curProgress, curMaxProgress)
  end
  if isMaxLevel then
    self._progressAreaLayout.preferredWidth = 0
  else
    self.progressCellsRect.anchoredPosition = Vector2(-(self._curMaxProgress - 2) * 40 - 10, 0)
    self._progressAreaLayout.preferredWidth = self._curMaxProgress * 40
  end
end
