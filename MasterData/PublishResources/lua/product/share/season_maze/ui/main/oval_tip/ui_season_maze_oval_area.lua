_class("UISeasonMazeOvalArea", UICustomWidget)
UISeasonMazeOvalArea = UISeasonMazeOvalArea

function UISeasonMazeOvalArea:OnShow(uiParams)
  self:InitWidget()
  self._rect = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  local width = self._rect.rect.width
  local height = self._rect.rect.height
  self._ovalCenter = Vector2(width / 2, height / 2)
  self._seasonMazeID = GameGlobal.GetModule(SeasonMazeModule):CurSeasonMazeID()
  self._seasonID = GameGlobal.GetModule(SeasonMazeModule):UIModule():GetSeasonID()
  local cfg = Cfg.cfg_season_campaign_client[self._seasonID]
  self._oval = OvalShape:New(width / 2 - cfg.OvalTipPadding[1], height / 2 - cfg.OvalTipPadding[2])
  self._arrowPool = {}
  self._tips = {}
  self._uiModule = GameGlobal.GetModule(SeasonMazeModule):UIModule()
  self._camera = self._uiModule:SeasonMazeManager():SeasonMazeCameraManager():Camera()
  self._uiCamera = GameGlobal.UIStateManager():GetControllerCamera("UISeasonMazeScene")
  self:_RefreshPlayer()
end

function UISeasonMazeOvalArea:InitWidget()
  self._tipsParent = self:GetUIComponent("Transform", "tips")
end

function UISeasonMazeOvalArea:OnHide()
  for _, req in ipairs(self._arrowPool) do
    req:Dispose()
  end
  self._arrowPool = nil
  for _, tip in pairs(self._tips) do
    tip:Dispose()
  end
  self._tips = nil
end

function UISeasonMazeOvalArea:AddTarget(target, type)
  if self._tips[target] then
    Log.error("duplicate target")
    return
  end
  local prefab = self:_LoadPrefab()
  local tip = UISeasonMazeOvalTip:New(self._seasonMazeID, prefab, function(tip)
    self:_OnTipClick(tip)
  end)
  tip:ResetTarget(target, type)
  self._tips[target] = tip
end

function UISeasonMazeOvalArea:Update(dt)
  for _, tip in pairs(self._tips) do
    local screenPos = self._camera:WorldToScreenPoint(tip:TargetWorldPos())
    local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._rect, screenPos, self._uiCamera, nil)
    local canShow = true
    local arrowPos = self._oval:CrossPoint(pos)
    local distance = tip:GetCanShowDistance(self._camera.orthographicSize)
    if distance > Vector2.Distance(arrowPos, pos) then
      canShow = false
    end
    if self._oval:IsInside(pos) or not canShow then
      if not tip:IsInOval() then
        tip:Hide()
      end
    else
      if tip:IsInOval() then
        tip:Show()
      end
      arrowPos = arrowPos or self._oval:CrossPoint(pos)
      local dir = Vector3(pos.x - arrowPos.x, pos.y - arrowPos.y, 0)
      local lookRot = Quaternion.LookRotation(Vector3.forward, dir)
      if lookRot then
        local rot = lookRot
        tip:Sync(arrowPos, rot)
      end
    end
  end
end

function UISeasonMazeOvalArea:_LoadPrefab()
  if #self._arrowPool == 0 then
    local req = ResourceManager:GetInstance():SyncLoadAsset("UISeasonMazeOvalTip.prefab", LoadType.GameObject)
    local tr = req.Obj.transform
    tr:SetParent(self._tipsParent, false)
    tr.localPosition = Vector3.zero
    tr.localRotation = Quaternion.identity
    tr.localScale = Vector3.one
    return req
  else
    local req = self._arrowPool[#self._arrowPool]
    self._arrowPool[#self._arrowPool] = nil
    return req
  end
end

function UISeasonMazeOvalArea:_ReleaseTip(req)
  req:Dispose()
end

function UISeasonMazeOvalArea:_OnTipClick(tip)
  self._uiModule:SeasonMazeManager():SeasonMazeCameraManager():SeasonCamera():Focus(tip:TargetWorldPos())
end

function UISeasonMazeOvalArea:_RefreshPlayer()
  self:AddTarget(self._uiModule:SeasonMazeManager():Player(), UISeasonOvalTipType.Player)
end
