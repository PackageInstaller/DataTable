require("ui_season_id_enum")
require("ui_season_cfgs")
require("state_register")
UISeasonCfgs[UISeasonID.S3] = {
  MainController = "UIS3MainController",
  CollageUI = "UISeasonS3Collages",
  ExchangeUI = "UIS3ExchangeController",
  QuestContent = "UIS4QuestContent",
  TaskList = {
    Navi = "UIS3TaskListNavi",
    Btn = "UIS3TaskListBtn",
    Content = "UIS3TaskListContent"
  },
  SceneUI = "UISeasonMainS3",
  SceneState = UIStateType.UISeasonS3,
  StageUI = "UISeasonLevelStageS3",
  TaskStageUI = "UISeasonTaskLevelStageS3",
  HelperUI = "UIS3HelperController",
  CollectionPanel = "UISeasonShowCollectionAwardS3",
  GetItemPanel = "UISeasonShowAwardsS3",
  EvidencePanel = "UISeasonShowNormalAwardS3",
  BuffIconInBattle = "exp_s3_buff_bficon02",
  BuffTitleInBattle = "str_season_s3_buff_title",
  BattleResultAwardList = "UISeasonResultMultiAwardListS3",
  PlayIconAtlas = "UIS3Scene.spriteatlas",
  StoryUI = "UISeasonStoryS3",
  MainAtlas = "UIS3Main.spriteatlas",
  Level = {
    atlas = "UIS3Scene.spriteatlas",
    widget = "SeasonUILevelS3",
    sprite = "exp_s3_map_star01",
    spriteGray = "exp_s3_map_star02"
  },
  FuncAtlas = "UIS3Main.spriteatlas"
}
