
--region global define
local CS                  = CS
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
local Vector3Int = CS.UnityEngine.Vector3Int
local EasyTouch  = CS.HedgehogTeam.EasyTouch.EasyTouch
---@type ClubGVGUtils
local ClubGVGUtils = import("Game.UI.Club.GVG.ClubGVGUtils")
local Pool                 = import("Game.Utils.Pool")
local BehaviourAction = CS.Engine.Lib.BehaviourAction
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local LineRenderer                   = CS.UnityEngine.LineRenderer
---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')

--endregion

--region define
local EvtType       = EasyTouch.EvtType

local On_SwipeStart = EvtType.On_SwipeStart
local On_Swipe      = EvtType.On_Swipe
local On_SwipeEnd   = EvtType.On_SwipeEnd

local LineRendererType = typeof(LineRenderer)

local SetActive = CfUtils.SetActive

local GVGConstants  = ClubGVGUtils.Constants
local LuaParametersType       = LuaParametersReader.Type 

local FocusPosition = Vector3.New()
local FocusPositionNew = Vector3.New()
local Velocity = Vector3.New()

local DefineMaxCoreID = 20004

local Debug = false

local ClearTable = function (t)
    for key, value in pairs(t) do
        t[key] = nil
    end
    
end

local strict_number_equal = strict_number_equal
local VectorEquals = function (v1, v2)
    return strict_number_equal(v1.x, v2.x) and strict_number_equal(v1.y, v2.y) and strict_number_equal(v1.z, v2.z)
end

--endregion

--- from: Assets/BundleResources/Scenes/GVGmap/Prefabs/GVGCameraRoot.prefab > name: CameraRoot
---@class ClubGVGCameraControl
---@field Env                           	ClubGVGCameraControl                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CameraConfiner1               	UnityEngine.PolygonCollider2D           	@ 0    
---@field CameraConfiner2               	UnityEngine.PolygonCollider2D           	@ 1    
---@field CameraConfiner3               	UnityEngine.PolygonCollider2D           	@ 2    
---@field CameraWidthMatcher            	UnityEngine.Transform                   	@ 3    
---@field LuaParams                     	Engine.Modules.LuaParameters            	@ 4    
local ClubGVGCameraControl = Class('ClubGVGCameraControl')

function ClubGVGCameraControl:__init()
    self._isActive = false
    ---@type table<number, ClubGVGGroupBaseNode>
    self._buildingId2Env = {}

    -- self._startIdAndEndId2Line = {}
    self._playerId2Line = {}

    self._buildingId2Index = {}
    self._uiPos2BuildingId = {}
    self._uiPosList = {}

    --- 相机平滑过渡时间
    self._smoothTime = nil

    --- 是否禁用触摸
    self._isDisable = false

    self._mapScaleType = GVGConstants.MapScaleType.Secondary
end


function ClubGVGCameraControl:__delete()

end


-- function ClubGVGCameraControl:Awake()
-- end


function ClubGVGCameraControl:Start()
    self:RegisterEvents()
    
end


function ClubGVGCameraControl:OnDestroy()
    self:UnRegisterEvents()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()

end


--region init 

