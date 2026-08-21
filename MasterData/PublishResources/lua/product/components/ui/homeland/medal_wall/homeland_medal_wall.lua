_class("HomelandMedalWall", HomeBuilding)
HomelandMedalWall = HomelandMedalWall

function HomelandMedalWall:Constructor(insID, architecture, cfg)
  self._isInited = false
end

function HomelandMedalWall:InitMedalWall(architecture)
  if self._isInited then
    return
  end
  self._isInited = true
  self._uiModule = GameGlobal.GetUIModule(HomelandModule)
  self._isVisit = self._uiModule:GetClient():IsVisit()
  self._pstid = architecture.pstid
  self._buildID = self:GetBuildId()
  self._buildPstID = self:GetBuildPstId()
  self._transform = self:Transform()
  self._medalRoot = GameObjectHelper.FindChild(self._transform, "MedalRoot")
  self._meadalWall = GameObjectHelper.FindChild(self._transform, "hl_envmod_building_5256001")
  if self._isVisit then
    self:RefreshMedalWall()
  else
    self:_InitMedalWall()
  end
end

function HomelandMedalWall:Dispose()
  HomelandMedalWall.super.Dispose(self)
  self:ClearMedals()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function HomelandMedalWall:ClearMedals()
  if self._medals then
    for k, v in pairs(self._medals) do
      v:Destroy()
    end
  end
  self:RemoveEvents()
end

function HomelandMedalWall:RemoveEvents()
  if self._updateMedalCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.BoardMedalUpdate, self._updateMedalCallback)
    self._updateMedalCallback = nil
  end
end

function HomelandMedalWall:_InitMedalWall()
  if self._updateMedalCallback == nil then
    self._updateMedalCallback = GameHelper:GetInstance():CreateCallback(self.RefreshMedalWall, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.BoardMedalUpdate, self._updateMedalCallback)
  end
  self:RefreshMedalWall()
end

function HomelandMedalWall:RefreshMedalWall()
  if self._medals then
    for k, v in pairs(self._medals) do
      v:Destroy()
    end
  end
  self._medals = {}
  local placeData
  if self._isVisit then
    placeData = self._uiModule:GetVisitInfo().medal_placement
  else
    placeData = GameGlobal.GetModule(MedalModule):GetPlacementInfo()
  end
  local boardCfg = Cfg.cfg_item_medal_board[placeData.board_back_id]
  if boardCfg and self._meadalWall then
    local meadalWallMesh = self._meadalWall:GetComponent(typeof(UnityEngine.MeshRenderer))
    local matName = boardCfg.BoardMat .. ".mat"
    self._res = ResourceManager:GetInstance():SyncLoadAsset(matName, LoadType.Mat)
    if self._res then
      meadalWallMesh.material = self._res.Obj
    else
      Log.fatal("该勋章板资源不存在", matName)
    end
  end
  local medalEditor = GameGlobal.GetModule(MedalModule):GetN22MedalEditData()
  local medalList = medalEditor:GetMappingBoardMedalList(MedalWallConfig.HomelandMedalWallWidth, placeData)
  for _, boardMedal in pairs(medalList) do
    self._medals[#self._medals + 1] = HomelandMedal:New(self._medalRoot, boardMedal, self._buildID)
  end
end
