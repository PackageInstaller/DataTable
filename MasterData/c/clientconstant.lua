---@diagnostic disable: undefined-global

--require("Config").Load()

Config.UI = {
    Login_ServerList     = "UI/ServerList.prefab",
}


TypeInfo = {
    Canvas = typeof(UnityEngine.Canvas),
    GraphicRaycaster = typeof(UnityEngine.UI.GraphicRaycaster),
    GameObject = typeof(UnityEngine.GameObject),
    Transform = typeof(UnityEngine.Transform),
    Image = typeof(UnityEngine.UI.Image),
    RectTransform = typeof(UnityEngine.RectTransform),
    Button = typeof(UnityEngine.UI.Button),
    Text = typeof(UnityEngine.UI.Text),
    RawImage = typeof(UnityEngine.UI.RawImage),
    Toggle = typeof(UnityEngine.UI.Toggle),
    Slider = typeof(UnityEngine.UI.Slider),
    Scrollbar = typeof(UnityEngine.UI.Scrollbar),
    Dropdown = typeof(UnityEngine.UI.Dropdown),
    InputField = typeof(UnityEngine.UI.InputField),
    ScrollRect = typeof(UnityEngine.UI.ScrollRect),
    CanvasGroup = typeof(UnityEngine.CanvasGroup),
    ToggleGroup = typeof(UnityEngine.UI.ToggleGroup),
    CanvasRenderer = typeof(UnityEngine.CanvasRenderer),
    DontFade = typeof(DontFade),
    RichText = typeof(MyRichText.RichText),
    MapScrollController = typeof(MapScrollController),
    ContentSizeFitter = typeof(UnityEngine.UI.ContentSizeFitter),
    RichEditorBox = typeof(RichEditorBox),
    RichScrollText = typeof(MyRichText.RichScrollText),
    TabToggle = typeof(TabToggle),
    GridLayoutGroup = typeof(UnityEngine.UI.GridLayoutGroup),
    LayoutGroup = typeof(UnityEngine.UI.LayoutGroup),
    Animator = typeof(UnityEngine.Animator),
    DClick = typeof(DClick),
    ConnectionManager = typeof(ConnectionManager),
    LineRendererAnimation = typeof(LineRendererAnimation),
    Connection = typeof(Connection),
    Animation = typeof(UnityEngine.Animation),
    VerticalLayoutGroup = typeof(UnityEngine.UI.VerticalLayoutGroup),
    Renderer = typeof(UnityEngine.Renderer),
    UTableView = typeof(UTableView),
    UTableCell = typeof(UTableCell),
    UIAudio = typeof(UIAudio),
    TextMeshProUGUI = typeof(TMPro.TextMeshProUGUI),
    MarqueeText = typeof(MarqueeText),
    RubyTextMeshProUGUI = typeof(TMPro.RubyTextMeshProUGUI),
    ClickListener = typeof(ClickListener),
    DragListener = typeof(DragListener),
    PointerListener = typeof(PointerListener),
    SkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic),
    ClickLongPressListener = typeof(ClickLongPressListener),
    LayoutElement = typeof(UnityEngine.UI.LayoutElement),
    ParticleSystem = typeof(UnityEngine.ParticleSystem),
    ParticleSystemRenderer = typeof(UnityEngine.ParticleSystemRenderer),
    ScaleButton = typeof(ScaleButton),
    AnimOverCallBack = typeof(AnimOverCallBack),
    AutoScrollRawImageUV = typeof(AutoScrollRawImageUV),
    UIRaycastClick = typeof(UIRaycastClick),
    SkeletonAnimation = typeof(Spine.Unity.SkeletonAnimation),
    TextLink = typeof(TextLink),
    TMP_InputField = typeof(TMPro.TMP_InputField),
    HorizontalLayoutGroup = typeof(UnityEngine.UI.HorizontalLayoutGroup),
    DrawInputController = typeof(DrawInputController),
    UICircularScrollView = typeof(CircularScrollView.UICircularScrollView),
    NavMeshAgent = typeof(UnityEngine.AI.NavMeshAgent),
    SetSpineAnimation = typeof(SetSpineAnimation),
    PlayableDirector = typeof(UnityEngine.Playables.PlayableDirector),
    PlayableAsset = typeof(UnityEngine.Playables.PlayableAsset),
    TimeLineMgr = typeof(TimeLineMgr),
    DestroyWithCallback = typeof(DestroyWithCallback),
    LookRectScroll = typeof(LookRectScroll),
    LoopListView2 = typeof(SuperScrollView.LoopListView2),
    LoopGridView = typeof(SuperScrollView.LoopGridView),
    CameraMoveControl = typeof(CameraMoveControl),
    Camera = typeof(UnityEngine.Camera),
    LineRenderer = typeof(UnityEngine.LineRenderer),
    CinemachineVirtualCamera = typeof(Cinemachine.CinemachineVirtualCamera),
    UniWebView = typeof(UniWebView),
    PlanarReflectionController = typeof(PlanarReflectionController),
    AutoAdjustCanvasRoot = typeof(AutoAdjustCanvasRoot),
    Typewriter = typeof(Typewriter),
    RectMask2D = typeof(UnityEngine.UI.RectMask2D),
    TextProxy = typeof(TextProxy),
    LuaMono = typeof(LuaMono),
    TextBatcher = typeof(TextBatcher),
    CoveAnimation = typeof(CoveActingSystem.CoveAnimation),
    CoveSpine = typeof(CoveActingSystem.CoveSpine),
    CoveFunctionBuilding = typeof(CoveFunctionBuilding),
    RenderTextureBindCamera = typeof(RenderTextureBindCamera),
}

