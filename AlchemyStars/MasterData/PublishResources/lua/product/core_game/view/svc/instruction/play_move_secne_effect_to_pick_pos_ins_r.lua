require("base_ins_r")
_class("PlayMoveSceneEffectToPickPosInstruction", BaseInstruction)
PlayMoveSceneEffectToPickPosInstruction = PlayMoveSceneEffectToPickPosInstruction

function PlayMoveSceneEffectToPickPosInstruction:Constructor(paramList)
  self._sceneEffID = tonumber(paramList.sceneEffID)
  self._sceneEffX = tonumber(paramList.sceneEffX) or 0
  self._sceneEffY = tonumber(paramList.sceneEffY) or 0
  self._sceneEffZ = tonumber(paramList.sceneEffZ) or 0
  self._moveTime = tonumber(paramList.moveTime)
end

function PlayMoveSceneEffectToPickPosInstruction:GetCacheResource()
  local t = {}
  if self._sceneEffID and self._sceneEffID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._sceneEffID].ResPath,
      1
    })
  end
  return t
end

function PlayMoveSceneEffectToPickPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local castPos = Vector3(self._sceneEffX, self._sceneEffY, self._sceneEffZ)
  local targetPosV2 = phaseContext:GetCurGridPos()
  local boardServiceRender = world:GetService("BoardRender")
  local targetPos = boardServiceRender:GridPos2RenderPos(targetPosV2)
  local effectEntity = world:GetService("Effect"):CreatePositionEffect(self._sceneEffID, castPos)
  YIELD(TT)
  local go = effectEntity:View():GetGameObject()
  local doTween = go.transform:DOMove(targetPos, self._moveTime / 1000.0, false)
  if doTween then
    doTween:SetEase(DG.Tweening.Ease.InOutSine)
  end
end
