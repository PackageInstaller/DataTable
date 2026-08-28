--------------------------------
--- 地图解密活动(春节活动)管理类
--- 提供发送网络请求之类的方法

------------ import ------------

local AntiqueModelController    = import("Game.Activity.MapDecryption.AntiqueRestoration.MapDecryptionAntiqueModelController")
local ExploreTrackingController = import("Game.Activity.MapDecryption.ExploreTracking.MapDecryptionExploreTrackingController")

local cs_coroutine  = require "XLua.cs_coroutine"
local Yielders      = CS.Engine.Lib.Yielders


local GameObject            = CS.UnityEngine.GameObject
local Object                = CS.UnityEngine.Object
local Image                 = CS.UnityEngine.UI.Image
local Vector3               = CS.UnityEngine.Vector3
local Quaternion            = CS.UnityEngine.Quaternion
local Mathf                 = CS.UnityEngine.Mathf
local UIModule              = CS.Engine.UI.UIModule

local KTool                 = CS.Engine.Lib.KTool
local URPCameraController   = CS.Game.Native.URP.URPCameraController

------------ import ------------

------------ define ------------
local checkTable   = checkTable
local checkNumber  = checkNumber
local Interfaces   = Interfaces
local yield_return = cs_coroutine.yield_return
------------ define ------------

---@class MapDecryptionMgr
local MapDecryptionMgr = Class('MapDecryptionMgr')


function MapDecryptionMgr:__init()
    ---@type MapDecryptionComponent
    self._component = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MapDecryptionComponent)

    self._controllerComps = {}
    self.sceneInstance = nil
    self._isLoadSceneComplete = false
    self._isRequestHomeComplete = false
end


function MapDecryptionMgr:__delete()
    --- 清理控制相关的组件
    for k, v in pairs(self._controllerComps) do
        v:Delete()
    end
    GameUtils.RemoveEntityCompByType(ECSComponentType.Constants.MapDecryptionComponent)
    self.sceneInstance = nil
    self._component = nil

    -- Object.Destroy( self._UIBlack_ManualTF.gameObject )
    self._UIBlack_ManualTF = nil
end

--- Initialize
---@param activityData ActivityDojo
function MapDecryptionMgr:Initialize(activityData)
    self:GetComponent():SetActivityData(activityData)
end


-- 读取后端 "ActivityMapDecryption/home" 数据
function MapDecryptionMgr:RequestHome()
    ---@type MapDecryptionComponent
    local component    = self:GetComponent()
    ---@type ActivityDojo
    local activityData = component:GetActivityData()
    self._isRequestHomeComplete = false
    return GameUtils.Request(Interfaces.ActivityMapDecryptionHome, {activityUuid = activityData.id}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        
        component:Initial(response.data)

        self._isRequestHomeComplete = true
    end)
end

--- RequestRepairAntiques
--- 请求修复古物
---@param antiqueId number 要修复的古物id
---@param consumes table 消耗道具
function MapDecryptionMgr:RequestRepairAntiques(antiqueId, consumes)
    local requestPath = Interfaces.ActivityMapDecryptionRepairAntiques
    self:__RequestAntique(requestPath, antiqueId, consumes)
end
function MapDecryptionMgr:RequestCompositeAntiques(antiqueId, consumes)
    local requestPath = Interfaces.ActivityMapDecryptionCompositeAntiques
    self:__RequestAntique(requestPath, antiqueId, consumes)
    