if EngineGlobal.GetPlatformName() == "WebGL" then
    TypeInfo.ClickLongPressListener = typeof(ClickLongPressListener)
end

Config.DefaultWhite = Color.New(255/255, 255/255, 255/255)
Config.DefaultDisabled = Color.New(140/255, 140/255, 140/255)

Config.DefaultWhiteStr = Config.DefaultWhite:ToHexStr()

-- Config.QualityColor = {
--     [Quality.White] = Config.DefaultWhite,
--     [Quality.Green] = Color.New(68/255,214/255,70/255),
--     [Quality.Blue] = Color.New(71/255,156/255,223/255),
--     [Quality.Purple] = Color.New(167/255,77/255,242/255),
--     -- [Quality.Purple] = Color.New(139/255,94/255,1),
--     [Quality.Orange] = Color.New(216/255,140/255,69/255),
--     [Quality.Red] = Color.New(226/255,18/255,18/255),
-- }

function Config.GetQualityColor(quality)
    if not quality then
        LuaLogger.w("quality is nil")
        quality = Quality.White
    end

    local color = Config.QualityColor[quality]
    if not color then
        LuaLogger.e("QualityColor %d hasn't been defined", quality)
    end

    return color
end

Config.AudioPath = {
    NormalButton = "Audio/UI/click.mp3",
    TabButton = "Audio/UI/click_tab.mp3",

    Main = "Audio/BGM/bgm_base_room.mp3",
    Main2 = "Audio/BGM/bgm_main_2.ogg",

    CatSound = {
        "Audio/Battle/cat1.mp3",
        "Audio/Battle/cat2.mp3",
        "Audio/Battle/cat3.mp3",
        "Audio/Battle/cat4.mp3"
    },
    BGM = "Audio/BGM/%s.wav",                   --背景音乐
    CharacterVoice = "Audio/RoleDialogue/%s",   --角色语音
    CharacterVoiceJP = "Audio/RoleDialogueJP/%s", --角色日语语音
    SE = "Audio/SE/%s.wav",                     --音效
    StorySE = "Audio/StorySE/%s.wav",           --剧情音效
    RoleMove = "Audio/SE/move.wav" ,            --角色移动音效
}

Config.AssetFile = {
    CurveLibrary = "AssetFile/CurveLibrary.asset"
}

Config.ResPath = {
    OrePath = "UI/Game/Mine/ore_%d.png",
    FursDataPath = "Config/Room/%s.bytes",
    TrashesDataPath = "Config/Room/%d_trashes.bytes",
    TrashDeleteEffectPath = "Prefabs/Effect/Battle/Common/MaoShe_Effect/Effect_MaoShe_DaSao.prefab",
    AwardFurEffectPath = "Prefabs/Effect/Battle/Common/MaoShe_Effect/Effect_MaoShe_JuGuangDeng.prefab",
}

Config.FontMaterialPath = {
    ZXHLYT_SDF_9f100e_03 = "<material=\"ZXHLYT_SDF_9f100e_03\">%s</font>",
    ZXHLYT_SDF_726a5e_03 = "<material=\"ZXHLYT_SDF_726a5e_03\">%s</font>",
    ZXHLYT_SDF_98620e_03 = "<material=\"ZXHLYT_SDF_98620e_03\">%s</font>",
    ZXHLYT_SDF_518937_03 = "<material=\"ZXHLYT_SDF_518937_03\">%s</font>",
    ZXHLYT_SDF_553618_03 = "<material=\"ZXHLYT_SDF_553618_03\">%s</font>",
}

Config.ResIconSpritePath = {
    res_2 = "<sprite=2>",       --金币
    res_11 = "<sprite=1>",      --钻石
    res_6 = "<sprite=0>",       --体力
    res_100 = "<sprite=3>",     --抽卡券
}

