------------ import ------------

local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local URPCameraController       = CS.Game.Native.URP.URPCameraController
------------ import ------------

------------ define ------------
local next          = next
local Quaternion    = Quaternion
local Vector3       = Vector3
local QuickTapType        = typeof(CS.HedgehogTeam.EasyTouch.QuickTap)
------------ define ------------

---@class MapDecryptionAntiqueModelController
local MapDecryptionAntiqueModelController = Class('MapDecryptionAntiqueModelController')


function MapDecryptionAntiqueModelController:__init()
    self._antiqueNodes     = {}
    self._antiqueLoaderCos = {}
    self._virtualCameraDefaultParams = {}
    self._antiqueParent    = nil
    self._isEnter          = false
end


function MapDecryptionAntiqueModelController:__delete()

end

--- Init
---@param sceneInstance SceneInstance
---@param component MapDecryptionComponent
function MapDecryptionAntiqueModelController:Init(sceneInstance, component)
    ---@type UnityEngine.GameObject
    self._antiqueParent = MapDecryptionUtils.CreateGameObject("Antiques", true)
    sceneInstance:AddCacheObject(self._antiqueParent)

    local SceneDefine = MapDecryptionConstants.SceneDefine
    local sceneVirtualCameraNode = sceneInstance:GetCacheObjectByName(SceneDefine.SceneVirtualCameraNode).transform
    self:InitVirtualCamera(sceneVirtualCameraNode)

    local scenePositionsNode = sceneInstance:GetCacheObjectByName(SceneDefine.ScenePositionsNode).transform
    local AntiquePositionsNode = scenePositionsNode:Find(SceneDefine.AntiquePositions)   
    local AntiqueCameraPositions = scenePositionsNode:Find(SceneDefine.AntiqueCameraPositions)   
    local AntiqueLabelNodePositions = scenePositionsNode:Find(SceneDefine.AntiqueLabelNodePositions)   
    local AntiqueTipsNodePositions = scenePositionsNode:Find(SceneDefine.AntiqueTipsNodePositions)   


    -- self:InitAntiqueCameraPositions(AntiqueCameraPositions)
    -- self._AntiquePositions = AntiquePositions
    local entityList = component:GetAntiqueEntityList()
    self:InitAllAntiquePositions(entityList, AntiquePositionsNode, AntiqueCameraPositions, AntiqueLabelNodePositions, AntiqueTipsNodePositions)
    self:InitAllAntique(entityList)

end

--- InitVirtualCamera
---@param sceneVirtualCameraNode UnityEngine.Transform
function MapDecryptionAntiqueModelController:InitVirtualCamera(sceneVirtualCameraNode)
    local SceneDefine = MapDecryptionConstants.SceneDefine
    local transform = sceneVirtualCameraNode:Find(SceneDefine.AntiqueRestorationCamera)
    self._virtualCameraDefaultParams = {
        localPosition = transform.localPosition,
        localRotation = transform.localRotation,
        localScale    = transform.localScale,
    }
    self._virtualCameraTrans = transform

end

function MapDecryptionAntiqueModelController:ResetVirtualCamera()
    local transform         = self._virtualCameraTrans
    local defParams         = self._virtualCameraDefaultParams
    transform.localPosition = defParams.localPosition
    transform.localRotation = defParams.localRotation
    transform.localScale    = defParams.localScale

end

--- InitAllAntiquePositions
---@param entityList MapDecryptionAntiqueRestorationEntity[]
---@param AntiquePositionsNode UnityEngine.Transform
function MapDecryptionAntiqueModelController:InitAllAntiquePositions(entityList, AntiquePositionsNode, AntiqueCameraPositions, AntiqueLabelNodePositions, AntiqueTipsNodePositions)
    local t = {}
    local t1 = {}
    local t2 = {}
    local t3 = {}
    local childCount = AntiqueTipsNodePositions.childCount
    local positionNode
    for i, v in ipairs(entityList) do
        ---@type UnityEngine.Transform
        positionNode = AntiquePositionsNode:GetChild(i - 1)
        t[v.antiqueId] = {positionNode.localPosition, positionNode.localRotation, positionNode.localScale}

        positionNode = AntiqueCameraPositions:GetChild(i - 1)
        t1[v.antiqueId] = {positionNode.position, positionNode.rotation, positionNode.localScale}

        positionNode = AntiqueLabelNodePositions:GetChild(i - 1)
        t2[v.antiqueId] = positionNode

        if i <= childCount then
            positionNode = AntiqueTipsNodePositions:GetChild(i - 1)
            t3[v.antiqueId] = positionNode
        end
    
    end
    self._antiqueId2TransInfo = t
    self._antiqueId2CameraTransInfo = t1
    self._antiqueId2LabelPosition = t2
    self._antiqueId2TipsPosition = t3
    
end

--- InitAntiqueCameraPositions
---@param positionNodes UnityEngine.Transform
function MapDecryptionAntiqueModelController:InitAntiqueCameraPositions(entityList, positionNodes)
    local t = {}
    local count = positionNodes.childCount
    for i = 1, count do
        ---@type UnityEngine.Transform
        local positionNode = positionNodes:GetChild(i - 1)
        
    end
end

