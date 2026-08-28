------------ import ------------

local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool

local cs_coroutine = require 'XLua.cs_coroutine'    -- 协程
local Yielders = CS.Engine.Lib.Yielders             -- 协程

local URPCameraController = CS.Game.Native.URP.URPCameraController

local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local CinemachineFreeLook   = CS.Cinemachine.CinemachineFreeLook
local GameObject            = CS.UnityEngine.GameObject
local Object                = CS.UnityEngine.Object
local Image                 = CS.UnityEngine.UI.Image
local Quaternion            = CS.UnityEngine.Quaternion

local SceneManagementIns        = SceneManagement:GetInstance()

------------ import ------------

------------ define ------------
local next          = next
local Quaternion    = Quaternion
local Vector3       = Vector3

------------ define ------------

---@class MapDecryptionExploreTrackingController
local MapDecryptionExploreTrackingController = Class('MapDecryptionExploreTrackingController')


function MapDecryptionExploreTrackingController:__init()
    self._exploreCamera = nil
    self._explorePositionRoot = nil
    self._explorePositions = {}
    self._exploreRotations = {}
    self._trackingCamera = nil
    self._trackingPositionRoot = nil
    self._trackingPositions = {}
    self._trackingRotations = {}
end


function MapDecryptionExploreTrackingController:__delete()
end

--- Init
---@param sceneInstance SceneInstance
function MapDecryptionExploreTrackingController:Init(sceneInstance)
    local sceneVirtualCameraNodeTrans = sceneInstance:GetCacheObjectByName(MapDecryptionConstants.SceneDefine.SceneVirtualCameraNode).transform
    local scenePositionsNodeTrans = sceneInstance:GetCacheObjectByName(MapDecryptionConstants.SceneDefine.ScenePositionsNode).transform
    local scenePlayerNodeTrans = sceneInstance:GetCacheObjectByName(MapDecryptionConstants.SceneDefine.ScenePlayerNode).transform

    self:InitTracking(sceneVirtualCameraNodeTrans, scenePositionsNodeTrans)
    self:InitExplore(sceneVirtualCameraNodeTrans, scenePositionsNodeTrans)
end

function MapDecryptionExploreTrackingController:InitExplore(sceneVirtualCameraNodeTrans, scenePositionsNodeTrans)
    local SceneDefine         = MapDecryptionConstants.SceneDefine
    self._exploreCamera       = sceneVirtualCameraNodeTrans:Find(SceneDefine.ExploreCamera) -- Transform
    self._exploreCameraComp = KTool.GetComponent(self._exploreCamera.gameObject, typeof(CinemachineVirtualCamera))
    assert( not isNull(self._exploreCameraComp) )

    -- exploreCamera 前一个阶段的 camera, 为了支持实现 exploreCamera 的 "进入" 动画效果:
    self._PrefixExploreCameraTF  = sceneVirtualCameraNodeTrans:Find(SceneDefine.PrefixExploreCamera) -- Transform, 
    self._PrefixExploreCameraComp = KTool.GetComponent(self._PrefixExploreCameraTF.gameObject, typeof(CinemachineVirtualCamera))
    assert( not isNull(self._PrefixExploreCameraComp) )

    self._explorePositionRoot = scenePositionsNodeTrans:Find(SceneDefine.ExplorePositions)
end

function MapDecryptionExploreTrackingController:InitTracking(sceneVirtualCameraNodeTrans, scenePositionsNodeTrans)
    local SceneDefine          = MapDecryptionConstants.SceneDefine
    self._trackingCamera       = sceneVirtualCameraNodeTrans:Find(SceneDefine.TrackingCamera)
    self._trackingCameraComp = KTool.GetComponent(self._trackingCamera.gameObject, typeof(CinemachineVirtualCamera))
    assert( not isNull(self._trackingCameraComp) )

    -- trackingCamera 前一个阶段的 camera, 为了支持实现 trackingCamera 的 "进入" 动画效果:
    self._PrefixTrackingCameraTF  = sceneVirtualCameraNodeTrans:Find(SceneDefine.PrefixTrackingCamera) -- Transform, 
    self._PrefixTrackingCameraComp = KTool.GetComponent(self._PrefixTrackingCameraTF.gameObject, typeof(CinemachineVirtualCamera))
    assert( not isNull(self._PrefixTrackingCameraComp) )

    self._trackingPositionRoot = scenePositionsNodeTrans:Find(SceneDefine.TrackingPositions)
