require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S1] = {
  MainController = "UIS1MainController",
  CollageUI = "UISeasonS1Collages",
  ExchangeUI = "UIS1ExchangeController",
  QuestContent = "UIS1QuestContent",
  TaskList = {
    Navi = nil,
    Btn = nil,
    Content = nil
  },
  SceneUI = "UISeasonMain",
  SceneState = UIStateType.UISeason,
  StageUI = "UISeasonLevelStage",
  TaskStageUI = "UISeasonTaskLevelStageS2",
  HelperUI = "UISeasonHelperController",
  CollectionPanel = "UISeasonShowCollectionAward",
  GetItemPanel = "UISeasonShowAwards",
  EvidencePanel = "UISeasonShowEvidenceAward",
  BuffIconInBattle = "exp_s1_buff_icon01",
  BuffTitleInBattle = "str_season_buff_title",
  BattleResultAwardList = "UISeasonResultMultiAwardList",
  PlayIconAtlas = "UISeasonMain.spriteatlas",
  StoryUI = "UISeasonStoryController",
  MainAtlas = "UISeasonMain.spriteatlas",
  Level = {
    widget = "SeasonUILevel",
    sprite = "exp_s1_map_icon07",
    spriteGray = "exp_s1_map_icon08"
  },
  FuncAtlas = "UIS1Main.spriteatlas"
}
