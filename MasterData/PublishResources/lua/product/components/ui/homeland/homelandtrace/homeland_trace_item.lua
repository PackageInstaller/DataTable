_class("HomeTraceItem", Object)
HomeTraceItem = HomeTraceItem

function HomeTraceItem:Constructor(traceID, taskItem, traceManager, position)
  self._traceID = traceID
  self._position = position
  self._taskItem = taskItem
  self._tracemanager = traceManager
  self._traceManagerHelper = self._tracemanager:GetHomelandTraceManagerHelper()
  self._traceCfg = self._traceManagerHelper:GetTraceInfo(traceID)
  if self._traceCfg then
    self._traceType = self._traceCfg.TraceType
  end
  self._homelandClient = self._tracemanager:GetHomelandClient()
  self._buildManager = self._homelandClient:BuildManager()
  self._homelandCameraManager = self._homelandClient:CameraManager()
  self._camera = self._homelandCameraManager:GetCamera()
  self._homelandPetManager = self._homelandClient:PetManager()
  self._homelandCharatorController = self._homelandClient:CharacterManager()
  self._onEnterBuildInteract = GameHelper:GetInstance():CreateCallback(self.EnterBuildInteract, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.EnterBuildInteract, self._onEnterBuildInteract)
  self._onLeaveBuildInteract = GameHelper:GetInstance():CreateCallback(self.LeaveBuildInteract, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.LeaveBuildInteract, self._onLeaveBuildInteract)
  self._uiRootGo = UnityEngine.GameObject.Find("UIHomelandMain")
  if self._uiRootGo then
    self._uiCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHomelandMain")
    self._uiRootRectTransform = self._uiRootGo.transform:Find("UICanvas/SafeArea/Trace")
    self._canUpdate = true
  else
    self._canUpdate = false
  end
  self._traceResPositions = {}
  self._tracePoints = {}
  self._iconRes = {}
  self._iconTransformInfos = {}
  self._prefabName = "eff_jy_renwuyindao_line.prefab"
  self._tracePoint = nil
  self._showInUI = true
  self._traceFinished = false
  self._petOffect = Vector3(0, 1.6, 0)
  self.screenOffset = Vector2(UnityEngine.Screen.width / 2, UnityEngine.Screen.height / 2)
end

function HomeTraceItem:GetManager()
  return self._tracemanager
end

function HomeTraceItem:GetTraceId()
  return self._traceID
end

function HomeTraceItem:GetTraceType()
  return self._traceType
end

function HomeTraceItem:Dispose()
  if self._onEnterBuildInteract then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.EnterBuildInteract, self._onEnterBuildInteract)
    self._onEnterBuildInteract = nil
  end
  if self._onLeaveBuildInteract then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.LeaveBuildInteract, self._onLeaveBuildInteract)
    self._onLeaveBuildInteract = nil
  end
  if self._iconRes then
    for i = 1, #self._iconRes do
      self._iconRes[i]:Dispose()
    end
  end
  self._iconRes = nil
  if self._tracePoints then
    for i = 1, #self._tracePoints do
      self._tracePoints[i]:Dispose()
    end
  end
  self._tracePoints = nil
  self._traceID = nil
  self._traceCfg = nil
  self._tracemanager = nil
  self._traceResPositions = nil
end

function HomeTraceItem:SetShow(bShow)
  self._showInUI = bShow
end

function HomeTraceItem:Update(deltaTimeMS)
  if self._canUpdate then
    self:UpdateFun()
  end
end

function HomeTraceItem:UpdateFun(deltaTimeMS)
  if self._traceResPositions and #self._traceResPositions > 0 then
    self._iconTransformInfos = {}
    for i = 1, #self._traceResPositions do
      self._camera = self._homelandCameraManager:GetCamera()
      local targetPos = self._traceResPositions[i]
      local targetScPoint = self._traceManagerHelper:WorldToScreenPoint(self._camera, targetPos)
      local isInner = self._traceManagerHelper:CheckInEllipse(targetScPoint.x, targetScPoint.y)
      local distance = self._traceManagerHelper:GetDistance(self._homelandCharatorController:GetCharacterTransform().position, targetPos)
      local targevec = Vector2(targetScPoint.x, targetScPoint.y)
      local dirInfo = {}
      if isInner <= 1 and 0 <= targetScPoint.z then
        dirInfo = {
          targevec,
          isInner,
          distance,
          targetScPoint.z
        }
        table.insert(self._iconTransformInfos, dirInfo)
      else
        local cross1, cross2, k = self._traceManagerHelper:CheckIntersect(self.screenOffset, targevec)
        local inner = self._traceManagerHelper:CheckInLine(cross1, self.screenOffset, targevec)
        local point = Vector2(0, 0)
        if 0 > targetScPoint.z then
          point = inner and cross2 or cross1
        else
          point = inner and cross1 or cross2
        end
        dirInfo = {
          point,
          isInner,
          distance,
          targetScPoint.z
        }
        table.insert(self._iconTransformInfos, dirInfo)
      end
    end
  end
  if self._showInUI then
    self:UpdateIcon()
  end
end

