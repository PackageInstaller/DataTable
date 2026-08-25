local Readonly = System.readonly
local M = {}
M.RelationListType = {
  Follow = "Follow",
  Attention = "Attention",
  Fans = "Fans",
  Visiter = "Visiter",
  Good = "Good",
  MutualFans = "MutualFans",
  UnfollowedFans = "UnfollowedFans",
  Bans = "Bans",
  StarAssist = "StarAssist"
}
M.OnlineState = {
  MainPanel = "MainPanel",
  Shop = "Shop",
  Summon = "Summon",
  Activity = "Activity",
  MainCopy = "MainCopy",
  Awaker = "Awaker",
  Challenge = "Challenge",
  Manual = "Manual",
  Battlepass = "Battlepass",
  Bag = "Bag",
  Alchemy = "Alchemy",
  Dispatch = "Dispatch",
  MainCopyInvestigate = "MainCopyInvestigate",
  DailyCopy = "DailyCopy",
  Copy = "Copy",
  WeekChallenge = "WeekChallenge",
  DailyChallenge = "DailyChallenge",
  WeeklyBoss = "WeeklyBoss",
  Offline = "Offline",
  PreparePVP = "PreparePVP",
  PVP = "PVP",
  PVPPwdMatching = "PVPPwdMatching",
  PVPPwdPrebuilt = "PVPPwdPrebuilt",
  PVPPwdDraft = "PVPPwdDraft"
}
M.PlayerInfoPage = Readonly({Overview = 1, BattleReplayView = 2})
M.SocialRelationType = {
  Cor = 1,
  UnAtten = 2,
  Atten = 3,
  MyFans = 4,
  Ban = 5
}
M.SocialAchieveKey = Readonly({
  AwakerNum = "AwakerNum",
  AchieveNum = "AchieveNum",
  LoginDay = "LoginDay",
  AssistNum = "AssistNum",
  Main1 = "Main1",
  Main2 = "Main2",
  Main3 = "Main3",
  DailyChallengeLifeMaxScore = "DailyChallengeLifeMaxScore",
  AbyssChallengeLifeMaxScore = "AbyssChallengeLifeMaxScore"
})
M.LargeImagePath = Readonly({
  SocialRelationPanelBg = "UIResources/UIBigImages/UI_Large/UI_Common_Image_Bg7.png"
})
M.SocialRelationPage = {
  Follow = 1,
  Fans = 2,
  Visiter = 3,
  Bans = 4,
  Search = 5,
  Rank = 6,
  Invitation = 7,
  Community = 8
}
M.SocialOnlineStateIconPath = Readonly({
  OutLineIcon = "UIResources/AtlasSource/UI_Social/UI_Social_State_3.png",
  OnLineTownIcon = "UIResources/AtlasSource/UI_Social/UI_Social_State_2.png",
  OnLineBattleIcon = "UIResources/AtlasSource/UI_Social/UI_Social_State_1.png"
})
M.SocialListItemType = Readonly({
  ShowAssist = 1,
  ShowVisited = 2,
  ShowNewFans = 3,
  ShowLikeRecord = 4,
  Ban = 5
})
M.GoodReason = Readonly({
  Social = 1,
  PVP = 2,
  PvpCollectionComment = 3,
  CollectionHallComment = 4
})
M.FriendRankTypePrefix = "Friend"
M.SocialRelationSortType = Readonly({
  Fans = 1,
  MutualFans = 2,
  UnfollowedFans = 3
})
M.SocialFollowSortType = Readonly({
  LastOnlineTime = 1,
  ClientLevel = 2,
  AwakerLevel = 3
})
M.SocialFollowSortParam = Readonly({
  {
    sortType = CommonDefine.FollowSortOrder.LastOnlineTimeDesc,
    param = "lastOnlineTime"
  },
  {
    sortType = CommonDefine.FollowSortOrder.ClientLevelDesc,
    param = "level"
  },
  {
    sortType = CommonDefine.FollowSortOrder.AwakerLevelDesc,
    param = "team"
  }
})
return M
