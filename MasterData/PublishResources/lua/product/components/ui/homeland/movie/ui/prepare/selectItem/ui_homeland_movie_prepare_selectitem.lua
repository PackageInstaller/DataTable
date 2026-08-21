_class("UIHomelandMoviePrepareSelectItem", UIHomelandMoviePrepareBase)
UIHomelandMoviePrepareSelectItem = UIHomelandMoviePrepareSelectItem

function UIHomelandMoviePrepareSelectItem:Constructor()
  self._movieCfgData = MovieDataHelper:New()
  self._phaseBtns = {}
  self._operateBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  self._moviePrepareManager = HomelandMoviePrepareManager:GetInstance()
  self._moviePrepareManager:Init(self._operateBuilding, self._movieCfgData)
  self._movieImgSp = {
    [MoviePrepareType.PT_Scene] = "dy_qqzb_tu01",
    [MoviePrepareType.PT_Prop] = "dy_qqzb_tu02",
    [MoviePrepareType.PT_Actor] = "dy_qqzb_tu03"
  }
end

function UIHomelandMoviePrepareSelectItem:SetPhasePanel(panel, phasePanelRect)
  self._phasePanel = panel
  self._phasePanelRect = phasePanelRect
end

function UIHomelandMoviePrepareSelectItem:Refresh(prepareType)
  HomelandMoviePrepareManager:GetInstance():SetPhaseType(prepareType)
  self._movieId = MoviePrepareData:GetInstance():GetMovieId()
  self._selectTitleId = nil
  self._selectItemId = nil
  self._prepareType = prepareType
  self._selectTitleId, self._selectItemId = self._moviePrepareManager:GetFirstTitleAndItem(self._prepareType)
  self:RefreshUI()
end

function UIHomelandMoviePrepareSelectItem:CheckExit(prepareType)
  local actorCfg = self._movieCfgData:GetMovieItemTitleById(self._movieId, MoviePrepareType.PT_Actor)
  local actors = self._moviePrepareManager:GetSelectedData(MoviePrepareType.PT_Actor)
  if #actors >= #actorCfg then
    return true
  end
  return false
end

function UIHomelandMoviePrepareSelectItem:Clear(prepareType)
  if prepareType == self._prepareType then
    self._moviePrepareManager:ClearAll(self._prepareType)
    self:RefreshUI()
  end
end

function UIHomelandMoviePrepareSelectItem:OnExit()
  self._moviePrepareManager:ClearShadowObject()
  self._moviePrepareManager:HideAllOutline(self._prepareType)
end

function UIHomelandMoviePrepareSelectItem:SetCamera(camera)
  self._camera = camera
end

function UIHomelandMoviePrepareSelectItem:OnShow()
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareItemSelect, self.RefreshUI)
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareTitleBtnClick, self.TitleBtnOnClick)
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareItemBtnClick, self.SelectItemBtnOnClick)
  self:AttachEvent(GameEventType.UIHomelandMovieSelectBtnClick, self.TitleBtnOnClick)
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareItemsSelected, self.OnPrepareItemsSelected)
  self:InitWidget()
end

function UIHomelandMoviePrepareSelectItem:OnHide()
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareItemSelect, self.RefreshUI)
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareTitleBtnClick, self.TitleBtnOnClick)
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareItemBtnClick, self.SelectItemBtnOnClick)
  self:DetachEvent(GameEventType.UIHomelandMovieSelectBtnClick, self.TitleBtnOnClick)
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareItemsSelected, self.OnPrepareItemsSelected)
  self._prepareType = nil
  self._movieCfgData = nil
end

function UIHomelandMoviePrepareSelectItem:InitWidget()
  self._atlas = self:GetAsset("UIHomelandMovie.spriteatlas", LoadType.SpriteAtlas)
  self._dynamictitles = self:GetUIComponent("UISelectObjectPath", "TitleItem")
  self._dynamicitems = self:GetUIComponent("UISelectObjectPath", "RowItem")
  self._infoText = self:GetUIComponent("UILocalizationText", "InfoText")
  self._movieImg = self:GetUIComponent("Image", "movieImg")
  self._empthImage = self:GetGameObject("empthImage")
end

function UIHomelandMoviePrepareSelectItem:_GetShowData()
  self._itemTitles = self._movieCfgData:GetMovieItemTitleById(self._movieId, self._prepareType)
end

function UIHomelandMoviePrepareSelectItem:RefreshUI()
  self:_GetShowData()
  self:RefreshItemTitle()
  self:RefreshItems()
  local id = self._movieId
  local cfg = Cfg.cfg_homeland_movice({})
  if cfg[id].DecorativePic then
    self._movieImg.sprite = self._atlas:GetSprite(cfg[id].DecorativePic)
  else
    Log.fatal("cfg_homeland_movice中未配置电影装饰图")
  end
end

