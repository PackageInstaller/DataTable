---@class IdolLive3D_States
local IdolLive3D_States = {}

-- 全局变量 及其配套函数

-- 外部调用时使用:
-- ---@type IdolLive3D_States
-- local IdolLive3D_States = import('Game.IdolLive3D.IdolLive3D_States')



-- ======================  =========================


-- 当前皮肤 使用的 版本:
IdolLive3D_States.currentVersion = 1


-- 功能总开关, 用来一键屏蔽整个功能
IdolLive3D_States.isOpenIdolLive3D = true



-- 是否在播放 timeline state 时隐藏 ui 按钮:
IdolLive3D_States.isHideUIInTimelineState = false


-- 进入场景时, 等待多少帧就停止等待:
IdolLive3D_States.loadWaitFrames = 300


-- =======
IdolLive3D_States.CameraMotionType = 
{ 
    Zoom        = 11, -- 镜头推拉
    Yaw         = 12, -- 偏航
    Pitch       = 13, -- 俯仰
}



IdolLive3D_States.VCamPriority = 
{
    High = 5, -- 不要大于主场景 vcam 的值, 否则回退到主场景后, 相机会抖动一帧
    Low = 1,
}



-- =======
IdolLive3D_States.StageJumpType = 
{ 
    FromSuperTimeline   = 11, 
    FromUIButton        = 12,
}

function IdolLive3D_States.IsStageJumpType( type_ ) 
    return  (type_==IdolLive3D_States.StageJumpType.FromSuperTimeline) or
            (type_==IdolLive3D_States.StageJumpType.FromUIButton)
end 



IdolLive3D_States.AnimatorState = 
{ 
    Idle = 11,
    SimpleIState = 12,
} 


-- ====================== PC / Mobile =========================
IdolLive3D_States.PlatformType = 
{ 
    Auto = 0, 
    Mobile = 1, 
    PC = 2 
}

-- 允许玩家指定平台, 以便在 editor 中测试;
IdolLive3D_States.expectedPlatformType = IdolLive3D_States.PlatformType.Auto -- todo: 若将本值设为 Mobile, 可在 pc editor 中强开移动模式

-- 实际的 平台变量:
IdolLive3D_States.isWindowsPlatform = false



-- 音效 播放模式:
IdolLive3D_States.SoundPattern =
{
    Default         = 0, -- T_默认模式 = 0,
    TimelineLoop    = 1, -- T_跟随timeline循环播放 = 1, 
}



-- SceneNode or ClipNode show:
IdolLive3D_States.NodeShowType =
{
    T_Open = 0,         -- 播放clip时开启   
    T_Hide = 1,         -- 播放clip时隐藏
    T_Open_Hide = 2,    -- 播放clip时开启_结束clip时隐藏
    T_Hide_Open = 3     -- 播放clip时隐藏_结束clip时开启
}


-- activeKey 的数种使用类型
IdolLive3D_States.ActiveKeyType =
{
    T_BothOpenAndClose = 0, -- T_同时监听开启和关闭
    T_OnlyOpen = 1,         -- T_仅监听开启
    T_OnlyClose = 2,        -- T_仅监听关闭
}



IdolLive3D_States.CameraMode =
{
    FreeManual  = 11,  -- 自由轨道相机 - 手动控制
    FreeAuto    = 12,  -- 自由轨道相机 - 自动运动
    Timeline    = 13,  -- timeline 内 vcam
    Freeze      = 14,  -- 自由轨道相机 - 冻结操作, 目前被 二段包/三段包 答题交互 使用;
}


IdolLive3D_States.FreeAutoMoveMode =
{
    Linear = 11,
    SmoothDamp = 12
}



IdolLive3D_States.FullScreenFXState =
{
    Hide = 0,
    FadeIn = 1,
    Show = 2,
    FadeOut = 3,
}



IdolLive3D_States.PlayState = 
{ 
    Before      = 11, -- 播放前
    Playing     = 12, -- 播放中
    Finished    = 13, -- 播放结束了
}


IdolLive3D_States.CueType =
{
    SFX     = 1,
    BGM     = 2,
    Voice   = 3,
}



-- ====================== InteractiveManager =========================