Config.SpritePath = {
    coveBtn = "Sprite/CoveBtn/btn_building_icon_%s.png",    --家园按钮图
    roleRankBg = "Sprite/Character/buttom/common_charM_lv%s_buttom.png",       --角色品质背景
    roleRankFarmeBg = "Sprite/Character/frame/common_charM_lv%s_frame.png",       --角色品质框
    roleNewRankFarmeBg = "Sprite/Character/frameLittle/char_poster_box_frame0%s.png",       --角色新品质框
    roleLevelIcon = "Sprite/Character/Star/char_classimg_0%s.png",              --角色等级图标
    roleQualityIcon = "Sprite/Character/QualityIcon/common_charquality_%s.png",          --角色品质图标
    RoleSStarIcon = "Sprite/Character/StarS/common_chars_level_%s.png",              --角色等级图标(小)
    RankBgSmall = "Sprite/Character/RankBgSmall/common_charS_lv%s_buttom.png",       --角色品质背景(小)
    RankFrameSmall = "Sprite/Character/RankFrameSmall/common_charS_lv%s_frame.png",       --角色品质框(小)
    ItemRankFarme = "Sprite/Item/RangeBox/common_equipmentbox_lv1_0%s.png",              --道具品质外边框
    ItemRankFarme2 = "Sprite/Item/RangeBox/common_equipmentbox_lv2_0%s.png",              --道具品质外边框
    ItemRankFarme3 = "Sprite/Item/RangeBox/mall_propshop_select_quality%s.png",              --道具品质外边框
    EquipShowRankBg = "Sprite/Equipment/EquipmentBox/equipment_box_0%s.png",            --道具展示背景

    EquipShowNull = "Sprite/Equipment/equipment_box_00_1.png",                         --装备展示背景空状态
    EquipShowHas = "Sprite/Equipment/equipment_box_00_2.png",                           --装备展示背景拥有状态
    RolePortrait = "Sprite/Character/img/%s/Portrait/character_%s.png",         --角色立绘
    RoleBreakPortrait = "Sprite/Character/img/%s_b/Portrait/character_%s_b.png",         --角色突破立绘
    RoleIcon = "Sprite/Character/Icon/%s.png",    --通用头像
    StoryRoleIcon = "Sprite/Character/img/%s/Icon/character_%s.png",    --角色头像只填cid调用情况

    HomeIcon = "Sprite/HomeIcon/building_%s.png",    --建筑图片
    HomeFunQuickIcon = "Sprite/HomeIcon/building_quick_%s.png",    --建筑图片
    ProsperityBuildIcon = "Sprite/HomeIcon/%s.png",    --繁荣建造图标

    TypeBtnIconOn = "Sprite/WareHouse/warehouse_tagicon_%s.png",            --仓库开启toggle
    TypeBtnIconOff = "Sprite/WareHouse/warehouse_tagicon_%s_1.png",          --仓库关闭toggle
    TechnologyTreeIcon = "Sprite/TechnologyTreePoint/%s.png",              --科技树点图标
    RolePeculiarity = "Sprite/Character/Peculiarity/char_camp_wordsbtn_%s.png",             --角色tag底图
    RoleFrameLittle = "Sprite/Character/frameLittle/char_camp_sametype_char_quality%s.png",     --角色圆形边框
    
    itemRankLine = "Sprite/Item/ItemMsgBg/warehouse_icon_quality_%s.png",             --仓库用品质线条
    StarLevelImg = "Sprite/Character/StarS/risingstar_img_%s.png",             --升星图标
    ItemIconPath = "Sprite/Item/ItemIcon/%s.png",                               --道具图标
    ItemIconPathSmall = "Sprite/Item/ItemIcon/%s_s.png",                        --道具图标小图
    TechnologyTreePath = "Sprite/TechnologyTree/%s.png",                               --科技树
    WeaponIconPath = "Sprite/Item/WeaponIcon/%s.png",                           --武器图标
    WeaponTypePath = "Sprite/Weapon/WeaponType/weapon_typeicon0%s.png",         --武器类型图标
    EquipIconPath = "Sprite/Item/EquipIcon/%s.png",                          --装备图标

    AttributeIcon = "Sprite/Attributes/attributes_icon_00%s.png",               --词条图标
    AttributeIconName = "Sprite/Attributes/%s.png",                             --词条名称图标
    SkillrePlacBg = "Sprite/Character/SkillrePlace/skillreplace_type0%s.png",       --技能类型底图
    SkillTypeBg = "Sprite/Character/SkillTypeBg/skillreplace_labelbox0%s.png",       --技能范围底图
    SkillIconPath = "Sprite/SkillIcon/%s.png",                                      --技能图标

    CutRoleLPath = "Sprite/Character/img/%s/CutRoleL/%s.png",           --角色大尺寸裁图 （文件夹名，文件名）
    CutRolePath = "Sprite/Character/img/%s/CutRole/%s.png",             --角色中等裁图 （文件夹名，文件名）
    IconRolePath = "Sprite/Character/img/%s/Icon/%s.png",               --角色头像
    ActivityBgPath = "Sprite/ActivityBg/%s.png",               --活动界面背景
    PortraitRolePath = "Sprite/Character/img/%s/Portrait/%s.png",       --角色立绘
    BannerRolePath = "Sprite/Character/img/%s/Banner/%s.png",       --角色立绘
    EquipBasePic = "Sprite/Character/EquipBasePic/EquipBasePic_%s.png",            --装备基础图标 （文件名）

    RoleTypeIconPath = "Sprite/Character/TypeIcon/attribute_%s.png",                --角色类型图标
    RoleTypeIconPathSmall = "Sprite/Character/TypeIcon/attribute_%s_s.png",         --角色类型图标(小)
    RoleTypeBgPath = "Sprite/Character/ShipType/techtree_ship_type_0%s.png",        --角色类型背景
    LevelTypeIconPath = "Sprite/Level/TypeIcon/img_principalline_icon0%s.png",      --关卡类型图标
    LevelMapPicturePath = "Sprite/Level/MapPicture/%s.png",                --关卡地图图片
    LevelDeepTypeIconPath = "Sprite/Level/DeepType/materiallevels_deeptype%s.png",--细分类型图标
    EnemyFrameIconPath = "Sprite/Character/EnemyFrame/img_principalline_enemyframe0%s.png",         --敌人品质框

    RankTypeIconPath = "Sprite/Character/RankIcon/warehouse_btn_%s.png",                --角色品质图标
    RankTypeOffIconPath = "Sprite/Character/RankIcon/warehouse_btnOff_%s.png",          --角色品质图标 （灰
    RaffleQualityBg = "Sprite/Character/Raffle/ShowCharBg/show_img_bj0%s.png",          --抽卡角色品质背景
    RaffleQualityBgMask = "Sprite/Character/Raffle/ShowCharBgMask/show_img_rolemask0%s.png",--抽卡角色品质背景遮罩
    RaffleQualityTips = "Sprite/Character/Raffle/ShowCharTips/show_img_line0%s.png",    --抽卡角色品质tips
    RaffleShowRare = "Sprite/Character/Raffle/ShowCharType/show_img_type%s.png",    --抽卡角色品质tips
    RaffleBoxBg = "Sprite/Character/Raffle/CharBox/show_img_rolebox0%s.png",            --抽卡角色品质框
    RaffleBoxMask = "Sprite/Character/Raffle/CharBoxMask/show_img_rolebox_mask0%s.png", --抽卡角色品质框遮罩
    RaffleBoxIndex = "Sprite/Character/Raffle/ShowCharIndex/show_img_number%s.png",     --抽卡角色序号
    RaffleNationBg = "Sprite/Character/Raffle/NationBg/show_nation_bg%s.png",         --抽卡角色阵营背景
    RafflePoolName = "Sprite/Character/Raffle/PoolName/%s.png",          --卡池名称
    RaffleTimeBg = "Sprite/Character/Raffle/PoolTimeBg/%s.png",        --卡池时间背景
    RaffleRoleInfoBg = "Sprite/Character/Raffle/RoleInfoBg/roleinfo_img_bj0%s.png",  --抽卡角色信息背景
    RaffleToggleIcon = "Sprite/Character/Raffle/PoolToggle/%s.png",     --卡池图标
    RafflePoolChar = "Sprite/Character/Raffle/PoolChar/%s.png",     --卡池角色图标

    MaterialLevelType = "Sprite/Level/MaterialLevelType/%s.png",  --资源细分类型图标
    MaterialLevelBanner = "Sprite/Level/MaterialLevelBanner/%s.png",  --资源细分类型banner
    MaterialChapterType = "Sprite/Level/MaterialChapterType/%s.png",  --资源章节类型图标

    BannerIconPath = "Sprite/Banner/%s.png",                --banner图片路径

    AVGScene = "Sprite/Story/Background/%s/%s.png",      --avg剧情背景路径
    AVGPicture = "Sprite/Story/Picture/%s.png",         --avg剧情图片路径

    SkinTagBgPath = "Sprite/SkinTag/skin_img_labelbox0%s.png",              --皮肤tag背景图
    SkinAnimIconPath = "Sprite/Character/AnimIcon/AnimIcon_%s.png",         --皮肤动画图标
    TreeIconPath = "Sprite/Character/TreeIcon/skilltree_node_icon0%s.png",      --技能树格子图标
    MsgTitlePath = "Sprite/MsgBoxTitle/msg_titleicon%s.png",          --MsgBox标题图标

    SeaMapBgImgPath = "Sprite/SeaMap/%s.png",          --海图背景图

    --邮件类型图标
    MailTypePath = {
        Reward = "Sprite/MailTypeIcon/mail_img_gift.png",
        Rewarded = "Sprite/MailTypeIcon/mail_img_gift_get.png",
        NotRead = "Sprite/MailTypeIcon/mail_img_mail01.png",
        Read = "Sprite/MailTypeIcon/mail_img_mail01_get.png",
    },

    --加载背景图
    LoadingBg = "Sprite/LoadingBg/%s/%s.png",      --加载背景图    

    --Buff图标
    BuffIconPath = "Sprite/BuffIcon/%s.png",

    --地块标签
    BattleBlockTagPath = "Sprite/BattleBlockTag/img_tag_%s.png",
    BattleBlockDefAddPath = "Sprite/BattleBlockDefAdd/%s.png",
    --技能类型图标
    SkillTypeIconPath = "Sprite/SkillType/atticon_%s.png",
    --技能克制图标
    SkillCounterIconPath = "Sprite/SkillCount/battle_scene_situation_%s.png",
    --Boss登场特效名称贴图路径
    BossEffectIconPath = "Sprite/BattleBossEffect/%s.png",
    --资源条背景路径
    ResBoxBgPath = "Sprite/ResBg/main_resbox%s.png",
    --角色阵营图标
    CharacterNationPath = "Sprite/Nation/Nation_%s.png",

    --商店物品图标
    shopItem = "Sprite/ShopItem/%s.png",

    --模拟演习关卡难度背景图标
    SimulatedLevelTypeBg = "Sprite/SimulatedLevel/TypeBox/tower_btn_level0%s.png",

    --模拟演习关卡序号图标
    SimulatedLevelNumIcon = "Sprite/SimulatedLevel/LevelNum/tower_img_number0%s.png",

    --模拟演习关卡难度英文图标
    SimulatedLevelEngIcon = "Sprite/SimulatedLevel/TypeEng/tower_img_word0%s.png",

    --模拟演习关卡buff背景图标
    SimulatedLevelBuffBg = "Sprite/SimulatedLevel/BuffBox/tower_img_genbox0%s.png",

    --说明界面示意路径
    InstructionsTypeIconPath = "Sprite/Instructions/%s.png",  --说明类型图标

    --引导半身像
    GuideRoleIcon = "Sprite/Guide/guide_role_%s.png",

    --时间对应的icon
    timeOfDayIcon = "Sprite/timeOfDay/timeOfDay_%s.png",

    --家园角色互动菜单图标
    CoveMenuIcon = "Sprite/CoveMenu/bubble_img_icon%s.png",                               --道具图标


    GameShopTypeIcon = "Sprite/ShopIcon/mall_sidebar_icon_%s.png",                               --道具图标
    GameShopRecommendIcon = "Sprite/ShopIcon/mall_recommend_%s.png",                               --道具图标
    GameShopQualityIcon = "Sprite/Item/RangeBox/mall_propshop_tab_box_deco%s.png",                               --道具图标
    GameShopRechargeBgIcon = "Sprite/ShopIcon/mall_topup_box_deco%s.png",                               --道具图标

    PassExpIconPath = "Sprite/PassTaskIcon/%s.png",                               --通行证经验图标

    HomeMoodsPath = "Sprite/homemoods/%s.png",                               --家园角色表情图标
    PassPanelBg = "Sprite/PassPanelBg/%s.png",                               --通行证面板背景图标

    MonthCard = "Sprite/MonthCard/mall_monthly_get_iconimg%s.png",    --建筑图片

    WeeklybossIcon = "Sprite/WeeklyBoss/BossHeadIcon/boss_role%s.png",    --危境攻坚boss头像
    WeeklybossPicture = "Sprite/WeeklyBoss/BossPicture/boss_img%s.png",    --危境攻坚boss立绘

    PlotBgPath = "Sprite/HandBook/%s.png",                               --剧情图标


    --情报图标
    IntelligenceTypeName = "Sprite/Intelligenct/intelligenctType_%s.png",
    IntelligenceSignName = "Sprite/Intelligenct/intelligenceSign_%s.png",
    IntelligencedifficultyName = "Sprite/Intelligenct/difficulty_%s.png",

    FunctionOpenTips = "Sprite/FunctionOpenTips/%s.png",    --功能开启提示图

    TaskIcon = "Sprite/Item/TaskIcon/%s.png",              --任务icon

    BombGameImgPath = "Sprite/BombGame/%s.png",

    LoadSpriteMask = "Sprite/UI/Common/transparent.png",
}

