_class("UISeasonMainOvalAreaS3", UICustomWidget)
UISeasonMainOvalAreaS3 = UISeasonMainOvalAreaS3

function UISeasonMainOvalAreaS3:OnShow(uiParams)
  self:InitWidget()
  self._rect = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  local width = self._rect.rect.width
  local height = self._rect.rect.height
  self._ovalCenter = Vector2(width / 2, height / 2)
  self._seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local cfg = Cfg.cfg_season_campaign_client[self._seasonID]
  self._oval = OvalShape:New(width / 2 - cfg.OvalTipPadding[1], height / 2 - cfg.OvalTipPadding[2])
  self._arrowPool = {}
  self._tips = {}
  self._uiModule = GameGlobal.GetUIModule(SeasonModule)
  self._camera = self._uiModule:SeasonManager():SeasonCameraManager():Camera()
  self._uiCamera = GameGlobal.UIStateManager():GetControllerCamera(UISeasonHelper.CurSeasonSceneUI())
  self._seasonManager = self._uiModule:SeasonManager()
  self:_RefreshMainLevelTarget()
  self:_RefreshDailyLevelTarget()
  self:_RefreshBoxTarget()
  self:_RefreshPlayer()
  self:_RefreshTask()
  self:AttachEvent(GameEventType.UISeasonOnLevelDiffChanged, self._RefreshMainLevelTarget)
  self:AttachEvent(GameEventType.OnEventPointProgressChange, self._RefreshTarget)
  self:AttachEvent(GameEventType.OnSeasonModeChanged, self._OnModeChanged)
  self:AttachEvent(GameEventType.OnSeasonTaskRefreshed, self._RefreshTask)
end

function UISeasonMainOvalAreaS3:InitWidget()
  self._tipsParent = self:GetUIComponent("Transform", "tips")
end

function UISeasonMainOvalAreaS3:SetData()
end

function UISeasonMainOvalAreaS3:OnHide()
  for _, req in ipairs(self._arrowPool) do
    req:Dispose()
  end
  self._arrowPool = nil
  for _, tip in pairs(self._tips) do
    tip:Dispose()
  end
  self._tips = nil
end

function UISeasonMainOvalAreaS3:AddTarget(target, type)
  if self._tips[target] then
    Log.error("duplicate target")
    return
  end
  local prefab = self:_LoadPrefab()
  local tip = UISeasonMainOvalTipS3:New(self._seasonID, prefab, function(tip)
    self:_OnTipClick(tip)
  end)
  tip:ResetTarget(target, type)
  self._tips[target] = tip
end

function UISeasonMainOvalAreaS3:RemoveTarget(obj)
  if not self._tips[obj] then
    Log.error("target not found")
    return
  end
  local tip = self._tips[obj]
  local req = tip:GetReq()
  self:_ReleaseTip(req)
  tip:Delete()
  self._tips[obj] = nil
end

function UISeasonMainOvalAreaS3:GetTipByType(type)
  for _, tip in pairs(self._tips) do
    if tip:Type() == type then
      return tip
    end
  end
end

function UISeasonMainOvalAreaS3:Update(dt)
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

function UISeasonMainOvalAreaS3:_LoadPrefab()
  if #self._arrowPool == 0 then
    local req = ResourceManager:GetInstance():SyncLoadAsset("UISeasonMainOvalTip.prefab", LoadType.GameObject)
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

function UISeasonMainOvalAreaS3:_ReleaseTip(req)
  req:Dispose()
end

function UISeasonMainOvalAreaS3:_ScreenToOval(screenPos)
  return screenPos - self._ovalCenter
end

function UISeasonMainOvalAreaS3:_OnTipClick(tip)
  local uiModule = GameGlobal.GetUIModule(SeasonModule)
  if tip:Type() == UISeasonOvalTipType.Player then
    uiModule:SeasonManager():SeasonCameraManager():SwitchMode(SeasonCameraMode.Follow)
  elseif tip:Type() == UISeasonOvalTipType.Mission then
    uiModule:SeasonManager():SeasonCameraManager():SeasonCamera():Focus(tip:TargetWorldPos())
  elseif tip:Type() == UISeasonOvalTipType.Box then
    uiModule:SeasonManager():SeasonCameraManager():SeasonCamera():Focus(tip:TargetWorldPos())
  elseif tip:Type() == UISeasonOvalTipType.Daily then
    uiModule:SeasonManager():SeasonCameraManager():SeasonCamera():Focus(tip:TargetWorldPos())
  elseif tip:Type() == UISeasonOvalTipType.Task then
    uiModule:SeasonManager():SeasonCameraManager():SeasonCamera():Focus(tip:TargetWorldPos())
  end
end

