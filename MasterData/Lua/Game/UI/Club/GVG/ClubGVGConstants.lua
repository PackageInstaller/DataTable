---@class ClubGVGConstants
local ClubGVGConstants = {}

ClubGVGConstants.PingTime = 2000
ClubGVGConstants.TimeoutTime = 8000
ClubGVGConstants.RetryTimeMax = 2
ClubGVGConstants.MainBuildingId = 1
ClubGVGConstants.MaxCoreBuildingId = 2
ClubGVGConstants.ApplyStatus = 2
ClubGVGConstants.BattingStatus = 3


---@alias ClubGVGConstants.ParamsId integer @ 社团GVG参数表id
ClubGVGConstants.ParamsId = {
    MaxClubCount                = 1,           ---		多少个社团一个组
    PlayerInitHP                = 6,           ---		玩家初始精力值
    AttackBuildingConsume       = 7,           ---		攻城精力值扣除
    AttackPlayerConsume         = 8,           ---		攻击玩家精力值扣除
    AttackedPlayerConsume       = 9,           ---		被玩家攻击精力值扣除
    FreeRebirthTimes            = 10,          ---		免费复活次数
    DurationOfProtectionPeriod  = 13,          ---		保护期持续时间（主基地显示保护罩且不能被攻打）
    AccelerateCurrency          = 14,          ---		加速消耗的货币id
    AccelerateCurrencyNum       = 15,          ---		加速消耗的货币数量
    AccelerateCoolDown          = 16,          ---		加速冷却时间（秒
    AccelerateLimitSeconds      = 17,          ---		小于多少秒不能加速
    MarchTime                   = 18,          ---		相邻建筑行军时间，秒
    BattleCoolDown              = 19,          ---		战斗冷却时间，秒
    BuildingCoolDown            = 20,          ---		攻城冷却时间，秒
    RebirthCoolDown             = 21,          ---		复活冷却时间，死亡后多少秒后可以复活
    OpeningDayNum               = 25,          ---     【社团GVG排期开启后的第_天开始活动！】
    ApplyStartSeconds           = 4,           ---      活动开始报名时间，当天5:00
    BattleStartSeconds          = 5,           ---      活动开始时间，当天20:00
    BattleEnterOffsetSeconds    = 11,          ---      活动开始前提前30分钟可以进入，秒
    ApplyEndOffsetSeconds       = 12,          ---      活动截止报名时间；在开始前多少秒截止
    ApplyMemberCount            = 22,          ---      社团人数小于8人时不能报名
    ApplyActivityPoint          = 23,          ---      社团周活跃度（贡献值）达到2000才能报名
    HPGoodsId                   = 31,          ---      精力值道具id
    RebirthGoodsId              = 32,          ---      复活道具id
    SuccessiveVictoryTimes      = 33,          ---      连续胜利次数
    StreamerDurationSeconds     = 36,          ---      GVG开始前的倒计时，从5秒开始弹窗
    RebirthGoodsBuyGoodsId      = 37,          ---      购买复活丹需要消耗的道具id（猫眼石
    RebirthGoodsBuyGoodsNum     = 38,          ---      购买复活丹需要消耗的道具数量（200猫眼石）
}

---@alias ClubGVGConstants.Name string 
ClubGVGConstants.Name = {
    NetworkContainerName        = "GVG.NetWorkContainer",
    Cell                        = "Cell",
    Grid                        = "Grid",
    Tilemap_building            = "Tilemap_building",
    Tilemap_select              = "Tilemap_select",
    MainCamera                  = "MainCamera",
    CameraRoot                  = "CameraRoot",
    FollowNode                  = "FollowNode",
    Lines                       = "Lines",
    Line                        = "Line",
    OverseaClubGvgGroupBaseNode = "OverseaClubGvgGroupBaseNode",
    UIFX_OverseaClubGvgGroup    = "UIFX_OverseaClubGvgGroup",
    UIFX_Rebirth                = "UIFX_Rebirth",
    UIFX_SafetyShield           = "UIFX_SafetyShield",
    UIFX_FireFight              = "UIFX_FireFight",
}

