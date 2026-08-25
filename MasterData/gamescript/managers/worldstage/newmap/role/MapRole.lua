local DOTween = CS.DG.Tweening.DOTween
local AnimatorType = typeof(CS.UnityEngine.Animator)
local MeshRenderer = CS.UnityEngine.MeshRenderer
local Texture2D = typeof(CS.UnityEngine.Texture2D)
local MapRole, Super = System.NewClass("MapRole", MapItemBase)

function MapRole:ctor(mgr)
  Super.ctor(self)
  self.binder = Vue.newBinder(self)
  self.labelName = nil
  self.manager = mgr
  self.prevPos = {x = 0, y = 0}
  self.fireEffectParam = {
    [1] = 0.155,
    [2] = 0.24,
    [3] = 0.34
  }
end

function MapRole:Dispose()
  self.material = nil
  Super.Dispose(self)
  DOTweenUtils.KillAllTweensByTarget(self)
  ResLoadMgr.UnloadAssetByTarget(self)
end

function MapRole:InitPrePos(lastPos)
  if lastPos then
    self._recoverdLastPos = {}
    self._recoverdLastPos.x = tonumber(lastPos.x)
    self._recoverdLastPos.y = tonumber(lastPos.y)
  end
end

function MapRole:SetGridPos(x, y)
  local prevX, prevY = self:GetGridPos()
  self.prevPos.x = prevX
  self.prevPos.y = prevY
  Super.SetGridPos(self, x, y)
  if self.go then
    self.go.name = string.format("%s, %s", x, y)
  end
  local terrainMgr = self.manager:GetComponent(MapTerrainManager)
  terrainMgr:UpdateClickable()
end

function MapRole:GetPrevPos()
  if 0 == self.prevPos.x and 0 == self.prevPos.y and self._recoverdLastPos then
    return self._recoverdLastPos.x, self._recoverdLastPos.y
  end
  return self.prevPos.x, self.prevPos.y
end

function MapRole:OnLoad()
  Super.OnLoad(self)
  self.cameraTransform = self.tf:Find("Main Camera")
  self.cameraPos = self.cameraTransform.localPosition
  local trigger = self.tf:GetComponent(typeof(CS.MapRoleTrigger))
  trigger.triggerCallback = System.fn(self, self.OnTrigger)
  local cameraMgr = self.manager:GetComponent(MapCameraManager)
  cameraMgr:AttachFollow(self.cameraTransform, self.tf, self.cameraPos)
  self.light = self.tf:Find("Spot Light"):GetComponent(typeof(CS.UnityEngine.Light))
  self.actorComp = self.tf:GetComponent(typeof(CS.ActorGlobalPos))
  self:SetFireParam(MapModel.Instance:GetRoleFOV())
  local actorObj = self.tf:Find("Z1-Actor-Mesh")
  self.animator = actorObj:GetComponent(AnimatorType)
  self.material = actorObj:GetComponent(typeof(MeshRenderer)).material
  self:SetRoleImg()
  self.binder:BindToRaw(function(_, avatarResId)
    if avatarResId and "" ~= avatarResId then
      local path = DT.GetConstant(avatarResId)
      if path and "" ~= path then
        local id = self:GetMaterialTexId()
        local avatarResTex = ResLoadMgr.LoadAsset(path, self, Texture2D)
        if avatarResTex then
          self.material:SetTexture(id, avatarResTex)
          return
        end
      end
    end
    if PlayerDataUtils.IsInAprileFool() then
      local path = PlayerDataUtils.GetAprileFoolReplaceMapAvatarRes()
      if path and "" ~= path then
        local id = self:GetMaterialTexId()
        local avatarResTex = ResLoadMgr.LoadAsset(path, self, Texture2D)
        if avatarResTex then
          self.material:SetTexture(id, avatarResTex)
          return
        end
      end
    end
    self:SetRoleImg()
  end, function()
    local stageData = WorldStageManager.Instance:GetCurStageData()
    return stageData.avatarResId
  end)
  self.binder:BindLongPressButton(self.tf, nil, System.fn(self, self.OnClickRole), 1)
