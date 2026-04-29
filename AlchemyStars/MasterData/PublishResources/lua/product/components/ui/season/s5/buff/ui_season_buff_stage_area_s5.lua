_class("UISeasonBuffStageAreaS5", UICustomWidget)
UISeasonBuffStageAreaS5 = UISeasonBuffStageAreaS5

function UISeasonBuffStageAreaS5:OnShow(uiParams)
  self.levelText = self:GetUIComponent("UILocalizationText", "Lv")
end

function UISeasonBuffStageAreaS5:DetailBtnOnClick()
  GameGlobal.UIStateManager():ShowDialog("UISeasonBuffMainInfoS5", self.componentID, self._curLevel, self._curProgress, self._isMaxLevel, self._curMaxProgress)
end

function UISeasonBuffStageAreaS5:SetData(obj)
  self._seasonObj = obj
  self.componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  self:RefreshInfo()
end

function UISeasonBuffStageAreaS5:RefreshInfo()
  local curLevel, curProgress, maxLevel, isMaxLevel, curMaxProgress = UISeasonHelper.CalcBuffLevel(self.componentID)
  self._curLevel = curLevel
  self._curProgress = curProgress
  self._isMaxLevel = isMaxLevel
  self._curMaxProgress = curMaxProgress
  self.levelText:SetText(StringTable.Get("str_season_buff_level", tostring(curLevel)))
end