Config.PrefabPath = {
    BattleRoot = "Prefabs/Battle/BattleRoot.prefab",
    StoryRoot = "Prefabs/Story/StoryRoot.prefab",
    BattleMapCube = "Prefabs/Battle/MapCube.prefab",
    MapCubeTxt = "Prefabs/Battle/MapCubeTxt.prefab",
    MoveArea = "Prefabs/Battle/MoveArea.prefab",
    ChooseArea = "Prefabs/Battle/ChooseArea.prefab",
    EdgeArea = "Prefabs/Battle/EdgeArea.prefab",
    SkillArea = "Prefabs/Battle/SkillArea.prefab",
    SkillArea2 = "Prefabs/Battle/SkillArea2.prefab",
    PrepareSkillArea = "Prefabs/Battle/PrepareSkillArea.prefab",
    SkillArrowArea = "Prefabs/Battle/SkillArrowArea.prefab",
    FormationArea = "Prefabs/Battle/FormationArea.prefab",
    BattleBlockTag = "Prefabs/Battle/BattleBlockTag.prefab",
    BattleRole = "Prefabs/Battle/BattleRole.prefab",
    RolePrefab = "Prefabs/Battle/Role/%s.prefab",
    NPCPrefab = "Prefabs/Battle/StoryNPC/npc_%s.prefab",
    UIRolePrefab = "Prefabs/UI/Spine/Role/%s.prefab",
    BattleEffect = "Prefabs/Effect/Battle/Common/%s/%s.prefab",
    SelectedArea = "Prefabs/Battle/SelectedArea.prefab",
    SeaMapRoot = "Prefabs/SeaMap/SeaMap.prefab",
    RoleModelPrefab = "Prefabs/Character/%s/%s.prefab",
    BulletPrefab = "Prefabs/Battle/Bullet/%s.prefab",
    RoleSpine = "Prefabs/Spine/Character/%s/%s.prefab",
    SceneSpine = "Prefabs/Spine/StoryScene/%s/%s.prefab",
    BombGameSpine = "Prefabs/Spine/BombGame/%s.prefab",
    AimLine = "Prefabs/Battle/AimLine.prefab",
    SpecialArea = "Prefabs/Battle/SpecialArea.prefab",
    BattleScenePrefab = "Prefabs/Battle/BattleScene/%s.prefab",
    StoryEffect = "Prefabs/Effect/UI/Story/%s.prefab",
    ShadowProjector = "Prefabs/Battle/SoftShadowProjector.prefab",
    BombUnderWater = "Prefabs/Battle/BattleEvent/BombUnderWater.prefab",  --水下炸弹特效
    Effect_Boss_Boom = "Prefabs/Effect/Battle/Common/Effect_Boss_Boom.prefab",  --炸弹爆炸特效
    FriendCreateEffect = "Prefabs/Effect/Battle/Common/Effect_FangZhi/Effect_FangZhi.prefab",  --友方创建特效
    EnemyCreateEffect = "Prefabs/Effect/Battle/Common/Effect_FangZhi/Effect_FangZhi_R.prefab",  --敌方创建特效
    SkillTimeLinePrefab = "Prefabs/Battle/SkillTimeLine/%s/%s_timeLine.prefab",              --技能timeLine预制体
    RaffleAniRoot = "Prefabs/Raffle/RaffleRoot.prefab",  --抽卡动画节点
    GenRoleFragRoot = "Prefabs/GenRoleFrag/GenRoleFragRoot.prefab",  --跑片节点
    StoryRoleCanvas = "Prefabs/Story/StoryRoleCanvas.prefab",  --剧情角色canvas
    BattleUIFogPrefab = "Prefabs/Battle/BattleUIFog.prefab",  --战斗UI雾效预制体


    SeaMapBox = "Prefabs/SeaMap/Obj/EventBox.prefab",
    SeaMapObjPath = "Prefabs/SeaMap/Obj/PointMoudle/%s.prefab",         --海图用模型预制体

    CoveRole = "Prefabs/Cove/CoveRole.prefab",      --家园角色预制体
    CoveMonster = "Prefabs/Cove/CoveMonster.prefab",      --家园角色预制体
    CoveBox = "Prefabs/Cove/CoveBox.prefab",      --家园角色预制体
    Interaction = "Prefabs/Cove/Interaction.prefab",--角色互动预制体
    Cove_Fishrod = "Prefabs/Cove/Cove_Fishrod.prefab",--角色互动预制体
    Cove_Catch = "Prefabs/Cove/Cove_catch%s.prefab",--角色互动预制体
    RenderPipelineSetup = "Prefabs/Common/RenderPipelineSetup.prefab",  --渲染设置
    --GlobalClickEffect = "Prefabs/Effect/Battle/UI/Effect_Ui_DianJi.prefab",  --全局点击特效
    GlobalClickEffect = "Prefabs/Effect/Battle/UI/Ui_Effect_DianJi.prefab",  --全局点击特效
    GlobalDragEffect = "Prefabs/Effect/Battle/UI/Ui_Effect_TuoWei.prefab",  --全局拖动特效
    
    
    HitText = "Prefabs/Battle/HitText/HitText.prefab",
    EffectText = "Prefabs/Battle/HitText/EffectText.prefab",
    SurvivalHitText = "Prefabs/Battle/HitText/SurvivalHitText.prefab",

    StartBattleCamPath = "Prefabs/Battle/EnterBattlePath.prefab",  --进入战斗相机运镜路径

    SeaMapModePath = "Prefabs/SeaMap/Obj/MapPrefab/Map_%s.prefab",  --海图模版路径

    HPPrefab = "Prefabs/Battle/HP/HP.prefab",  --血条预制体
    SkillIconPrefab = "Prefabs/Battle/HP/SkillIcon.prefab",  --选中框技能图标预制体

    WaterCollision = "Prefabs/Common/WaterCollision.prefab",  --水面碰撞预制体

    RoleModelSwinPrefab = "Prefabs/Character/%s/%sboth.prefab",

    CoveBtn = "Prefabs/Cove/CoveBtn.prefab",      --家园按钮预制体
    CoveBtnRes = "Prefabs/Cove/CoveBtnRes.prefab",      --家园资源按钮预制体
    CoveSpecialBtn = "Prefabs/Cove/CoveSpecialBtn_%s.prefab",      --家园按钮预制体

    QinBaoBtnEffect_1 = "Prefabs/Effect/Battle/UI/Effect_Ui_QinBao_Yellow.prefab",  --全局点击特效
    QinBaoBtnEffect_2 = "Prefabs/Effect/Battle/UI/Effect_Ui_QinBao_Blue.prefab",  --全局拖动特效
    QinBaoBtnEffect_3 = "Prefabs/Effect/Battle/UI/Effect_Ui_QinBao_Red.prefab",  --全局击特效
	SurvivalRole = "Prefabs/Survival/SurvivalRole.prefab",      --幸存者角色预制体
    SurvivalBullet = "Prefabs/Survival/SurvivalBullet.prefab",      --幸存者子弹预制体
    SurvivalAreaEffect = "Prefabs/Survival/SurvivalAreaEffect.prefab",      --幸存者区域效果预制体
    SurvivalAreaEffectPrefab = "Prefabs/Survival/SurvivalArea/%s.prefab",      --区域效果表现（技能 bullet 字段）
    SurvivalRoot = "Prefabs/Survival/SurvivalRoot.prefab",      --幸存者根节点
    SurvivalBulletPrefab = "Prefabs/Survival/SurvivalBullet/%s.prefab",      --幸存者子弹预制体
    SurvivalItem = "Prefabs/Survival/SurvivalItem.prefab",      --幸存者掉落道具父预制体
    SurvivalItemPrefab = "Prefabs/Survival/SurvivalItem/%s.prefab",      --幸存者掉落道具表现

    AutoChessMapArea = "Prefabs/AutoChess/Area_%d.prefab",
    AutoChessMapAreaLine = "Prefabs/AutoChess/Area_Line.prefab",
    AutoChessMapSelect = "Prefabs/AutoChess/Area_Select.prefab",
    AutoChessRole = "Prefabs/AutoChess/AutoChessRole.prefab",

}