end
function MapDecryptionMgr:__RequestAntique(requestPath, antiqueId, consumes)
    local response = {}
    GameUtils.Request(requestPath, {activityUuid = self:GetActivityUUId(), antiquesId = antiqueId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        
        local MapDecryptionConstants = MapDecryptionConstants
        ---------------------------------------
        --- 更新全局数据
        
        --- 更新服务端缓存数据
        ---@type MapDecryptionComponent
        local component = self:GetComponent()
        ---@type MapDecryptionAntiqueRestorationEntity
        local entity, finalAntiqueEntity = component:UpdateAntiqueStatus(antiqueId, 2)

        local finalAntiqueId = component:GetFinalAntiqueId()

        --- 更新背包
        local rewards = checkTable(checkTable(response.data).rewards)
        for i, v in ipairs(consumes) do
            local num = checkNumber(v.num or v.goodsNum)
            table.insert(rewards, {num = -num, goodsId = v.goodsId})
        end
        --- 插入最终古物
        if finalAntiqueId == antiqueId then
            table.insert(rewards, {num = 1, goodsId = antiqueId})
        end
        GoodsUtils.DrawRewards(rewards)

        --- 更新全局模型
        ---@type MapDecryptionAntiqueModelController
        local controllerComp = self:GetControllerCompByType(MapDecryptionConstants.ControllerCompType.Antique)
        controllerComp:RestoreAntique(entity, finalAntiqueEntity)

        ---------------------------------------
        --- 更新本地数据
        Events.Broadcast(MapDecryptionConstants.EventNames.RequestSuccess, requestPath, entity)

    end)
end

--- RequestDrawTask
---@param taskId number 任务id
function MapDecryptionMgr:RequestDrawTask(taskId, mapId)
    local requestPath = Interfaces.ActivityMapDecryptionDrawTask
     GameUtils.Request(requestPath, {activityUuid = self:GetActivityUUId(), taskId = taskId, mapId = mapId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        
        ---------------------------------------
        --- 更新全局数据
        ---@type MapDecryptionComponent
        local component = self:GetComponent()
        component:UpdateExploreTaskStatus(mapId, taskId, MapDecryptionConstants.ReceiveStatus.Received)

        local data = response.data
        local rewards = data.rewards
        
        GoodsUtils.DrawRewards(rewards)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })

        ---------------------------------------
        --- 更新本地数据
        Events.Broadcast(MapDecryptionConstants.EventNames.RequestSuccess, requestPath, taskId)
        
    end)


end

--- RequestDrawFinallyTask
---@param mapId number 地图id
function MapDecryptionMgr:RequestDrawFinallyTask(mapId)
    local requestPath = Interfaces.ActivityMapDecryptionDrawFinallyTask
     GameUtils.Request(requestPath, {activityUuid = self:GetActivityUUId(), mapId = mapId}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        
        ---------------------------------------
        --- 更新全局数据
        ---@type MapDecryptionComponent
        local component = self:GetComponent()
        component:UpdateExploreMapStatus(mapId, MapDecryptionConstants.ReceiveStatus.Received)

        local data = response.data
        local rewards = data.rewards
        GoodsUtils.DrawRewards(rewards)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })
        ---------------------------------------
        --- 更新本地数据
        Events.Broadcast(MapDecryptionConstants.EventNames.RequestSuccess, requestPath)

    end)

end

--- RequestDrawTask
---@param poolId number 转盘id
---@param num number 转动次数
function MapDecryptionMgr:RequestRotaryTable(poolId, num)
    poolId = checkString(poolId)
    num = checkNumber(num)
    local requestPath = Interfaces.ActivityMapDecryptionLuckyDraw
    local requestData = {activityUuid = self:GetActivityUUId(), poolId = poolId, num = num}
    GameUtils.Request(requestPath, requestData, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            CS.Engine.UI.UIRaycastBlocker.Instance:RemoveCondition("RotateRotaryTable")
            return
        end
        
        --- 广播请求成功
        Events.Broadcast(MapDecryptionConstants.EventNames.RequestSuccess, requestPath, response.data, requestData)
    end)

end


function MapDecryptionMgr:GetIsRequestHomeComplete()
    return self._isRequestHomeComplete
end

function MapDecryptionMgr:GetIsLoadSceneComplete()
    return self._isLoadSceneComplete
end
function MapDecryptionMgr:SetIsLoadSceneComplete(isLoadComplete)
    self._isLoadSceneComplete = isLoadComplete
end

function MapDecryptionMgr:GetIsCloseLoading()
    return self._isCloseLoading
end
function MapDecryptionMgr:SetIsCloseLoading(isClose)
    self._isCloseLoading = isClose
end

-- 缓存一些公共 gameobjs, 方便后续使用:
function MapDecryptionMgr:CacheGameObjects(manualGO)
    ---@type UINavigatorBar
    local navigatorEnv = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
    local manualGO = navigatorEnv.backAnimationGo
    if isNull(manualGO) then
        return
    end

    --- UIBlack_Manual
    -- local UIRootGO = GameObject.Find("UIRoot") -- GameObject
    self._UIBlack_ManualTF = manualGO.transform -- Transform
    assert( not isNull(self._UIBlack_ManualTF) )
    
    local UIBlack_ManualChildTF = self._UIBlack_ManualTF:Find("Img") -- Transform
    self._UIBlack_ManualChildImage = KTool.GetComponent( UIBlack_ManualChildTF.gameObject, typeof(Image))
    assert( not isNull(self._UIBlack_ManualChildImage) )

    KTool.SetActive( self._UIBlack_ManualTF.gameObject, false ) -- 务必关闭
