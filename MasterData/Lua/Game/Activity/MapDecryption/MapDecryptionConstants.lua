---@class MapDecryptionConstants
local MapDecryptionConstants = {

    LoadingParams = {
        Name      = "SpecifySceneLoadingPanel",
        EnvPath   = "Game.Behaviours.SpecifySceneLoadingPanel",
        -- Position  = Vector3.zero,
        -- Scale     = Vector3.one,
        -- Rotation  = Quaternion.identity
    },

    EventNames    = {
        SwitchExploreOrTracking           = "MapDecryption.SwitchExploreOrTracking",
        ActivityEnd                       = "MapDecryption.ActivityEnd",
        ActivityClose                     = "MapDecryption.ActivityClose",
        CreateBubbleSuccess               = "MapDecryption.CreateBubbleSuccess",                
        ChangeRoleStatus                  = "MapDecryption.ChangeRoleStatus",
        ShowBubble                        = "MapDecryption.ShowBubble",
        HideBubble                        = "MapDecryption.HideBubble",
        RestoreBubble                     = "MapDecryption.RestoreBubble",
        RestoreNpcStatus                  = "MapDecryption.RestoreNpcStatus",
        ShowOptions                       = "MapDecryption.ShowOptions",
        HideOptions                       = "MapDecryption.HideOptions",
        QuitOptions                       = "MapDecryption.QuitOptions",
        Gossip                            = "MapDecryption.Gossip",
        SelectGossip                      = "MapDecryption.SelectGossip",
        ChangeCameraControlMode           = "MapDecryption.ChangeCameraControlMode",
        ClickAntiqueNode                  = "MapDecryption.ClickAntiqueNode",
        RequestSuccess                    = "MapDecryption.RequestSuccess",
        ExploreMapId                      = "MapDecryption.ExploreMapId",
        TrackQuestId                      = "MapDecryption.TrackQuestId",
        PlayModelAction                   = "MapDecryption.PlayModelAction",
        HandleFunctionEnter               = "MapDecryption.HandleFunctionEnter",
        PCControllerF                     = "MapDecryption.PCController.F",
        PCControllerSwitchOption          = "MapDecryption.PCController.SwitchOption",
        PCControllerCheckOptionHightlight = "MapDecryption.PCController.CheckOptionHightlight",
        TimeChanged                       = "MapDecryption.TimeChanged",
        ReInitEasyTouch                   = "MapDecryption.ReInitEasyTouch",
        MaidCoffee_Change_Run_State       = "MaidCoffee_Change_Run_State",
        MazeUI2D                          = "MazeUI2D",
        
        ControlPlayerInputStatus          = "MapDecryption.ControlPlayerInputStatus",
        ChangeCamController               = "MapDecryption.ChangeCamController",
        UpdateRoleInputStatus             = "MapDecryption.UpdateRoleInputStatus",
        RestoreBrainBlend                 = "MapDecryption.RestoreBrainBlend",
    },

    DefaultImgAssets = {
        TrackingBoss   = "Arts/Textures/SpringFestival/spring_track_monster_icon00.png",
    },

    RoleSpinePath = {
        Neck  = "Unity_Export_Grp/DeformationScale_Grp/DeformationSystem/root_move_jnt/actor_move_jnt/Root_M/Spine1_M/Chest_M/UpperChest/Neck_M",
        Chest = "Unity_Export_Grp/DeformationScale_Grp/DeformationSystem/root_move_jnt/actor_move_jnt/Root_M/Spine1_M/Chest_M",
        EyeL  = "Unity_Export_Grp/DeformationScale_Grp/DeformationSystem/root_move_jnt/actor_move_jnt/Root_M/Spine1_M/Chest_M/UpperChest/Neck_M/Head_M/Eye_L",
        EyeR  = "Unity_Export_Grp/DeformationScale_Grp/DeformationSystem/root_move_jnt/actor_move_jnt/Root_M/Spine1_M/Chest_M/UpperChest/Neck_M/Head_M/Eye_R",
        Head  = "Unity_Export_Grp/DeformationScale_Grp/DeformationSystem/root_move_jnt/actor_move_jnt/Root_M/Spine1_M/Chest_M/UpperChest/Neck_M/Head_M"
    },

    PrefabPath = {
        ScenePlayer                    = "Prefabs/SpringFestival%s/SpringFestivalScenePlayer.prefab",
        -- ScenePlayer                    = "Prefabs/MaidCoffee/HumanPlayer.prefab",
        SceneVirtualCamera             = "Prefabs/SpringFestival%s/SpringFestivalSceneVirtualCamera.prefab",
        ScenePositions                 = "Prefabs/SpringFestival%s/SpringFestivalScenePositions.prefab",

        MapExploreNode                 = "Prefabs/SpringFestival%s/SpringFestivalMapExploreNode.prefab",
        MapTrackingNode                = "Prefabs/SpringFestival%s/SpringFestivalMapTrackingNode.prefab",
        AntiqueRestorationLabelNode    = "Prefabs/SpringFestival%s/SpringFestivalAntiqueRestorationLabelNode.prefab",
        AntiqueRestorationProgressNode = "Prefabs/SpringFestival%s/SpringFestivalAntiqueRestorationProgressNode.prefab",
        ConversationOptions            = "Prefabs/SpringFestival%s/SpringFestivalConversationOptions.prefab",
        RoleDialogueBubble             = "Prefabs/SpringFestival%s/SpringFestivalRoleDialogueBubble.prefab",
        OptionNode                     = "Prefabs/SpringFestival%s/SpringFestivalConversationOptionNode.prefab",
        DialogueNode                   = "Prefabs/SpringFestival%s/SpringFestivalConversationDialogueNode.prefab",
        TalkingNode                    = "Prefabs/Common/TalkingNode.prefab",
        BoyProtagonistController       = "RuntimeController/roleController_simple_lua.controller",
        GirlProtagonistController      = "RuntimeController/girlController_simple_lua2.controller"
    },

    VCameraBlenderSettingsPath = "Presets/SpringFestivalVCameraBlenderSettings.asset",
    UIBlack_ManualPath = "Prefabs/Common/UIBlack_Manual.prefab",

    EnvPath = {
        BubbleNode               = "Game.Activity.MapDecryption.Interaction.MapDecryptionRoleDialogueBubble",
        ConversationOptionNode   = "Game.Activity.MapDecryption.Interaction.MapDecryptionConversationOptionNode",
        ConversationOptionNodes  = "Game.Activity.MapDecryption.Interaction.MapDecryptionConversationOptions",
        ConversationDialogueNode = "Game.Activity.MapDecryption.Interaction.MapDecryptionConversationDialogueNode",
        TalkingNode              = "Game.Behaviours.TalkingNode",

        AntiqueModelController   = "Game.Activity.MapDecryption.AntiqueRestoration.MapDecryptionAntiqueModelController",
        
        ExplorePanelListCell     = "Game.Activity.MapDecryption.ExploreTracking.MapDecryptionExplorePanelListCell",
        ExplorePanel             = "Game.Activity.MapDecryption.ExploreTracking.MapDecryptionExplorePanel",
        TrackingPanel            = "Game.Activity.MapDecryption.ExploreTracking.MapDecryptionTrackingPanel",
        MapExploreNode           = "Game.Activity.MapDecryption.ExploreTracking.MapDecryptionMapExploreNode",
        MapTrackingNode          = "Game.Activity.MapDecryption.ExploreTracking.MapDecryptionMapTrackingNode",
        -- CameraInput              = "Game.Behaviours.CameraInputCN",
        -- ETCJoystick              = "Game.Behaviours.ETCJoystickCN",

        CameraInput              = "Game.Behaviours.CameraInput",
        ETCJoystick              = "Game.Behaviours.ETCJoystick",

        CameraParamsController   = "Game.Behaviours.CameraParamsController",
    },

    SceneDefine = {
        ScenePlayerNode          = "ScenePlayerNode",
        SceneVirtualCameraNode   = "SceneVirtualCameraNode",
        ScenePositionsNode       = "ScenePositionsNode",

        HumanPlayer              = "HumanPlayer",

        NPCLayerTag              = "Avatars",
        WorldSpaceCanvasName     = "worldSpaceCanvas",
        ExploreCamera            = "ExploreCamera",
        PrefixExploreCamera      = "PrefixExploreCamera",
        TrackingCamera           = "TrackingCamera",
        PrefixTrackingCamera     = "PrefixTrackingCamera",
        AntiqueRestorationCamera = "AntiqueRestorationCamera",
        StoreCamera              = "StoreCamera",
        PrefixStoreCamera        = "PrefixStoreCamera",
        TrackingPositions        = "TrackingPositions",
        ExplorePositions         = "ExplorePositions",
        AntiquePositions         = "AntiquePositions",
        AntiqueCameraPositions   = "AntiqueCameraPositions",
        AntiqueLabelNodePositions   = "AntiqueLabelNodePositions",
        AntiqueTipsNodePositions  = "AntiqueTipsNodePositions",
        NonPlayerCharacters      = "NonPlayerCharacters",
        PlayerCharacter          = "PlayerCharacter",

        Human                    = "Human",
        CameraInput              = "CameraInput",
        PlayerInput              = "PlayerInput",

        Protagonist              = "Protagonist",
        RoleParams               = "RoleParams",
        LookAtIKAndController    = "LookAtIKAndController",
        LookAtIK                 = "LookAtIK",
        NPCLookAtTarget          = "NPCLookAtTarget",
        Center                   = "_center_",
        CMFreeLook               = "CMFreeLook",
        LocationVirtualCamera    = "LocationVirtualCamera",
        LocationVirtualCameraPath = "HumanPlayer/Human/LocationVirtualCamera",
        DialogueOptions          = "DialogueOptions",
        UICameraParamsContoller  = "UICameraParamsContoller",
        MainCamera               = "MainCamera",

        NpcRoot                  = "NpcRoot",
        NpcName                  = "Npc",
        NPCParams                = "NPCParams",
        NpcTargetName            = "PlayerLookAtTarget",
        NpcTriggerNode           = "TriggerNode",
        SceneAllCollider          = "box_collider",
        
    },

    MapNodeEventType = {
        -- 事件类型：0无，1初始点，2主线剧情，3对话剧情，4机关点，5宝箱点，6战斗点
        Normal        = 0,     --- 无
        Initial       = 1,     --- 初始点
        MainPlot      = 2,     --- 主线剧情
        DialogPlot    = 3,     --- 对话剧情
        Trap          = 4,     --- 机关点
        TreasureChest = 5,     --- 宝箱点
        Battle        = 6,     --- 战斗点
    },

    ---@class MapDecryptionConstants.FunctionEnterType
    FunctionEnterType = {
        ----------------------------
        --- 配表
        Explore            = 1,   ---探索望月城
        Tracking           = 2,   ---追踪傀化物
        AntiqueRestoration = 3,   ---古物修复
        Turntable          = 4,   ---新年转盘
        Store              = 5,   ---新年大促
        Gossip             = 6,   ---闲聊
        Quit               = 7,   ---再见

    },

    TalkSceneType = {
        ClickBubble     = 1,   --- 点击交互气泡时
        EnterStore      = 9,   --- 进入新年商店界面时
        EnterTurntable  = 10,  ---进入新年转盘界面时
        BuyGoods        = 11,  ---在新年商店中购买物品时
        Turn            = 12,  ---在新年转盘中转动轮盘时
    },

    ExploreTrackingSubViewType = {
        Explore  = 1,
        Tracking = 2
    },

    ReceiveStatus = {
        NotComplete = 0,  --- 未完成
        CanReceive  = 1,  --- 能领取
        Received    = 2,  --- 已领取
    },

    InteractiveId = {
        1, --- 云灿
        2, --- 云沛
        3, --- 小玲
    },

    NPCStatus = {
        Normal     = 0, --- 人物在碰撞器外
        Display    = 1, --- 展示自身名字
        LookUpFace = 2, --- 看下玩家
        Dialogue   = 3, --- 对话
    },

    ParamsIds = {
        LookAtFaceDistancePercentage = 3, --- look at效果开启距离（已交互NPC为原点的半径距离）
        DialogueDistancePercentage   = 4, --- 出交互气泡的开启距离（已交互NPC为原点的半径距离）
        LookAtMaxAngle               = 5,
        TurnMinAngle                 = 6,
    },

    ControllerCompType = {
        Antique         = 2,
        ExploreTracking = 3,
    },

    EventResult = {
        AntiqueRestore         = 1, --- 古物修复         需要古物修复表id
        FindAntique            = 2, --- 发现古物         需要古物修复表id
        UnlockTrackQuest       = 3, --- 解锁追踪关卡      需要追踪关卡表id
        FindMap                = 4, --- 发现新地图        需要解密地图表id
        CompleteMapExploration = 5, --- 完成地图探索      需要解密地图表id
    },

    InteractStatus = {
        None     = 0, --- 空
        Dialogue = 1, --- 对话
        Option   = 2, --- 选项
        Gossip   = 3, --- 闲聊
    }

}

return MapDecryptionConstants