Config.ScenePath = {
    BattleMapScene = "Scene/Battle/%s/%s.unity",    --战斗场景
    HomelandScene = "Scene/Homeland/Homeland.unity",    --家园场景
    ZhihuishiScene = "Scene/Zhihuishi/Zhihuishi.unity",    --指挥室场景
    GenRoleFragScene = "Scene/GenRoleFrag/GenRoleFrag.unity",    --跑片场景
    EmptyScene = "Scene/EmptyScene/EmptyScene.unity",    --空场景
    SeaMapScene = "Scene/SeaMapScene/SeaMapScene.unity",    --海图场景
    BattleScene = "Scene/BattleScene/BattleScene.unity",    --战斗场景
    SurvivalScene = "Scene/SurvivalScene/SurvivalScene.unity",    --幸存者场景
    AutoChessScene = "Scene/AutoChessScene/AutoChessScene.unity",    --战斗场景
}

--字体文件路径
Config.FontPath = {
    Total = "Font/TotalNum/TotalNum.fontsettings",
    Red = "Font/RedNum/RedNum.fontsettings",
    Heal = "Font/HealNum/HealNum.fontsettings",
    Grey = "Font/GreyNum/GreyNum.fontsettings",
    White = "Font/WhiteNum/WhiteNum.fontsettings",
}

