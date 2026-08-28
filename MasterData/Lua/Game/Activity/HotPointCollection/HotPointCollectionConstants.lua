---@class HotPointCollectionConstants
local HotPointCollectionConstants = {}

HotPointCollectionConstants.ActivityPageCellCount = 6

HotPointCollectionConstants.ViewType = {
    NewCard     = 1, --- 新战斗员
    NewSkin     = 2, --- 新皮肤
    NewActivity = 3, --- 新活动
    NewFunction = 4, --- 新功能
}

HotPointCollectionConstants.PrefabType  = {
    DisplayCard     = 1,
    DisplayModule   = 2,
}

HotPointCollectionConstants.PrefabPath = {
    HotpointNewCombatantDialog = "Prefabs/Hotpoint/HotpointNewCombatantDialog.prefab",
    HotpointNewActivityDialog  = "Prefabs/Hotpoint/HotpointNewActivityDialog.prefab",
    HotpointRole               = "Prefabs/Hotpoint/%s.prefab",
    CatSpine                   = "Spine/CatSpine/CatPrefab/%s.prefab",
    MoviePath                  = "Movie/%s.usm",

}

HotPointCollectionConstants.PrefabType2PrefabPath = {
    [HotPointCollectionConstants.PrefabType.DisplayCard]   = HotPointCollectionConstants.PrefabPath.HotpointNewCombatantDialog,
    [HotPointCollectionConstants.PrefabType.DisplayModule] = HotPointCollectionConstants.PrefabPath.HotpointNewActivityDialog,

}

HotPointCollectionConstants.EnvPath = {
    HotPointCollectionNewActivity         = "Game.Activity.HotPointCollection.HotPointCollectionNewActivity",
    HotPointCollectionNewCombatant        = "Game.Activity.HotPointCollection.HotPointCollectionNewCombatant",
    HotPointCollectionNewCombatantBtnHead = "Game.Activity.HotPointCollection.HotPointCollectionNewCombatantBtnHead",
    HotPointCollectionNewActivityItemCell = "Game.Activity.HotPointCollection.HotPointCollectionNewActivityItemCell",
    HotPointCollectionAssociatedNode      = "Game.Activity.HotPointCollection.HotPointCollectionAssociatedNode",
    CardProgressionListCell               =  "Game.CardProgression.Common.CardProgressionListCell",
    SubPrefabLoader                       = "Game.Activity.HotPointCollection.SubPrefabLoader",
}

HotPointCollectionConstants.ViewType2Config = {
    [HotPointCollectionConstants.ViewType.NewCard]     = {prefabType = HotPointCollectionConstants.PrefabType.DisplayCard  , luaPath = HotPointCollectionConstants.EnvPath.HotPointCollectionNewCombatant},
    [HotPointCollectionConstants.ViewType.NewActivity] = {prefabType = HotPointCollectionConstants.PrefabType.DisplayModule, luaPath = HotPointCollectionConstants.EnvPath.HotPointCollectionNewActivity},
    [HotPointCollectionConstants.ViewType.NewFunction] = {prefabType = HotPointCollectionConstants.PrefabType.DisplayModule, luaPath = HotPointCollectionConstants.EnvPath.HotPointCollectionNewActivity},
    [HotPointCollectionConstants.ViewType.NewSkin]     = {prefabType = HotPointCollectionConstants.PrefabType.DisplayCard  , luaPath = HotPointCollectionConstants.EnvPath.HotPointCollectionNewCombatant},
}

HotPointCollectionConstants.DefineName = {
    Cell     = "Cell",
    ItemCell = "ItemCell",
}

HotPointCollectionConstants.LoadStatus = {
    Non        = 1, --- 空
    Processing = 2, --- 准备中
    Finished   = 3, --- 完成
}


HotPointCollectionConstants.DataType  = {
    Activity     = 1, --- 新活动
    Module       = 2, --- 新模块
}


return HotPointCollectionConstants