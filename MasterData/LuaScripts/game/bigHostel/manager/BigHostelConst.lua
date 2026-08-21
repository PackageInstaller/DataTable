-- @FileName:   BigHostelConst.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2025-04-23 15:58:03
-- @Copyright:   (LY) 2025 锚点降临

BigHostelConst = {}

BigHostelConst.BaseAnimatorParams =
{
    Start = "start",
    Switch = "switch",
    Show = "show",
    InitIdle = "idle_1",
}

-- BigHostelConst.startStateName = "showStart"
BigHostelConst.startStateHash = gs.Animator.StringToHash("showStart")

BigHostelConst.Animator_Parame_Type =
{
    Float = 1,
    Int = 3,
    Bool = 4,
    Trigger = 9,
}

BigHostelConst.SceneUI_Type =
{
    MIANUI = 1,
    INTERACTIVE = 2,
    TRIAL = 3,
}

BigHostelConst.FullBodyBipedEffector =
{
    ["Body"] = 0, --身体
    ["LeftShoulder"] = 1, --左右肩膀
    ["RightShoulder"] = 2,
    ["LeftThigh"] = 3, --左右大腿根部
    ["RightThigh"] = 4,
    ["LeftHand"] = 5, --左右手
    ["RightHand"] = 6,
    ["LeftFoot"] = 7, --左右脚
    ["RightFoot"] = 8,
}

BigHostelConst.CapsuleColliderDic = 
{
    x = 0,
    y = 1,
    z = 2,
}
