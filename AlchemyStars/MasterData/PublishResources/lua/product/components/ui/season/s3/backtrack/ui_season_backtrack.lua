_class("UISeasonBackTrack", UIController)
UISeasonBackTrack = UISeasonBackTrack

function UISeasonBackTrack:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonBackTrack:OnShow(uiParams)
  self.openCb = uiParams[2]
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._seasonUIModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonID = self:_GetCurSeasonID()
  self._preIndex = nil
  self._curIndex = nil
  self:InitWidget()
  self:_OnValue()
  if self.openCb then
    self.openCb(true)
  end
end

function UISeasonBackTrack:InitWidget()
  self._map = self:GetUIComponent("RawImageLoader", "Map")
  self._mapRect = self:GetUIComponent("RectTransform", "Map")
  self._arrowRect = self:GetUIComponent("RectTransform", "Arrow")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._desc = self:GetUIComponent("RollingText", "Desc")
  self._scrollViewGO = self:GetGameObject("ScrollView")
  self._goBtnGO = self:GetGameObject("GoBtn")
  self._atlas = self:GetAsset("UISeasonBackTrack.spriteatlas", LoadType.SpriteAtlas)
  self._animation = self:GetUIComponent("Animation", "Animation")
  self._animation2 = self:GetUIComponent("Animation", "SafeArea")
  self._transPointPool = self:GetUIComponent("UISelectObjectPath", "Map")
end

