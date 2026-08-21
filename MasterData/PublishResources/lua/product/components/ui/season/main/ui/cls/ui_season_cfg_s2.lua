require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S2] = {
  MainController = "UIS2MainController",
  CollageUI = "UISeasonS2Collages",
  ExchangeUI = "UIS2ExchangeController",
  QuestContent = "UIS2QuestContent",
  TaskList = {
    Navi = "UIS2TaskListNavi",
    Btn = "UIS2TaskListBtn",
    Content = "UIS2TaskListContent"
  },
  SceneUI = "UISeasonMainS2",
  SceneState = UIStateType.UISeasonS2,
  StageUI = "UISeasonLevelStageS2",
  TaskStageUI = "UISeasonTaskLevelStageS2",
  HelperUI = "UISeasonHelperControllerS2",
  CollectionPanel = "UISeasonShowCollectionAwardS2",
  GetItemPanel = "UISeasonShowAwardsS2",
  EvidencePanel = "UISeasonShowEvidenceAward",
  BuffIconInBattle = "exp_s2_buff_icon05",
  BuffTitleInBattle = "str_season_buff_title_S2",
  BattleResultAwardList = "UISeasonResultMultiAwardListS2",
  PlayIconAtlas = "UIS2Main.spriteatlas",
  StoryUI = "UISeasonStoryController",
  MainAtlas = "UISeasonMain.spriteatlas",
  Level = {
    atlas = "UIS2Scene.spriteatlas",
    widget = "SeasonUILevelS2",
    sprite = "exp_s2_map_star01",
    spriteGray = "exp_s2_map_star02"
  },
  FuncAtlas = "UIS2Main.spriteatlas"
}
