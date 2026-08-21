require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S8] = {
  MainController = "UIS8MainController",
  CollageUI = "UISeasonSeasonCollages",
  CollageUI_Cfg = {
    TabBtnNames = {
      [2] = "str_season_s8_cg",
      [3] = "str_season_s8_music"
    }
  },
  ExchangeUI = "UISeasonExchangeController",
  ExchangeUI_Cfg = {
    Spine = "S8_kv_2_spine_idle",
    SpineOffsetY = 0,
    LogoName = "exp_s8_shop_tittle01",
    GoodBgName = "exp_s8_shop_btn01",
    DiscountBgColor = Color(0.8352941176470589, 0.2980392156862745, 0.24705882352941178),
    Desc = "str_season_s8_exchange_desc"
  },
  QuestContent = "UIS8QuestContent",
  TaskList = {
    Navi = "UIS3TaskListNavi",
    Btn = "UIS3TaskListBtn",
    Content = "UIS3TaskListContent"
  },
  SceneUI = "UISeasonMainS8",
  SceneState = UIStateType.UISeasonS8,
  StageUI = "UISeasonLevelStageS8",
  TaskStageUI = "UISeasonTaskLevelStageS8",
  HelperUI = "UIS8HelperController",
  CollectionPanel = "UISeasonShowCollectionAwardS8",
  GetItemPanel = "UIGetItemController",
  EvidencePanel = "UISeasonShowNormalAwardS8",
  BuffIconInBattle = "exp_s8_buff_toptoon",
  BuffTitleInBattle = "str_season_s8_buff_title",
  BattleResultAwardList = "UISeasonResultMultiAwardListS8",
  PlayIconAtlas = "UIS8Scene.spriteatlas",
  StoryUI = "UISeasonStoryController",
  MainAtlas = "UIS8Main.spriteatlas",
  Level = {
    atlas = "UIS8Scene.spriteatlas",
    widget = "SeasonUILevelS8",
    sprite = "exp_s8_map_star01",
    spriteGray = "exp_s8_map_star02"
  },
  FuncAtlas = "UIS8Main.spriteatlas"
}