function UISeasonBackTrack:_OnValue()
  self._cfgs = {}
  local normalSeasonId = self._seasonModule:GetCurSeasonID()
  local cfgs = Cfg.cfg_season_backtrack({})
  for _, cfg in pairs(cfgs) do
    if EDITOR then
      table.insert(self._cfgs, cfg)
    elseif normalSeasonId >= cfg.ID then
      table.insert(self._cfgs, cfg)
    end
  end
  table.sort(self._cfgs, function(a, b)
    return a.ID > b.ID
  end)
  self._content:SpawnObjects("UISeasonBackTrackItem", #self._cfgs)
  self._widgets = self._content:GetAllSpawnList()
  for index, cfg in ipairs(self._cfgs) do
    self._widgets[index]:SetData(self._seasonID, self._atlas, index, cfg, function(index)
      self:_OnClickItem(index)
    end, function(seasonID)
      return self:_IsShowSign(seasonID)
    end)
  end
  for i = 1, #self._cfgs do
    if self._cfgs[i].ID == self._seasonID then
      self:_OnClickItem(i, true)
      break
    end
  end
  self:Lock("UISeasonBackTrack_EnterAni")
  self:StartTask(function(TT)
    for index, widget in ipairs(self._widgets) do
      widget:PlayEngerAni()
      widget:OnSelect(self._curIndex == index)
      YIELD(TT, 50)
    end
    self:UnLock("UISeasonBackTrack_EnterAni")
  end)
end

function UISeasonBackTrack:_OnClickItem(index, dontPlayClickAni)
  if self._curIndex == index then
    return
  end
  self._selectTransPoint = nil
  self._preIndex = self._curIndex
  self._curIndex = index
  local cfg = self._cfgs[self._curIndex]
  if cfg then
    self._seasonID = cfg.ID
    self._map:LoadImage(cfg.MapImage)
    self._mapRect.sizeDelta = Vector2(cfg.Size[1], cfg.Size[2])
    self._title.text = StringTable.Get(cfg.Title)
    self._desc:RefreshText(StringTable.Get(cfg.Desc))
    self:_RefreshTransPoint()
  end
  if not dontPlayClickAni then
    self:Lock("UISeasonBackTrack_ItemClickAni")
    self:StartTask(function(TT)
      for _index, widget in pairs(self._widgets) do
        if _index == self._preIndex then
          widget:OnSelect(false)
        elseif _index == self._curIndex then
          widget:OnSelect(true)
        end
      end
      YIELD(TT, 400)
      self:UnLock("UISeasonBackTrack_ItemClickAni")
    end)
  end
end

function UISeasonBackTrack:_RefreshTransPoint()
  local transCfgs = {}
  local cfgs = Cfg.cfg_season_mission({
    BackTrackID = self._seasonID
  })
  local normalSeasonId = self._seasonModule:GetCurSeasonID()
  local backTrackNavPoint, unLockZoneIds
  if self._seasonID ~= normalSeasonId then
    backTrackNavPoint = true
  else
    local isBackTrack = self._seasonUIModule:IsBackTrack()
    if isBackTrack then
      unLockZoneIds = self._seasonUIModule:GetSnapNormalSeasonData("UnlockZoneIds")
    else
      unLockZoneIds = self._seasonUIModule:SeasonManager():SeasonMapManager():UnlockZoneIDs()
    end
  end
  for k, cfg in pairs(cfgs) do
    local id = cfg.ID
    local cfgEventPoint = Cfg.cfg_season_map_eventpoint[id]
    if cfgEventPoint and cfgEventPoint.EventPointType == SeasonEventPointType.NavPoint then
      if backTrackNavPoint then
        table.insert(transCfgs, cfgEventPoint)
      else
        for _, zoneId in pairs(unLockZoneIds) do
          if zoneId == cfg.ZoneID then
            table.insert(transCfgs, cfgEventPoint)
            break
          end
        end
      end
    end
  end
  local len = #transCfgs
  local widgets = self._transPointPool:SpawnObjects("UISeasonTransPoint", len)
  for i = 1, len do
    local subWidget = widgets[i]
    local cfg = transCfgs[i]
    local pos = Vector2(cfg.Position[1], cfg.Position[3])
    pos = self._seasonUIModule:SeasonManager():SeasonMapManager():TransMapObjPos2D(pos)
    local w = self._mapRect.sizeDelta.x
    pos.x = pos.x * w
    pos.y = pos.y * self._mapRect.sizeDelta.y
    local scale = 1700 / w
    subWidget:SetData(cfg, pos, scale, function(select)
      if self._selectTransPoint then
        self._selectTransPoint:SetSelect(false)
      end
      self._selectTransPoint = select
      self._selectTransPoint:SetSelect(true)
    end)
  end
end

function UISeasonBackTrack:_TransToTarget(position, eventId)
  if self._seasonID == self:_GetCurSeasonID() then
    self._seasonUIModule:SeasonManager():SeasonPlayerManager():GetPlayer():TransToTarget(position, eventId)
    self:CloseDialog()
  else
    local param = {}
    param.position = position
    param.eventId = eventId
    param.style = SeaonPlayerEnterStyle.Direct
    if self._seasonID == self:GetModule(SeasonModule):GetCurSeasonID() then
      self._seasonModule.uiModule:BackToCurSeason(param)
    else
      self._seasonModule.uiModule:SeasonBackTrack(self._seasonID, param)
    end
  end
end

function UISeasonBackTrack:MapListBtnOnClick(go)
  local show = self._scrollViewGO.activeSelf
  self._scrollViewGO:SetActive(not show)
  self._animation2:Stop()
  self:Lock("UISeasonBackTrack_ListBtnClick_Ani")
  self:StartTask(function(TT)
    if show then
      self._animation2:Play("uieff_UISeasonBackTrack_list_close")
    else
      self._animation2:Play("uieff_UISeasonBackTrack_list_open")
    end
    YIELD(TT, 300)
    self:UnLock("UISeasonBackTrack_ListBtnClick_Ani")
  end)
end

function UISeasonBackTrack:GoBtnOnClick(go)
  if not self._seasonModule:CheckSeasonAndMissionCoseAndJump() then
    return
  end
  if self._selectTransPoint then
    local clickCfg = self._selectTransPoint:GetCfg()
    local pos = Vector3(clickCfg.Position[1], clickCfg.Position[2], clickCfg.Position[3])
    local offset = clickCfg.TransportPointSkew
    local targetPos = SeasonNavTransPoint.CalcNavPosition(pos, offset)
    self:_TransToTarget(targetPos, clickCfg.ID)
    return
  end
  if self._seasonID == self:_GetCurSeasonID() then
    ToastManager.ShowToast(StringTable.Get("str_season_backtrack_go_toast"))
  else
    if not self._seasonModule.uiModule:IsBackTrack() then
      self._seasonModule.uiModule:SeasonManager():SeasonPlayerManager():GetPlayer():SyncPosition()
    end
    if self._seasonID == self:GetModule(SeasonModule):GetCurSeasonID() then
      self._seasonModule.uiModule:BackToCurSeason()
    else
      self._seasonModule.uiModule:SeasonBackTrack(self._seasonID)
    end
  end
end

function UISeasonBackTrack:CloseBtnOnClick(go)
  self:Lock("UISeasonBackTrackCloseBtnOnClick")
  self:StartTask(function(TT)
    self._animation:Play("uieff_UISeasonBackTrack_out")
    YIELD(TT, 200)
    self:CloseDialog()
    self:UnLock("UISeasonBackTrackCloseBtnOnClick")
  end, self)
end

function UISeasonBackTrack:MapBtnOnClick(go)
  if self._selectTransPoint then
    self:Lock("MapBtnOnClick")
    self:StartTask(function(TT)
      self._selectTransPoint:SetSelect(false)
      self._selectTransPoint = nil
      YIELD(TT, 300)
      self:UnLock("MapBtnOnClick")
    end)
  end
end

function UISeasonBackTrack:_GetCurSeasonID()
  return self._seasonModule.uiModule:GetSeasonID()
end

function UISeasonBackTrack:_IsShowSign(seasonID)
  local tasks = self._seasonModule.uiModule:SeasonManager():SeasonMapManager():GetEventPointsByType(SeasonEventPointType.Task)
  if tasks then
    for _, eventPoint in pairs(tasks) do
      if eventPoint:GetMissionCfg().BackTrackID == seasonID then
        return true
      end
    end
  end
  return false
end
