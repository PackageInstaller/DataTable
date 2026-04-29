_class("UISeasonBuffStageAreaS6", UICustomWidget)
UISeasonBuffStageAreaS6 = UISeasonBuffStageAreaS6

function UISeasonBuffStageAreaS6:OnShow(uiParams)
  self.levelText = self:GetUIComponent("UILocalizationText", "Lv")
end

function UISeasonBuffStageAreaS6:DetailBtnOnClick()
  GameGlobal.UIStateManager():ShowDialog("UISeasonBuffMainInfoS6", self.componentID, self._curLevel, self._curProgress, self._isMaxLevel, self._curMaxProgress)
end

function UISeasonBuffStageAreaS6:SetData(obj)
  self._seasonObj = obj
  self.componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  self:RefreshInfo()
end

function UISeasonBuffStageAreaS6:RefreshInfo()
  local curLevel, curProgress, maxLevel, isMaxLevel, curMaxProgress = UISeasonHelper.CalcBuffLevel(self.componentID)
  self._curLevel = curLevel
  self._curProgress = curProgress
  self._isMaxLevel = isMaxLevel
  self._curMaxProgress = curMaxProgress
  self.levelText:SetText(StringTable.Get("str_season_buff_level", tostring(curLevel)))
end
