---@class IdolLive3D_StatesV2
local IdolLive3D_StatesV2 = {}

-- 全局变量 及其配套函数

-- 外部调用时使用:
-- ---@type IdolLive3D_StatesV2
-- local IdolLive3D_StatesV2 = import('Game.IdolLive3D.V2.IdolLive3D_StatesV2')



-- ======================  =========================


IdolLive3D_StatesV2.SceneBuildName = "build_tf"


IdolLive3D_StatesV2.loaderHead_Stage  = "Stage_"
IdolLive3D_StatesV2.loaderHead_SimpleFX = "SimpleFX_"
IdolLive3D_StatesV2.loaderHead_ToIdle  = "ToIdle_"



IdolLive3D_StatesV2.StageClipNames = 
{ 
    --ToIdle  = "ToIdle", -- 只能做个头
    ---
    Idle    = "Idle",
    Idle2   = "Idle2",
    ---
    Interact_1      = "Interact_1",
    Interact_2      = "Interact_2",
    Interact_3      = "Interact_3",
    Interact_4      = "Interact_4",
    Interact_5      = "Interact_5",
    Interact_6      = "Interact_6",
    Interact_7      = "Interact_7",
    Interact_8      = "Interact_8",
    Interact_9      = "Interact_9",
    Interact_10     = "Interact_10",
}




-- 数据和 c# 中的 IKNodeType 一致:
IdolLive3D_StatesV2.IKNodeType = 
{
    Spine1 = 1,
    ---
    lWrist = 10,
    lShoulder = 11,
    lElbow = 12,
    lAnkle = 13,
    lHip = 14,
    lKnee = 15,
    ---
    rWrist = 20,
    rShoulder = 21,
    rElbow = 22,
    rAnkle = 23,
    rHip = 24,
    rKnee = 25,
}


-- 数据和 c# 中的 IKRegionType 一致:
IdolLive3D_StatesV2.IKRegionType = 
{
    Ellipse = 1, -- 一个椭圆平面活动区域
    Arc = 2, -- 一条弧线
}


IdolLive3D_StatesV2.IKUIHandMoveMode = 
{
    PingPong        = 0, -- 
    SingleDirMove   = 1, -- 单向滑动
}



IdolLive3D_StatesV2.SuperTimelineClipType = 
{
    Normal   = 101, -- 基础的 clip 
    FakeIK   = 102, -- fakeIK clip
}



function IdolLive3D_StatesV2.Str2IKNodeType( str_ )

    -- str_ = string.lower(str_)
    -- if str_ == "" then 
    -- elseif then 
    -- else
    -- end
end




-- ====================== Collider  =========================

IdolLive3D_StatesV2.collideLayerMask = -5 

IdolLive3D_StatesV2.anySimpleTapName = "_any_" -- 点中 任意一个有效的碰撞体
IdolLive3D_StatesV2.emptySimpleTapName = "_"   -- 点中 有效喷状体之外的区域, 和 "_any_" 互斥

IdolLive3D_StatesV2.allSimpleTapName = "_all_" -- "_any_" 与 "_" 的 并集; 只推进写在 json 配置中



-- 碰撞体节点一般绑定一个 ID 组件来传递信息, ID.id (int) 用做类型识别
IdolLive3D_StatesV2.ColliderIdType = 
{
    Base    = 0,    -- role 或场景里的 节点, 最常见的
    IKDrag = 131,   -- role ik drag 节点 专用 (这些 collider 是代码 IdolLive3D_RoleIKMgr 自动添加的)
    FakeIK = 141,   -- fake ik drag 节点 专用 (这些 collider 需要人类手动绑定)
    -- ...
}



-- 是否进入一次有效的 ik drag swipe;  必须一直到这次 swipe 操作彻底停止, 本 flag 才会被释放(改为 false) 
-- 用它来屏蔽掉 camera 滑屏响应:
IdolLive3D_StatesV2.IsInsideIKDragSwipe = false 

-- 是否正在一次 有效的 ik drag 过程中, 一旦这个 ik drag 阶段被终止, 本 flag 立刻被释放; (哪怕此时玩家手指还未离开屏幕, 此时 IsInsideIKDragSwipe 依然为 true) 
IdolLive3D_StatesV2.IsIKDragging = false





return IdolLive3D_StatesV2