---@param mainCamera UnityEngine.Camera
---@param buildingTileMap UnityEngine.Tilemaps.Tilemap
---@param mgr ClubGVGMgr
---@param buildingInfoContainer UnityEngine.GameObject
---@param effectContainer UnityEngine.GameObject
---@param linesGo UnityEngine.GameObject
function ClubGVGCameraControl:Init(mainCamera, buildingTileMap, mgr, buildingInfoContainer, effectContainer, linesGo)
    -- print("ClubGVGCameraControl------>>>")
    self._mainCamera = mainCamera
    self._mainCameraTransform = mainCamera.transform
    self._buildingTileMap  = buildingTileMap
    self._buildingInfoContainer = buildingInfoContainer
    self._buildingInfoContainerTrans = buildingInfoContainer.transform
    self._linesGo = linesGo
    self._linesTrans = linesGo.transform
    self._effectContainer = effectContainer
    self._effectContainerTrans = effectContainer.transform


    self._mgr = mgr
    local buildId2TileData = mgr:GetBuildId2TileData()
    local position2BuildingId = mgr:GetPosition2BuildingId()
    local mapPosition = mgr:GetMapPosition()
    self._buildId2TileData = buildId2TileData
    self._position2BuildingId = position2BuildingId
    self._mapPosition = mapPosition
    -- ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.MarchTime)

    self._cameraConfiners = {}
    for key, value in pairs(GVGConstants.MapScaleType) do
        local CameraConfiner = self[string.format("CameraConfiner%s", GVGConstants.MapScaleType.Secondary - value + 1)]
        if isNotNull(CameraConfiner) then 
            local points = CameraConfiner.points
            local maxX, minX = -1000, 1000
            local maxY, minY = -1000, 1000
            for i = 0, points.Length -1, 1 do
                local point = points[i]
                local pX, pY = point.x, point.y
                maxX = math.max(pX, maxX)
                minX = math.min(pX, minX)
                maxY = math.max(pY, maxY)
                minY = math.min(pY, minY)
            end
            self._cameraConfiners[value] = {maxX, minX, maxY, minY}
        end
    end

    local CinemachineBrainType       = typeof(CS.Cinemachine.CinemachineBrain)
    local brain = mainCamera.gameObject:GetComponent(CinemachineBrainType)
    self._brain = brain

    ---@type CameraWidthMatcher
    local env = CfUtils.GetLuaScr(self.CameraWidthMatcher, GVGConstants.LuaPath.CameraWidthMatcher)
    if isNotNull(env) then
        env:Fresh(mainCamera)
    end
    self._cameraWidthMatcherEnv = env

    self._baseEffectPool = Pool.New(function () 
        local parent = self._effectContainer
        return parent:AddChild(self:GetEffectContainerChild()).transform
    end, 3)
    -- self._baseEffectPool:Free(self:GetEffectContainerChild().transform)

    ---@type Pool
    self._pool = Pool.New(function ()
        local container = self._buildingInfoContainer
        local node = container:AddChild(self:GetBuildingInfoContainerChild())
        return self:GetBuildingInfoEnv(node)
    end, 3)
    -- self._pool:Free(self:GetBuildingInfoEnv(self:GetBuildingInfoContainerChild()))

    ---@type Pool
    self._linePool = Pool.New(function ()
        local container = linesGo
        local node = container:AddChild(self:GetLineContainerChild())
        return self:GetLineEnv(node)
    end, 3)
    -- self._linePool:Free(self:GetLineEnv(self:GetLineContainerChild()))

    self._gender = CfUtils.IsWoman() and 2 or 1

    self._isActive = true
end

function ClubGVGCameraControl:RegisterEvents()
    self.OnSwipeActionEventFunc = Bind(self, self.OnSwipeActionEvent)
    EasyTouch.On_SwipeStart(   '+', self.OnSwipeActionEventFunc )
    EasyTouch.On_Swipe(      '+', self.OnSwipeActionEventFunc )
    EasyTouch.On_SwipeEnd(   '+', self.OnSwipeActionEventFunc )

    ---@type Engine.Lib.BehaviourAction
    local behaviorAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    self._behaviorAction = behaviorAction
    behaviorAction.UpdateAction = Bind(self, self.OnUpdateAction)

    self._enableUIDetection = EasyTouch.GetEnableUIDetection()
    EasyTouch.SetEnableAutoSelect(true)
    EasyTouch.SetEnableUIDetection(false)
    EasyTouch.instance.alwaysSendSwipe = true
    
end

function ClubGVGCameraControl:UnRegisterEvents()
    EasyTouch.On_SwipeStart( '-', self.OnSwipeActionEventFunc )
    EasyTouch.On_Swipe(      '-', self.OnSwipeActionEventFunc )
    EasyTouch.On_SwipeEnd(   '-', self.OnSwipeActionEventFunc )

    EasyTouch.SetEnableUIDetection(self._enableUIDetection)
    EasyTouch.instance.alwaysSendSwipe = false
    
    self.OnSwipeActionEventFunc = nil
    self._behaviorAction.UpdateAction = nil
