require("base_ins_r")
_class("PlaySceneObjLegacyAnimationInstruction", BaseInstruction)
PlaySceneObjLegacyAnimationInstruction = PlaySceneObjLegacyAnimationInstruction

function PlaySceneObjLegacyAnimationInstruction:Constructor(paramList)
  local str = paramList.animNames
  self._animNames = string.split(str, "|")
  self._sceneObjName = paramList.sceneObjName
end

function PlaySceneObjLegacyAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._animNames == nil then
    Log.fatal("Legacy animation params is nil!")
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local sceneGO = renderBoardCmpt:GetSceneGO("SceneRoot")
  local go = GameObjectHelper.FindChild(sceneGO.transform, self._sceneObjName).gameObject
  if go then
    local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
    if anim == nil then
      Log.fatal("Cant play legacy animation, animation not found in ", go.name)
      return
    end
    if table.count(self._animNames) > 1 then
      anim:Stop()
      for i = 1, #self._animNames do
        anim:PlayQueued(self._animNames[i])
      end
    else
      anim:Play(self._animNames[1])
    end
  end
end