IdolLive3D_States.InteractiveStateType = 
{ 
    Idle        = 11,  -- 
    Simple      = 12,  -- 常规交互
    Timeline    = 13,  -- timeline交互
    Sound       = 14,  -- 机位触发的 音效动作
    SuperTimeline = 15, -- super timeline交互
    ---
    StageSmoothSwitch  = 16, -- 通过播放 toIdle 动画的方式, 平滑地过度到一个新的 stage idle, 
    StageJump          = 17, -- 人造 iState; V2 专用, 包含 uiBtn, superTimeline

    --- 
    IdleSwitch  = 20, -- 人造 iState; V1专用 包含: toIdle, uiBtn, superTimeline
    ---
}
function IdolLive3D_States.IsValidIStateType( type )
    return  (type == IdolLive3D_States.InteractiveStateType.Idle or 
            type == IdolLive3D_States.InteractiveStateType.Simple or 
            type == IdolLive3D_States.InteractiveStateType.Timeline or 
            type == IdolLive3D_States.InteractiveStateType.Sound or 
            type == IdolLive3D_States.InteractiveStateType.SuperTimeline or 
            type == IdolLive3D_States.InteractiveStateType.StageSmoothSwitch or 
            type == IdolLive3D_States.InteractiveStateType.StageJump or 
            type == IdolLive3D_States.InteractiveStateType.IdleSwitch)
end

function IdolLive3D_States.GetStateTypeString( type )
    if isNull(type) then                                                            return "nil"
    elseif  type == IdolLive3D_States.InteractiveStateType.Idle then                return "Idle"
    elseif type == IdolLive3D_States.InteractiveStateType.Simple then               return "Simple"
    elseif type == IdolLive3D_States.InteractiveStateType.Timeline then             return "Timeline"
    elseif type == IdolLive3D_States.InteractiveStateType.Sound then                return "Sound"
    elseif type == IdolLive3D_States.InteractiveStateType.SuperTimeline then        return "SuperTimeline"
    elseif type == IdolLive3D_States.InteractiveStateType.StageSmoothSwitch then    return "StageSmoothSwitch"
    elseif type == IdolLive3D_States.InteractiveStateType.StageJump then            return "StageJump(V2)"
    elseif type == IdolLive3D_States.InteractiveStateType.IdleSwitch then           return "IdleSwitch(V1)"
    else                                                                            return "Oth..."
    end 
end

-- superTimeline 离场方式:
IdolLive3D_States.SuperTimelineLeaveMode = 
{ 
    FullScreenFX = 0,   -- 全屏特效转场
    Smooth       = 1,   -- 相机平滑运动转场
}




IdolLive3D_States.InteractiveType = 
{ 
    Touch   = 11,   -- 触碰型 触发
    Spacial = 12,   -- 机位型 触发
}


IdolLive3D_States.IdleSwitchMode = 
{ 
    ByCameraSpacial = 11,   -- 由相机机位来触发
    ByButton        = 12,   -- 由按钮来触发
}


IdolLive3D_States.IdleType = 
{ 
    Type_100 = 100, -- 通常为 远处 
    Type_200 = 200, -- 通常为 近处
}


-- 
IdolLive3D_States.CameraSpatialRangeCompareMode = 
{ 
    Include = 11,
    Outside = 12,
}


IdolLive3D_States.TimelineNodeEnterConditionType = 
{
    T_NoCondition = 0,      -- T_无条件自动进入
    T_WithCondition = 1,    -- T_满足条件后才能进入
}


IdolLive3D_States.TimelineCameraBlendMode = 
{ 
    -- 先让 freeTrack 旋转到接近 timeline相机的位置, 然后 cut 到 timeline相机处
    -- 当两相机机位差异过大时, 适合此模式
    FreeTrackRotate = 11, 
    -- 直接从 freetrack相机 过渡到 timeline相机 
    -- 当两相机机位差异很小时, 适合此模式
    SimpleBlend = 12,   
}



-- free track camera
IdolLive3D_States.FreeCameraMode = 
{
    PosFree     = 0,    -- 默认模式, 当俯仰偏航时, vcam 绕着一个点旋转, 始终看向这个点, 
    PosLocked   = 1,    -- pos锁定模式, 当俯仰偏航时, vcam pos 不动, 绕着自己摇头抬头
}


-- ============================= Blocker Keys ===================================

-- 让某些协程成为 唯一流程:
IdolLive3D_States.BlockerKeys = 
{   
    StageJump = "Live3D_StageJump",

    

}





