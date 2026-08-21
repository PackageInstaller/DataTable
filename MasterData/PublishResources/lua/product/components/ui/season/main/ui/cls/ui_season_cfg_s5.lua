require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S5] = {
  MainController = "UIS5MainController",
  CollageUI = "UISeasonSeasonCollages",
  CollageUI_Cfg = {
    BgName = "exp_s5_book_bg",
    TabBtnNames = {
      [2] = "str_season_s5_cg",
      [3] = "str_season_s5_music"
    }
  },
  ExchangeUI = "UISeasonExchangeController",
  ExchangeUI_Cfg = {
    Spine = "1701073_spine_idle",
    LogoName = "exp_s5_shop_tittle01",
    GoodBgName = "exp_s5_shop_btn01",
    DiscountBgColor = Color(0.19215686274509805, 0.4196078431372549, 0.9137254901960784),
    Desc = "str_season_s5_exchange_desc"
  },
  QuestContent = "UIS5QuestContent",
  TaskList = {
    Navi = "UIS3TaskListNavi",
    Btn = "UIS3TaskListBtn",
    Content = "UIS3TaskListContent"
  },
  SceneUI = "UISeasonMainS5",
  SceneState = UIStateType.UISeasonS5,
  StageUI = "UISeasonLevelStageS5",
  TaskStageUI = "UISeasonTaskLevelStageS5",
  HelperUI = "UIS5HelperController",
  CollectionPanel = "UISeasonShowCollectionAwardS5",
  GetItemPanel = "UIGetItemController",
  EvidencePanel = "UISeasonShowNormalAwardS5",
  BuffIconInBattle = "exp_s5_buff_toptoon",
  BuffTitleInBattle = "str_season_s5_buff_title",
  BattleResultAwardList = "UISeasonResultMultiAwardListS5",
  PlayIconAtlas = "UIS5Scene.spriteatlas",
  StoryUI = "UISeasonStoryController",
  MainAtlas = "UIS5Main.spriteatlas",
  Level = {
    atlas = "UIS5Scene.spriteatlas",
    widget = "SeasonUILevelS5",
    sprite = "exp_s5_map_star01",
    spriteGray = "exp_s5_map_star02"
  },
  FuncAtlas = "UIS5Main.spriteatlas"
}
