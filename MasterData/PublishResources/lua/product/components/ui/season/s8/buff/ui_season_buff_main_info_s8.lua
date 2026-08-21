_class("UISeasonBuffMainInfoS8", UIController)
UISeasonBuffMainInfoS8 = UISeasonBuffMainInfoS8

function UISeasonBuffMainInfoS8:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self.levelText = self:GetUIComponent("UILocalizationText", "Lv")
  self.fullAreaGo = self:GetGameObject("FullArea")
  self.progressCellsGo = self:GetGameObject("ProgressCells")
  self.titleText = self:GetUIComponent("UILocalizationText", "BuffTitle")
  self.contentText = self:GetUIComponent("UILocalizationText", "Content")
  self.contentTitle = self:GetUIComponent("UILocalizationText", "ContentTitle")
  self.progressCellsGen = self:GetUIComponent("UISelectObjectPath", "ProgressCells")
  self.nextBtnGo = self:GetGameObject("NextBtn")
  self.nextBtnGo:SetActive(true)
  self.prevBtnGo = self:GetGameObject("PrevBtn")
  self.prevBtnGo:SetActive(false)
  self._sr = self:GetUIComponent("ScrollRect", "ContentScroll")
  self._animation = self:GetUIComponent("Animation", "animation")
  self.componentID = uiParams[1]
  self._curLevel = uiParams[2]
  self._curProgress = uiParams[3]
  self._isMaxLevel = uiParams[4]
  self._curMaxProgress = uiParams[5]
  self._curShowContentLevel = self._curLevel
  self:InitInfo()
  self:RefreshContent()
end

function UISeasonBuffMainInfoS8:InitInfo()
  self.levelText:SetText(StringTable.Get("str_season_buff_level", tostring(self._curLevel)))
  self.fullAreaGo:SetActive(self._isMaxLevel)
  self.progressCellsGo:SetActive(not self._isMaxLevel)
  self.nextBtnGo:SetActive(not self._isMaxLevel)
  self._progressCells = self.progressCellsGen:SpawnObject("UISeasonBuffProgressCellsS8")
  self._progressCells:SetData(self._curProgress, self._curMaxProgress)
end

function UISeasonBuffMainInfoS8:RefreshContent()
  self.titleText:SetText(StringTable.Get(UISeasonHelper.CurSeasonBuffTitleInBattle()))
  if self._curShowContentLevel == self._curLevel then
    self.contentTitle:SetText(StringTable.Get("str_season_buff_detail_title_current"))
  else
    self.contentTitle:SetText(StringTable.Get("str_season_buff_detail_title_next"))
  end
  local cfgGroup = Cfg.cfg_component_season_wordbuff({
    ComponentID = self.componentID,
    Lv = self._curShowContentLevel
  })
  if cfgGroup and 0 < #cfgGroup then
    local cfg = cfgGroup[1]
    local desc = cfg.Desc
    self.contentText:SetText(StringTable.Get(desc))
  else
    self.contentText:SetText("")
  end
  if self._sr then
    self._sr.verticalNormalizedPosition = 0
  end
end

function UISeasonBuffMainInfoS8:BgOnClick()
  self:_CloseWithAni()
end

function UISeasonBuffMainInfoS8:CloseBtnOnClick()
  self:_CloseWithAni()
end

function UISeasonBuffMainInfoS8:_CloseWithAni()
  self:Lock("UISeasonBuffMainInfoS8:CloseAni")
  self:StartTask(function(TT)
    YIELD(TT, 130)
    self:CloseDialog()
    self:UnLock("UISeasonBuffMainInfoS8:CloseAni")
  end)
end

function UISeasonBuffMainInfoS8:NextBtnOnClick()
  self.nextBtnGo:SetActive(false)
  self.prevBtnGo:SetActive(true)
  self._curShowContentLevel = self._curShowContentLevel + 1
  self:RefreshContent()
end

function UISeasonBuffMainInfoS8:PrevBtnOnClick()
  self.nextBtnGo:SetActive(true)
  self.prevBtnGo:SetActive(false)
  self._curShowContentLevel = self._curShowContentLevel - 1
  self:RefreshContent()
end

function UISeasonBuffMainInfoS8:HelpOnClick()
  GameGlobal.UIStateManager():ShowDialog("UISeasonBuffMainTipsS8")
end