--受击提示路径
Config.HitTipsPath = {
    Partial = "Sprite/BattleHitImg/battle_jumptxt_01.png",  --擦伤
    Partial2 = "Sprite/BattleHitImg/battle_jumptxt_02.png", --防护消耗
    Miss = "Sprite/BattleHitImg/battle_jumptxt_04.png",     --未命中
    Miss2 = "Sprite/BattleHitImg/battle_jumptxt_05.png",    --未激发
    Miss3 = "Sprite/BattleHitImg/battle_jumptxt_06.png",    --跳弹
}

Config.MaterialPath = {
    SeaMapBgPath = "Material/MapMat/%s.mat",            --海图地面材质
}

Config.TimeLinePath = {
    Character = "Prefabs/Effect/Battle/TimeLine/%s.playable",              --角色用timeline
}

Config.LevelIdReject = 2200000

Config.MaxRoleStar = 6   --角色最大星级


Config.GameReportPath = UnityEngine.Application.persistentDataPath.."/GameReport.lua"
Config.FieldBoardDataPath = UnityEngine.Application.persistentDataPath.."/FieldBoardData.lua"
Config.CalculationGameReport = UnityEngine.Application.persistentDataPath.."/CalculationGameReport.txt"
Config.CommonPath = UnityEngine.Application.dataPath.."/../../../common/"
Config.LevelLuaPath = UnityEngine.Application.dataPath.."/../../../common/table/lua/cfg/level/"
Config.StoryLuaPath = UnityEngine.Application.dataPath.."/../../../common/table/lua/client/story/%s"
Config.MapFilePath = UnityEngine.Application.dataPath.."/../../../common/table/battleMap/map001.bytes"
Config.PVMapFilePath = UnityEngine.Application.dataPath.."/../../../common/table/battleMap/map002.bytes"