end

--endregion 


--region logic 

function ClubGVGCameraControl:FocusBuilding(buildingId, isRebirth)
    local buildingTileMap  = self._buildingTileMap
    local Camera           = self._mainCameraTransform

    local worldPos = self._mgr:GetBuildingWorldPos(buildingId, buildingTileMap)
    FocusPosition:Set(worldPos.x, worldPos.y, Camera.position.z)
    FocusPositionNew:Set(FocusPosition.x, FocusPosition.y, FocusPosition.z)
    -- print("FocusPosition", FocusPosition)
    Camera.position = FocusPosition

    self:DrawAreaInfo()

    if isRebirth then
        local env = self._buildingId2Env[buildingId]
        env:FreshRebirthEffectShowStatus(true)
    end
    
end

function ClubGVGCameraControl:FreshAllBuildingEffectShowStatus(isShow)
    for index, env in pairs(self._buildingId2Env) do
        env:FreshEffectShowStatus(isShow)
    end
end


function ClubGVGCameraControl:SetIsActive( isActive_ )
    self._isActive = isActive_
end

function ClubGVGCameraControl:DisableTouchState( isDisable )
    self._isDisable = isDisable
end


--endregion 


--region get/set 

function ClubGVGCameraControl:GetTileCell(worldPos)
    local buildingTileMap  = self._buildingTileMap
    local cell = buildingTileMap:WorldToCell(worldPos)
    cell.z = 0
    return cell
end

---endregion 


--region handler 


function ClubGVGCameraControl:OnSwipeActionEvent(gesture)
    if not self._isActive then return end
    if self._isDisable then return end

    local gestureType = gesture.type
    if gestureType == On_SwipeStart then
        self:UpdateBuildingClickEventActiveState(false)

    elseif gestureType == On_Swipe then
        -- local normalized = gesture.deltaPosition.normalized * self:GetNormalizedScale()
        local cameraSize = self:GetCameraSize() * -1
        local normalized = gesture.deltaPosition / SCREEN_HEIGHT * (cameraSize * 2)
        FocusPositionNew:Set(FocusPositionNew.x + normalized.x, normalized.y + FocusPositionNew.y, FocusPositionNew.z)
        -- local deltaPosition = gesture.deltaPosition
        
        local maxX, minX, maxY, minY = self:GetCameraConfiner()
        FocusPositionNew.x = math.max(minX, math.min(FocusPositionNew.x, maxX))
        FocusPositionNew.y = math.max(minY, math.min(FocusPositionNew.y, maxY))
        
    elseif gestureType == On_SwipeEnd then
        self:UpdateBuildingClickEventActiveState(true)

    end
end

function ClubGVGCameraControl:OnUpdateAction()
    self:UpdateLinePosition()

    if isNotNull(self._cameraWidthMatcherEnv) then
        self._cameraWidthMatcherEnv:Update()
    end

    if not self._isActive then return end

    if VectorEquals(FocusPosition, FocusPositionNew) then return end
    
    local smoothTime = self:GetSmoothTime()
    FocusPosition = Vector3.Lerp(FocusPosition, FocusPositionNew, smoothTime)
    -- FocusPosition, Velocity = Vector3.SmoothDamp(FocusPosition, FocusPositionNew, Velocity, smoothTime)
    -- Velocity = Velocity * self:GetVelocityScale()

    local Camera           = self._mainCameraTransform
    Camera.position = FocusPosition
    
    self:DrawAreaInfo()
        
end