function MapDecryptionAntiqueModelController:InitAllAntique(entityList)
    local parent = self._antiqueParent
    local count = #entityList 
    for i = count, 1, -1 do
        ---@type MapDecryptionAntiqueRestorationEntity
        local entity = entityList[i]
        self:LoadAntique(entity, parent)

        --- 如果 最后一个古物已修复 则前三个不需要加载
        if entity.isFinal and entity.status == 2 then
            break
        end
    end


end

--- LoadAntique
--- 加载古物
---@param entity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueModelController:LoadAntique(entity, parent)
    ---@type MapDecryptionAntiqueRestorationVo
    local antiqueRestorationVo = entity.antiqueRestorationVo
    local antiqueId            = entity.antiqueId
    local status               = entity.status
    --- 如果 未获得古物则不加载
    if status == 0 then
        return
    end
    local isRestore  = status == 2
    local prefabPath = isRestore and antiqueRestorationVo.prefab2 or antiqueRestorationVo.prefab1
    if string.isEmpty(prefabPath) then
        return
    end
    local co = cs_coroutine.start(function ()
        local go = GameUtils.LoadBundleAsync(prefabPath, parent)
        local oldAntiqueNode = self._antiqueNodes[antiqueId]
        if not isNull(oldAntiqueNode) then
            KTool.SafeDelete(oldAntiqueNode)
        end
        self:InitAntiqueNode(go, entity) 

        self._antiqueNodes[antiqueId]     = go
        self._antiqueLoaderCos[antiqueId] = nil
    end)
    self._antiqueLoaderCos[antiqueId] = co

end

--- InitAntiqueNode
---@param go UnityEngine.GameObject
---@param entity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueModelController:InitAntiqueNode(go, entity)
    ---@type UnityEngine.Transform
    local transInfo = self._antiqueId2TransInfo[entity.antiqueId]
    local localPosition, localRotation, localScale = transInfo[1], transInfo[2], transInfo[3]
    local transform            = go.transform
    transform.localPosition    = localPosition
    transform.localRotation    = localRotation
    transform.localScale       = localScale
    
    ---@type HedgehogTeam.EasyTouch.QuickTap
    local quickTap = KTool.GetOrAddComponent(go, QuickTapType)
    quickTap.onTap:AddListener(function(gesture)
        if self._callback then
            self._callback(entity)
        end

    end)
end

function MapDecryptionAntiqueModelController:CheckIsInitComplete()
    return next(self._antiqueLoaderCos) == nil
end

--- RestoreAntique
--- 恢复古物
---@param antiqueEntity      MapDecryptionAntiqueRestorationEntity
---@param finalAntiqueEntity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueModelController:RestoreAntique(antiqueEntity, finalAntiqueEntity)
    --- 如果当前是最后一个古物
    --- 则隐藏前面的古物
    --- 隐藏 MapDecryptionAntiqueRestorationProgressNode
    local parent = self._antiqueParent
    local isFinal = antiqueEntity.isFinal
    if isFinal then
        --- 则隐藏前面的古物
        for antiqueId, antiqueNode in pairs(self._antiqueNodes) do
            if antiqueId ~= antiqueEntity.antiqueId then
                KTool.SafeDelete(antiqueNode.gameObject)
            end
        end
    elseif finalAntiqueEntity then
        self:LoadAntique(finalAntiqueEntity, parent)    
    end

    self:LoadAntique(antiqueEntity, parent)
end

function MapDecryptionAntiqueModelController:GetAntiqueNode(antiqueId)
    return self._antiqueNodes[antiqueId]
end

function MapDecryptionAntiqueModelController:GetAntiqueLabelPosition(antiqueId)
    return self._antiqueId2LabelPosition[antiqueId]
end

function MapDecryptionAntiqueModelController:GetAntiqueTipsPosition(antiqueId)
    return self._antiqueId2TipsPosition[antiqueId]
end

function MapDecryptionAntiqueModelController:SetVirtualCamShowState(isShow)
    KTool.SetActive(self._virtualCameraTrans.gameObject, isShow)
end

function MapDecryptionAntiqueModelController:SetClickAntiqueCallback(callback)
    self._callback = callback
end

function MapDecryptionAntiqueModelController:LookAtAntique(antiqueId)
    -- local antiqueNode         = self:GetAntiqueNode(antiqueId)

    local positionInfo = self._antiqueId2CameraTransInfo[antiqueId]
    if next(positionInfo) == nil then
        return
    end
    local position, rotation, localScale = SafeUnpack(positionInfo)

    ---@type UnityEngine.Transform
    local virtualCameraTrans = self._virtualCameraTrans
    virtualCameraTrans:SetPositionAndRotation(position, rotation)
    virtualCameraTrans.localScale = localScale

    -- local cameraPosition      = self._virtualCameraTrans.position
    -- local antiqueNodePosition = antiqueNode.transform.position
    -- local distance            = Vector3.Distance(cameraPosition, antiqueNodePosition)
    -- local v3                  = Vector3.New(antiqueNodePosition.x - cameraPosition.x, antiqueNodePosition.y - cameraPosition.y, antiqueNodePosition.z - cameraPosition.z)
    
    -- self._virtualCameraTrans.forward = v3
    -- local position = self._virtualCameraTrans.position
    -- self._virtualCameraTrans.position = Vector3.New(position.x + distance * 0.5, position.y, position.z)

end

return MapDecryptionAntiqueModelController