Config.UiUseStr = {
    UserInfoDetailsPanel = "用户信息",
    AchievementPanel = "成就",
    FieldGuidePanel = "图鉴",
    HundredCatsPanel = "百喵拼图",
    MailPanel = "邮箱",
    SigninPanel = "签到",
    InterludeLoadingPanel = "喵广场",
    RafflePanel = "抽卡",
    CatNurturancePanel = "喵小窝",
    CatAdaptiveSkillPanel = "喵小窝-适应",
    TaskPanel = "任务",
    LevelHardPanel = "关卡回顾",
    LevelHardSweepPanel = "关卡回顾-扫荡",
    RoomPanel = "猫屋",
    NewbieSignIn = "新手签到",
    NewbieTask = "新手任务",
    RoomEditPanel = "家具编辑",
    LevelInfoPanel = "关卡信息",
    ChangeBattleItemPanel = "关卡信息-道具选择",
    FormationPanel = "编队",
    MatchWinConditionPanel = "战斗-过关条件"
}

Config.GameStageStr = {
    AppStart = "app启动",
    Privacy = "隐私条款",
    Update = "热更新",
    Reg = "注册",
    Login = "登录",
    Main = "进入主场景",
}

Config.LevelStatueName = {
    NotCompleteNormal = "NotCompleteLevelStatue",              
    CompleteNormal = "CompletedLevelStatue",
}

