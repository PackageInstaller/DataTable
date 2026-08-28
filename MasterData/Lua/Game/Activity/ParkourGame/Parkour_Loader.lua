---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()

local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local ResourceModule = CS.Engine.Modules.ResourceModule

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")

--- funtoy:
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local Vector3 = CS.UnityEngine.Vector3
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Quaternion = CS.UnityEngine.Quaternion
local Canvas = CS.UnityEngine.Canvas
local Animator = CS.UnityEngine.Animator
local GameObject = CS.UnityEngine.GameObject
local Object = CS.UnityEngine.Object
local CapsuleCollider = CS.UnityEngine.CapsuleCollider
local SphereCollider = CS.UnityEngine.SphereCollider
local Rigidbody = CS.UnityEngine.Rigidbody


local GameUtils = import('Game.Utils.GameUtils')


---@class Parkour_Loader
local Parkour_Loader = Class("Parkour_Loader")
-- 外部访问时使用:
--local Parkour_Loader = import('Game.Activity.ParkourGame.Parkour_Loader')

-- =================================================================

local BlackInDuration = 0.2 -- 0.1
local BlackOutDuration = 0.5


-- ============================ singleton ====================================

local currentInstance = nil
local global_co1 = nil
local global_co2 = nil




function Parkour_Loader.CreateInstance()
    if currentInstance ~= nil  then 
        printError( "koko - 异常: 不允许出现多个 Parkour_Loader, 暂时将其手动清空" )
        Parkour_Loader.DeleteInstance()
    end 
    --- 
    currentInstance = Parkour_Loader.New()
    return currentInstance
    ---
    -- if currentInstance == nil then 
    --     currentInstance = Parkour_Loader.New()
    --     return currentInstance
    -- else 
    --     printError( "koko - 异常: 不允许出现多个 Parkour_Loader" )
    --     return nil
    -- end 
end


function Parkour_Loader.DeleteInstance()
    --printError("IdolLive3D_Loader.DeleteInstance")
    if currentInstance ~= nil then 
        ---
        currentInstance:Delete() -- 会调用 __delete()
        currentInstance = nil
    else 
        print( "异常: Parkour_Loader currentInstance 居然为 nil" )
    end 
end

function Parkour_Loader.GetInstance()
    return currentInstance
end


-- ================================================================
function Parkour_Loader:__init(  )
    self.isTgtLoadDone = false 
    self.fxGos = {}
    self.co_fxs = {}
end


function Parkour_Loader:__delete()
    --printError("Parkour_Loader:__delete")

    for _,co in pairs(self.co_fxs) do 
        CoStop(co)
    end 

    CoStop(global_co1)
    CoStop(global_co2)
    --
    self:ReleaseAllLoader()
end


-- ================================================================
function Parkour_Loader:IsAllLoadingFinished()
    for name,loader in pairs(self.loaders) do 
        if loader.IsSuccess == false then 
            return false 
        end 
    end 
    return true
end


function Parkour_Loader:ReleaseAllLoader()
    for _,loader in pairs(self.loaders) do
        loader:Release()
    end
    self.loaders = {}
end


-- ================================================================

--外部是协程:
--- 主入口
---@param activityUuid_ number
function Parkour_Loader.TryEnter( activityUuid_ )
    --printError("TryEnter")

    xTry(function()

        Mgr:Clear( true )
        local pLoader = Parkour_Loader.CreateInstance()
        pLoader:_StartLoad()


        pLoader.SelectUIInitDone = Events.AddListener(ParkourGameUtil.Events.SelectUIInitDone, function()
            CoStop(global_co2)
            global_co2 = CoStart(function()
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.5 )) -- 强等, 确保 ui 切换一定完成
                GameUtils.HideBlack( BlackOutDuration ) ------------------------- 黑幕淡出 ---------------------------------
                -- 释放事件:
                if pLoader.SelectUIInitDone then
                    Events.RemoveListener(ParkourGameUtil.Events.SelectUIInitDone, pLoader.SelectUIInitDone)
                end
            end)
        end)

        ---
        local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
        ParkourGameUtil.SetVCamBlendMode( CinemachineBlendDefinition.Style.Cut, 0.0 ) 

        GameUtils.ShowBlack( BlackInDuration )  ------------------------ 黑幕淡入 ----------------------------------
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds( BlackInDuration ))
        
        cs_coroutine.yield_return(pLoader:_WaitLoad())

        ---
        Mgr.activityUuid = activityUuid_
        Mgr.isBackFromMainDialogForResume               = false
        Mgr.isBackFromMainDialogForResumeForInfinity    = false
        CfUtils.DialogOpen(
            Constants.UITypeIds.OverseaParkourMainlineDialog, 
            nil,
            {UIArgs(Constants.UITypeIds.ParkourGameOptionDialog)}
        )

        -- !!! 等待 选关UI页面 init完毕, 然后触发 SelectUIInitDone 事件;

    end, 
    function()

        GameUtils.HideBlack( 0 ) ------------------------- 黑幕淡出 ---------------------------------
        --UIRaycastBlocker:RemoveCondition("OpenDialogAction")
        --KCookie.Set(Constants.IsOpnePageing, 0)
        printError("%s", debug.traceback())
    end)


    --end)
