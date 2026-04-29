require("base_ins_r")
_class("PlayHideSceneAndPlaySceneEffInstruction", BaseInstruction)
PlayHideSceneAndPlaySceneEffInstruction = PlayHideSceneAndPlaySceneEffInstruction

function PlayHideSceneAndPlaySceneEffInstruction:Constructor(paramList)
  self._sceneOpenEffectID = tonumber(paramList.sceneOpenEffectID)
  self._openDelayTime = tonumber(paramList.openDelayTime) or 0
  self._sceneEffectID = tonumber(paramList.sceneEffectID)
  self._sceneEffPos = Vector2(tonumber(paramList.gridPosX), tonumber(paramList.gridPosY))
  self._backIntensity = tonumber(paramList.backIntensity)
end

function PlayHideSceneAndPlaySceneEffInstruction:GetCacheResource()
  local t = {}
  if self._sceneOpenEffectID and self._sceneOpenEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._sceneOpenEffectID].ResPath,
      1
    })
  end
  if self._sceneEffectID and 0 < self._sceneEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._sceneEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayHideSceneAndPlaySceneEffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectSvc = world:GetService("Effect")
  effectSvc:CreateWorldPositionEffect(self._sceneOpenEffectID, self._sceneEffPos)
  if self._openDelayTime > 0 then
    YIELD(TT, self._openDelayTime)
  end
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local goScene = renderBoardCmpt:GetSceneGO("SceneRoot")
  if goScene then
    goScene:SetActive(false)
  end
  local sceneEffEntity = effectSvc:CreateWorldPositionEffect(self._sceneEffectID, self._sceneEffPos)
  renderBoardCmpt:SetSceneEffectEntityID(sceneEffEntity:GetID())
  local goRenderSetting = UnityEngine.GameObject.Find("[H3DRenderSetting]")
  local csRenderSetting = goRenderSetting:GetComponent("H3DRenderSetting")
  if csRenderSetting.BackIntensity then
    csRenderSetting.BackIntensity = self._backIntensity
  end
end
