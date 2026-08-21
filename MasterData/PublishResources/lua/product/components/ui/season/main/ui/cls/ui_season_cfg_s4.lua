require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S4] = {
  MainController = "UIS4MainController",
  CollageUI = "UISeasonS4Collages",
  ExchangeUI = "UIS4ExchangeController",
  QuestContent = "UIS4QuestContent",
  TaskList = {
    Navi = "UIS3TaskListNavi",
    Btn = "UIS3TaskListBtn",
    Content = "UIS3TaskListContent"
  },
  SceneUI = "UISeasonMainS4",
  SceneState = UIStateType.UISeasonS4,
  StageUI = "UISeasonLevelStageS4",
  TaskStageUI = "UISeasonTaskLevelStageS4",
  HelperUI = "UIS4HelperController",
  CollectionPanel = "UISeasonShowCollectionAwardS4",
  GetItemPanel = "UISeasonShowAwardsS4",
  EvidencePanel = "UISeasonShowNormalAwardS4",
  BuffIconInBattle = "exp_s4_buff_icon01",
  BuffTitleInBattle = "str_season_s4_buff_title",
  BattleResultAwardList = "UISeasonResultMultiAwardListS4",
  PlayIconAtlas = "UIS4Scene.spriteatlas",
  StoryUI = "UISeasonStoryController",
  MainAtlas = "UIS4Main.spriteatlas",
  Level = {
    atlas = "UIS4Scene.spriteatlas",
    widget = "SeasonUILevelS4",
    sprite = "exp_s4_map_star01",
    spriteGray = "exp_s4_map_star02"
  },
  FuncAtlas = "UIS4Main.spriteatlas"
}