end

function MapRole:SetRoleImg()
  if not self.texture then
    local ResPath = GenderDataUtils.GetMapAvatarRes()
    if nil ~= ResPath and "" ~= ResPath then
      self.texture = ResLoadMgr.LoadAsset(ResPath, self, Texture2D)
    end
  end
  if self.texture then
    local id = self:GetMaterialTexId()
    self.material:SetTexture(id, self.texture)
  end
end

function MapRole:OnClickRole()
  EventMgr.Instance.GridClick:Dispatch(self:GetGridPos())
end

function MapRole:GetMaterialTexId()
  if not self.TexId then
    self.TexId = CS.UnityEngine.Shader.PropertyToID("_MainMap")
  end
  return self.TexId
end

function MapRole:GetLight()
  return self.light
end

function MapRole:OnTrigger(result)
  local cameraMgr = self.manager:GetComponent(MapCameraManager)
  if nil == cameraMgr then
    return
  end
  if 0 == result then
    cameraMgr:DetachFollow(self.tf, self.cameraTransform.position)
  else
    cameraMgr:AttachFollow(self.cameraTransform, self.tf, self.cameraPos, true)
  end
end

function MapRole:OnAnimEnd()
end

function MapRole:PlayAnim(animName)
  if not self.animator then
    Logger.Warn("MapRole没有animator组件")
    return
  end
  AnimatorUtils.PlayState(self.animator, animName)
end

function MapRole:PlayTopAnim(str)
  if self.animator == nil or nil == self.tmpName then
    return
  end
  self.tmpName.text = str
  AnimatorUtils.PlayState(self.animator, "Base Layer.mapRoot_PressureAdd")
end

function MapRole:SetFireParam(level)
  local param = self.fireEffectParam[level]
  if param then
    self.actorComp.FogRadius = param
  end
end

function MapRole:MoveByGrid(gridX, gridY, _, EndFunc)
  if self.tf then
    local y = self.tf.localPosition.y
    local curPosX, curPosY = self:GetGridPos()
    local mapEntity = self.manager.parent
    local moveTime = mapEntity:GetMoveGridTime()
    local prevPosX, prevPosY = self:GetPrevPos()
    local posX, posZ = mapEntity:GetWorldPosByGridPos(gridX, gridY)
    local sequence = DOTween.Sequence(self)
    AudioManager.Instance:PostSoundEvent("Play_Explore_MC_Move")
    local gearMgr = self.manager:GetComponent(MapGearManager)
    local curGear = gearMgr:GetGearByPos(curPosX, curPosY)
    if curGear and curGear:GetType() == CommonDefine.GearItemType.DropTerrain and tonumber(prevPosX) == tonumber(gridX) and tonumber(prevPosY) == tonumber(gridY) then
      Alert.Show(10555)
      self.manager.isMoving = false
      return
    end
    local effectMgr = self.manager:GetComponent(MapArtEffectManager)
    sequence:Append(self.tf:DOLocalMove(CS.UnityEngine.Vector3(posX, y, posZ), moveTime))
    self.prevPos.x, self.prevPos.y = curPosX, curPosY
    local gear = gearMgr:GetGearByPos(gridX, gridY)
    local isActiveBattleNode = gear and CommonDefine.GearBattleType[gear:GetType()] and not gear:IsRemoved()
    if isActiveBattleNode then
      effectMgr:PlayBattleNearDown(curPosX, curPosY, gridX, gridY)
    else
      effectMgr:PlayOpenMistAndGridAnim(curPosX, curPosY, gridX, gridY)
    end
    sequence:OnComplete(function()
      if EndFunc then
        EndFunc(gridX, gridY)
      end
    end)
  end
end

return MapRole
