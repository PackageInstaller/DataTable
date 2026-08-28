---
--- 烹饪玩法 Constants
--- Author: dawanfan
--- Date: 2024-3-12 11:55:01
---


---@class ActivityCookingConstants
local ActivityCookingConstants = {}

ActivityCookingConstants.GuestMenuFoodNum = 3
ActivityCookingConstants.ItemMaxLevel = 3

ActivityCookingConstants.GameMode = {
    Normal = 1,  -- 正常模式
    Endless = 2,  -- 无尽模式
}

ActivityCookingConstants.KitchenwareState = {
    Idle = 0,  -- 空闲
    Working = 1, -- 制作中
    Finish = 2, -- 制作完成
    Burnt = 3, -- 烤糊
}

ActivityCookingConstants.StarConditions = {
    [1] = "SuccessGuestNum",
    [2] = "SellMoney"
}

ActivityCookingConstants.UpgradeItemType = {
    Ingredients = 1,
    Kitchenware = 2,
}

ActivityCookingConstants.CookingFailType = {
    Burnt = 1,
    DropFood = 2
}

ActivityCookingConstants.CookingFailMessage = {
    [ActivityCookingConstants.CookingFailType.Burnt] = "本关卡禁止烧糊食物",
    [ActivityCookingConstants.CookingFailType.DropFood] = "本关卡禁止丢弃食物",
}

ActivityCookingConstants.ParamsDefine = {
    RESTORE_HP_INTERVAL  = 1, -- 恢复活动体力所需秒数
    RESTORE_NUM          = 2, -- 活动体力每次恢复X点
    HP_UP_LIMIT          = 3, -- 活动体力恢复上限
    BUY_CONSUME_ITEM     = 4, -- 兑换体力用道具id
    BUY_CONSUME_ITEM_NUM = 5, -- 消耗道具的数量（从左至右依次递增。到最右后循环）
    BUY_NUM              = 6, -- 消耗道具可兑换的体力数量
    BUY_DAILY_TIME_LIMIT = 7, -- 每日活动体力最多可兑换次数
    HP_ITEM_ID           = 8, -- 活动体力道具id
}

---@class ActivityCookingUIConfig
---@field EntryDialog number
---@field UpgradeDialog number
---@field RankDialog number
---@field OperateMainDialog number
---@field OperatePopup number
---@field OperateSuspendDialog number
---@field InstructionDialog number

---@type table<number, ActivityCookingUIConfig>
ActivityCookingConstants.CookingUIConfigs = {
    [1] = {
        EntryDialog = Constants.UITypeIds.ActivityCakeShopFightDialog,
        UpgradeDialog = Constants.UITypeIds.ActivityCakeShopFightBuffDialog,
        RankDialog = Constants.UITypeIds.CommonRankingsDialog,
        -- RankRewardPreviewDialog = Constants.UITypeIds.ActivityCookingRankRewardPreviewDialog,
        OperateMainDialog = Constants.UITypeIds.ActivityOperateMainDialog,
        OperatePopup = Constants.UITypeIds.ActivityOperatePopup,
        OperateSuspendDialog = Constants.UITypeIds.ActivityOperateSuspendDialog,
        InstructionDialog = Constants.UITypeIds.ActivityCakeShopInstructionDialog
    },
    [2] = {
        EntryDialog = Constants.UITypeIds.ActivityMountainFightDialog,
        UpgradeDialog = Constants.UITypeIds.ActivityMountainFightBuffDialog,
        RankDialog = Constants.UITypeIds.CommonRankingsDialog,
        -- RankRewardPreviewDialog = Constants.UITypeIds.ActivityCookingRankRewardPreviewDialog,
        OperateMainDialog = Constants.UITypeIds.ActivityMountainOperateMainDialog,
        OperatePopup = Constants.UITypeIds.ActivityMountainOperatePopup,
        OperateSuspendDialog = Constants.UITypeIds.ActivityMountainOperateSuspendDialog,
        InstructionDialog = Constants.UITypeIds.ActivityMountainInstructionDialog
    },
    [3] = {
        EntryDialog = Constants.UITypeIds.ActivityMountainFightDialog_11300303,
        UpgradeDialog = Constants.UITypeIds.ActivityMountainFightBuffDialog_11300303,
        RankDialog = Constants.UITypeIds.CommonRankingsDialog,
        -- RankRewardPreviewDialog = Constants.UITypeIds.ActivityCookingRankRewardPreviewDialog,
        OperateMainDialog = Constants.UITypeIds.ActivityMountainOperateMainDialog_11300303,
        OperatePopup = Constants.UITypeIds.ActivityMountainOperatePopup_11300303,
        OperateSuspendDialog = Constants.UITypeIds.ActivityMountainOperateSuspendDialog_11300303,
        InstructionDialog = Constants.UITypeIds.ActivityMountainInstructionDialog_11300303
    }
}

ActivityCookingConstants.BGMConfig = {
    [1] = "bgm_instance_nekopara_plot_relaxed_daytime",
    [2] = "bgm_instance_spring03",
}

return ActivityCookingConstants