end



--外部是协程:
--- 主入口
---@param activityUuid_ number
function Parkour_Loader.TryEnterGamePrepareDialog( activityUuid_ )
    --printError("TryEnter")

    xTry(function()

        Mgr:Clear( false )
        local pLoader = Parkour_Loader.CreateInstance()
        pLoader:_StartLoad()


        pLoader.SelectUIInitDone = Events.AddListener(ParkourGameUtil.Events.SelectUIInitDone, function()
            CoStop(global_co2)
            global_co2 = CoStart(function()
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.5 )) -- 强等, 确保 ui 切换一定完成
                GameUtils.HideBlack( BlackOutDuration ) ------------------------- 黑幕淡出 ---------------------------------
                -- 释放事件:
                if pLoader.SelectUIInitDone then
                    Events.RemoveListener(ParkourGameUtil.Events.SelectUIInitDone, pLoader.SelectUIInitDone)
                end
            end)
        end)

        ---
        local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
        ParkourGameUtil.SetVCamBlendMode( CinemachineBlendDefinition.Style.Cut, 0.0 ) 

        GameUtils.ShowBlack( BlackInDuration )  ------------------------ 黑幕淡入 ----------------------------------
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds( BlackInDuration ))
        
        cs_coroutine.yield_return(pLoader:_WaitLoad())

        ---
        Mgr.activityUuid = activityUuid_
        Mgr.isBackFromMainDialogForResume               = false
        Mgr.isBackFromMainDialogForResumeForInfinity    = false
        CfUtils.DialogOpen(
            Constants.UITypeIds.OverseaParkourGamePrepareDialog, 
            nil,
            {UIArgs(Constants.UITypeIds.ParkourGameOptionDialog)}
        )

        -- !!! 等待 选关UI页面 init完毕, 然后触发 SelectUIInitDone 事件;

    end, 
    function()

        GameUtils.HideBlack( 0 ) ------------------------- 黑幕淡出 ---------------------------------
        --UIRaycastBlocker:RemoveCondition("OpenDialogAction")
        --KCookie.Set(Constants.IsOpnePageing, 0)
        printError("%s", debug.traceback())
    end)
end