end


--- GetComponent
---@return MapDecryptionComponent
function MapDecryptionMgr:GetComponent()
    return self._component
end

function MapDecryptionMgr:CheckActivityIsEnd()
    return self._component:CheckActivityIsEnd()
end

--- GetActivityData
---@return ActivityDojo
function MapDecryptionMgr:GetActivityData()
    ---@type MapDecryptionComponent
    local component    = self:GetComponent()
    local activityData = component:GetActivityData()
    return activityData
end

function MapDecryptionMgr:GetActivityUUId()
    ---@type MapDecryptionComponent
    local component    = self:GetComponent()
    local activityData = component:GetActivityData()
    return activityData.id
end


function MapDecryptionMgr:GetTargetVirtualCamera(target)
    local SceneDefine = MapDecryptionConstants.SceneDefine
    local sceneVirtualCameraNode = self.sceneInstance:GetCacheObjectByName(SceneDefine.SceneVirtualCameraNode).transform
    local transform = sceneVirtualCameraNode:Find(target)
    return transform
end

function MapDecryptionMgr:GetTargetPlayer(target)
    local SceneDefine = MapDecryptionConstants.SceneDefine
    local Node = self.sceneInstance:GetCacheObjectByName(SceneDefine.ScenePlayerNode).transform
    local transform = Node:Find(target)
    return transform
end

function MapDecryptionMgr:InitControllerComps(sceneInstance)
    self.sceneInstance = sceneInstance
    local ControllerCompType        = MapDecryptionConstants.ControllerCompType
    ---@type MapDecryptionExploreTrackingController
    local exploreTrackingController = ExploreTrackingController.New()
    exploreTrackingController:Init(sceneInstance)
    self._controllerComps[ControllerCompType.ExploreTracking] = exploreTrackingController

    -- while not self:GetIsRequestHomeComplete() do
    --     yield_return()
    -- end

    ---@type MapDecryptionAntiqueModelController
    local antiqueModelController = AntiqueModelController.New()
    antiqueModelController:Init(sceneInstance, self:GetComponent())
    self._controllerComps[ControllerCompType.Antique] = antiqueModelController

end

function MapDecryptionMgr:InitAllAntique()
    ---@type MapDecryptionAntiqueModelController
    local antiqueModelController = self._controllerComps[MapDecryptionConstants.ControllerCompType.Antique]
    local component = self:GetComponent()
    local entityList = component:GetAntiqueEntityList()
    antiqueModelController:InitAllAntique(entityList)
end

function MapDecryptionMgr:GetTrackQuestId()
    ---@type MapDecryptionComponent
    local component    = self:GetComponent()
    return component:GetTrackQuestId()
end

function MapDecryptionMgr:GetControllerCompByType(compType)
    return self._controllerComps[compType]
end



-- 更为细微的 全屏黑色淡入淡出, 可手工控制 淡入, 全黑, 淡出 三个阶段
---@param easeInSpeed_ number    @ 变黑的速度
---@param easeOutSpeed_ number   @ 变淡的速度
---@param blackTime_ number      @ 黑色阶段的时长
---@param blackFunc_ fun():void   @ 进入黑色阶段后要调用的callback
---@return System.Collections.IEnumerator
function MapDecryptionMgr:BlackEaseInAndOut( easeInSpeed_, easeOutSpeed_, blackTime_, blackFunc_ )
    local navigatorEnv = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
    local blackGo = navigatorEnv.backAnimationGo
    if isNull(blackGo) then
        return
    end

    ---:
    local tmpColor = self._UIBlack_ManualChildImage.color 
    KTool.SetActive( self._UIBlack_ManualTF.gameObject, true )

    --- 慢慢的 线性变黑:
    local t = 0.0 
    while t < 1.0 do
        t = t + easeInSpeed_ * CS.UnityEngine.Time.deltaTime
        tmpColor.a = t
        self._UIBlack_ManualChildImage.color  = tmpColor
        cs_coroutine.yield_return()
    end

    cs_coroutine.yield_return()
    -- custom func:
    if not isNull(blackFunc_) then 
        blackFunc_()
    end
    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(blackTime_))

    --- 慢慢的 线性变透明:
    while t > 0.0 do
        t = t - easeOutSpeed_ * CS.UnityEngine.Time.deltaTime
        tmpColor.a = t
        self._UIBlack_ManualChildImage.color  = tmpColor
        cs_coroutine.yield_return()
    end

    KTool.SetActive( self._UIBlack_ManualTF.gameObject, false )
