---@class DreamSpaceStates
local DreamSpaceStates = {}

-- 白塔 全局变量 及其配套函数

-- 外部调用时使用:
-- ---@type DreamSpaceStates
-- local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')


local GameObject = CS.UnityEngine.GameObject
local KeyCode = CS.UnityEngine.KeyCode

--==============================================================================================


DreamSpaceStates.JumpType = 
{
    None = 0,
    Up = 1,
    Down = 2,
    Forward = 3,
}

-- 内容必须和 JumpType 一致, 两种类型会作 equal 比较
DreamSpaceStates.JumpHintType = 
{
    None = 0,
    Up = 1,
    Down = 2,
    Forward = 3,
}


DreamSpaceStates.FootStepState = 
{
    Idle = 0,
    Walk = 1,
    Run = 2,
    JumpStart = 3,
    JumpEnd = 4
}


DreamSpaceStates.InputMode = 
{
    FromDevice = 1, -- 选用设备输入值 (玩家输入值)
    FromCode = 2,   -- 选用代码生成值 (比如进入 autoWalk 模式时)

}



DreamSpaceStates.FloorMaterials =
{
    Default = 0, -- metal
    Glass = 1,
}


-- 映射 几个 自定义 layers:
DreamSpaceStates.layers = 
{
    FloorDetect = "Layer_29",
    Volume = "Layer_30",
    CameraCollision = "Layer_31",
    
}


DreamSpaceStates.EnvironmentType = 
{
    Default = 0,
    InPipe = 1,  -- 猫在管道内
}



-- ====================== event name =========================
-- ! 放在此处而不是 Constants.EventNames 中, 是为了支持单lua场景
DreamSpaceStates.EventNames = 
{
    OnCreatePlayerInitEnd       = "OnCreatePlayerInitEnd", -- 无参
    OnCreatePlayerDestroy       = "OnCreatePlayerInitDestroy", -- 无参
    --SetHumanHasTurnBack         = "SetHumanHasTurnBack", -- 参数: {bool},  是否启动 human 角色的 180度大转身动画 (有些角色不支持)
    ShowOrHideUICanvas          = "ShowOrHideUICanvas",  -- 参数: {bool}
    OnMeow                      = "OnMeow",
}



-- ======================
-- 整个角色控制器 是否初始化完成:
DreamSpaceStates.isRoleControllerInited = false


-- 管理 DelayFollow:Update()
DreamSpaceStates.IsDelayFollowUpdateActive = true

-- 当进入 "可跳跃" 区域时, 需要显示 jumpHint, jumpCurve 和 jumpButton
DreamSpaceStates.IsShowJumpUI = false 

-- 地板材质:
DreamSpaceStates.floorMaterial = DreamSpaceStates.FloorMaterials.Default

-- 猫所在环境类型, 会影响声音
DreamSpaceStates.environmentType = DreamSpaceStates.EnvironmentType.Default

-- 是否显示 猫跳跃曲线
DreamSpaceStates.isShowCatJumpCurve = true


-- 是否支持 alt 组合键
DreamSpaceStates.isUseAltKey = true


-- ====================== 帧率 =========================
DreamSpaceStates.cachedFrameRate = 30  -- 白塔外部帧率缓存

DreamSpaceStates.recommendedFrameRateForPC     = 60     -- PC 端锁帧
DreamSpaceStates.recommendedFrameRateForMobile = 30     -- 移动端锁帧


-- ====================== max wait frames in DelayInit() =========================
DreamSpaceStates.DelayInitWaitFrames = 500 -- DelayInit() 中最大等待帧数


-- ====================== PC / Mobile =========================
DreamSpaceStates.PlatformType = 
{ 
    Auto = 0,       -- 推荐且唯一正确的配置变量
    Mobile = 1,     -- 强制进入 移动端模式, 仅为了 debug
    PC = 2          -- 强制进入 pc模式, 仅为了 debug
}

-- 允许玩家指定平台, 以便在 editor 中测试;
DreamSpaceStates.expectedPlatformType = DreamSpaceStates.PlatformType.Auto -- todo: 若将本值设为 Mobile, 可在 pc editor 中强开移动模式; (不要在 运行时代码 中改写此值)

-- 实际的 平台变量:
DreamSpaceStates.isWindowsPlatform = false

-- 检查平台信息:
DreamSpaceStates.CheckPlatform = function()
    -- PC / Mobile 平台:
    if DreamSpaceStates.expectedPlatformType == DreamSpaceStates.PlatformType.Auto then 
        local DreamSpaceLuaUtils = import('Game.DreamSpace.Tools.DreamSpaceLuaUtils')
        DreamSpaceStates.isWindowsPlatform = DreamSpaceLuaUtils.IsReallyPCPlatform() 
    else 
        DreamSpaceStates.isWindowsPlatform = (DreamSpaceStates.expectedPlatformType == DreamSpaceStates.PlatformType.PC)
    end 
    print("koko - isWindowsPlatform: " .. tostring(DreamSpaceStates.isWindowsPlatform) )
