require("base_ins_r")
_class("ScreenShotSetTextureNormalInstruction", BaseInstruction)
ScreenShotSetTextureNormalInstruction = ScreenShotSetTextureNormalInstruction

function ScreenShotSetTextureNormalInstruction:Constructor(paramList)
  self._duration = tonumber(paramList.duration) or 3500
  self._effectID = tonumber(paramList.effectID)
  self._effectName = paramList.effectName
  self._block = tonumber(paramList.block) or 1
  self._rootName = paramList.rootName
  self._textureName = paramList.textureName
  self._casterEffectHolderEffectID = tonumber(paramList.casterEffectHolderEffectID)
end

function ScreenShotSetTextureNormalInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local obj
  if self._effectID then
    local effectService = world:GetService("Effect")
    local efx = effectService:CreateScreenEffPointEffect(self._effectID)
    obj = efx:View():GetGameObject()
  end
  if self._casterEffectHolderEffectID and self._casterEffectHolderEffectID > 0 then
    local casterEffectHolderCmpt = casterEntity:EffectHolder()
    local effectEntityIDList = casterEffectHolderCmpt:GetEffectEntityIDByEffectID(self._casterEffectHolderEffectID)
    if effectEntityIDList then
      local effectEntityID = effectEntityIDList[#effectEntityIDList]
      local effectEntity = world:GetEntityByID(effectEntityID)
      if effectEntity and effectEntity:View() then
        obj = effectEntity:View():GetGameObject()
      end
    end
  elseif self._effectName then
    obj = GameObjectHelper.Find(self._effectName)
  end
  if not obj then
    return
  end
  local taegetObj = obj
  if self._rootName then
    taegetObj = GameObjectHelper.FindChild(obj.transform, self._rootName)
  end
  if not taegetObj then
    return
  end
  local csMeshRenderer = taegetObj.gameObject:GetComponentInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  local cMainCamera = world:MainCamera()
  local csCamera = cMainCamera._sceneCamera
  self._csCamera = csCamera
  self._oldMask = csCamera.cullingMask
  self._oldclearFlags = csCamera.clearFlags
  csCamera.clearFlags = UnityEngine.CameraClearFlags.Depth
  csCamera.cullingMask = 1048576
  local casterEntityObj = casterEntity:View():GetGameObject()
  GameObjectHelper.SetGameObjectLayer(casterEntityObj, 20)
  self:SetPieceEntityObjLayer(world, 20)
  local renderTextureScene = self:OnGetRenderTexture()
  YIELD(TT)
  GameObjectHelper.SetGameObjectLayer(casterEntityObj, 0)
  self:SetPieceEntityObjLayer(world, 0)
  local csMaterial = csMeshRenderer.material
  csMaterial:SetTexture(self._textureName, renderTextureScene)
  csMeshRenderer.material = csMaterial
  if self._block == 1 then
    YIELD(TT, self._duration)
    renderTextureScene:Destroy()
    self:_DeleteBoardBindEffect(casterEntity)
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, self._duration)
      renderTextureScene:Destroy()
      self:_DeleteBoardBindEffect(casterEntity)
    end)
  end
end

function ScreenShotSetTextureNormalInstruction:_DeleteBoardBindEffect(casterEntity)
  local world = casterEntity:GetOwnerWorld()
  if casterEntity and self._casterEffectHolderEffectID and self._casterEffectHolderEffectID > 0 then
    local casterEffectHolderCmpt = casterEntity:EffectHolder()
    if casterEffectHolderCmpt then
      local effectEntityIDList = casterEffectHolderCmpt:GetEffectEntityIDByEffectID(self._casterEffectHolderEffectID)
      if effectEntityIDList then
        for _, effectEntityID in ipairs(effectEntityIDList) do
          local effectEntity = world:GetEntityByID(effectEntityID)
          if world and effectEntity then
            world:DestroyEntity(effectEntity)
          end
        end
      end
      casterEffectHolderCmpt:ClearEffectByEffectID(self._casterEffectHolderEffectID)
    end
  end
end

function ScreenShotSetTextureNormalInstruction:OnGetRenderTexture()
  self._csCamera.gameObject:SetActive(true)
  local renderTexture = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  self._csCamera.targetTexture = renderTexture
  self._csCamera:Render()
  UnityEngine.RenderTexture.active = renderTexture
  self._csCamera.targetTexture = nil
  UnityEngine.RenderTexture.active = nil
  self._csCamera.cullingMask = self._oldMask
  self._csCamera.clearFlags = self._oldclearFlags
  self._csCamera.gameObject:SetActive(false)
  return renderTexture
end

function ScreenShotSetTextureNormalInstruction:SetPieceEntityObjLayer(world, layer)
  local pieceGroup = world:GetGroup(world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    if e and e:View() and e:View():GetGameObject() then
      local pieceEntityObj = e:View():GetGameObject()
      if pieceEntityObj then
        GameObjectHelper.SetGameObjectLayer(pieceEntityObj, layer)
      end
    end
  end
end

function ScreenShotSetTextureNormalInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
