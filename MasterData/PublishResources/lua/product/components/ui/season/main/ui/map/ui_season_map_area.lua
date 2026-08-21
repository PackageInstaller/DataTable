_class("UISeasonMapArea", UICustomWidget)
UISeasonMapArea = UISeasonMapArea

function UISeasonMapArea:OnShow(uiParams)
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local seasonID = self._uiSeasonModule:GetSeasonID()
  self._seasonMapCfg = Cfg.cfg_season_map[seasonID]
  self:_GetComponents()
  self._seasonManager = self._uiSeasonModule:SeasonManager()
  self._seasonPlayerManager = self._seasonManager:SeasonPlayerManager()
  self._seasonPlayer = self._seasonPlayerManager:GetPlayer()
  self._seasonMapManager = self._seasonManager:SeasonMapManager()
  self._cameraTransform = self._seasonManager:SeasonCameraManager():SeasonCamera():Transform()
  self._leftUpAnchorPos = Vector3(self._seasonMapCfg.LeftUpAnchorPos[1], self._seasonMapCfg.LeftUpAnchorPos[2], self._seasonMapCfg.LeftUpAnchorPos[3])
  self._rightDownAnchorpos = Vector3(self._seasonMapCfg.RightDownAnchorPos[1], self._seasonMapCfg.RightDownAnchorPos[2], self._seasonMapCfg.RightDownAnchorPos[3])
  self._atlas = self:GetAsset("UISeasonMain.spriteatlas", LoadType.SpriteAtlas)
  self:_InitMapEvent()
  self:AttachEvent(GameEventType.UISeasonOnLevelDiffChanged, self._InitMapEvent)
  self:AttachEvent(GameEventType.OnSeasonModeChanged, self._InitMapEvent)
end

function UISeasonMapArea:_GetComponents()
  self._roleAnchorTf = self:GetUIComponent("Transform", "RoleAnchor")
  self._mapCenterRectTf = self:GetUIComponent("RectTransform", "MapCenter")
  local x = 2048
  local y = 1536
  local scale = self._seasonMapCfg.MapScale
  self._mapCenterRectTf.sizeDelta = Vector2(x * scale, y * scale)
  self.mapEventPool = self:GetUIComponent("UISelectObjectPath", "EventLayer")
  self._mapMask = self:GetUIComponent("RectTransform", "MapMask")
  self._originOffset = self._mapMask.anchoredPosition
  self._roleOutAnchor = self:GetUIComponent("RectTransform", "RoleOutAnchor")
  self._roleOutAnchor.gameObject:SetActive(false)
  self._roleOutTf = self:GetUIComponent("Transform", "RoleOutAnchor")
  local mapImage = self:GetUIComponent("RawImageLoader", "MapImage")
  mapImage:LoadImage(self._seasonMapCfg.MiniMapRes)
  self._mapRadius = 120.0
  self._roleOutAnchorOffset = -1
  self._redpoint = self:GetGameObject("Redpoint")
  self._redpoint:SetActive(LocalDB.GetInt("UISeasonBackTrackRedpoint", 0) <= 0)
  self:GetGameObject("BackTrack"):SetActive(GameGlobal.GetModule(SeasonModule):GetCurSeasonID() >= UISeasonID.S3)
end

function UISeasonMapArea:_InitMapEvent()
  if self._seasonMapManager == nil then
    return
  end
  local dt = 0
  self:_RefreshRoleAnchor(dt)
  local points = {}
  local showTypes = {
    SeasonEventPointType.MainLevel,
    SeasonEventPointType.MainStory,
    SeasonEventPointType.NavPoint
  }
  for _, type in ipairs(showTypes) do
    local events = self._seasonMapManager:GetEventPointsByType(type)
    if events and 0 < #events then
      table.appendArray(points, events)
    end
  end
  local count = #points
  self.mapEventPool:SpawnObjects("UISingleSeasonMapEvent", count)
  local list = self.mapEventPool:GetAllSpawnList()
  for i, v in ipairs(list) do
    local single = points[i]
    v:SetData(single, self._mapCenterRectTf)
  end
end

function UISeasonMapArea:SetData()
end

function UISeasonMapArea:OnHide()
end

function UISeasonMapArea:Update(dt)
  if self._cameraTransform == nil then
    return
  end
  self:_RefreshRoleAnchor(dt)
  if self.mapEventPool then
    local list = self.mapEventPool:GetAllSpawnList()
    for i, v in ipairs(list) do
      v:Update(dt)
    end
  end
end

function UISeasonMapArea:_RefreshRoleAnchor(dt)
  local ctf = self._cameraTransform
  local ptf = self._seasonPlayer:Transform()
  local leftUpPos = self._leftUpAnchorPos
  local rightDownPos = self._rightDownAnchorpos
  local cameraPos = ctf.position
  local mapPosDelta = rightDownPos - leftUpPos
  local curPosDelta = rightDownPos - cameraPos
  local percentX = curPosDelta.x / mapPosDelta.x
  local percentY = curPosDelta.z / mapPosDelta.z
  local anchoredPos = Vector2(percentX * self._mapCenterRectTf.sizeDelta.x, -percentY * self._mapCenterRectTf.sizeDelta.y)
  self._mapCenterRectTf.anchoredPosition = anchoredPos
  local playerPos = ptf.position
  curPosDelta = rightDownPos - playerPos
  percentX = curPosDelta.x / mapPosDelta.x
  percentY = curPosDelta.z / mapPosDelta.z
  local anchoredPos2 = Vector2(-percentX * self._mapCenterRectTf.sizeDelta.x, percentY * self._mapCenterRectTf.sizeDelta.y)
  local rolePOS = anchoredPos + anchoredPos2
  local offset = self._originOffset
  local halfUIRadius = self._mapRadius
  local delta = (rolePOS - self._mapMask.anchoredPosition + offset).magnitude
  local dir = (rolePOS - self._mapMask.anchoredPosition + offset).normalized
  if delta > halfUIRadius + self._roleOutAnchorOffset then
    local newPos = self._mapMask.anchoredPosition - offset + halfUIRadius * dir
    self._roleAnchorTf.anchoredPosition = newPos
  else
    self._roleOutAnchor.gameObject:SetActive(false)
    self._roleAnchorTf.anchoredPosition = anchoredPos + anchoredPos2
  end
end

function UISeasonMapArea:BackTrackBtnOnClick(go)
  if not GameGlobal.GetModule(SeasonModule):CheckSeasonCloseAndJump() then
    return
  end
  if GameGlobal.GetModule(SeasonModule):GetCurSeasonID() >= UISeasonID.S3 then
    self:ShowDialog("UISeasonBackTrack")
    LocalDB.SetInt("UISeasonBackTrackRedpoint", 1)
    self._redpoint:SetActive(false)
  end
end