function ClubGVGCameraControl:DrawAreaInfo()
    local cell = self:GetTileCell(FocusPosition)
    local builds = self._mgr:AoiAroundX(cell)
    self._builds = builds
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()

    local uiPosList        = self._uiPosList
    local buildingId2Index = self._buildingId2Index
    local uiPos2BuildingId = self._uiPos2BuildingId

    local curMaxBuildingIndex = -1
    local curIsFindMaxCoreBuildingIdInArea = false

    if next(buildingId2Index) then
        for index, buildingId in ipairs(builds) do
            local buildingInfo = mgr:GetBuildInfo(buildingId)
            if buildingInfo.type ~= GVGConstants.MaxCoreBuildingId then
                --- 如果新的里不存在老的建筑 则需要移除
                local oldIndex = buildingId2Index[buildingId]
                if oldIndex ~= nil then
                    buildingId2Index[buildingId] = nil
                end
            else
                curMaxBuildingIndex = index
                curIsFindMaxCoreBuildingIdInArea = true
                
            end
        end
    
        if curIsFindMaxCoreBuildingIdInArea then
            buildingId2Index[DefineMaxCoreID] = nil
    
        end
    end

    --- 移除不在当前区域范围内的建筑物
    for buildingId, index in pairs(buildingId2Index) do
        local env = self._buildingId2Env[buildingId]
        if isNotNull(env) then
            self._pool:Free(env)
        end
        self._buildingId2Env[buildingId] = nil
        buildingId2Index[buildingId] = nil
    end

    ClearTable(uiPosList)
    ClearTable(uiPos2BuildingId)

    local DrawBuildInfoOrUpdatePos = function(buildingId)
        local uiPos = self._buildingId2Env[buildingId] == nil and self:DrawBuildInfo(buildingId) or self:GetBuildingUIPos(buildingId)
        uiPos2BuildingId[uiPos] = buildingId
        table.insert(uiPosList, uiPos)
        self._buildingId2Env[buildingId]:UpdatePosition(uiPos)
    end

    --- 渲染在当前区域范围内的建筑物
    if curIsFindMaxCoreBuildingIdInArea then
        local buildingId = DefineMaxCoreID
        DrawBuildInfoOrUpdatePos(buildingId)
        buildingId2Index[buildingId] = curMaxBuildingIndex

    end
    
    for index, buildingId in ipairs(builds) do
        local buildingInfo = mgr:GetBuildInfo(buildingId)
        if buildingInfo.type ~= GVGConstants.MaxCoreBuildingId then
            DrawBuildInfoOrUpdatePos(buildingId)
        end
        buildingId2Index[buildingId] = index
    end

    self._isFindMaxCoreBuildingIdInArea = curIsFindMaxCoreBuildingIdInArea

    --- 排序在当前区域范围内的建筑物
    self:SortBuildings()

    ---@type ClubGVGHomeDojo
    local dojo = mgr:GetHomeDojo()
    local marchInfo = dojo.marchInfo
    for playerId, env in pairs(self._playerId2Line) do
        local marchData = marchInfo[playerId]
        if marchData == nil or not self:CheckIsNeedShowLine(marchData) then
            self._linePool:Free(env)
            self._playerId2Line[playerId] = nil
        end
    end
    
    local curSeconds = GameUtils.GetServerTime()
    for playerId, marchData in pairs(marchInfo) do
        self:UpdateOrAddMarchLine(marchData, curSeconds)
    end

    
end

function ClubGVGCameraControl:DrawBuildInfo(buildingId)
    ---@type ClubGVGGroupBaseNode
    local env = self._pool:Obtain()
    local uiPos
    if isNotNull(env) then
        env:FreshUI(buildingId)
        env:FreshSelectStatus(self._selectBuildingId == buildingId)
        uiPos = self:GetBuildingUIPos(buildingId)
        env:UpdatePosition(uiPos)
    end

    self._buildingId2Env[buildingId] = env
    
    return uiPos

end

---GetBuildingUIPos
---获取建筑物的ui坐标
function ClubGVGCameraControl:GetBuildingUIPos(buildingId)
    local containerTrans = self._buildingInfoContainerTrans
    local worldPos = self._mgr:GetBuildingWorldPos(buildingId, self._buildingTileMap)
    local uiPos = CfUtils.WorldPosition2UIPosition(worldPos, containerTrans, self._mainCamera)
    return uiPos
