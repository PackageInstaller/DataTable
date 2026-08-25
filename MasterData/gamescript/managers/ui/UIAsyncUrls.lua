local UIAsyncUrls = {
  [Urls.AwakerBasePanel] = {autoDestroyTime = -1},
  [Urls.MainPanel] = {autoDestroyTime = 10, forceSync = true},
  [Urls.DbgBattlePanel] = {
    autoDestroyTime = -1,
    PanelCls = UIAsyncBattlePanel
  },
  [Urls.BattleExSkillPanel] = {autoDestroyTime = 10},
  [Urls.BagView] = {autoDestroyTime = 10},
  [Urls.KeeperSkillObtainView] = {autoDestroyTime = 1},
  [Urls.TaskMainView] = {autoDestroyTime = 20},
  [Urls.TaskSchoolView] = {autoDestroyTime = 20},
  [Urls.TaskCareerView] = {autoDestroyTime = 20},
  [Urls.TaskPlayerLevelView] = {autoDestroyTime = 20},
  [Urls.TaskHomeAchievementView] = {autoDestroyTime = 20},
  [Urls.SummonNewItemPanel] = {autoDestroyTime = 10},
  [Urls.CopyMainView] = {autoDestroyTime = 15, forceSync = true},
  [Urls.CopyMainChapterView] = {autoDestroyTime = 10, forceSync = true},
  [Urls.CopyLargeBranchView] = {autoDestroyTime = 10, forceSync = true},
  [Urls.CopySmallBranchView] = {autoDestroyTime = 10, forceSync = true},
  [Urls.FuncBattleCardDisplayPanel] = {autoDestroyTime = 20},
  [Urls.CopiesAwakerInfoPanelNew] = {autoDestroyTime = 20, forceSync = true}
}
return UIAsyncUrls