-- ============================= input flag ===================================
-- !! 目前能禁止用户输入的开关有三个, CameraMode.FreeManual 和 下面两个
-- 是否禁止玩家的 Swipe 和 Pinch 操作 (控制自由轨道相机旋转的)
IdolLive3D_States.isForbidPlayerSwipeAndPinch = false 

-- timeline 阶段是否允许 操作自由轨道相机 
IdolLive3D_States.isForbidPlayerSwipeAndPinchInTimeline = false 

IdolLive3D_States.InitInputFlags = function()
    IdolLive3D_States.isForbidPlayerSwipeAndPinch = false 
    IdolLive3D_States.isForbidPlayerSwipeAndPinchInTimeline = false 
end



--- 有些代码必须等待 MainUI 初始化完毕后, 再被执行;
IdolLive3D_States.isUIMainInited = false 



-- 当前帧是否正在播放 timeline
-- 此外还可通过监听 event: Constants.EventNames.Live3DIsInTimelineState 来得知 timeline 的开始帧 和 结束帧; -- !! 这个 event 很可能可被下面的 EventNewInteractiveState 取代
IdolLive3D_States.isPlayingTimeline = false 


-- 在特殊需求下, 希望能在 free camera 被 freeze 后, 依然支持 点击触发交互动作
IdolLive3D_States.isSupportInteractiveInFreeze = false


-- 放在 timeline 根目录下的 节点, 用来分别放置 男/女 内容, 比如手;
IdolLive3D_States.timelineMaleName   = "Live3D_Timeline_Male"
IdolLive3D_States.timelineFemaleName = "Live3D_Timeline_Female"


-- ====================== Event Names =========================
IdolLive3D_States.EventFreeCameraFreeze             = "IdolLive3D_FreeCameraFreeze" 
IdolLive3D_States.EventPlayAction                   = "IdolLive3D_PlayAction"    -- 当一个设置了 key 的交互动作被触发时, 广播此 event
IdolLive3D_States.EventMoveTo                       = "IdolLive3D_MoveTo" 
IdolLive3D_States.EventGetFreeCameraSpatialParams   = "IdolLive3D_GetFreeCameraSpatialParams" 
IdolLive3D_States.EventSwitchIdleToOth              = "IdolLive3D_EventSwitchIdleToOth" -- 按钮触发, 在 idle 100 / 200 间切换; -- !! V2 中将被弃用
IdolLive3D_States.EventNewInteractiveState          = "IdolLive3D_EventNewInteractiveState" -- 参数: 一个 iState, 是 IdolLive3D_InteractiveManager:AddToQueue() 的参数;
IdolLive3D_States.EventPlayVideoSubtitle            = "IdolLive3D_EventPlayVideoSubtitle" -- 播放一段字幕, 参数: (1)字幕id (string), 在策划配表中; (2)waitTime, 播放前摇时长
IdolLive3D_States.EventSimpleTapInAnyTime           = "IdolLive3D_EventSimpleTapInAnyTime" -- 只要玩家 simpleTap 点击屏幕内有效碰撞体, 都会触发本事件; 参数: (1): 碰撞体组件ID内的 string 值;
IdolLive3D_States.EventStartPlaySuperTimelineClip   = "IdolLive3D_EventStartPlaySuperTimelineClip" -- 每次开始播放新的 super timeline clip 时, 本事件被触发; 参数: {clipJson, timelineStateEnv}
IdolLive3D_States.EventEndPlaySuperTimelineClip     = "IdolLive3D_EventEndPlaySuperTimelineClip" -- 每次结束播放一个 super timeline clip 时, 本事件被触发; 参数: {clipJson, timelineStateEnv}
IdolLive3D_States.EventGetUIMain                    = "IdolLive3D_EventGetUIMain"  -- 参数: retTable 返回值容器, retTable.uiMain 就是 IdolLive3D_UIMain 实例本体 Env
IdolLive3D_States.EventSuperTL_StartQTE             = "IdolLive3D_SuperTL_StartQTE" -- 启用 qte;
IdolLive3D_States.EventSuperTL_EndQTE               = "IdolLive3D_SuperTL_EmdQTE" -- 结束 qte, 并得到: 是否成功
IdolLive3D_States.EventShowDebugUI                  = "IdolLive3D_EventShowDebugUI" -- 参数: bool, 是否显示

