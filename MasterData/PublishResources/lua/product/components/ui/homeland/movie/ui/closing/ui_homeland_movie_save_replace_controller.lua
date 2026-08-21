_class("UIHomelandMovieSaveReplaceController", UIController)
UIHomelandMovieSaveReplaceController = UIHomelandMovieSaveReplaceController

function UIHomelandMovieSaveReplaceController:OnShow(uiParams)
  self._homelandModule = self:GetModule(HomelandModule)
  self._curPstId = MoviePrepareData:GetInstance():GetPstId()
  self._records = uiParams[1]
  self:AttachEvent(GameEventType.UIHomelandMovieReplaceRecordSelect, self.OnRecordSelect)
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandMovieSaveReplaceController:OnHide()
  self:DetachEvent(GameEventType.UIHomelandMovieReplaceRecordSelect, self.OnRecordSelect)
end

function UIHomelandMovieSaveReplaceController:_GetComponents()
  self._replaceList = self:GetUIComponent("UISelectObjectPath", "List")
end

function UIHomelandMovieSaveReplaceController:_OnValue()
  self._replaceList:SpawnObjects("UIHomelandMovieReplaceRecordItem", table.count(self._records))
  local spawnList = self._replaceList:GetAllSpawnList()
  local idx = 1
  for _, v in pairs(self._records) do
    local pstId, record = v.pstid, v
    spawnList[idx]:SetData(pstId, record)
    idx = idx + 1
  end
end

function UIHomelandMovieSaveReplaceController:QuitOnClick()
  self:CloseDialog()
end

function UIHomelandMovieSaveReplaceController:OnRecordSelect(recordPstId)
  self:Lock("UIHomelandMovieSaveReplaceController_OnRecordSelect")
  MovieDataManager:GetInstance():SaveRecordData(recordPstId, function()
    self:UnLock("UIHomelandMovieSaveReplaceController_OnRecordSelect")
    ToastManager.ShowHomeToast(StringTable.Get("str_movie_save_success_tip"))
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMovieSaved)
  end)
end
