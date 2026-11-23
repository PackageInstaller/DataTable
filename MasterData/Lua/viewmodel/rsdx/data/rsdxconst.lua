RSDXConst = {}

RSDXConst.LevelMaxRow = 5
RSDXConst.LevelMaxCol = 8
RSDXConst.DefaultLevelID = "RSDX1001"
RSDXConst.ItemGridSpace = {X = 7, Y = 7}
RSDXConst.EliminateAnimDelay = 0.15
RSDXConst.ElementScaleAnimTime1 = 0.05
RSDXConst.ElementScaleAnimTime2 = 0.1
RSDXConst.ElemenetEffectTime = 0.6
RSDXConst.GameSpriteAtlaName = "RSDX"
RSDXConst.ElementColor = {
    [1001] = UnityEngine.Color.red,
    [1002] = UnityEngine.Color.green,
    [1003] = UnityEngine.Color.blue,
    [1004] = UnityEngine.Color.yellow,
}

RSDXConst.ForNeighborData = {
    {x = -1, y = 0},
    {x = 0, y = -1},
    {x = 1, y = 0},
    {x = 0, y = 1}
}
RSDXConst.EightNeighborData = {
    {x = -1, y = 0},
    {x = 0, y = -1},
    {x = 1, y = 0},
    {x = 0, y = 1},
    {x = -1, y = -1},
    {x = 1, y = -1},
    {x = 1, y = 1},
    {x = -1, y = 1}
}