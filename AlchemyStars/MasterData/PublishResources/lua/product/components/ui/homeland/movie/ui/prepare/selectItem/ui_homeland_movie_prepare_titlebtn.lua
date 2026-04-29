_class("UIHomelandMoviePrepareTitleBtn", UICustomWidget)
UIHomelandMoviePrepareTitleBtn = UIHomelandMoviePrepareTitleBtn

function UIHomelandMoviePrepareTitleBtn:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomelandMoviePrepareTitleBtn:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareItemSelect, self.RefreshUI)
  self._btnNames = {
    [1] = "str_movie_item_btn_type1",
    [2] = "str_movie_item_btn_type2",
    [3] = "str_movie_item_btn_type3",
    [4] = "str_movie_item_btn_type4"
  }
end

function UIHomelandMoviePrepareTitleBtn:OnHide()
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareItemSelect, self.RefreshUI)
end

function UIHomelandMoviePrepareTitleBtn:InitWidget()
  self._selectImg = self:GetUIComponent("Image", "select")
  self._select = self:GetGameObject("select")
  self._mask = self:GetGameObject("mask")
  self._txt = self:GetUIComponent("UILocalizationText", "txt")
end

function UIHomelandMoviePrepareTitleBtn:SetData(index, data, prepareType, selectTitleId, atlas)
  self._index = index
  self._atlas = atlas
  self._data = data
  self._selectTitleId = selectTitleId
  self._prepareType = prepareType
  self:RefreshUI()
end

function UIHomelandMoviePrepareTitleBtn:RefreshUI()
  if not self._data then
    return
  end
  self._select:SetActive(self._selectTitleId == self._data.ID)
  local sp = self._selectTitleId == self._data.ID and "n17_layout_btn03" or "n17_layout_btn03"
  self._selectImg.sprite = self._atlas:GetSprite(sp)
  self._txt:SetText(StringTable.Get(self._data.Name))
  self._txt.color = self._selectTitleId == self._data.ID and Color(1, 1, 1) or Color(0.40784313725490196, 0.40784313725490196, 0.40784313725490196)
end

function UIHomelandMoviePrepareTitleBtn:BtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMoviePrepareTitleBtnClick, self._data.ID, self._prepareType)
end
