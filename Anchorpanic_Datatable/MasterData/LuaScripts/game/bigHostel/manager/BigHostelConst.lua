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
    InitIdle = "idle_1",
}

-- BigHostelConst.startStateName = "showStart"
BigHostelConst.startStateHash = gs.Animator.StringToHash("showStart")

BigHostelConst.Animator_Conditions_Type =
{
    Float = 1,
    Int = 2,
    Bool = 3,
    Trigger = 4,
}

BigHostelConst.SceneUI_Type =
{
    MIANUI = 1,
    INTERACTIVE = 2,
    TRIAL = 3,
}