end

function ClubGVGCameraControl:SortBuildings()
    local uiPosList        = self._uiPosList
    if next(uiPosList) == nil then return end
    table.sort(uiPosList, function(a, b) 
        return a.y > b.y
    end)
        
    local uiPos2BuildingId = self._uiPos2BuildingId
    for i, uiPos in ipairs(uiPosList) do
        local buildingId = uiPos2BuildingId[uiPos]
        local env = self._buildingId2Env[buildingId]
        if isNotNull(env) then
            env:UpdateSiblingIndex(i - 1)
        end
    end

end

function ClubGVGCameraControl:OnClickBuildingAction(buildingId)
    if not self._isActive then
        return
    end
    self:FreshBuildingSelectStatus(self._selectBuildingId, false)
    self:FreshBuildingSelectStatus(buildingId, true)
    self._selectBuildingId = buildingId

    Events.Broadcast(GVGConstants.EventNames.ShowBuildingDetails, buildingId)   
end

function ClubGVGCameraControl:FreshBuildingSelectStatus(buildingId, isSelect)
    if buildingId == nil then return end
    buildingId = self:GetRealBuildingId(checkNumber(buildingId)) 
    local env = self._buildingId2Env[buildingId]
    if isNotNull(env) then
        env:FreshSelectStatus(isSelect)
    end

end

function ClubGVGCameraControl:ReloadBuildings()
    for buildingId, env in pairs(self._buildingId2Env) do
        if isNotNull(env) then
            env:FreshUI(buildingId)
        end
    end
end

function ClubGVGCameraControl:FreshBuilding(buildingId)
    if buildingId == nil then return end
    buildingId = self:GetRealBuildingId(checkNumber(buildingId)) 
    local env = self._buildingId2Env[buildingId]
    if isNotNull(env) then
        env:FreshUI(buildingId)
    end

end


function ClubGVGCameraControl:RemoveAllProtectionPeriod()
    for key, env in pairs(self._buildingId2Env) do
        env:RemoveProtectionPeriod()
    end
end


function ClubGVGCameraControl:RemoveMarchLine(marchData)
    local marchPlayerId   = checkNumber(marchData.playerId)
    self:RemoveMarchLineById(marchPlayerId)
end

function ClubGVGCameraControl:RemoveMarchLineById(playerId)
    playerId = checkNumber(playerId)
    local env = self._playerId2Line[playerId]
    if isNotNull(env) then
        -- SetActive(env.controller, false)
        self._linePool:Free(env)
        self._playerId2Line[playerId] = nil
    end
end

function ClubGVGCameraControl:UpdateOrAddMarchLine(marchData, curSeconds)
    --- 发现最大核心建筑 则需要替换
    local startBuildingId = self:GetRealBuildingId(checkNumber(marchData.startBuilding)) 
    local endBuildingId   = self:GetRealBuildingId(checkNumber(marchData.endBuilding))   
    if not (self._buildingId2Index[startBuildingId] or self._buildingId2Index[endBuildingId]) then
        return
    end

    local marchPlayerId   = checkNumber(marchData.playerId)

    local mgr = self._mgr
    local playerInfo = mgr:GetPlayerInfoById(marchPlayerId)
    local isSelfClub = checkNumber(playerInfo.clubId) == mgr:GetClubId()
    local gender = mgr:GetPlayerId() == marchPlayerId and self._gender or nil

    local env = self._playerId2Line[marchPlayerId] == nil and self._linePool:Obtain() or self._playerId2Line[marchPlayerId]
    self:DrawMarchLine(env, startBuildingId, endBuildingId, isSelfClub, gender, checkNumber(marchData.endTime), curSeconds, checkNumber(marchData.totalMarchingTime))
    self._playerId2Line[marchPlayerId] = env
end