---@alias ClubGVGConstants.AniName string 
ClubGVGConstants.AniName = {
    HomelandTalentDetailsPopup_Cancel              = "HomelandTalentDetailsPopup_Cancel",
    HomelandTalentDetailsPopup_Choose              = "HomelandTalentDetailsPopup_Choose",
    OverseaClubGvgBtnAuto_Off                      = "OverseaClubGvgBtnAuto_Off",
    OverseaClubGvgBtnAuto_OffDefault               = "OverseaClubGvgBtnAuto_OffDefault",
    OverseaClubGvgBtnAuto_On                       = "OverseaClubGvgBtnAuto_On",
    OverseaClubGvgBtnAuto_OnDefault                = "OverseaClubGvgBtnAuto_OnDefault",
    OverseaClubGvgGroupDefeatPlayerNode_Entry      = "OverseaClubGvgGroupDefeatPlayerNode_Entry",
    OverseaClubGvgGroupRebornDetailsNode_Entry     = "OverseaClubGvgGroupRebornDetailsNode_Entry",
    OverseaClubGvgGroupRebornDetailsNode_Out       = "OverseaClubGvgGroupRebornDetailsNode_Out",
}

ClubGVGConstants.ExtraPrefabType = {
    MpaSelectAsset        = 1,
    BuildingInfoContainer = 2,
    EffectContainer       = 3,

}

---@alias ClubGVGConstants.PrefabPath string 
ClubGVGConstants.PrefabPath = {
    OverseaClubGvgGroupSafeModeCountdownPopup = "Prefabs/OverClub/OverseaClubGvgGroupSafeModeCountdownPopup.prefab",
    OverseaClubGvgGroupDefeatPlayerNode       = "Prefabs/OverClub/OverseaClubGvgGroupDefeatPlayerNode.prefab",
    OverseaClubGvgGroupRebornDetailsNode      = "Prefabs/OverClub/OverseaClubGvgGroupRebornDetailsNode.prefab",
    OverseaClubGvgBuildingInfoContainer       = "Prefabs/OverClub/OverseaClubGvgBuildingInfoContainer.prefab",
    OverseaClubGvgGroupEffectContainer        = "Prefabs/OverClub/OverseaClubGvgGroupEffectContainer.prefab",
    OverseaClubGvgGroupWatchNode              = "Prefabs/OverClub/OverseaClubGvgGroupWatchNode.prefab",
    OverseaClubGvgJumpTips                    = "Prefabs/OverClub/OverseaClubGvgJumpTips.prefab",
    -- OverseaClubGvgGroupBaseNode       = "Prefabs/OverClub/OverseaClubGvgGroupBaseNode.prefab",
    MpaSelectAsset                            = "Scenes/GVGmap/Tiles/map_gvg_line_01.asset",
}

---@alias ClubGVGConstants.LuaPath string 
ClubGVGConstants.LuaPath = {
    ClientLuaPath                             = "Game.Behaviours.LuaKLobbyClientEx",
    OverseaChatButtonNode                     = "Game.OverseaChat.OverseaChatButtonNode",
    ClubGVGGroupMainBtnTeam                   = "Game.UI.Club.GVG.View.ClubGVGGroupMainBtnTeam",
    ClubGVGTeamGroup                          = "Game.UI.Club.GVG.View.ClubGVGTeamGroup",
    ClubGVGTeamNode                           = "Game.UI.Club.GVG.View.ClubGVGTeamNode",
    ClubGVGGroupBuildingDetails               = "Game.UI.Club.GVG.View.ClubGVGGroupBuildingDetails",
    ClubGVGGroupBuildingDetailsTeamInfo       = "Game.UI.Club.GVG.View.ClubGVGGroupBuildingDetailsTeamInfo",
    ClubGVGGroupHeadNode                      = "Game.UI.Club.GVG.View.ClubGVGGroupHeadNode",
    ClubGVGGroupBuildingDetailsBattleTeam     = "Game.UI.Club.GVG.View.ClubGVGGroupBuildingDetailsBattleTeam",
    ClubGVGGroupBuildingDetailsBattleTeamCell = "Game.UI.Club.GVG.View.ClubGVGGroupBuildingDetailsBattleTeamCell",
    CommonTabToggleUp                         = "Game.Behaviours.CommonTabToggleUp",
    ClubGVGGroupBaseTeamCell                  = "Game.UI.Club.GVG.View.ClubGVGGroupBaseTeamCell",
    ClubGVGGroupBaseTeamCellIdle              = "Game.UI.Club.GVG.View.ClubGVGGroupBaseTeamCellIdle",
    ClubGVGGroupBaseTeamCellProgress          = "Game.UI.Club.GVG.View.ClubGVGGroupBaseTeamCellProgress",
    ClubGVGGroupBaseTeamCellPlayerInfo        = "Game.UI.Club.GVG.View.ClubGVGGroupBaseTeamCellPlayerInfo",
    ClubGVGGroupFightMessageCell              = "Game.UI.Club.GVG.View.ClubGVGGroupFightMessageCell",
    ClubGVGGroupFightRecordsCell              = "Game.UI.Club.GVG.View.ClubGVGGroupFightRecordsCell",
    ClubGVGGroupPlayerInfo                    = "Game.UI.Club.GVG.View.ClubGVGGroupPlayerInfo",
    ClubGVGGroupFightRecordDetailsTeamNode    = "Game.UI.Club.GVG.View.ClubGVGGroupFightRecordDetailsTeamNode",
    ClubGVGGroupRankingsNode                  = "Game.UI.Club.GVG.View.ClubGVGGroupRankingsNode",
    ClubGVGGroupRankingsRewardNode            = "Game.UI.Club.GVG.View.ClubGVGGroupRankingsRewardNode",
    ClubGVGGroupSafeModeCountdown             = "Game.UI.Club.GVG.View.ClubGVGGroupSafeModeCountdown",
    ClubGVGGroupDefeatPlayerNode              = "Game.UI.Club.GVG.View.ClubGVGGroupDefeatPlayerNode",
    VirtualCameraWidthMatcher                 = "Game.Behaviours.VirtualCameraWidthMatcher",
    ClubGVGCameraControl                      = "Game.UI.Club.GVG.ClubGVGCameraControl",
    ClubGVGGroupRebornDetailsNode             = "Game.UI.Club.GVG.View.ClubGVGGroupRebornDetailsNode",
    ClubGVGGroupBaseNode                      = "Game.UI.Club.GVG.View.ClubGVGGroupBaseNode",
    ClubGVGGroupBaseImportantNode             = "Game.UI.Club.GVG.View.ClubGVGGroupBaseImportantNode",
    ClubGVGGroupBaseNormalNode                = "Game.UI.Club.GVG.View.ClubGVGGroupBaseNormalNode",
    ClubGVGLineNode                           = "Game.UI.Club.GVG.View.ClubGVGLineNode",
    OverseaClubGVGJumpTips                    = "Game.UI.Club.GVG.View.OverseaClubGVGJumpTips",
    CameraWidthMatcher                        = "Game.Behaviours.CameraWidthMatcher",
}