function Parkour_Loader:_StartLoad()
    self.loaders = {}
    self.loaders.gameSelect     = ResourceModule.LoadBundleAsync("Prefabs/Activity/ParkourGame/ParkourGameSelect.prefab", nil, true)
    self.loaders.gameTest       = ResourceModule.LoadBundleAsync("Prefabs/Activity/ParkourGame/ParkourGameTest.prefab", nil, true)
    self.loaders.roleAnimatorController = ResourceModule.LoadBundleAsync("RuntimeController/Animator_miniworld/15202_cat.overrideController", nil, true)
    self.loaders.role                   = ResourceModule.LoadBundleAsync("Arts/Prefab_cat/15202.prefab", nil, true)
    ---
    self.loaders.suspendDialog          = ResourceModule.LoadBundleAsync("Prefabs/OverseaParkour12001801/OverseaParkourSuspendDialog12001801.prefab", nil, true)
    self.loaders.normalFinishDialog     = ResourceModule.LoadBundleAsync("Prefabs/OverseaParkour12001801/OverseaParkourEvaluateStoryStarLevelPopup12001801.prefab", nil, true)
    self.loaders.infiniteFinishDialog   = ResourceModule.LoadBundleAsync("Prefabs/OverseaParkour12001801/OverseaParkourEvaluateEndlessPopup12001801.prefab", nil, true)

    --- 
    self.loaders.fx_role_death         = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_death.prefab", nil, true)          -- 死亡
    self.loaders.fx_role_jump2    = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_erduantiao.prefab", nil, true)     -- 二段跳
    self.loaders.fx_role_huachan       = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_huachan.prefab", nil, true)        -- 滑铲
    self.loaders.fx_role_shield         = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_hudun.prefab", nil, true)          -- 护盾
    self.loaders.fx_role_injured_jingji    = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_jingji_hit.prefab", nil, true)     -- 荆棘受伤
    self.loaders.fx_role_wudichongci   = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_wudichongci.prefab", nil, true)    -- 无敌冲刺
    self.loaders.fx_role_magnet      = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_xitieshi.prefab", nil, true)       -- 吸铁石

    self.loaders.fx_bullet_rock_brock       = ResourceModule.LoadBundleAsync("Effect/prefab/fx_88001_skill01_hit.prefab", nil, true)       -- boss的石头攻击, 触地碎裂
    self.loaders.fx_role_injured_feather    = ResourceModule.LoadBundleAsync("Effect/prefab/fx_88001_skill02_hit.prefab", nil, true)       -- role 受伤: boss的羽毛攻击

    self.loaders.fx_boss_injured_1    = ResourceModule.LoadBundleAsync("Effect/prefab/fx_88001_hit.prefab", nil, true)       -- boss 受伤: 眼睛 
    self.loaders.fx_boss_injured_2    = ResourceModule.LoadBundleAsync("Effect/prefab/fx_88001_hit02.prefab", nil, true)       -- boss 受伤: 镜子发光

    self.loaders.fx_moster_death_2    = ResourceModule.LoadBundleAsync("Effect/prefab/fx_TinyWorld_death_2.prefab", nil, true)       -- 小怪死亡

    --- 
    self.loaders.fx_Gain_get_green      = ResourceModule.LoadBundleAsync("Effect/prefab/fx_Gain_get_green.prefab", nil, true)          -- role 吃道具
    self.loaders.fx_Gain_get_blue       = ResourceModule.LoadBundleAsync("Effect/prefab/fx_Gain_get_blue.prefab", nil, true)          -- role 吃道具
    self.loaders.fx_Gain_get_yellow     = ResourceModule.LoadBundleAsync("Effect/prefab/fx_Gain_get_yellow.prefab", nil, true)          -- role 吃道具


end


-- 协程:
function Parkour_Loader:_WaitLoad()
    while true do 
        if self:IsAllLoadingFinished() == true then 
            self.isTgtLoadDone = true
            break
        end 
        --print("koko - 等待 加载")
        coroutine.yield(Yielders.EndOfFrame)
    end 
    -- for i=1,ParkourGameUtil.loadWaitFrames do 
    --     if self:IsAllLoadingFinished() == true then 
    --         self.isTgtLoadDone = true
    --         break
    --     end 
    --     print("koko - 等待 加载")
    --     coroutine.yield(Yielders.EndOfFrame)
    -- end 
    -- if self.isTgtLoadDone ~= true then 
    --     printError("koko - 始终没等到 资源加载完成")
    --     return
    -- end 
end




---@return UnityEngine.GameObject, Engine.Modules.AbstractResourceLoader
function Parkour_Loader:TryInstanceGO( assetName_ )
    local loader = self.loaders[tostring(assetName_)]
    local go = nil
    if isNotNull(loader) and loader.IsSuccess==true then 
        go = loader:Instantiate()
    else 
        printError("跑酷, 异步加载失败: " .. tostring(assetName_))
    end 
    return go, loader
end



-- 适用于 animator controller, 材质球等:
---@return UnityEngine.Object, Engine.Modules.AbstractResourceLoader
function Parkour_Loader:TryGetResultObject( assetName_ )
    local loader = self.loaders[tostring(assetName_)]
    if isNotNull(loader) and loader.IsSuccess==true then 
        return loader.ResultObject, loader
    else 
        printError("跑酷, 异步加载失败: " .. tostring(assetName_))
        return nil, nil
    end 
end