function HomeTraceItem:UpdateIcon()
  if not self._iconRes then
    return
  end
  if #self._iconTransformInfos > 0 and self._uiRootRectTransform ~= nil then
    for i = 1, #self._iconRes do
      if self._iconRes[i] then
        local res, pos = self._traceManagerHelper:ScreenPointToLocalPointInRectangle(self._uiRootRectTransform, self._uiCamera, self._iconTransformInfos[i][1])
        self._iconRes[i]:GetTransform().anchoredPosition = pos
        self._iconRes[i]:SetTracePointDir(self._iconTransformInfos[i])
      end
    end
  end
end

function HomeTraceItem:StartRun()
  if self._tracemanager then
    self:CreateTraceObjs()
  end
end

function HomeTraceItem:StopRun()
  if self._tracemanager then
    for index, value in ipairs(self._traceResPositions) do
      value:Dispose()
    end
    for i = 1, #self._iconRes do
      self._iconRes[i]:Dispose()
    end
  end
  self._traceResPositions = {}
  self._iconRes = {}
end

function HomeTraceItem:CreateIcons()
  if not self._canUpdate then
    return
  end
  if not self._traceCfg then
    return
  end
  for i = 1, #self._traceResPositions do
    local iconItem = HomeTraceIcon:New(self._traceID, self, self._uiRootRectTransform)
    table.insert(self._iconRes, iconItem)
    iconItem:SetParent(self._uiRootRectTransform, false)
  end
end

function HomeTraceItem:CreateTraceObjs()
  if not self._traceCfg then
    return
  end
  if self._traceResPositions then
    for i = 1, #self._traceResPositions do
      self._traceResPositions[i]:ClearInteractPoint()
    end
    self._traceResPositions = {}
  end
  self._traceCount = 0
  self:_CreateTraceObjs_Pos()
  self:_CreateTraceObjs_Npc()
  self:_CreateTraceObjs_Build()
  self:_CreateTraceObjs_BuildHang()
  self:CreateIcons()
end

function HomeTraceItem:_CreateTraceObjs_Core(info, obj, traceResPos)
  self._traceCount = self._traceCount + 1
  local point = HomelandTracePoint:New(self, info, self._traceCount, obj)
  table.insert(self._traceResPositions, traceResPos)
  table.insert(self._tracePoints, point)
end

function HomeTraceItem:_CreateTraceObjs_Pos()
  if self._traceCfg.Pos then
    for i = 1, #self._traceCfg.Pos do
      local pos = self._position or Vector3(self._traceCfg.Pos[i][1], self._traceCfg.Pos[i][2], self._traceCfg.Pos[i][3])
      local info = {}
      info.obj = self._prefabName
      info.position = pos
      info.config = self._traceCfg
      info.radius = self._traceCfg.Radius
      info.effectObj = self._tracePoint
      info.isNpc = false
      self:_CreateTraceObjs_Core(info, nil, pos)
    end
  end
end

function HomeTraceItem:_CreateTraceObjs_Npc()
  if self._traceCfg.NpcId ~= nil then
    for i = 1, #self._traceCfg.NpcId do
      local pets = self._taskItem:GetTaskNpcs()
      for key, value in pairs(pets) do
        local config = value:GetPetConfig()
        if config.Id == self._traceCfg.NpcId[i] and pets[key]:AgentTransform() then
          local pos = pets[key]:AgentTransform().position + self._petOffect
          local info = {}
          info.position = pets[key]:GetInteractPosition()
          info.config = self._traceCfg
          info.isNpc = true
          self:_CreateTraceObjs_Core(info, pets[key], pos)
        end
      end
    end
  end
end

function HomeTraceItem:_CreateTraceObjs_Build()
  local architectureId = self._traceCfg.ArchitectureId
  if architectureId ~= nil then
    local building = self._buildManager:FindBuildingByCfgID(architectureId)
    if building then
      local pos = building:Pos()
      local info = {}
      info.position = pos
      info.config = self._traceCfg
      info.isNpc = true
      self:_CreateTraceObjs_Core(info, building._go, pos)
    end
  end
end

function HomeTraceItem:_CreateTraceObjs_BuildHang()
  local architectureId = self._traceCfg.TargetHangPoint and self._traceCfg.TargetHangPoint[1]
  local hangId = self._traceCfg.TargetHangPoint and self._traceCfg.TargetHangPoint[2]
  if architectureId ~= nil and hangId ~= nil then
    local building = self._buildManager:FindBuildingByCfgID(architectureId)
    if building then
      local pos = building:GetHangPointPosByID(hangId)
      if pos then
        local info = {}
        info.position = pos
        info.config = self._traceCfg
        info.isNpc = true
        self:_CreateTraceObjs_Core(info, building._go, pos)
      end
    end
  end
end

function HomeTraceItem:Emphasize()
  if self._iconRes then
    for i = 1, #self._iconRes do
      self._iconRes[i]:Emphasize()
    end
  end
end

function HomeTraceItem:EnterBuildInteract(point)
  if self._tracePoints and #self._tracePoints > 0 then
    for i = 1, #self._tracePoints do
      self._tracePoints[i]:OnTrigger(point)
    end
  end
end

function HomeTraceItem:LeaveBuildInteract(point)
  if self._tracePoints and #self._tracePoints > 0 then
    for i = 1, #self._tracePoints do
      self._tracePoints[i]:OnLeave(point)
    end
  end
end

function HomeTraceItem:ShowTraceIcons(bShow)
  if self._iconRes then
    for i = 1, #self._iconRes do
      self._iconRes[i]:SetShow(bShow)
    end
  end
end