function UISeasonMainOvalAreaS3:_RefreshMainLevelTarget()
  local levelPoints = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.MainLevel)
  local storyPoints = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.MainStory)
  local level, story
  for _, point in ipairs(levelPoints) do
    if point:IsLastMainLevelGroup() then
      level = point
      break
    end
  end
  for _, point in ipairs(storyPoints) do
    if point:IsLastStory() then
      story = point
      break
    end
  end
  local target
  if level and not story then
    target = level
  elseif not level and story then
    target = story
  else
    if level and story then
      if level:GetMissionCfg().ID > story:GetMissionCfg().ID then
        target = level
      else
        target = story
      end
    else
    end
  end
  if target then
    local tip = self:GetTipByType(UISeasonOvalTipType.Mission)
    if tip then
      tip:ResetTarget(target, UISeasonOvalTipType.Mission)
    else
      self:AddTarget(target, UISeasonOvalTipType.Mission)
    end
  else
    local tip = self:GetTipByType(UISeasonOvalTipType.Mission)
    if tip then
      self:RemoveTarget(tip:Target())
    end
  end
end

function UISeasonMainOvalAreaS3:_RefreshDailyLevelTarget()
  local tip = self:GetTipByType(UISeasonOvalTipType.Daily)
  if tip then
    self:RemoveTarget(tip:Target())
  end
  local dailyLevels = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.DailyLevel)
  if dailyLevels then
    for _, point in ipairs(dailyLevels) do
      self:AddTarget(point, UISeasonOvalTipType.Daily)
    end
  end
end

function UISeasonMainOvalAreaS3:_RefreshBoxTarget()
  local boxPoints = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.Box)
  local subBoxPoints = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.SubBox)
  local trapPoints = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.Mechanism)
  local subTrapPoints = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.SubMechanism)
  table.appendArray(boxPoints, subBoxPoints)
  table.appendArray(boxPoints, trapPoints)
  table.appendArray(boxPoints, subTrapPoints)
  local boxTargets = {}
  for _, point in ipairs(boxPoints) do
    local curProgressExpress = point:CurProgressExpress()
    if curProgressExpress then
      local result, content = curProgressExpress:ContainExpress(SeasonExpressType.Show)
      if result and content and (not content.id or content.id == point:GetID()) and content.show then
        local expresses = curProgressExpress:GetExpresses(SeasonExpressType.Sign)
        if expresses then
          for _, express in pairs(expresses) do
            content = express:Content()
            local signType = content.type
            if signType == SeasonExpressTiming.Before then
              boxTargets[#boxTargets + 1] = point
              break
            end
          end
        end
      end
    end
  end
  local tips = {}
  for _, tip in pairs(self._tips) do
    if tip:Type() == UISeasonOvalTipType.Box then
      table.insert(tips, tip)
    end
  end
  for _, target in ipairs(boxTargets) do
    if 0 < #tips then
      local tip = table.remove(tips, 1)
      tip:ResetTarget(target, UISeasonOvalTipType.Box)
    else
      self:AddTarget(target, UISeasonOvalTipType.Box)
    end
  end
  for _, tip in ipairs(tips) do
    self:RemoveTarget(tip:Target())
  end
end

function UISeasonMainOvalAreaS3:_RefreshPlayer()
  local tip = self:GetTipByType(UISeasonOvalTipType.Player)
  if tip then
    tip:ResetTarget(self._seasonManager:SeasonPlayerManager():GetPlayer(), UISeasonOvalTipType.Player)
  else
    self:AddTarget(self._seasonManager:SeasonPlayerManager():GetPlayer(), UISeasonOvalTipType.Player)
  end
end

function UISeasonMainOvalAreaS3:_RefreshTarget()
  self:_RefreshMainLevelTarget()
  self:_RefreshBoxTarget()
  self:_RefreshTask()
end

function UISeasonMainOvalAreaS3:_OnModeChanged()
  self:_RefreshMainLevelTarget()
  self:_RefreshDailyLevelTarget()
  self:_RefreshBoxTarget()
  self:_RefreshPlayer()
  self:_RefreshTask()
end

function UISeasonMainOvalAreaS3:_RefreshTask()
  local oldTips = {}
  for _, tip in pairs(self._tips) do
    if tip:Type() == UISeasonOvalTipType.Task then
      table.insert(oldTips, tip)
    end
  end
  for _, tip in pairs(oldTips) do
    self:RemoveTarget(tip:Target())
  end
  local tasks = self._seasonManager:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.Task)
  if tasks then
    for _, point in ipairs(tasks) do
      local curProgressExpress = point:CurProgressExpress()
      if curProgressExpress then
        local result, content = curProgressExpress:ContainExpress(SeasonExpressType.Show)
        if result and content and (not content.id or content.id == point:GetID()) and content.show then
          local expresses = curProgressExpress:GetExpresses(SeasonExpressType.Sign)
          if expresses then
            for _, express in pairs(expresses) do
              content = express:Content()
              local signType = content.type
              if signType == SeasonExpressTiming.Before then
                self:AddTarget(point, UISeasonOvalTipType.Task)
                break
              end
            end
          end
        end
      end
    end
  end
end
