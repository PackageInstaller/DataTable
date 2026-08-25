local RedDotDefine = {}
RedDotDefine.SvrSaveVal = {Default = "0", Cleared = "1"}
RedDotDefine.SvrRedRemoveType = {ByServer = 1, ByClient = 2}
RedDotDefine.RedDotType = {
  None = "None",
  Red = "Red",
  New = "New",
  Num = "Num"
}
RedDotDefine.OldRedAttrType2RedDotTypeDict = {
  [RedPointDataUtils.RedAttrType.Red] = RedDotDefine.RedDotType.Red,
  [RedPointDataUtils.RedAttrType.IsNew] = RedDotDefine.RedDotType.New,
  [RedPointDataUtils.RedAttrType.Num] = RedDotDefine.RedDotType.Num
}
RedDotDefine.RedDotPriority = {
  RedDotDefine.RedDotType.New,
  RedDotDefine.RedDotType.Num,
  RedDotDefine.RedDotType.Red
}
RedDotDefine.RedDotID = {
  DailyCopyEntry = "DailyCopyEntry",
  DailyCopyTask = "DailyCopyTask",
  DailyCopyCareerLevel = "DailyCopyCareerLevel",
  ActivityMainEntry = "ActivityMainEntry",
  RecallEntry = "RecallEntry",
  GamePassportEntry = "GamePassportEntry",
  CopyMainEntry = "CopyMainEntry",
  StageGroupsMainChaperPageEntry = "StageGroupsMainChaperPageEntry",
  CopySmallSubplotPageEntry = "CopySmallSubplotPageEntry",
  CopyLargeSubplotPageEntry = "CopyLargeSubplotPageEntry",
  CopyConfessionPageEntry = "CopyConfessionPageEntry",
  CopySpecialSubplotPageEntry = "CopySpecialSubplotPageEntry",
  CopyLinkageActivityPageEntry = "CopyLinkageActivityPageEntry",
  StageGroupsMorimenChapterEntry = "StageGroupsMorimenChapterEntry",
  StageGroupstarsCameRightChapterEntry = "StageGroupstarsCameRightChapterEntry",
  TreasureMailEntry = "TreasureMailEntry"
}
RedDotDefine.DynamicRedDotID = {
  DynamicFuncNew = "DynamicFuncNew",
  ActivityTabList = "ActivityTabList",
  ActivityTaskListGroupEntry = "ActivityTaskListGroupEntry",
  ActivityShopEntry = "ActivityShopEntry",
  SingleActivityEntry = "SingleActivityEntry",
  StageGroupEntry = "StageGroupEntry",
  ActivityStageGroupEntry = "ActivityStageGroupEntry",
  ActivitySubplotEntry = "ActivitySubplotEntry",
  RailWayEntry = "RailWayEntry",
  RailWayEntryWithoutSeasonReward = "RailWayEntryWithoutSeasonReward",
  ActivityStageListCanGetReward = "ActivityStageListCanGetReward",
  ActivityWorldBossStageGroupEntry = "ActivityWorldBossStageGroupEntry",
  ActivityWorldBossEntry = "ActivityWorldBossEntry",
  GuideNoteSidebarTab = "GuideNoteSidebarTab",
  GuideNoteMainEntry = "GuideNoteMainEntry",
  GuideNoteTierReward = "GuideNoteTierReward",
  RedDotConversionRemain = "RedDotConversionRemain",
  MainStageGroupSimpleRedDotEntry = "MainStageGroupSimpleRedDotEntry",
  MainStageGroupHardRedDotEntry = "MainStageGroupHardRedDotEntry",
  MainStageGroupNorNightmareRedDotEntry = "MainStageGroupNorNightmareRedDotEntry",
  StageGroupRememberRedDotEntry = "StageGroupRememberRedDotEntry",
  StageGroupRedDot = "StageGroupRedDot",
  ResonanceRedDot = "ResonanceRedDot",
  ResonanceGroupRedDot = "ResonanceGroupRedDot",
  StageGroupStarsProgRedDot = "StageGroupStarsProgRedDot",
  StageGroupArchivementRedDot = "StageGroupArchivementRedDot",
  SubplotStageGroupRedDot = "SubplotStageGroupRedDot",
  SubplotStageGroupEntryRedDot = "SubplotStageGroupEntryRedDot",
  SubplotStageRedDot = "SubplotStageRedDot",
  ArtCollectionCGTab = "ArtCollectionCGTab",
  ShopTypeTabRedDot = "ShopTypeTabRedDot",
  AnnouncementNoticeItem = "AnnouncementNoticeItem",
  AnnouncementPageTab = "AnnouncementPageTab",
  AnnouncementEntrance = "AnnouncementEntrance",
  TutorialMainTabRedDot = "TutorialMainTabRedDot",
  TutorialMainItemRedDot = "TutorialMainItemRedDot",
  TutorialMainNextPageRedDot = "TutorialMainNextPageRedDot",
  MailItemUnread = "MailItemUnread"
}
RedDotDefine.ServerRedDotID = {
  StageNewRedDot = "new_stage_unlock"
}
RedDotDefine.RedDotConfigs = {
  [Urls.MainPanel] = {
    Red_Diving = {
      redDotID = RedDotDefine.RedDotID.DailyCopyEntry
    },
    Red_Activity = {
      redDotID = RedDotDefine.RedDotID.ActivityMainEntry
    },
    Red_Recall = {
      redDotID = RedDotDefine.RedDotID.RecallEntry
    },
    Red_GamePassport = {
      redDotID = RedDotDefine.RedDotID.GamePassportEntry
    },
    Com_RedDot_MQ = {
      redDotID = RedDotDefine.RedDotID.CopyMainEntry
    }
  },
  [Urls.CopyMainView] = {
    ["toggle_1/RedDot"] = {
      redDotID = RedDotDefine.RedDotID.StageGroupsMainChaperPageEntry
    },
    ["toggle_2/RedDot"] = {
      redDotID = RedDotDefine.RedDotID.CopySmallSubplotPageEntry
    },
    ["toggle_3/RedDot"] = {
      redDotID = RedDotDefine.RedDotID.CopyLargeSubplotPageEntry
    },
    ["toggle_4/RedDot"] = {
      redDotID = RedDotDefine.RedDotID.CopyConfessionPageEntry
    },
    ["toggle_5/RedDot"] = {
      redDotID = RedDotDefine.RedDotID.CopySpecialSubplotPageEntry
    },
    ["toggle_6/RedDot"] = {
      redDotID = RedDotDefine.RedDotID.CopyLinkageActivityPageEntry
    }
  },
  [Urls.CopyMainChapterView] = {
    Com_RedDot_1 = {
      redDotID = RedDotDefine.RedDotID.StageGroupsMorimenChapterEntry
    },
    Com_RedDot_2 = {
      redDotID = RedDotDefine.RedDotID.StageGroupstarsCameRightChapterEntry
    }
  },
  [Urls.DailyChallengeView] = {
    Red_Record = {
      redDotID = RedDotDefine.RedDotID.DailyCopyTask
    },
    Red_Reward = {
      redDotID = RedDotDefine.RedDotID.DailyCopyCareerLevel
    }
  }
}
return RedDotDefine