function UIHomelandMoviePrepareSelectItem:RefreshItemTitle()
  if self._itemTitles == nil or #self._itemTitles == 0 then
    self._dynamictitles:SpawnObjects("UIHomelandMoviePrepareTitleBtn", 0)
  else
    self._selectTitleId = self._selectTitleId == nil and self._itemTitles[1] or self._selectTitleId
    self._dynamictitles:SpawnObjects("UIHomelandMoviePrepareTitleBtn", #self._itemTitles)
    self._titlesItems = self._dynamictitles:GetAllSpawnList()
    for index, item in pairs(self._titlesItems) do
      local uiNode = self._titlesItems[index]
      local data = self._movieCfgData:GetMovieItemByItemId(self._itemTitles[index])
      uiNode:SetData(index, data, self._prepareType, self._selectTitleId, self._atlas)
    end
  end
end

function UIHomelandMoviePrepareSelectItem:RefreshSelectBtns()
  if not self._itemTitles then
    return
  end
  if self._itemTitles == nil or #self._itemTitles == 0 or self._prepareType == MoviePrepareType.PT_Scene then
    self._phasePanel:SpawnObjects("UIHomelandMovieSelectBtn", 0)
  else
    self._globalCamera = GameGlobal.GetUIModule(HomelandModule):GetClient():CameraManager():GlobalCameraController():CameraCmp()
    self._phasePanel:SpawnObjects("UIHomelandMovieSelectBtn", #self._itemTitles)
    self._itemSelectbtns = self._phasePanel:GetAllSpawnList()
    for index, item in pairs(self._itemTitles) do
      local uiNode = self._itemSelectbtns[index]
      local data = self._movieCfgData:GetMovieItemByItemId(self._itemTitles[index])
      local pathRoot = self._operateBuilding:Transform():Find("MoviePath")
      if not data then
        Log.fatal("RefreshSelectBtns()" .. self._itemTitles[index])
      end
      local posinfo = data.HangPoint
      local parent = pathRoot:Find(posinfo)
      local sceenPos = self._moviePrepareManager:WorldToScreenPoint(self._globalCamera, parent.position)
      local targevec = Vector2(sceenPos.x, sceenPos.y)
      local res, rectPos = self._moviePrepareManager:ScreenPointToLocalPointInRectangle(self._phasePanelRect, self._camera, targevec)
      uiNode:SetData(index, data, self._prepareType, rectPos, self._selectTitleId, self._atlas)
    end
  end
end

function UIHomelandMoviePrepareSelectItem:ClearSelectBtns()
  if self._phasePanel then
    self._phasePanel:SpawnObjects("UIHomelandMovieSelectBtn", 0)
  end
end

function UIHomelandMoviePrepareSelectItem:RefreshItems()
  self._showitem = self._movieCfgData:GetMovieItemByItemId(self._selectTitleId)
  if self._showitem == nil or #self._showitem == 0 then
    self._dynamicitems:SpawnObjects("UIHomelandMoviePrepareItem", 0)
    self._infoText:SetText("<color=#F9F8F0>_____</color>" .. StringTable.Get("str_movie_item_null"))
    self._empthImage:SetActive(true)
  else
    self._empthImage:SetActive(false)
    local selectables = self._showitem.SelectList
    self._selectItemId = self._selectItemId == nil and selectables[1] or self._selectItemId
    self._dynamicitems:SpawnObjects("UIHomelandMoviePrepareItem", #selectables)
    self._items = self._dynamicitems:GetAllSpawnList()
    for index, item in pairs(self._items) do
      local uiNode = self._items[index]
      uiNode:SetData(index, selectables[index], self._prepareType, self._selectItemId, self._selectTitleId, self._movieCfgData, self._atlas)
    end
    self._infoText:SetText("<color=#F9F8F0>_____</color>" .. StringTable.Get(self._showitem.Introduction))
  end
end

function UIHomelandMoviePrepareSelectItem:OnSwitchTitleId(selectTitleId)
  self._selectTitleId = selectTitleId
  self:RefreshUI()
end

function UIHomelandMoviePrepareSelectItem:OnSelectSceneObject(selectTitleId, itemId)
  self._selectTitleId = selectTitleId
  self:RefreshUI()
end

function UIHomelandMoviePrepareSelectItem:TitleBtnOnClick(selectTitleId, prepareType)
  self._selectTitleId = selectTitleId
  self:RefreshUI()
  self:RefreshSelectBtns()
end

function UIHomelandMoviePrepareSelectItem:SelectItemBtnOnClick(isAdd, prepareType, selectTilleId, data)
  if isAdd then
    self._selectItemId = data[1]
  else
    self._selectItemId = nil
  end
  self:RefreshUI()
end

function UIHomelandMoviePrepareSelectItem:OnPrepareItemsSelected(prepareType, selectTilleId, itemId)
  self._selectTitleId = selectTilleId
  self._selectItemId = itemId
  self:RefreshUI()
  self:RefreshSelectBtns()
end

function UIHomelandMoviePrepareSelectItem:CreateShadowObject(movieId, prepareType, title)
end

function UIHomelandMoviePrepareSelectItem:ClearAll()
  self._moviePrepareManager:ClearAll()
end

function UIHomelandMoviePrepareSelectItem:BtnBackOnClick()
end