function ClubGVGCameraControl:CheckIsNeedShowLine(marchData)
    local startBuildingId = self:GetRealBuildingId(checkNumber(marchData.startBuilding)) 
    local endBuildingId   = self:GetRealBuildingId(checkNumber(marchData.endBuilding))   
    --- 发现最大核心建筑 则需要替换
    if not (self._buildingId2Index[startBuildingId] or self._buildingId2Index[endBuildingId]) then
        return false
    end
    return true
end

function ClubGVGCameraControl:GetRealBuildingId(buildingId)
    return self:IsMaxCoreBuilding(buildingId) and DefineMaxCoreID or buildingId
end

---是否是最大核心建筑
function ClubGVGCameraControl:IsMaxCoreBuilding(buildingId)
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local buildingInfo = mgr:GetBuildInfo(buildingId)
    return buildingInfo.type == GVGConstants.MaxCoreBuildingId
end

---绘制行军路线
function ClubGVGCameraControl:DrawMarchLine(env, startBuildingId, endBuildingId, isSelfClub, gender, endTime, curSeconds, totalMarchingTime)
    if isNotNull(env) then
        local startPos = self._mgr:GetBuildingWorldPos(startBuildingId, self._buildingTileMap)
        local endPos   = self._mgr:GetBuildingWorldPos(endBuildingId, self._buildingTileMap)
        env:Fresh(startPos, endPos, isSelfClub, gender, endTime, curSeconds, totalMarchingTime)

    end

    -- self._startIdAndEndId2Line[startBuildingId] = self._startIdAndEndId2Line[startBuildingId] or {}
    -- self._startIdAndEndId2Line[startBuildingId][endBuildingId] = env

end

---刷新选中的建筑状态
function ClubGVGCameraControl:FreshSelectBuildingStatus(buildingId)
    local selectBuildingId = self._selectBuildingId
    if selectBuildingId ~= checkNumber(buildingId) then
        return
    end

    self:FreshBuilding(selectBuildingId)
    Events.Broadcast(GVGConstants.EventNames.ShowBuildingDetails, selectBuildingId, true)   
end

---更新线位置（每帧）
function ClubGVGCameraControl:UpdateLinePosition()
    ---@param lineEnv ClubGVGLineNode
    for playerId, lineEnv in pairs(self._playerId2Line) do
        lineEnv:UpdatePosition()
    end
end

---更新线（每秒）
function ClubGVGCameraControl:UpdateBySeconds(curSeconds)
    ---@param lineEnv ClubGVGLineNode
    for playerId, lineEnv in pairs(self._playerId2Line) do
        if isNotNull(lineEnv) then
            lineEnv:UpdateBySeconds(curSeconds)
        end
    end
end

function ClubGVGCameraControl:UpdateBuildingClickEventActiveState(isActive)
    for key, env in pairs(self._buildingId2Env) do
        env:SetClickEventActiveState(isActive)
    end
end

---@return ClubGVGGroupBaseNode
function ClubGVGCameraControl:GetBuildingInfoEnv(node)
    ---@type ClubGVGGroupBaseNode
    local env = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGGroupBaseNode)
    env:SetCallback(Bind(self, self.OnClickBuildingAction))
    env:SetEffectContainerAndPool(self._effectContainerTrans, self._baseEffectPool)
    return env
end

function ClubGVGCameraControl:GetBuildingInfoContainerChild()
    if isNull(self._buildingInfoContainerChild) then
        local name = GVGConstants.Name.OverseaClubGvgGroupBaseNode
        self._buildingInfoContainerChild = self._buildingInfoContainerTrans:Find(name).gameObject
    end
    return self._buildingInfoContainerChild
end

---@return ClubGVGLineNode
function ClubGVGCameraControl:GetLineEnv(node)
    ---@type ClubGVGLineNode
    local env = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGLineNode)
    return env
end

function ClubGVGCameraControl:GetLineContainerChild()
    if isNull(self._lineContainerChild) then
        local name = GVGConstants.Name.Line
        self._lineContainerChild = self._linesTrans:Find(name).gameObject
    end
    return self._lineContainerChild
end

