---
--- 乱流幻境入口
--- Author: dawanfan
--- Date: 2024-1-9 17:32:02
---

local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require "XLua.cs_coroutine"
local Yielders = CS.Engine.Lib.Yielders
local ResourceModule = CS.Engine.Modules.ResourceModule
local LayerMask = CS.UnityEngine.LayerMask
local Physics = CS.UnityEngine.Physics
local Input = CS.UnityEngine.Input
local KTool = CS.Engine.Lib.KTool
local CinemachineBrain = CS.Cinemachine.CinemachineBrain
local sceneManagement = SceneManagement:GetInstance()
local CursorLockMode = CS.UnityEngine.CursorLockMode
local Vector3 = CS.UnityEngine.Vector3
local Cursor = CS.UnityEngine.Cursor

---@type DreamSpaceStates
local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')
local DreamSpaceCamera = import('Game.DreamSpace.Tools.DreamSpaceCamera')
local DreamSpaceLuaUtils = import('Game.DreamSpace.Tools.DreamSpaceLuaUtils')
local PlayerLoader = import('Game.DreamSpace.CharacterController.PlayerLoader')
local RoleControllerLoader = import('Game.DreamSpace.CharacterController.RoleControllerLoader')

local defaultLayer = LayerMask.NameToLayer( "Default" )
local roleLayer = LayerMask.NameToLayer( "role" )
local sceneId = Constants.IdSceneSetting55

---@class FairylandEnter
---@field _isPlayOp boolean
---@field _isLoadingComplete boolean
---@field _isCloseLoading boolean
---@field loadingPanel UILoadingPanel
---@field loaders Engine.Modules.AbstractResourceLoader[]
local FairylandEnter = Class("FairylandEnter")

function FairylandEnter:__init()
    self._isCloseLoading = false
end

function FairylandEnter:__delete()
    self.contriller = nil
end

function FairylandEnter:Awake() end

function FairylandEnter:OnInitialize()
    
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(function()
            self:DoInitialize()
        end)
    )

    return coWait
end

function FairylandEnter:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end

function FairylandEnter:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:ClearCache()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function FairylandEnter:DoInitialize()

    -------- 此时 白塔场景 尚未加载 ---------:

    self.isLayerIgnore_Role_Default = Physics.GetIgnoreLayerCollision( roleLayer, defaultLayer )
    if self.isLayerIgnore_Role_Default == true then 
        Physics.IgnoreLayerCollision( roleLayer, defaultLayer, false ) -- 让两层相互参与碰撞
    end 
    print( "两层是否碰撞: role-default = " .. tostring(not Physics.GetIgnoreLayerCollision( roleLayer, defaultLayer )) )

    Physics.autoSimulation = true
    Input.multiTouchEnabled = true  

    -- EasyTouch.instance.enableUIMode = false
    -- EasyTouch.SetUICompatibily( true)
end

function FairylandEnter:SetLoadingUI(loadingPanel)
    self.loadingPanel = loadingPanel
end

function FairylandEnter:AsyncLoadingResources()

    -- PC / Mobile 平台:
    DreamSpaceStates.CheckPlatform()
    
    --- load resource
    self:StartLoadAsync()

    --- load scene
    local displayProgress = 0
    local sceneEndProgress  = 90
    local totalEndProgress  = 100
    
    local sceneManagement = SceneManagement:GetInstance()
    sceneManagement:Transition({identifier=sceneId, isCache=true}, true)
    while sceneManagement:IsTransition() do
        displayProgress = self:UpdateProgress(displayProgress, sceneEndProgress)
        cs_coroutine.yield_return()
    end
    sceneManagement:SetActive(sceneId, true, false)

    ---
    for i=sceneEndProgress, totalEndProgress, 0.05 do
        print("koko 资源帧")
        if self:IsAllLoadingFinished() == true then 
            print("koko 资源 加载完成")
            break
        end
        
        self.loadingPanel:__Progress(i)
        coroutine.yield(Yielders.EndOfFrame)
    end 
    cs_coroutine.yield_return( self:WaitLoadingAndSetting() )
    self:ReleaseAllLoader()

    self._isLoadingComplete = true
    if not self._isPlayOp or self.loadingPanel:GetLoopTimes() > 0 then
        self:CloseLoading()
        self._isCloseLoading = true
    end
    cs_coroutine.yield_return()
end

---@param displayProgress number
---@param toProgress number
function FairylandEnter:UpdateProgress(displayProgress, toProgress)
    if displayProgress < toProgress then
        while displayProgress < toProgress do
            displayProgress = displayProgress + 5
            if not self._isPlayOp then
                self.loadingPanel:__Progress(displayProgress * 0.01)
            end
            cs_coroutine.yield_return(Yielders.EndOfFrame)
        end

    else
        cs_coroutine.yield_return(Yielders.EndOfFrame)
    end
    
    return displayProgress
end

function FairylandEnter:CloseLoading()
    if not self._isPlayOp then
        self.loadingPanel:__Progress(1)
    end
    self.loadingPanel:Close()
end

function FairylandEnter:StartLoadAsync()
    self.loaders = {}

    RoleControllerLoader.ResetAll() 
    RoleControllerLoader.RegistLoadPaths({
        "DreamSpace/Gameplay/SwitchablePlayeForLua.prefab",
        "Arts/Prefab_human/103008_human.prefab",
    })
end

function FairylandEnter:IsAllLoadingFinished()
    for name,loader in pairs(self.loaders) do 
        if loader.IsSuccess == false then 
            return false 
        end 
    end 

    if RoleControllerLoader.IsAllLoadingFinish() == false then 
        return false 
    end 
    return true
end

function FairylandEnter:ReleaseAllLoader()
    for _, loader in pairs(self.loaders) do
        loader:Release()
    end
end

function FairylandEnter:WaitLoadingAndSetting()
    while not self:IsAllLoadingFinished() do
        coroutine.yield(Yielders.EndOfFrame)
    end

    -- ====================================

    local InputManager = import('Game.DreamSpace.CharacterController.InputManager')
    InputManager.Init() -- 重置所有公共变量

    --- 找到 leftJoystick 
    local LeftJoystickCanvasMgr = import('Game.DreamSpace.UI.LeftJoystickCanvasMgr'):GetInstance()
    LeftJoystickCanvasMgr:CheckOrInitSync()
    self.leftJoystick = LeftJoystickCanvasMgr.leftJoystickEnv

    ---
    Cursor.lockState = CursorLockMode.None
end

function FairylandEnter:ClearCache()
    -- URPCameraController.Instance:SetMainCameraActive(true)
    Physics.autoSimulation = false
    Input.multiTouchEnabled = false
    -- EasyTouch.SetEnable2FingersGesture(false) -- 这么写不完善 ... 

    Physics.IgnoreLayerCollision( roleLayer, defaultLayer, self.isLayerIgnore_Role_Default ) -- 恢复旧设置
    print( "两层是否碰撞: role-default = " .. tostring(not Physics.GetIgnoreLayerCollision( roleLayer, defaultLayer )) )


    -- 删除 ui canvas:
    local RoleControllerRootCanvasMgr = import('Game.DreamSpace.UI.RoleControllerRootCanvasMgr'):GetInstance()
    RoleControllerRootCanvasMgr:CheckAndRemove()


    self:UnloadScene()
    self.settingVo = nil
end

function FairylandEnter:UnloadScene()
    local sceneInstance = sceneManagement:GetSceneInstance(sceneId)
    if sceneInstance then
        coroutine.yield(sceneManagement:UnloadScene(sceneInstance))
    end
end

return FairylandEnter
