local this = class("pagePhotographPoint", G_UIPageBase)

function this.bind()
  return {
    main = true,
    goCaptureArea = false,
    goWhiteCut = false,
    photo = false,
    playerInfo = true,
    playerId = "",
    playerName = "",
    dim = false,
    angle = 0
  }
end

function this.methods()
  return {
    onClick_closePage = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_screenCapture = function(self)
      self.bind.goWhiteCut = true
      self.bind.goCaptureArea = true
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Take")
      L_PhotoManager:capture(function(t2d)
        L_UI:open("pagePhotoPreview", {rt = t2d}, function()
          self.bind.goWhiteCut = false
          self.bind.captureArea = false
        end)
        local sceneId = AzurWorldInstance.CurWorldId
        local worldAreaId = AzurWorld.areaManager:GetMapAreaId()
        L_AchievementUtil.req_clientBehaviourRecord(L_Const.commonCondition.RegionPhotoTimes, {
          sceneId,
          worldAreaId,
          1
        }, function()
          printf("req_clientBehaviourRecord", sceneId, worldAreaId)
        end)
        L_AchievementUtil.req_clientBehaviourRecord(L_Const.commonCondition.ExplorePhoto, {
          sceneId,
          self.worldMapId,
          1
        }, function()
        end)
      end)
    end,
    onClick_closePhoto = function(self)
    end,
    onClick_savePhoto = function(self)
    end,
    onClick_preBtn = function(self)
      self:setPreCameraPos()
    end,
    onClick_nextBtn = function(self)
      self:setNextCameraPos()
    end
  }
end

function this:fadeIn()
  local data = {
    coverdTime = 0.9,
    fadeOut = true,
    fadeIn = false,
    isCompleteClose = true
  }
  L_GameUtil.openMask(data)
end

function this:check(options, callback)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PhotographEntrance))
    callback(false)
    return
  end
  local result = true
  if result then
    result = not L_BattleStore:getIsInBattle() and L_PhotoManager:getMainControlIsFree() and not L_PlayerStore:getIsNewPlayer()
    if not result then
      L_FlyMsgManager:showNormalMsgByKey("notice_pagePhoto_04")
    end
  end
  if result then
    self:fadeIn()
  end
  callback(result)
end

function this:preOpen(options)
  self.cameraRotateSpeed = 3
  self.showPlayerInfo = true
  self.bind.playerId = tostring(L_PlayerStore:getPlayerId())
  self.bind.playerName = L_PlayerStore:getPlayerName()
  L_ShortCutManager:registerPageMainShortCut()
  C_CameraManager.ActivateTactics(C_ECameraType.Photo, C_CinemachineBlendType.Cut, 0)
  L_PlayerManager:stopIdleAnim()
  self.npcList = {}
  self.npcIndex = 1
  if options then
    local params = string.split(options.params, "**")
    for i, v in ipairs(params) do
      local r = tonumber(v)
      if not math.isEmpty(r) then
        table.insert(self.npcList, r)
      end
    end
    self.worldMapId = options.worldMapId
  end
  self:updateCameraPos()
  self:bindScreenTouch("+")
  AzurWorld.HomeMgr:LockAllEffect(true)
  self:findSelfWorldMapId()
end

function this:close(options)
  this.super.close(self, options)
  L_PhotoManager:releasePendingCaptureRTs()
  self:DisableCurVirCam()
  self.virtualCamera = nil
  self.photographCamera = nil
  AzurWorld.HomeMgr:LockAllEffect(false)
  self:bindScreenTouch("-")
  C_CameraManager.DeactivateTactics(C_ECameraType.Photo)
  L_PlayerManager:initIdleAnim()
end

function this:show(options)
  this.super.show(self, options)
end

function this:setPreCameraPos()
  if self.npcList ~= nil then
    self:DisableCurVirCam()
    self.npcIndex = self.npcIndex - 1
    if self.npcIndex <= 0 then
      self.npcIndex = #self.npcList
    end
  end
  self:updateCameraPos()
end

function this:setNextCameraPos()
  if self.npcList ~= nil then
    self:DisableCurVirCam()
    self.npcIndex = self.npcIndex + 1
    if self.npcIndex > #self.npcList then
      self.npcIndex = 1
    end
  end
  self:updateCameraPos()
end

function this:DisableCurVirCam()
  if self.virtualCamera then
    self.virtualCamera.enabled = false
    self.virtualCamera.transform.forward = self.oriForward
  end
  self.oriForward = nil
end

