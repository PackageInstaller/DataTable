local OtakuType = {}

local DeployHeroType = {
    Room = 1,
    Task = 2,
}

local OtakuRoomType = {
    EST_Undefine = 0,
    EST_Bridge = 1, --舰桥
    EST_Produce = 2, --制造室
    EST_Communication = 4, --通讯室
    EST_Dormitory = 5, --宿舍
    EST_Canteen = 6, --餐厅
    EST_Compose = 7, --合成舱
    EST_Survey = 8, --调查舱
    EST_Kitchen = 9, --厨房
    EST_Max = 10,
}

local OtakuRoomTypeSort = {
    OtakuRoomType.EST_Bridge,
    OtakuRoomType.EST_Produce,
    OtakuRoomType.EST_Canteen,
    OtakuRoomType.EST_Kitchen,
    OtakuRoomType.EST_Compose,
}

local AvailableRooms = {
    OtakuRoomType.EST_Bridge, --舰桥
    OtakuRoomType.EST_Produce, --制造室
    OtakuRoomType.EST_Communication, --通讯室
    OtakuRoomType.EST_Dormitory, --宿舍
    OtakuRoomType.EST_Canteen, --餐厅
}

local RoomStateLiveType = {
    Bridge = 1, --舰桥
    Produce = 2, --制造室
    Cook = 5, --餐厅-厨房
    DiningTable = 6, --餐厅-打扫
    Compound = 8, --合成仓
    Kitchen = 9,--厨房
}

local RoomEnterType = {
    [OtakuRoomType.EST_Produce] = "RequestEnterProduceStudio",
    [OtakuRoomType.EST_Dormitory] = "RequestEnterDormitoryStudio",
    [OtakuRoomType.EST_Canteen] = "RequestEnterCanteenStudio",
}

local RoomStateType = {
    Normal = 1, --默认
    Lock = 2, --未解锁
    Reward = 3, --可领奖
    Finish = 4, --任务完成
    Build = 5, --可建造
    Building = 6, --建造中
    Builded = 7, --建造完成
    Dormitory = 8, --宿舍常态
    BlackMask = 9, -- 黑色遮罩
}

local RoomContentStateType = {
    Normal = 1, --默认
    Producing = 2, --生产中
    Eating = 3, --用餐中
    Stop = 5, --停产中
    ProduceFree = 6, --制造仓空闲中
    ComposeFree = 7, --合成仓空闲中
    KitchenFree = 8, --厨房空闲中
    EatFree = 9, --餐厅空闲中
}

local DeployState = {
    Plus = 1,
    Normal = 2,
    Lock = 3
}

local DeployHeroState = {
    Idle = 1,
    OtherCabin = 2,
    CurCabin = 3
}

local UpgradeState = {
    Available = 1, -- 可升级
    LessConsume = 2, -- 材料不足
    LessBridgeLv = 3, -- 舰桥中心等级不够
}

local NetUpdateType = {
    Upgrade = 1, -- 升级
    Garrison = 2, -- 入驻
    CancelGarrison = 3 -- 取消入驻
}

-- 合成舱页签
local ComposeTabType = {
    HeroUpItem = 1, -- 英雄升级材料
    BuildItem = 2, -- 基建材料
    GeneItem = 3 -- 基因材料
}

local MakeType = {
    MakeCabin = 1, -- 制造舱
    ComposeCabin = 2, -- 合成舱
}

OtakuType.RoomContentStateType = RoomContentStateType
OtakuType.RoomStateType = RoomStateType
OtakuType.DeployHeroType = DeployHeroType
OtakuType.OtakuRoomType = OtakuRoomType
OtakuType.OtakuRoomTypeSort = OtakuRoomTypeSort
OtakuType.AvailableRooms = AvailableRooms
OtakuType.DeployState = DeployState
OtakuType.DeployHeroState = DeployHeroState
OtakuType.UpgradeState = UpgradeState
OtakuType.RoomStateLiveType = RoomStateLiveType
OtakuType.NetUpdateType = NetUpdateType
OtakuType.RoomEnterType = RoomEnterType
OtakuType.ComposeTabType = ComposeTabType
OtakuType.MakeType = MakeType

return OtakuType
