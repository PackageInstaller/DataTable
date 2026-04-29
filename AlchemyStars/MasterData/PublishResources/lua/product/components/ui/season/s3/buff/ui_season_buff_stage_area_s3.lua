_class("UISeasonBuffStageAreaS3", UICustomWidget)
UISeasonBuffStageAreaS3 = UISeasonBuffStageAreaS3

function UISeasonBuffStageAreaS3:OnShow(uiParams)
  self.levelText = self:GetUIComponent("UILocalizationText", "Lv")
end

function UISeasonBuffStageAreaS3:DetailBtnOnClick()
  GameGlobal.UIStateManager():ShowDialog("UISeasonBuffMainInfoS3", self.componentID, self._curLevel, self._curProgress, self._isMaxLevel, self._curMaxProgress)
end

function UISeasonBuffStageAreaS3:SetData(obj)
  self._seasonObj = obj
  self.componentID = self._seasonObj:GetSeasonMissionComponentCfgID()
  self:RefreshInfo()
end

function UISeasonBuffStageAreaS3:RefreshInfo()
  local curLevel, curProgress, maxLevel, isMaxLevel, curMaxProgress = UISeasonHelper.CalcBuffLevel(self.componentID)
  self._curLevel = curLevel
  self._curProgress = curProgress
  self._isMaxLevel = isMaxLevel
  self._curMaxProgress = curMaxProgress
  self.levelText:SetText(StringTable.Get("str_season_buff_level", tostring(curLevel)))
end
