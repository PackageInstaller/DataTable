local CS_UnityEngine_GameObject = CS.UnityEngine.GameObject
local CS_UnityEngine_Collider = CS.UnityEngine.Collider
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightSceneCtrl = class("DormFightSceneCtrl", DormFightCtrlBase)

function DormFightSceneCtrl:ctor()
  self._walls = nil
end

function DormFightSceneCtrl:OnEnterFightScene()
  self._walls = {}
  local transObjects = CS_UnityEngine_GameObject.Find("Objects").transform
  local transWallRoot = transObjects:Find("Wall")
  local childCount = transWallRoot.childCount
  for i = 0, childCount - 1 do
    local transWall = transWallRoot:GetChild(i)
    local colliderWall = transWall:GetComponent(typeof(CS_UnityEngine_Collider))
    if not IsNull(colliderWall) then
      table.insert(self._walls, colliderWall)
    end
  end
end

function DormFightSceneCtrl:OnExitFightScene()
  self._walls = nil
end

function DormFightSceneCtrl:GetWallList()
  return self._walls or {}
end

function DormFightCtrlBase:OnUpdate(deltaTime)
end

return DormFightSceneCtrl
