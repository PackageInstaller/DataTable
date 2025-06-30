-- @FileName:   CiruitConst.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

CiruitConst = {}

CiruitConst.GridSize = 120
-- CiruitConst.ColorList =
-- {
--     "",
--     gs.ColorUtil.GetColor("FF3D01FF"),
--     gs.ColorUtil.GetColor("008AfFFF"),
-- }

CiruitConst.GridType =
{
    Put = 0,--摆放
    Start = 1, --起点
    End = 2, --终点
    L = 11, --L
    I = 12, --I
    Skew = 13, --//
    T = 14, --T
    Cross = 15, --+
}

CiruitConst.GridDir =
{
    Up = 1,
    Right = 2,
    Down = 3,
    Left = 4,
}
