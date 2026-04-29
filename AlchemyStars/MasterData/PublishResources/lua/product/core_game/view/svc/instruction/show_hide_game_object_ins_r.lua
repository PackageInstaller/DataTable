require("base_ins_r")
_class("ShowHideGameObjectInstruction", BaseInstruction)
ShowHideGameObjectInstruction = ShowHideGameObjectInstruction

function ShowHideGameObjectInstruction:Constructor(paramList)
  local str = paramList.isShow or "0"
  self._isShow = tonumber(str) > 0
  self._goName = paramList.goName or ""
end

function ShowHideGameObjectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if string.isnullorempty(self._goName) then
    Log.fatal("### ShowHideGameObjectInstruction param [goName] invalid. goName=", self._goName)
    return
  end
  local cRenderBoard = world:GetRenderBoardEntity():RenderBoard()
  local go = cRenderBoard:GetSceneGO(self._goName)
  if go then
    go:SetActive(self._isShow)
  else
    Log.fatal("### no GameObject named [", self._goName, "] in scene.")
  end
end
