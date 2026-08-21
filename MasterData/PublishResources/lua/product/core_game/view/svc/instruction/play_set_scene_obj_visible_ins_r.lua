require("base_ins_r")
_class("PlaySetSceneObjVisibleInstruction", BaseInstruction)
PlaySetSceneObjVisibleInstruction = PlaySetSceneObjVisibleInstruction

function PlaySetSceneObjVisibleInstruction:Constructor(paramList)
  self._sceneObjName = paramList.sceneObjName
  self._visible = tonumber(paramList.visible)
end

function PlaySetSceneObjVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local sceneGO = renderBoardCmpt:GetSceneGO("SceneRoot")
  local go = GameObjectHelper.FindChild(sceneGO.transform, self._sceneObjName).gameObject
  if go then
    go:SetActive(self._visible == 1)
  end
end