---@param parentTF_ UnityEngine.Transform
function Parkour_Loader:InstanceRole( parentTF_ )
    --- animator controller:
    local roleAnimatorController, animatorControllerLoader = self:TryGetResultObject("roleAnimatorController")
    if isNull(roleAnimatorController) then 
        return nil, nil
    end
    --- role go:
    local roleTF = nil
    local roleGO, roleLoader = self:TryInstanceGO("role")
    if isNotNull(roleGO) then 

        roleTF = roleGO.transform
        --roleTF:SetPositionAndRotation( Vector3.zero, Quaternion.identity)


        if isNotNull(parentTF_) then 
            roleTF:SetParent( parentTF_ )
            roleTF:Rotate( 0, 90, 0 ) 
        end 
        roleTF.localPosition = Vector3( -3.7, -1.2, 0 )

        -- local PlayerRootTF = gameTestTF:Find("Track3/PlayerRoot")
        -- roleTF:SetParent( PlayerRootTF )
        -- roleTF:Rotate( 0, 90, 0 ) 

        local innTF = roleTF:Find("Unity_Export_Grp")
        innTF.localScale = Vector3.one * 3 -- !! 猫放大倍数

        --- 
        ParkourGameUtil.SetRoleCollider( roleTF.gameObject, ParkourGameUtil.roleNormalColliderHeight )
        ParkourGameUtil.AddRoleHitCollider( roleTF.gameObject, ParkourGameUtil.roleHitColliderRadius )

        --- 
        ---@type UnityEngine.Rigidbody
        local rigidBody = CfUtils.GetOrAddComponent(roleTF.gameObject, typeof(Rigidbody))
        rigidBody.mass = 4
        rigidBody.drag = 0.05 
        rigidBody.constraints = CS.UnityEngine.RigidbodyConstraints.FreezeRotation

        ---
        local roleAnimator = KTool.GetComponent(roleTF.gameObject, typeof(Animator))
        roleAnimator.runtimeAnimatorController = roleAnimatorController
        animatorControllerLoader:Retain(roleGO) -- !! MUST 防止 roleAnimatorController 被释放

        ---@type ParkourPlayerController
        local luaBehaviour = AddLuaBehaviour(roleGO, "Game.Activity.ParkourGame.MainGame.ParkourPlayerController")
        --Mgr.player = luaBehaviour.Env
        
        return roleTF, luaBehaviour.Env
    end 
    return nil, nil
end



--- 开启/关闭 一个 fx;
---@param fxName_ string 
---@param parent_ UnityEngine.Transform
---@param isShow_ boolean 
---@param isInsideCoroutine_ boolean @ 本次函数调用是否在一个 协程内; (这样就不用自己再开协程了)
function Parkour_Loader:SetFX( fxName_, parent_, isShow_, isInsideCoroutine_ )
    fxName_ = tostring(fxName_)
    if isNull(self.fxGos[fxName_]) then
        --printError("instance fx go: " .. tostring(fxName_))
        self.fxGos[fxName_] = Parkour_Loader.GetInstance():TryInstanceGO(fxName_)
        local fxTF = self.fxGos[fxName_].transform
        ---
        fxTF:SetParent( parent_ )
        fxTF.localPosition = Vector3.zero
        fxTF.localRotation = Quaternion.identity
        fxTF.localScale = Vector3.one
    end

    if isShow_ == true then 
        if isInsideCoroutine_ == true then 
            CfUtils.SetActive( self.fxGos[fxName_], false )
            coroutine.yield(Yielders.EndOfFrame)
            CfUtils.SetActive( self.fxGos[fxName_], true )
        else
            CoStop(self.co_fxs[fxName_])
            self.co_fxs[fxName_] = CoStart(function()
                CfUtils.SetActive( self.fxGos[fxName_], false )
                coroutine.yield(Yielders.EndOfFrame)
                CfUtils.SetActive( self.fxGos[fxName_], true )
            end)
        end
    else 
        CfUtils.SetActive( self.fxGos[fxName_], false )
    end 
end



---@return UnityEngine.GameObject
function Parkour_Loader:InstanceFXGO( fxName_, parent_ )
    local fxGo = Parkour_Loader.GetInstance():TryInstanceGO(fxName_)
    if isNotNull(parent_) then 
        fxGo.transform:SetParent( parent_ )
        fxGo.transform.localPosition = Vector3.zero
        fxGo.transform.localRotation = Quaternion.identity
        fxGo.transform.localScale = Vector3.one
    end 
    CfUtils.SetActive( fxGo, false ) -- hide
    return fxGo
end




function Parkour_Loader:HideAllFX()
    for _,go in pairs(self.fxGos) do 
        CfUtils.SetActive( go, false )
    end 
end





return Parkour_Loader