---@alias ClubGVGConstants.ResourcePath string 
ClubGVGConstants.ResourcePath = {
    TileMapData = "Presets/ClubGVG/TileData_%s.json"
}

---@alias ClubGVGConstants.EventNames string 
ClubGVGConstants.EventNames = {
    RequestSuccess                  = "ClubGVG.RequestSuccess",               
    FocusHomeDialog                 = "ClubGVG.FocusHomeDialog",               
    ChangeCountDown                 = "ClubGVG.ChangeCountDown",
    ChangeStage                     = "ClubGVG.ChangeStage",
    ChangeStageStatus               = "ClubGVG.ChangeStageStatus",
    ShowBuildingDetails             = "ClubGVG.ShowBuildingDetails",
    ActivityEnd                     = "ClubGVG.ActivityEnd",
    ReceiveRecord                   = "ClubGVG.ReceiveRecord",                 --- 接受战报
    DataUpdate                      = "ClubGVG.DataUpdate",             
    ShowBannerUI                    = "ClubGVG.ShowBannerUI",                  ---显示横幅
    DrawLines                       = "ClubGVG.DrawLines",                     ---绘制线
    FocusBuilding                   = "ClubGVG.FocusBuilding",  
    ControlBuildingEff              = "ClubGVG.ControlBuildingEff",            ---控制建筑物特效
    SetCameraShowState              = "ClubGVG.SetCameraShowState",    
    ChangeBuildingDetailsShowState  = "ClubGVG.ChangeBuildingDetailsShowState",
    UpdateTaskRedPoint              = "ClubGVG.UpdateTaskRedPoint",            --- 更新任务红点
    ChangeOrthographicSize          = "ClubGVG.ChangeOrthographicSize",        
    ClinetContentTimeout            = "ClubGVG.ClinetContentTimeout",          -- 长连接超时
}

---@alias ClubGVGConstants.Stage number 
ClubGVGConstants.Stage = {
    Unopened  = 0, -- 未开启
    Apply     = 1, -- 报名阶段
    Preview   = 2, -- 战前预览
    Batting   = 3, -- 战斗中
    Result    = 4, -- 结算
}