IdolLive3D_States.EventVirtualSimpleTap              = "IdolLive3D_VirtualSimpleTap" -- 触发一次 虚拟的 SimpleTap; 比如点击了某个ui按钮; 参数: touchKey:string

IdolLive3D_States.EventStageJumpByKey              = "IdolLive3D_EventStageJumpByKey" -- 触发 stage 跳转, 参数: Live3D_UIKey; 如: "ui_jump_pos"

IdolLive3D_States.EventChangeUIPosStageJumpBtnImg    = "IdolLive3D_EventChangeUIPosStageJumpBtnImg" -- 切换 posStageJumpBtn 的 img;  参数: idx (int); 1,2,3 这种; 对应 c# 的 PosStageJumpBtnImgIdx
IdolLive3D_States.EventChangeUICamStageJumpBtnTxt    = "IdolLive3D_EventChangeUICamStageJumpBtnTxt" -- 切换 camStageJumpBtn 的 txt;  参数: txt (string)


-- V1 二段包加载专用:
IdolLive3D_States.EventSmlPackageInitFreeze          = "IdolLive3D_EventSmlPackageInitFreeze" -- 二段包初始化阶段, 专用来开启角色 "近景特写" + "冻结"


-- ui 全屏特效:
IdolLive3D_States.EventShowUIFullPanel              = "IdolLive3D_EventShowUIFullPanel" -- smooth show UI fullPanel; 参数: (1)bool isShow, (2)float duration, (3)color
IdolLive3D_States.EventSetUIFullPanel               = "IdolLive3D_EventSetUIFullPanel" -- set fullPanel params; 参数: (1)color

-- V2: 通用:
IdolLive3D_States.EventSetUICustomShow         = "IdolLive3D_EventSetUICustomShow"         -- 改写 某个ui组件的 show;       参数: (1)Live3D_UIKey, (2)isShow:bool, (3)fadeInTime:float, (4)isEffectImmediately:bool 是否立刻起效
IdolLive3D_States.EventSetUICustomGray         = "IdolLive3D_EventSetUICustomGray"         -- 改写 某个ui组件的 show;       参数: (1)Live3D_UIKey, (2)isGray:bool, (3)isEffectImmediately:bool 是否立刻起效
IdolLive3D_States.EventSetUIBtnCustomClickFunc = "IdolLive3D_EventSetUIBtnCustomClickFunc" -- 设置 某个uiBtn组件的 点击响应; 参数: (1)Live3D_UIKey, (2)clickFunc:function or nil;

IdolLive3D_States.EventFirstActiveUITouchTip = "IdolLive3D_EventFirstActiveUITouchTip" -- 第一次触发某个 动作记录; 参数: uiTouchTipKey (string)
IdolLive3D_States.EventGetUITouchTip = "IdolLive3D_EventGetUITouchTip" -- 得到目标 动作记录的数据; 参数: (1) uiTouchTipKey (string), (2) retTable {ret}; ret 就是返回数据


-- V2 专用:
IdolLive3D_States.EventSetActiveKey = "IdolLive3D_EventSetActiveKey"  -- 将某个 activeKey 设为 true 或 false; 以此来实现类似 "二阶段" 的时间性阶段变化; 参数: (1) key:string, (2)isActive:bool




-- ====================== GameInstaller 二段包/三段包 阶段的 =========================

IdolLive3D_States.GameInstaller = 
{
    -- 答题交互的 freeCamera 的目标位置参数组:
    tgtFreeCameraParams = 
    {
        -- 目标相机机位
        tgtCameraSpatialParams = 
        {
            yaw = 0,
            pitch = 0.1,
            zoom = 0.3
        },
        enterTime = 4.0,        -- freeCamera 滑向 tgtFreeCameraSpatialParams 位置的耗时时长
        closeThreshold = 0.008,  -- freeCamera 距离 tgtFreeCameraSpatialParams 多近时结束运动, 推荐在 0.01 周围;
    },

    -- 远距离机位
    farFreeCameraParams = 
    {
        -- 目标相机机位
        tgtCameraSpatialParams = 
        {
            yaw = 0,
            pitch = 0.5,
            zoom = 0.9
        },
        enterTime = 3.5,        -- freeCamera 滑向 tgtFreeCameraSpatialParams 位置的耗时时长
        closeThreshold = 0.008,  -- freeCamera 距离 tgtFreeCameraSpatialParams 多近时结束运动, 推荐在 0.01 周围;
    },

}


