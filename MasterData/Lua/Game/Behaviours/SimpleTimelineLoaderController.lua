
--region global define
local import    = import
local CS        = CS
local isNotNull = isNotNull
local CoStart   = CoStart
local CoYield   = CoYield
local CoStop    = CoStop
--endregion

--region import

---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
local UINavigationBarRoot      = CS.UINavigationBarRoot
local ResourceModule           = CS.Engine.Modules.ResourceModule
local URPCameraController      = CS.Game.Native.URP.URPCameraController
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type GachaponUtils
local GachaponUtils            = import('Game.Gachapon.GachaponUtils')

--endregion

--region define

local function GetParent(parentPath, rootTrans)
    local parentTrans
    if not string.isEmpty(parentPath) then
        parentTrans = rootTrans:Find(parentPath)
    end
    if isNull(parentTrans) then
        parentTrans = rootTrans
    end
    return parentTrans
end


--endregion

---@class SimpleTimelineLoaderController
local SimpleTimelineLoaderController = Class('SimpleTimelineLoaderController')

--region init 

---Start
---@param timelinePath string
---@param parent UnityEngine.GameObject
---@param params table
function SimpleTimelineLoaderController:Start(timelinePath, timelineParent, params)

    --- { [trackName] = {trackObject:和prefabPath二选一， prefabPath 和trackObject二选一, parentPath:默认timeline根节点 }
    local trackName2TrackInfo        = params.trackName2TrackInfo
    local extraLoaderConfig          = params.extraLoaderConfig
    local customOnNotify             = params.customOnNotify
    local timelineLoaderCompleteCb   = params.timelineLoaderCompleteCb
    local timeLinePlayStartCb        = params.timeLinePlayStartCb
    local timeLinePlayCompleteCb     = params.timeLinePlayCompleteCb
    ---是否显示主相机
    local isShowMainCamera           = params.isShowMainCamera == true
    local isShowUICamera             = params.isShowUICamera == true
    local isOpenMainCamera           = params.isOpenMainCamera == true
    UINavigationBarRoot.Instance:SetActive(false)

    local showTlCo = CardProgressionUtils.BlockerAndStartCo(timelinePath, function ()
        
        --- 1. 创建timeline loader
        local tlLoader     = ResourceModule.LoadBundleAsync(timelinePath, nil, true)

        --- 2. 创建 track loader
        local trackName2Object       = {}
        local trackObject2ParentPath = {}
        local prefabPath2Loader      = {}
        local prefabPath2TrackNames  = {}
        local prefabPath2ParentPath  = {}
        if trackName2TrackInfo then
            for trackName, value in pairs(trackName2TrackInfo) do
                local trackObject = value.trackObject
                local prefabPath  = value.prefabPath
                if isNotNull(trackObject) then
                    trackName2Object[trackName]         = trackObject
                    if not value.isDisableSetParent then
                        trackObject2ParentPath[trackObject] = value.parentPath or ""
                    end
                elseif prefabPath then
                    prefabPath2TrackNames[prefabPath] = prefabPath2TrackNames[prefabPath] or {}
                    if next(prefabPath2TrackNames[prefabPath]) == nil then
                        local loader = ResourceModule.LoadBundleAsync(prefabPath, nil, true)
                        prefabPath2Loader[prefabPath] = loader
                        prefabPath2ParentPath[prefabPath] = value.parentPath or ""
                    end
                    table.insert(prefabPath2TrackNames[prefabPath], trackName)

                end
            end
        end

        local extraLoaders = {}
        local extraGos = {}
        --- 2.1 创建 extra loader
        if extraLoaderConfig then
            for index, config in ipairs(extraLoaderConfig) do
                local prefabPath = config.prefabPath
                local prefabIns = config.prefabIns
                if not string.isEmpty(prefabPath) then
                    local loader = ResourceModule.LoadBundleAsync(prefabPath, nil, true)
                    extraLoaders[index] = loader
                elseif isNotNull(prefabIns) then
                    extraGos[index] = prefabIns
                    
                end
            end
        end

        --- 3. 初始化timeline 并隐藏
        local tlGo = CardProgressionUtils.CustomInstantiate(tlLoader, timelineParent.gameObject)
        ---@type UnityEngine.Transform
        local tlTrans = tlGo.transform
        ---@type UnityEngine.Playables.PlayableDirector
        local playableDirector     = tlGo:GetComponentInChildren(CardProgressionConstants.CompType.PlayableDirectorType)
        playableDirector.playOnAwake = false
        KTool.SetActive(tlGo.gameObject, false)

        local function InitGameObject(go)
            KTool.SetLayer(tlGo, go, true)
            local transform = go.transform
            transform.localPosition = Vector3.zero
            transform.localRotation = Quaternion.identity
            -- KTool.ResetLocalTransform(transform)
        end

        --- 3.1 处理外部传入的 trackObject
        for trackObject, parentPath in pairs(trackObject2ParentPath) do
            local parentTrans = GetParent(parentPath, tlTrans)

            trackObject.transform:SetParent(parentTrans)
            InitGameObject(trackObject)
            
        end

        --- 4. 实例化trackObject
        for prefabPath, loader in pairs(prefabPath2Loader) do
            local parentPath = prefabPath2ParentPath[prefabPath]
            local parentTrans = GetParent(parentPath, tlTrans)

            local trackObject = CardProgressionUtils.CustomInstantiate(loader, parentTrans)
            InitGameObject(trackObject)

            local trackNames = prefabPath2TrackNames[prefabPath]
            for index, trackName in ipairs(trackNames) do
                trackName2Object[trackName] = trackObject
            end

        end

        --- 4.1 实例化 extra Object
        local extraObjects = {}
        for index, loader in pairs(extraLoaders) do
            local config = extraLoaderConfig[index]
            local parentPath = config.parentPath
            local parentTrans = GetParent(parentPath, tlTrans)
            local go = CardProgressionUtils.CustomInstantiate(loader, parentTrans)
            InitGameObject(go)
            table.insert(extraObjects, go)
        end

        for index, go in pairs(extraGos) do
            local config = extraLoaderConfig[index]
            local parentPath = config.parentPath
            local parentTrans = GetParent(parentPath, tlTrans, tlGo)
            go.transform:SetParent(parentTrans)
            InitGameObject(go)
            -- table.insert(extraObjects, go)
        end

                
        if timelineLoaderCompleteCb then
            timelineLoaderCompleteCb(tlGo, playableDirector)
        end

        
        --- 5. 绑定自定义通知
        local notify
        if isNotNull(customOnNotify) then
            notify = function(origin, notification, context)
                customOnNotify(origin, notification, context, extraObjects)
            end
            GachaponUtils.AppendTimelineCustomNotify(tlGo, notify)
        end

        local modelTrackSources = GachaponUtils.BindTimelines(playableDirector, trackName2Object)
        ---6. 关闭相机显示 
        -- URPCameraController.Instance:SetActive(false)
        -- if not isShowMainCamera and isShowUICamera then
        --     print("SetMainCameraActive---->>>>")
        --     URPCameraController.Instance:SetMainCameraActive(false)
        -- else
        --     URPCameraController.Instance:SetActive(false)
        -- end

        ---7. 显示并播放timeline
        KTool.SetActive(tlGo.gameObject, true)

        if not isShowMainCamera and isShowUICamera then
            -- URPCameraController.Instance:SetMainCameraActive(false)
            CfUtils.SetActive(URPCameraController.Instance.mainCamera, false)
            local cameraComp = tlGo:GetComponentInChildren(typeof(CS.UnityEngine.Camera))
            URPCameraController.Instance:InitCameraStack(cameraComp)
        elseif not isOpenMainCamera then
            URPCameraController.Instance:SetActive(false)
        end
        playableDirector:Play()

        if timeLinePlayStartCb then
            timeLinePlayStartCb(tlGo)
        end

        local duration = playableDirector.duration

        if self._waitCoCb then
            self._waitCoCb()
        end
        self._co = CoStart(function() 
            CoYield(duration)
            self._co = nil
        end)
        
        while self._co ~= nil do
            CoYield()
        end
        
        ---8. 清理timeline 绑定
        GachaponUtils.ClearTimelineBinding(playableDirector, modelTrackSources)

        ---9. 移除timeline 自定义通知
        if notify then
            GachaponUtils.RemoveTimelineCustomNotify(tlGo, notify)
        end

        ---10. 调用timeline 播放完成  
        if timeLinePlayCompleteCb then
            timeLinePlayCompleteCb(playableDirector)
        end

        ---11. 隐藏timeline 并 删除
        KTool.SetActive(tlGo.gameObject, false)
        KTool.SafeDelete(tlGo)

        ---12. 开启相机显示 不是太想记录播放前的相机状态 外面控制开关吧
        -- URPCameraController.Instance:SetActive(true)
        
        UINavigationBarRoot.Instance:SetActive(true)

    end)
    
    return showTlCo

end

function SimpleTimelineLoaderController:Close()
    if isNotNull(self._co) then
        CoStop(self._co)
        self._co = nil
    end
    
end


--endregion 


--region logic 


--endregion 


--region get/set 

function SimpleTimelineLoaderController:SetWaitCoIsStartCb(cb)
    self._waitCoCb = cb
end

---endregion 


--region handler 


---endregion 


return SimpleTimelineLoaderController