---@alias ClubGVGConstants.StageStatus number 
ClubGVGConstants.StageStatus = {
    Non                             = 0,
    --- 准备阶段 未编辑队伍
    PrepareAndUneditedTeam          = 1,
    --- 准备阶段 编辑队伍完成
    PrepareComplete                 = 2,
    --- 战斗阶段 未编辑队伍
    BattleStageAndUneditedTeam      = 3,
    --- 战斗阶段 未加入战场
    BattleStageAndNonAcceded        = 4,
    --- 在战场里
    InBattle                        = 5,
    
}

---@alias ClubGVGConstants.PlayerStatus number 
ClubGVGConstants.PlayerStatus = {
    Marching          = 1, --- 行军中
    Suspend           = 2, --- 驻守
    SuccessiveVictory = 3, --- 连续胜利
}

---@alias ClubGVGConstants.BuildingStatus number 
ClubGVGConstants.BuildingStatus = {
    Non                    = 0, --- 无状态 （工会死亡 玩家死亡）
    CanMarch               = 1, --- 能行军
    Marching               = 2, --- 玩家要行军到这里
    AttackBuildingOrPlayer = 3, --- 可进攻建筑或玩家
}

---@alias ClubGVGConstants.BuildingStatusLabelType number 
ClubGVGConstants.BuildingStatusLabelType = {
    Attack   = 1, ---战斗列
    Defense  = 2, ---防守列
    Battling = 3, ---对战列
}

---@alias ClubGVGConstants.PackageId number 
ClubGVGConstants.PackageId = {
    PlayerEnterGVG         = 6100,
    Report                 = 6101, ---战报同步通知
    WinningStreak          = 6102, --- 连胜通知
    KillWinningStreak      = 6103, --- 终结连胜通知（双方工会的）
    PlayerEnterGVGSuccess  = 6104, --- 连接成功
}

---@alias ClubGVGConstants.ReportId number
ClubGVGConstants.ReportId = {
    ---加入战场
    Join                  = 1,    
    ---行军
    March                 = 2,    
    ---加速行军
    Accelerate            = 3,    
    ---攻击建筑(砍血)
    Building_Atk          = 4,    
    ---建筑物归属变化
    Building_Change       = 5,    
    ---攻击玩家
    Player_Atk            = 6,    
    ---攻击玩家结果
    Player_Atk_Over       = 7,    
    ---玩家死亡
    Player_Die            = 8,    
    ---建筑物归属变化多次
    Building_Change_Multi = 9,

}

---@alias ClubGVGConstants.TriggerType number 
ClubGVGConstants.TriggerType = {
    ---阶段改变
    Stage_Change              = 1, 
    ---加速行军完成
    Accelerate_Complete       = 2,  
    ---行军完成
    March_Complete            = 3,      
    ---攻击 建筑 限制移除 （战报逻辑）
    Atk_Building_Limit_Remove          = 5,
    ---攻击 玩家 限制移除 （战报逻辑）
    Atk_Player_Limit_Remove          = 7,
    ---攻击 限制移除 （由于触发Atk_Limit_Remove前后端吧数据弄成最新的 此类型只做移除玩家限制 初始化进攻数据时使用）
    Atk_Limit_Remove          = 8,
    ---复活完成
    Rebirth_Limit_Remove      = 9,
    ---保护罩时间到期
    Protection_Period_Limit_Remove = 10, 
    ---复活完成
    Rebirth_Effect_Remove      = 11,
}


---@alias ClubGVGConstants.RankingLabelType number 
ClubGVGConstants.RankingLabelType = {
    Club   = 1, --- 工会排行
    Player = 2, --- 玩家排行
}

---@alias ClubGVGConstants.BannerType number 
ClubGVGConstants.BannerType = {
    AttackPlayer      = 1, --- 进攻玩家
    DefeatPlayer      = 2, --- 击败玩家
    WinningStreak     = 3, --- 连胜
    KillWinningStreak = 4, --- 终结连胜
}

---死亡原因
---@alias ClubGVGConstants.PlayerDieType number 
ClubGVGConstants.PlayerDieType = {
    Battle        = 1, ---战斗
    Hp            = 2, ---精力耗尽
    Club          = 3, ---工会团灭
    CommitSuicide = 4, --- 自杀
}

---战报状态
---@alias ClubGVGConstants.ReportState number 
ClubGVGConstants.ReportState = {
    Discard = 1, --- 丢弃
    Update  = 2, --- 更新
    Reset   = 3, --- 重置
}

---地图缩放类型
---@alias ClubGVGConstants.MapScaleType number 
ClubGVGConstants.MapScaleType = {
    Default     = 0, --- 默认
    First       = 1, --- 一级
    Secondary   = 2, --- 二级
}

return ClubGVGConstants