Config.DegreeOfDifficulty = {
    PointLineSimple = "PointLineSimple",
    PointLineDifficulty = "PointLineDifficulty",
}

Config.isBattleStoryEditor = GV.IsEditor

--海图尺寸边界 2 中尺寸
Config.SeaMapBoundary = {
    [2] = {
        left = 3,
        right = -3,
    }
}

Config.PlayerPrefKey = {
    AccountFirstEnterGame = "AccountFirstEnterGame"
}

Config.ClientConstant = {
    XipuQQ = "762212550"
}

Config.WxQueryInfoKey = {
    ConfidantCode = "confidantCode",
    ConfidantServer = "confidantServer",
    ConfidantName = "confidantName",
    feed_game_scene = "feed_game_scene",
    feed_game_extra = "feed_game_extra",
    feed_game_channel = "feed_game_channel",
    start_page = "start_page",
    card_id = "card_id",
}

Config.AudioPlayType = {
    [Config.AudioPath.NormalButton] = 1,
    [Config.AudioPath.TabButton] = 1,
    ["click"] = 1,
    ["click_tab"] = 1,
}


Config.Match = {
    FileName = ".*/(.+)%.",
}

if GV.GlobalConfig.IsInternalFormal() or GV.GlobalConfig.IsXipuAbroad() then
	Config.AudioPath.Main = "Audio/BGM/bgm_main_2.ogg"
end