local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessInputCtrl = class("WarChessInputCtrl", base)
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_LeanGesture = CS.Lean.Touch.LeanGesture
local CS_Physics = CS.PhysicsUtility
local CS_InputUtility = CS.InputUtility
local CS_RenderManager = CS.RenderManager

function WarChessInputCtrl:ctor(wcCtrl)
end

function WarChessInputCtrl:OnSceneLoadOver()
  self.__camMain = UIManager:GetMainCamera()
end

function WarChessInputCtrl:GetMouseCurentGroundPos()
  local mousePos = CS_InputUtility.MousePosition
  mousePos = Vector3.New(mousePos.x, mousePos.y, 1)
  local worldPos = self.__camMain:ScreenToWorldPoint(mousePos * CS_RenderManager.SceneCameraResolutionRatio)
  local camPos = self.__camMain.transform.position
  local rayDir = worldPos - camPos
  local hitPoint = MathUtil:GetIntersectWithLineAndPlane(camPos, rayDir, Vector3.up, Vector3.zero)
  return hitPoint
end

function WarChessInputCtrl:WorldPos2ScreenPos(worldPos)
  return self.__camMain:WorldToScreenPoint(worldPos)
end

function WarChessInputCtrl:GetIsOverSpecificGUI(UIName)
  local mousePos = CS_InputUtility.MousePosition
  local result = CS_LeanTouch.RaycastGui(mousePos)
  for i = 0, result.Count - 1 do
    local uigo = result[i].gameObject
    if not IsNull(uigo) and uigo.name == UIName then
      return true
    end
  end
  return false
end

function WarChessInputCtrl:Delete()
end

return WarChessInputCtrl