end


-- ====================== 进出白塔的 loading 图 id =========================
DreamSpaceStates.LoadingPanel_IMG_ID = 3  -- "loading_bg_3"


-- ====================== 左摇杆 name =========================
DreamSpaceStates.JoystickName = "LeftJoystick" -- 场景中目标 joystick 需要同步为此名字

-- ==============================
-- 当前已完成的 任务个数, (运营需要的数据)
DreamSpaceStates.FinshedTaskNum = 0


-- ================================= Keyboard: =======================================

DreamSpaceStates.KeyboardInfo = 
{
    Horizontal      = "Horizontal",
    Vertical        = "Vertical",
    SwitchKey       = KeyCode.Q,
    AttackKey       = KeyCode.F,
    CatEyeKey       = KeyCode.K,
    JumpKey         = KeyCode.Space,
    PcTipsKey       = KeyCode.P, -- pc 版玩法提示面板
    InteractiveKey  = KeyCode.E, -- 交互键
    InspectKey      = KeyCode.R, -- 碎片化剧情 信息键
    Meow            = KeyCode.Z, -- 猫叫
    LeftCtrl        = KeyCode.LeftControl -- 走/跑 切换
}



-- ================================= 关卡相关的信息: =======================================
DreamSpaceStates.questId = 0 -- 关卡id: 1001 这种

DreamSpaceStates.isMajorRewardDrawed = false  -- 当前关卡 是否领取过 主奖励

DreamSpaceStates.isAllPiecesCollectedAlready  = false -- 是否在本次白塔章节之前,   当前关卡的碎片 已经集齐
DreamSpaceStates.isAllPiecesCollectedThisTime = false -- 是否在本次白塔章节结束时, 当前关卡的碎片 已经集齐




-- ================================= UI 界面: =======================================

-- pc 模式下, ui代码 四散各处, 有些子界面是互斥的, 用本变量来统一管理
DreamSpaceStates.CurrentOpenPanelTypeInPC = 
{
    None = 11,
    SuspendPanel = 12,
    PCTipsPanel = 13,
    InspectPanel = 14,   --碎片化叙事面板
}

DreamSpaceStates.currentOpenPanelTypeInPC = DreamSpaceStates.CurrentOpenPanelTypeInPC.None


-- 在 触发机关, 播放剧情时, 此值要设 false, 此时禁止点击 P/ESC 来打开 ui子界面
-- todo: 也许可以搞成 计数器 ...
DreamSpaceStates.subPanelFreesInPC = 
{
    mainProcess = false,
    count       = 0,        -- 引用计数, 等于 0 表示 true
    jump        = false,
}




-- 重置:
function DreamSpaceStates.IsSubPanelFreeInPC_Reset()
    DreamSpaceStates.subPanelFreesInPC = 
    {
        mainProcess = false,
        count       = 0,
        jump        = false,
    }
end


function DreamSpaceStates.SubPanelFreeInPC_ToString()
    return "{MainProcess:" .. tostring(DreamSpaceStates.subPanelFreesInPC.mainProcess) ..
            ", Count:" .. tostring(DreamSpaceStates.subPanelFreesInPC.count) .. 
            ", Jump:" .. tostring(DreamSpaceStates.subPanelFreesInPC.jump)
end


-- 锁: 引用计数 版
function DreamSpaceStates.LockSubPanelFreeInPC_ByCount( lockState )
    if lockState == DreamSpaceStates.InputLockState.Lock then 
        DreamSpaceStates.subPanelFreesInPC.count = DreamSpaceStates.subPanelFreesInPC.count + 1
        --printError("koko - 计数器+ " .. DreamSpaceStates.SubPanelFreeInPC_ToString() )
    elseif lockState == DreamSpaceStates.InputLockState.Unlock then 
        DreamSpaceStates.subPanelFreesInPC.count = DreamSpaceStates.subPanelFreesInPC.count - 1
        --printError("koko - 计数器- " .. DreamSpaceStates.SubPanelFreeInPC_ToString() )
    else 
        printError("koko - 参数异常: " .. tostring(lockState) )
    end 
end



function DreamSpaceStates.IsSubPanelFreeInPC()
    if DreamSpaceStates.subPanelFreesInPC.count < 0 then 
        print("koko - 引用计数异常 subPanelFreesInPC.count: " .. tostring(DreamSpaceStates.subPanelFreesInPC.count) )
        DreamSpaceStates.subPanelFreesInPC.count = 0
    end 
    ---
    return      DreamSpaceStates.subPanelFreesInPC.mainProcess == true 
            and DreamSpaceStates.subPanelFreesInPC.count == 0
            and DreamSpaceStates.subPanelFreesInPC.jump == true
