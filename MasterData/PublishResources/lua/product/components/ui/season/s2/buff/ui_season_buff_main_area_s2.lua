_class("UISeasonBuffMainAreaS2", UICustomWidget)
UISeasonBuffMainAreaS2 = UISeasonBuffMainAreaS2

function UISeasonBuffMainAreaS2:OnShow(uiParams)
  self.levelText = self:GetUIComponent("UILocalizationText", "Lv")
  self.fullAreaGo = self:GetGameObject("FullArea")
  self.fullAreaGo:SetActive(false)
  self.progressCellsGo = self:GetGameObject("ProgressCells")
  self.progressCellsGo:SetActive(true)
  self.progressCellsGen = self:GetUIComponent("UISelectObjectPath", "ProgressCells")
  self.btnRect = self:GetUIComponent("RectTransform", "DetailBtn")
  self.bgRect = self:GetUIComponent("RectTransform", "Bg")
  self._baseBgWidth = self.bgRect.sizeDelta.x
  self._baseBtnWidthWidth = self.btnRect.sizeDelta.x
  self._basePosX = self.btnRect.anchoredPosition.x
end

function UISeasonBuffMainAreaS2:DetailBtnOnClick()
  local uiMoudle = GameGlobal.GetUIModule(SeasonModule)
  if uiMoudle:SeasonManager():LockUI() then
    return
  end
  uiMoudle:SeasonManager():SeasonPlayerManager():GetPlayer():Stop(false)
  GameGlobal.UIStateManager():ShowDialog("UISeasonBuffMainInfoS2", self.componentID, self._curLevel, self._curProgress, self._isMaxLevel, self._curMaxProgress)
end

function UISeasonBuffMainAreaS2:SetData(obj)
  self._seasonObj = obj
  self._progressCells = self.progressCellsGen:SpawnObject("UISeasonBuffProgressCellsS2")
  self:RefreshInfo()
end

function UISeasonBuffMainAreaS2:RefreshInfo()
  self.componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  local curLevel, curProgress, maxLevel, isMaxLevel, curMaxProgress = UISeasonHelper.CalcBuffLevel(self.componentID)
  self._curLevel = curLevel
  self._curProgress = curProgress
  self._isMaxLevel = isMaxLevel
  self._curMaxProgress = curMaxProgress
  self.levelText:SetText(StringTable.Get("str_season_buff_level", tostring(curLevel)))
end