end



function MapDecryptionExploreTrackingController:GetAllPositionBySubType(subType)
    local SubViewType = MapDecryptionConstants.ExploreTrackingSubViewType
    local isExplore   = subType == SubViewType.Explore
    local positions   = isExplore and self._explorePositions or self._trackingPositions
    local rotations   = isExplore and self._exploreRotations or self._trackingRotations
    if next(positions) == nil then
        ---@type UnityEngine.Transform
        local root       = isExplore and self._explorePositionRoot or self._trackingPositionRoot
        local childCount = root.childCount
        for i = 1, childCount, 1 do
            local child = root:GetChild(i - 1)
            table.insert(positions, child.position)
            table.insert(rotations, child.rotation)
        end
        
    end

    return positions, rotations

end

function MapDecryptionExploreTrackingController:ShowVirtualCameraBySubType(subType)
    local SubViewType = MapDecryptionConstants.ExploreTrackingSubViewType
    KTool.SetActive(self._exploreCamera.gameObject,  subType == SubViewType.Explore)
    KTool.SetActive(self._trackingCamera.gameObject, subType == SubViewType.Tracking)
end


-- 当进入 TrackingCamera 或 ExploreCamera 时, 需要更为复杂的 进入动画: (带协程)
function MapDecryptionExploreTrackingController:ShowVirtualCameraBySubTypePro(subType)
    if self._backFromFight then
        self:SetBackFromFight(false)
        self:ShowVirtualCameraBySubType(subType)
        return
    end
    if isNull(subType) then 
        return
    end
    local SubViewType = MapDecryptionConstants.ExploreTrackingSubViewType

    --- 找到本次的 目标 vcamera:
    local preVCameraTF = nil 
    local preVCameraComp = nil
    local tgtVCameraTF = nil 
    local tgtVCameraComp = nil
    if subType == SubViewType.Explore then 
        preVCameraTF   = self._PrefixExploreCameraTF
        preVCameraComp = self._PrefixExploreCameraComp
        tgtVCameraTF   = self._exploreCamera
        tgtVCameraComp = self._exploreCameraComp

    elseif subType == SubViewType.Tracking then 
        preVCameraTF   = self._PrefixTrackingCameraTF
        preVCameraComp = self._PrefixTrackingCameraComp
        tgtVCameraTF   = self._trackingCamera
        tgtVCameraComp = self._trackingCameraComp
    end
    assert( not isNull(preVCameraTF) )
    assert( not isNull(preVCameraComp) )
    assert( not isNull(tgtVCameraTF) )
    assert( not isNull(tgtVCameraComp) )

    MapDecryptionMgr.EnterVCameraWithPreAnim( preVCameraTF, preVCameraComp, tgtVCameraTF, tgtVCameraComp, 0.4,  
        function()
            KTool.SetActive(self._exploreCamera.gameObject,         subType == SubViewType.Explore)
            KTool.SetActive(self._trackingCamera.gameObject,        subType == SubViewType.Tracking)
        end 
    )
end


-- -- 从 "追踪"界面 回退到 第三人称角色视角时:
function MapDecryptionExploreTrackingController:SwitchVCameraWhenReturn()

    KTool.SetActive(self._exploreCamera.gameObject,  false)
    KTool.SetActive(self._trackingCamera.gameObject, false)
end

--- SetBackFromFight
--- 设置从战斗返回标识
---@param backFromFight boolean
function MapDecryptionExploreTrackingController:SetBackFromFight(backFromFight)
    self._backFromFight = backFromFight
end


return MapDecryptionExploreTrackingController

