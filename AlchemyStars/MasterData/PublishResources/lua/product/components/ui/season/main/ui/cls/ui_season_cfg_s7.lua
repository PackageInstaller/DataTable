require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S7] = {
  MainController = "UIS7MainController",
  CollageUI = "UISeasonSeasonCollages",
  CollageUI_Cfg = {
    TabBtnNames = {
      [2] = "str_season_s7_cg",
      [3] = "str_season_s7_music"
    }
  },
  ExchangeUI = "UISeasonExchangeController",
  ExchangeUI_Cfg = {
    Spine = "1500424_spine_idle",
    SpineOffsetY = -369,
    LogoName = "exp_s7_shop_tittle01",
    GoodBgName = "exp_s7_shop_btn01",
    DiscountBgColor = Color(0.8352941176470589, 0.2980392156862745, 0.24705882352941178),
    Desc = "str_season_s7_exchange_desc"
  },
  QuestContent = "UIS7QuestContent",
  TaskList = {
    Navi = "UIS3TaskListNavi",
    Btn = "UIS3TaskListBtn",
    Content = "UIS3TaskListContent"
  },
  SceneUI = "UISeasonMainS7",
  SceneState = UIStateType.UISeasonS7,
  StageUI = "UISeasonLevelStageS7",
  TaskStageUI = "UISeasonTaskLevelStageS7",
  HelperUI = "UIS7HelperController",
  CollectionPanel = "UISeasonShowCollectionAwardS7",
  GetItemPanel = "UIGetItemController",
  EvidencePanel = "UISeasonShowNormalAwardS7",
  BuffIconInBattle = "exp_s7_buff_toptoon",
  BuffTitleInBattle = "str_season_s7_buff_title",
  BattleResultAwardList = "UISeasonResultMultiAwardListS7",
  PlayIconAtlas = "UIS7Scene.spriteatlas",
  StoryUI = "UISeasonStoryController",
  MainAtlas = "UIS7Main.spriteatlas",
  Level = {
    atlas = "UIS7Scene.spriteatlas",
    widget = "SeasonUILevelS7",
    sprite = "exp_s7_map_star01",
    spriteGray = "exp_s7_map_star02"
  },
  FuncAtlas = "UIS7Main.spriteatlas"
}
