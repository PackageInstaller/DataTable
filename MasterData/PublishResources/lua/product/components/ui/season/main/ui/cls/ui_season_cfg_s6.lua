require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S6] = {
  MainController = "UIS6MainController",
  CollageUI = "UISeasonSeasonCollages",
  CollageUI_Cfg = {
    TabBtnNames = {
      [2] = "str_season_s6_cg",
      [3] = "str_season_s6_music"
    }
  },
  ExchangeUI = "UISeasonExchangeController",
  ExchangeUI_Cfg = {
    Spine = "1500924_spine_idle",
    SpineOffsetY = 0,
    LogoName = "exp_s6_shop_tittle",
    GoodBgName = "exp_s6_shop_btn01",
    DiscountBgColor = Color(0.8352941176470589, 0.2980392156862745, 0.24705882352941178),
    Desc = "str_season_s6_exchange_desc"
  },
  QuestContent = "UIS6QuestContent",
  TaskList = {
    Navi = "UIS3TaskListNavi",
    Btn = "UIS3TaskListBtn",
    Content = "UIS3TaskListContent"
  },
  SceneUI = "UISeasonMainS6",
  SceneState = UIStateType.UISeasonS6,
  StageUI = "UISeasonLevelStageS6",
  TaskStageUI = "UISeasonTaskLevelStageS6",
  HelperUI = "UIS6HelperController",
  CollectionPanel = "UISeasonShowCollectionAwardS6",
  GetItemPanel = "UIGetItemController",
  EvidencePanel = "UISeasonShowNormalAwardS6",
  BuffIconInBattle = "exp_s6_buff_toptoon",
  BuffTitleInBattle = "str_season_s6_buff_title",
  BattleResultAwardList = "UISeasonResultMultiAwardListS6",
  PlayIconAtlas = "UIS6Scene.spriteatlas",
  StoryUI = "UISeasonStoryController",
  MainAtlas = "UIS6Main.spriteatlas",
  Level = {
    atlas = "UIS6Scene.spriteatlas",
    widget = "SeasonUILevelS6",
    sprite = "exp_s6_map_star01",
    spriteGray = "exp_s6_map_star02"
  },
  FuncAtlas = "UIS6Main.spriteatlas"
}