end


-- 当进入 TrackingCamera, ExploreCamera, StoreCamera 时, 需要更为复杂的 进入动画: (带协程)
---@param preVCameraTF_     UnityEngine.Transform                   -- 
---@param preVCameraComp_   Cinemachine.CinemachineVirtualCamera    -- 
---@param tgtVCameraTF_     UnityEngine.Transform                   -- 
---@param tgtVCameraComp_   Cinemachine.CinemachineVirtualCamera    -- 
---@param totalMoveTime_    number                       -- 
---@param func_             fun():void                     -- 
function MapDecryptionMgr.EnterVCameraWithPreAnim( preVCameraTF_, preVCameraComp_, tgtVCameraTF_, tgtVCameraComp_, totalMoveTime_,  func_ )

    -- 当从 战斗编队 界面退回到 TrackingCamera 时, 也会调用本函数, 此时目标虚拟相机已经开启, 直接终止后续操作:
    if KTool.IsActiveInHierarchy(tgtVCameraTF_.gameObject) then
        return
    end

    --- 找到 当前 camera 数据源:
    local mainCamera = URPCameraController.Instance.mainCamera
    local mainCameraTF = mainCamera.gameObject.transform
    assert( not isNull(mainCameraTF) )

    --- 缓存数据:
    local srcPos = mainCameraTF.position
    local midPos = preVCameraTF_.position
    local dstPos = tgtVCameraTF_.position

    local srcRotation = mainCameraTF.rotation
    local midRotation = preVCameraTF_.rotation
    local dstRotation = tgtVCameraTF_.rotation

    local srcFOV = mainCamera.fieldOfView
    local midFOV = preVCameraComp_.m_Lens.FieldOfView
    local dstFOV = tgtVCameraComp_.m_Lens.FieldOfView

    --- 让 tgtVCamera 进入 mid 状态:
    tgtVCameraTF_.position = midPos
    tgtVCameraTF_.rotation = midRotation
    MapDecryptionMgr.SetVCameraFOV( tgtVCameraComp_, midFOV )

    --- 切换虚拟相机到 tgtVCamera:
    -- 按照策划需求, 此阶段为 cut 切镜头, 需要配置 SpringFestivalVCameraBlenderSettings.asset 文件来实现
    KTool.SetActive(preVCameraTF_.gameObject,   false)
    if not isNull(func_) then 
        func_()
    end

    UICommonUtils.WaitBrainBlendingComplete()

    ------ 第二阶段: 
    local t = 0.01 -- [0f, 1f]
    while t < 1.0 do
        -- 得到一个 smooth 的两头平滑的 t值: (线性t值的运动效果比较生硬)
        local smoothT = Mathf.SmoothStep( 0.0, 1.0, t )

        -- 让前段变快, 尾段变缓:
        local it = 1.0 - smoothT
        local tm = 1.0 - it*it

        -- position, rotation:
        tgtVCameraTF_.position = Vector3.Lerp( midPos, dstPos, tm )
        tgtVCameraTF_.rotation = Quaternion.Lerp( midRotation, dstRotation, tm )

        -- fov: 
        local tt = MapDecryptionMgr.Remap( 0.0, 1.0, 0.0, 1.1, t ) -- 为了让 fov 提前几帧到达预定值
        tt = Mathf.Min( tt, 1.0 )
        
        local fov = Mathf.Lerp( midFOV, dstFOV, tt )
        MapDecryptionMgr.SetVCameraFOV( tgtVCameraComp_, fov )

        ---:
        local step = CS.UnityEngine.Time.deltaTime / totalMoveTime_ -- 上一帧的 百分比;
        t = t + step
        cs_coroutine.yield_return()
    end
end


function MapDecryptionMgr.SetVCameraFOV( vcameraComp_, fov_ )
    local lens = vcameraComp_.m_Lens
    lens.FieldOfView = fov_
    vcameraComp_.m_Lens = lens
end


-- x 在区间[t1,t2] 中, 求区间[s1,s2] 中同比例的点的值;
function MapDecryptionMgr.Remap( t1, t2, s1, s2, x ) 
    return ((x - t1) / (t2 - t1) * (s2 - s1) + s1)
end



return MapDecryptionMgr