function this:updateCameraPos()
  self.virtualCamera = nil
  if self.npcList == nil or self.npcList[self.npcIndex] == nil then
  else
    local npcId = self.npcList[self.npcIndex]
    local npc = C_EntityManager.GetEntity(npcId)
    local worldMapId = 0
    if npc then
      local trans = npc.transform:GetRawTransform()
      self.oriForward = trans.forward
      self.virtualCamera = trans:GetComponent(typeof(C_CinemachineVirtualCamera))
      worldMapId = npc.data.configId
      local _worldMapTpl = L_GameTpl:getWorldMapTpl()
      local tpl = _worldMapTpl:getTplById(AzurWorldInstance.CurWorldId, worldMapId)
      local angle = _worldMapTpl:getExpandParams(tpl, "angle")
      self.bind.angle = angle
    end
  end
  self.photographCamera = C_CameraManager.GetTactics(C_ECameraType.Photo).cineMachineCamera
  if self.virtualCamera then
    self.virtualCamera.enabled = true
    self:copyVirtualCamera(self.virtualCamera, self.photographCamera)
  end
end

function this:copyVirtualCamera(source, target)
  target.transform.position = source.transform.position
  target.m_Lens = source.m_Lens
  local v = source.transform.localEulerAngles.x
  local h = source.transform.localEulerAngles.y
  local body = target:GetCinemachineComponent(0)
  local aim = target:GetCinemachineComponent(1)
  if aim then
    local m_VerticalAxis = aim.m_VerticalAxis
    m_VerticalAxis.m_MinValue = v - 10
    m_VerticalAxis.m_MaxValue = v + 10
    m_VerticalAxis.Value = v
    aim.m_VerticalAxis = m_VerticalAxis
    local m_HorizontalAxis = aim.m_HorizontalAxis
    m_HorizontalAxis.m_MinValue = h - 10
    m_HorizontalAxis.m_MaxValue = h + 10
    m_HorizontalAxis.Value = h
    aim.m_HorizontalAxis = m_HorizontalAxis
  end
end

function this:bindScreenTouch(sign)
  self.onDragStartHandle = self.onDragStartHandle or L_CommonUtil.handle(self.onTouch_dragStart, self)
  self.onDragHandle = self.onDragHandle or L_CommonUtil.handle(self.onTouch_drag, self)
  self.onDragEndHandle = self.onDragEndHandle or L_CommonUtil.handle(self.onTouch_dragEnd, self)
  C_ScreenTouch.OnUI_DragStart(sign, self.onDragStartHandle)
  C_ScreenTouch.OnUI_Drag(sign, self.onDragHandle)
  C_ScreenTouch.OnUI_DragEnd(sign, self.onDragEndHandle)
end

function this:onTouch_dragStart(gesture)
  self.touchMain = gesture.go == self.bindComponents.main.gameObject
end

function this:onTouch_drag(gesture)
  if not self.touchMain then
    return
  end
  if self.virtualCamera == nil then
    return
  end
  local tempForward = self.virtualCamera.transform.forward
  self.virtualCamera.transform.eulerAngles = C_Vector3(self.virtualCamera.transform.eulerAngles.x - 360 * self.cameraRotateSpeed * gesture.deltaTime * (gesture.deltaPosition.y / C_Screen.height), self.virtualCamera.transform.eulerAngles.y + 360 * self.cameraRotateSpeed * gesture.deltaTime * (gesture.deltaPosition.x / C_Screen.width), 0)
  local angle = C_Vector3.Angle(self.oriForward, self.virtualCamera.transform.forward)
  if angle > self.bind.angle then
    self.virtualCamera.transform.forward = tempForward
  end
end

function this:onTouch_dragEnd()
  self.touchMain = nil
end

function this:findSelfWorldMapId()
  if self.worldMapId then
    return self.worldMapId
  end
  local pos = self.targetPos
  local _worldMapTpl = L_GameTpl:getWorldMapTpl()
  local sceneId = AzurWorldInstance.CurWorldId
  local spawnerId = L_Const.photoExploreSpawner
  local tplList = _worldMapTpl:getAllTplBySpawnerId(sceneId, spawnerId)
  for _, tpl in pairs(tplList) do
    local targetPos = _worldMapTpl:getPosition(tpl)
    if targetPos.x - pos.x < 30 and 30 > targetPos.y - pos.y and 30 > targetPos.z - pos.z then
      self.worldMapId = _worldMapTpl:getId(tpl)
      return
    end
  end
end

return this