end




-- ================================= 玩家输入/视角旋转 锁 =======================================

-- 计数器, 若数值大于 0, 说明有人想要 "禁止玩家输入" (移动,  旋转视角等)
-- 使用者可用 ++, -- 来占用和释放
DreamSpaceStates._inputForbiddenerNum = 0

-- bool 类型的旋转屏蔽值
-- false 表示 允许玩家旋转
-- 目前有些场景需要屏蔽 视角旋转控制, 但又不适合用 _inputForbiddenerNum 来实现, 就改用此变量;
-- 优点: 和计数器不同, 本开关不会出现 嵌套丢失问题, 永远能一键开启旋转
DreamSpaceStates._rotateForbiddenFlag = false

DreamSpaceStates.InputLockState = 
{
    Lock = 101,
    Unlock = 102,
}


function DreamSpaceStates.InputLock_ToString()
    return "inputForbiddener: Num:" .. tostring(DreamSpaceStates._inputForbiddenerNum) .. 
            ", Flag:" .. tostring(DreamSpaceStates._rotateForbiddenFlag)
end


-- 初始化: 允许玩家旋转视角,  允许玩家各种输入
function DreamSpaceStates.InitInputLock()
    DreamSpaceStates._inputForbiddenerNum = 0
    DreamSpaceStates._rotateForbiddenFlag = false
    DreamSpaceStates._canRolemove = true
end


-- !! LockInput_ByCount() 和 LockInput_ByFlag() 不要混用
function DreamSpaceStates.LockInput_ByCount( lockState )
    if lockState == DreamSpaceStates.InputLockState.Lock then 
        DreamSpaceStates._inputForbiddenerNum = DreamSpaceStates._inputForbiddenerNum + 1
    elseif lockState == DreamSpaceStates.InputLockState.Unlock then 
        DreamSpaceStates._inputForbiddenerNum = DreamSpaceStates._inputForbiddenerNum - 1
    else
        printError("koko 参数异常: " .. tostring(lockState))
    end
    --printError("koko - inputLock 计数器- " .. tostring(DreamSpaceStates._inputForbiddenerNum) )
end


-- !! LockInput_ByCount() 和 LockInput_ByFlag() 不要混用
function DreamSpaceStates.LockInput_ByFlag( lockState )
    if lockState == DreamSpaceStates.InputLockState.Lock then 
        DreamSpaceStates._inputForbiddenerNum = 1
    elseif lockState == DreamSpaceStates.InputLockState.Unlock then 
        DreamSpaceStates._inputForbiddenerNum = 0
    else
        printError("koko 参数异常: " .. tostring(lockState))
    end
end


function DreamSpaceStates.LockViewRotate_ByFlag( lockState )
    if lockState == DreamSpaceStates.InputLockState.Lock then 
        DreamSpaceStates._rotateForbiddenFlag = true
    elseif lockState == DreamSpaceStates.InputLockState.Unlock then 
        DreamSpaceStates._rotateForbiddenFlag = false
    else
        printError("koko 参数异常: " .. tostring(lockState))
    end
end


-- ret true: 禁止 玩家的各种输入
function DreamSpaceStates.IsInputForbidden()
    return (DreamSpaceStates._inputForbiddenerNum > 0)
end


-- ret true: 禁止 玩家旋转视角
function DreamSpaceStates.IsViewRotateForbidden()
    return (DreamSpaceStates._inputForbiddenerNum > 0) or (DreamSpaceStates._rotateForbiddenFlag == true )
end




-----------------------
--- 仅仅屏蔽 角色移动;
DreamSpaceStates._canRolemove = true

-- ret true: 角色可以移动
function DreamSpaceStates.CanRoleMove()
    return (DreamSpaceStates._canRolemove == true)
end

function DreamSpaceStates.SetRoleMoveFlag( canMove_ )
    DreamSpaceStates._canRolemove = checkBool(canMove_)
end



-- ================================= 开关 状态 =======================================

-- 有些东西在 "打开", "关闭" 时存在动画:
DreamSpaceStates.OpenState = 
{
    Opened = 101,
    Opening = 102,
    Closed = 103,
    Closing = 1.4
}



-- ================================= 单场景 flag: =======================================

local isSingleLuaScene = nil 

---@return boolean
function DreamSpaceStates.IsSingleLuaScene()
    if isSingleLuaScene == nil then 
        isSingleLuaScene = isNotNull( GameObject.Find("/__Single_Lua_Scene_Flag__") )
        print( "koko - isSingleLuaScene: " .. tostring(isSingleLuaScene) )
    end 
    return isSingleLuaScene == true
end





return DreamSpaceStates
