_class("UIHomelandMovieSelectBtn", UICustomWidget)
UIHomelandMovieSelectBtn = UIHomelandMovieSelectBtn

function UIHomelandMovieSelectBtn:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomelandMovieSelectBtn:OnShow(uiParams)
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareTitleBtnClick, self.MoviePrepareTitleBtnClick)
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareItemBtnClick, self.RefreshUI)
  self:InitWidget()
end

function UIHomelandMovieSelectBtn:OnHide()
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareTitleBtnClick, self.MoviePrepareTitleBtnClick)
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareItemBtnClick, self.RefreshUI)
end

function UIHomelandMovieSelectBtn:InitWidget()
  self._stateGo = self:GetGameObject("state")
  self._state = self:GetUIComponent("Image", "state")
  self._txt = self:GetUIComponent("UILocalizationText", "txt")
  self._rect = self:GetUIComponent("RectTransform", "tra")
end

function UIHomelandMovieSelectBtn:SetData(index, data, prepareType, rectPos, selectTitleId, atlas)
  self._index = index
  self._data = data
  self._prepareType = prepareType
  self._rectPos = rectPos
  self._selectTitleId = selectTitleId
  self._atlas = atlas
  self:RefreshUI()
end

function UIHomelandMovieSelectBtn:RefreshUI()
  self._rect.anchoredPosition = self._rectPos
  if not self._data then
    return
  end
  local show = HomelandMoviePrepareManager:GetInstance():CheckHadSelect(self._prepareType, self._data.ID)
  self._stateGo:SetActive(not show)
  local sp = self._data.ID == self._selectTitleId and "dy_qqzb_xz02" or "dy_qqzb_xz01"
  self._state.sprite = self._atlas:GetSprite(sp)
  self._txt:SetText(StringTable.Get(self._data.Name))
end

function UIHomelandMovieSelectBtn:MoviePrepareTitleBtnClick(selectTitleId)
  self._selectTitleId = selectTitleId
  self:RefreshUI()
end

function UIHomelandMovieSelectBtn:BtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMovieSelectBtnClick, self._data.ID, self._prepareType)
end