function ClubGVGCameraControl:GetEffectContainerChild()
    if isNull(self._effectContainerChild) then
        local name = GVGConstants.Name.UIFX_OverseaClubGvgGroup
        self._effectContainerChild = self._effectContainerTrans:Find(name).gameObject
    end
    return self._effectContainerChild
end

function ClubGVGCameraControl:GetSmoothTime()
    if self._smoothTime == nil or Debug == true then
        self._smoothTime = LuaParametersReader.Read( self.LuaParams, "smoothTime", LuaParametersType.Float ) 
    end
    return self._smoothTime
    -- return 0.3
end

function ClubGVGCameraControl:GetCameraSize()
    if isNotNull(self._cameraWidthMatcherEnv) then
        return self._cameraWidthMatcherEnv:GetDesiredHalfHeight() or self._cameraWidthMatcherEnv:GetVerticalFoV()
    end 

    return 2.8125
end


function ClubGVGCameraControl:ChangeOrthographicSize(num, buildingId)
    if isNull(self._cameraWidthMatcherEnv) then
        return
    end
    self._mapScaleType = num
    if num == GVGConstants.MapScaleType.Secondary then
        self._cameraWidthMatcherEnv:SetSceneWidthNew(10)
        local worldPos = self._mgr:GetBuildingWorldPos(buildingId, self._buildingTileMap)
        FocusPosition:Set(worldPos.x, worldPos.y, FocusPosition.z)
        FocusPositionNew:Set(worldPos.x, worldPos.y, FocusPosition.z)
        self._mainCameraTransform.position = FocusPosition
        
    elseif num == GVGConstants.MapScaleType.First then
        self._cameraWidthMatcherEnv:SetSceneWidthNew(25)
        local worldPos = self._mgr:GetBuildingWorldPos(DefineMaxCoreID, self._buildingTileMap)
        FocusPosition:Set(worldPos.x, worldPos.y, FocusPosition.z)
        FocusPositionNew:Set(worldPos.x, worldPos.y, FocusPosition.z)
        self._mainCameraTransform.position = FocusPosition
        SetActive(self._buildingInfoContainer, false)
        SetActive(self._linesGo, false)

    elseif num == GVGConstants.MapScaleType.Default then
        self._cameraWidthMatcherEnv:SetSceneWidthNew(40)
        local worldPos = self._mgr:GetBuildingWorldPos(DefineMaxCoreID, self._buildingTileMap)
        FocusPosition:Set(worldPos.x, worldPos.y, FocusPosition.z)
        FocusPositionNew:Set(worldPos.x, worldPos.y, FocusPosition.z)
        self._mainCameraTransform.position = FocusPosition
        SetActive(self._buildingInfoContainer, false)
        SetActive(self._linesGo, false)

    end
end

function ClubGVGCameraControl:CompleteChangeOrthographicSize(num, buildingId)
    if num == GVGConstants.MapScaleType.Secondary then
        SetActive(self._buildingInfoContainer, true)
        SetActive(self._linesGo, true)
        self:FocusBuilding(buildingId)
        
    end
end

function ClubGVGCameraControl:SetLineShowState(isShow)
    SetActive(self._linesGo, isShow)
end

function ClubGVGCameraControl:GetCameraConfiner()
    local points = self._cameraConfiners[self._mapScaleType]
    return SafeUnpack(points)
end

-- function ClubGVGCameraControl:GetNormalizedScale()
--     -- if self._normalizedScale == nil or Debug == true then
--     --     self._normalizedScale = LuaParametersReader.Read( self.LuaParams, "normalizedScale", LuaParametersType.Float ) 
--     -- end
--     -- return self._normalizedScale
--     return -0.2
-- end

-- function ClubGVGCameraControl:GetVelocityScale()
--     -- if self._velocityScale == nil or Debug == true then
--     --     self._velocityScale = LuaParametersReader.Read( self.LuaParams, "velocityScale", LuaParametersType.Float ) 
--     -- end
--     -- return self._velocityScale
--     return 0.3
-- end

---endregion 


return ClubGVGCameraControl
