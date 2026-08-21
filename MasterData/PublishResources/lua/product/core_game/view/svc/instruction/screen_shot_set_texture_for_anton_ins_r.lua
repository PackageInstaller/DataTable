require("base_ins_r")
_class("ScreenShotSetTestureForAntonInstruction", BaseInstruction)
ScreenShotSetTestureForAntonInstruction = ScreenShotSetTestureForAntonInstruction

function ScreenShotSetTestureForAntonInstruction:Constructor(paramList)
  self._duration = tonumber(paramList.duration) or 3500
  self._effectID = tonumber(paramList.effectID)
  self._block = tonumber(paramList.block) or 1
end

function ScreenShotSetTestureForAntonInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local efx = effectService:CreateScreenEffPointEffect(self._effectID)
  local obj = efx:View():GetGameObject()
  obj:SetActive(false)
  obj:SetActive(true)
  local csMeshRenderer = obj.gameObject:GetComponentInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  local cMainCamera = world:MainCamera()
  local csCamera = cMainCamera._sceneCamera
  self._csCamera = csCamera
  self._oldMask = csCamera.cullingMask
  self._oldclearFlags = csCamera.clearFlags
  csCamera.clearFlags = UnityEngine.CameraClearFlags.Depth
  csCamera.cullingMask = 1048576
  local casterEntityObj = casterEntity:View():GetGameObject()
  GameObjectHelper.SetGameObjectLayer(casterEntityObj, 20)
  local renderTextureScene = self:OnGetRenderTexture()
  GameObjectHelper.SetGameObjectLayer(casterEntityObj, 0)
  YIELD(TT)
  csCamera.cullingMask = 2097152
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local brillantLineObj = renderBoardCmpt:GetBrillantGridObj()
  local renderTextureWangge
  if brillantLineObj ~= nil then
    GameObjectHelper.SetGameObjectLayer(brillantLineObj, 21)
    renderTextureWangge = self:OnGetRenderTexture()
    GameObjectHelper.SetGameObjectLayer(brillantLineObj, 0)
  else
    renderTextureWangge = self:OnGetRenderTexture()
  end
  local csMaterial = csMeshRenderer.material
  csMaterial:SetTexture("_SceneTex", renderTextureScene)
  csMaterial:SetTexture("_LineTex", renderTextureWangge)
  csMeshRenderer.material = csMaterial
  if self._block == 1 then
    YIELD(TT, self._duration)
    renderTextureScene:Destroy()
    renderTextureWangge:Destroy()
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, self._duration)
      renderTextureScene:Destroy()
      renderTextureWangge:Destroy()
    end)
  end
end

function ScreenShotSetTestureForAntonInstruction:OnGetRenderTexture()
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

function ScreenShotSetTestureForAntonInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