--- 调用本函数, 让 深度互动 进入 "自由相机冻结" 状态; 
--- 传参可以指定冻结状态的 相机位置, 若参数为 nil, 表示瞬间冻结;
---@param tgtFreeCameraParams_ table or nil @ 指定相机目标位置, 可为 nil; 它的格式请参考 IdolLive3D_States.GameInstaller.tgtFreeCameraParams
---@param isSupportInteractiveInFreeze_ boolean @ 在冻结状态下, 是否支持 点击触发交互动作
---@return boolean @ 是否开启成功, 如果 深度正在播放 timeline, 是无法进入 答题模式的:
function IdolLive3D_States.EnterFreeze( tgtFreeCameraParams_, isSupportInteractiveInFreeze_ )
    if IdolLive3D_States.isPlayingTimeline == true then 
        return false
    end 
    if type(isSupportInteractiveInFreeze_) ~= "boolean" then 
        isSupportInteractiveInFreeze_ = false
    end 
    -- 检查参数:
    local tp = tgtFreeCameraParams_
    if tp ~= nil then 
        if  (isTable(tp.tgtCameraSpatialParams)==false) or type(tp.tgtCameraSpatialParams.yaw) ~= "number" or type(tp.tgtCameraSpatialParams.pitch) ~= "number" or type(tp.tgtCameraSpatialParams.zoom) ~= "number" 
            or type(tp.enterTime) ~= "number"
            or type(tp.closeThreshold) ~= "number"
        then 
            printError("参数 tgtFreeCameraParams_ 内部数据不合规, 此参数被当作 nil 处理")
            tp = nil
        end 
    end 
    ---
    IdolLive3D_States.isSupportInteractiveInFreeze = isSupportInteractiveInFreeze_
    Events.Broadcast(IdolLive3D_States.EventFreeCameraFreeze, { isFreeze = true, tgtFreeCameraParams = tp }) 
    return true
end


--- 调用本函数, 让 深度互动 脱离 "自由相机冻结" 状态;
--- 就算上面的 冻结过程动画 没有播完, 也能调用本函数, 
--- 脱离冻结 是立即执行的; 
---@return boolean @ 是否离开成功
function IdolLive3D_States.LeaveFreeze()
    if IdolLive3D_States.isPlayingTimeline == true then 
        return false
    end 
    IdolLive3D_States.isSupportInteractiveInFreeze = false
    Events.Broadcast(IdolLive3D_States.EventFreeCameraFreeze,  { isFreeze = false }) 
    return true
end


-- 如: IdolLive3D_States.MoveToState( IdolLive3D_States.GameInstaller.farFreeCameraParams )
-- 让 free camera 运动到一个指定的机位, 然后释放控制权
-- !! 本函数请勿滥用
function IdolLive3D_States.MoveToState( tgtFreeCameraParams_ )
    -- 检查参数:
    local tp = tgtFreeCameraParams_
    if tp ~= nil then 
        if  (isTable(tp.tgtCameraSpatialParams)==false) or type(tp.tgtCameraSpatialParams.yaw) ~= "number" or type(tp.tgtCameraSpatialParams.pitch) ~= "number" or type(tp.tgtCameraSpatialParams.zoom) ~= "number" 
            or type(tp.enterTime) ~= "number"
            or type(tp.closeThreshold) ~= "number"
        then 
            printError("参数 tgtFreeCameraParams_ 内部数据不合规, 此参数被当作 nil 处理")
            return
        end 
    end 
    Events.Broadcast(IdolLive3D_States.EventMoveTo, { tgtFreeCameraParams = tp }) 
end 


-- 得到自由相机的 机位参数:
-- ret = 
-- {    
--     yaw,     -- 方位角       [0f,360f]
--     pitch,   -- Y轴值,       [0f, 1f]
--     zoom,    -- 相机镜头拉伸, [0f,1f]
-- }
function IdolLive3D_States.GetFreeCameraSpatialParams()
    local retTable = {}
    Events.Broadcast(IdolLive3D_States.EventGetFreeCameraSpatialParams, retTable)
    return retTable.ret
end


return IdolLive3D_States
