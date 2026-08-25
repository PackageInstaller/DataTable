local RailWayStageGroupTid = DT.GetOriginalConstant("RailWayStageGroupTid")
local FeatureId = CommonDefine.FeatureId
local CareerLevelType = CareerLevelDefine.CareerLevelType
local RedDotID = RedDotDefine.RedDotID
local DynamicRedDotID = RedDotDefine.DynamicRedDotID
local ServerRedDotID = RedDotDefine.ServerRedDotID
local Difficulty = CommonDefine.Difficulty
local RedDotTreeUtils = {}
local DailyChallengedSelecStageLevel = DT.GetOriginalConstant("DailyChallengedSelecStageLevel")

function RedDotTreeUtils.GetDailyCopyEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.DailyCopyEntry, "每日副本入口")
  rst:AddChild(RedDotFeatureUnlockWork(FeatureId.DailyChallenge, DailyChallengedSelecStageLevel))
  rst:AddChild(RedDotTreeUtils.GetDailyCopyCareerLevelRedDotTree())
  rst:AddChild(RedDotTreeUtils.GetDailyCopyTaskRedDotTree())
  rst:AddChild(RedDotSeasonTaskCanReceiveWork(CommonDefine.SeasonGameplayType.ConsciousnessDiving, FeatureId.DailyChallenge, 0))
  return rst
end

function RedDotTreeUtils.GetDailyCopyCareerLevelRedDotTree()
  local rst = RedDotOrFlow(RedDotID.DailyCopyCareerLevel, "每日副本生涯等级奖励入口")
  rst:AddChild(RedDotFeatureUnlockWork(FeatureId.DailyChallenge, 0))
  rst:AddChild(RedDotCareerLevelCanReceiveWork(CareerLevelType.DailyChallenge))
  return rst
end

function RedDotTreeUtils.GetDailyCopyTaskRedDotTree()
  local rst = RedDotOrFlow(RedDotID.DailyCopyTask, "每日副本任务奖励入口")
  rst:AddChild(RedDotFeatureUnlockWork(FeatureId.DailyChallenge, 0))
  rst:AddChild(RedDotDailyCopyTaskWork())
  return rst
end

function RedDotTreeUtils.GetActivityMainEntryRedDotTree()
  local rst = RedDotSequenceFlow(RedDotID.ActivityMainEntry, "活动主界面入口")
  rst:AddChild(RedDotFeatureUnlockWork(FeatureId.Activity, 0))
  rst:AddChild(RedDotActivitySvrWork())
  rst:AddChild(RedDotTreeUtils.GetActivityClientRedDotTree())
  return rst
end

function RedDotTreeUtils.GetActivityClientRedDotTree(targetActivityTidList)
  local rst = RedDotSequenceFlow(nil, "客户端活动红点")
  if not targetActivityTidList or not table.next(targetActivityTidList) then
    targetActivityTidList = {}
    for _, activityDataClient in pairs(ActivityManager.Instance:GetDisplayActivityList()) do
      table.insert(targetActivityTidList, activityDataClient.activityTid)
    end
  end
  for _, activityTid in pairs(targetActivityTidList) do
    local activityRedDotTree = RedDotActivityTreeUtils.GetAcitivityRedDotTree({activityTid = activityTid})
    rst:AddChild(activityRedDotTree)
  end
  return rst
end

function RedDotTreeUtils.GetActivityPermanentClientRedDotTree()
  local rst = RedDotSequenceFlow(nil, "客户端常驻活动红点")
  rst:AddChild(RedDotTreeUtils.GetRailWayEntryRedDotTree())
  return rst
end

function RedDotTreeUtils.GetSingleActivityEntryRedDotTree(args)
  local activityTid = args.activityTid
  local rst = RedDotSequenceFlow(DynamicRedDotID.SingleActivityEntry, "单活动入口红点")
  rst:AddChild(RedDotActivitySvrWork({activityTid}))
  rst:AddChild(RedDotTreeUtils.GetActivityClientRedDotTree({activityTid}))
  return rst
end

function RedDotTreeUtils.GetActivityTabListRedDotTree(args)
  local activityTid = args.activityTid
  local trialActivityTidList = args.trialActivityTidList or {}
  local targetActivityTidList = {activityTid}
  for _, trialActivityTid in pairs(trialActivityTidList) do
    table.insert(targetActivityTidList, trialActivityTid)
  end
  local rst = RedDotSequenceFlow(DynamicRedDotID.ActivityTabList, "活动Tab列表Item")
  rst:AddChild(RedDotActivitySvrWork(targetActivityTidList))
  rst:AddChild(RedDotTreeUtils.GetActivityClientRedDotTree(targetActivityTidList))
  return rst
end

function RedDotTreeUtils.GetRailWayEntryRedDotTree()
  local rst = RedDotOrFlow(nil, "小火车玩法入口")
  rst:AddChild(RedDotCareerLevelCanReceiveWork(CareerLevelDefine.CareerLevelType.RailWay))
  rst:AddChild(RedDotTaskTypeCanGetRewardWork(CommonDefine.TaskType.TaskType_RailWay))
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(RailWayStageGroupTid)
  rst:AddChild(RedDotResonanceUpgradeWork(resonanceGroupId))
  rst:AddChild(RedDotSeasonTaskCanReceiveWork(CommonDefine.SeasonGameplayType.ConsciousnessRailway, nil, nil))
  return rst
end

function RedDotTreeUtils.GetRailWayEntryRedDotTreeWithoutSeasonReward()
  local rst = RedDotOrFlow(nil, "小火车玩法入口(不含赛季奖励)")
  rst:AddChild(RedDotCareerLevelCanReceiveWork(CareerLevelDefine.CareerLevelType.RailWay))
  rst:AddChild(RedDotTaskTypeCanGetRewardWork(CommonDefine.TaskType.TaskType_RailWay))
  rst:AddChild(RedDotResonanceUpgradeWork(RailWayStageGroupTid))
  return rst
end

function RedDotTreeUtils.GetTaskListActivityTaskGroupRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.ActivityTaskListGroupEntry, "回归活动任务组Tab红点")
  rst:AddChild(RedDotActivityTaskGroupFirstOpenWork({
    args.taskGroupTid
  }, args.activityTid))
  rst:AddChild(RedDotTasksCanGetRewardWork(args.taskTidList))
  return rst
end

function RedDotTreeUtils.GetActivityShopRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.ActivityShopEntry, "活动商店红点")
  rst:AddChild(RedDotActivityShopWork(args.activityTid))
  return rst
end

function RedDotTreeUtils.GetStageGroupEntryRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.StageGroupEntry, "关卡组入口红点")
  rst:AddChild(RedDotStageGroupDisplayWork({
    args.stageGroupTid
  }))
  return rst
end

function RedDotTreeUtils.GetActivityStageGroupEntryRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.ActivityStageGroupEntry, "活动关卡组入口红点")
  local activityTid = args.activityTid
  local stageGroupType = ActivityCfgUtils.GetStageGroupType(activityTid)
  if not ActivityManager.Instance:IsActivityFinishedByTid(activityTid) then
    rst:AddChild(RedDotStageGroupDisplayWork(CopyDataUtils.GetStageGroupIdList(stageGroupType)))
  end
  return rst
end

function RedDotTreeUtils.GetActivitySubplotEntryRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.ActivitySubplotEntry, "活动支线入口红点")
  if not ActivityManager.Instance:IsActivityFinishedByTid(args.activityTid) then
    rst:AddChild(RedDotStageGroupAllDiffWork(args.stageGroupTidList))
  end
  return rst
end

function RedDotTreeUtils.GetRedDotActivityStageListCanGetRewardWork(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.ActivityStageListCanGetReward, "活动关卡列表处于可领取状态")
  rst:AddChild(RedDotActivityStageListCanGetRewardWork(args.activityTid, args.stageTidList))
  return rst
end

function RedDotTreeUtils.GetGuideNoteSidebarRedDotTree(args)
  local moduleType = args and args.moduleType
  local rst = RedDotSequenceFlow(DynamicRedDotID.GuideNoteSidebarTab, "密境手记侧栏页签")
  if moduleType then
    rst:AddChild(RedDotGuideNoteSidebarWork(moduleType))
  end
  return rst
end

function RedDotTreeUtils.GetGuideNoteMainEntryRedDotTree()
  local ModuleType = GuideNoteDefine.ModuleType
  local rst = RedDotOrFlow(DynamicRedDotID.GuideNoteMainEntry, "密境手记主界面入口")
  rst:AddChild(RedDotTreeUtils.GetGuideNoteSidebarRedDotTree({
    moduleType = ModuleType.DailyActivity
  }))
  rst:AddChild(RedDotTreeUtils.GetGuideNoteSidebarRedDotTree({
    moduleType = ModuleType.WeeklyActivity
  }))
  return rst
end

function RedDotTreeUtils.GetGuideNoteTierRewardRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.GuideNoteTierReward, "密境手记活跃度奖励节点")
  rst:AddChild(RedDotGuideNoteTierRewardWork(args and args.show == true))
  return rst
end

function RedDotTreeUtils.GetCopyMainEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.CopyMainEntry, "主线和支线入口红点")
  local stageGroupEntryTree = RedDotCopyMainEntryWork()
  rst:AddChild(stageGroupEntryTree)
  stageGroupEntryTree:AddChild(RedDotTreeUtils.GetStageGroupsMainChapterPageEntryRedDotTree())
  stageGroupEntryTree:AddChild(RedDotTreeUtils.GetCopySmallSubplotPageEntryRedDotTree())
  stageGroupEntryTree:AddChild(RedDotTreeUtils.GetCopyLargeSubplotPageEntryRedDotTree())
  stageGroupEntryTree:AddChild(RedDotTreeUtils.GetCopyConfessionPageEntryRedDotTree())
  stageGroupEntryTree:AddChild(RedDotTreeUtils.GetCopySpecialSubplotPageEntryRedDotTree())
  stageGroupEntryTree:AddChild(RedDotTreeUtils.GetCopyLinkageActivityPageEntryRedDotTree())
  return rst
end

function RedDotTreeUtils.GetStageGroupsMainChapterPageEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.StageGroupsMainChaperPageEntry, "关卡主界面主线页签红点")
  local mainPageTree = RedDotStageGroupsMainChapterPageEntryWork()
  mainPageTree:AddChild(RedDotTreeUtils.GetStageGroupsMorimenChapterEntryRedDotTree())
  mainPageTree:AddChild(RedDotTreeUtils.GetStageGroupsStarsCameRightChapterEntryRedDotTree())
  rst:AddChild(mainPageTree)
  return rst
end

function RedDotTreeUtils.GetCopySmallSubplotPageEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.CopySmallSubplotPageEntry, "关卡主界面意识浅游页签红点")
  local pageTree = RedDotCopySmallSubplotPageEntryWork()
  rst:AddChild(pageTree)
  local groupIds = CopyExtModel.Instance:GetSubplotGroupList()
  for i = 1, #groupIds do
    local tree = RedDotTreeUtils.GetSubplotStageGroupEntryRedDotTree({
      stageGroupTid = groupIds[i]
    })
    pageTree:AddChild(tree)
  end
  return rst
end

function RedDotTreeUtils.GetCopyLargeSubplotPageEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.CopyLargeSubplotPageEntry, "关卡主界面特遣记录页签红点")
  local pageTree = RedDotCopyLargeSubplotPageEntryWork()
  rst:AddChild(pageTree)
  local groupIds = CopyExtModel.Instance:GetSublplotLargeGroupList()
  for i = 1, #groupIds do
    local tree = RedDotTreeUtils.GetSubplotStageGroupEntryRedDotTree({
      stageGroupTid = groupIds[i]
    })
    pageTree:AddChild(tree)
  end
  return rst
end

function RedDotTreeUtils.GetCopyConfessionPageEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.CopyConfessionPageEntry, "关卡主界面繁衍狂热页签红点")
  rst:AddChild(RedDotCopyConfessionPageEntryWork())
  return rst
end

function RedDotTreeUtils.GetCopySpecialSubplotPageEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.CopySpecialSubplotPageEntry, "关卡主界面异梦视界页签红点")
  local pageTree = RedDotCopySpecialSubplotPageEntryWork()
  rst:AddChild(pageTree)
  local groupIds = CopyExtModel.Instance:GetSpecialGroupList()
  for i = 1, #groupIds do
    local tree = RedDotTreeUtils.GetSubplotStageGroupEntryRedDotTree({
      stageGroupTid = groupIds[i]
    })
    pageTree:AddChild(tree)
  end
  return rst
end

function RedDotTreeUtils.GetCopyLinkageActivityPageEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.CopyLinkageActivityPageEntry, "关卡主界面联动活动页签红点")
  local pageTree = RedDotCopyLinkageActivityPageEntryWork()
  rst:AddChild(pageTree)
  local groupIds = CopyExtModel.Instance:GetLinkageActivityNormalGroupList()
  if #groupIds > 0 then
    pageTree:AddChild(RedDotStageGroupAllDiffWork(groupIds))
  end
  for i = 1, #groupIds do
    local tree = RedDotTreeUtils.GetSubplotStageGroupEntryRedDotTree({
      stageGroupTid = groupIds[i]
    })
    pageTree:AddChild(tree)
  end
  return rst
end

function RedDotTreeUtils.GetStageGroupsMorimenChapterEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.StageGroupsMorimenChapterEntry, "忘却篇主线章节红点")
  local chapterTree = RedDotStageGroupsMorimenChapterEntryWork()
  rst:AddChild(chapterTree)
  local stageChapterName = cd.StageChapterName.StageChapterMorimens
  chapterTree:AddChild(RedDotTreeUtils.GetMainStageGroupSimpleRedDotTree({stageChapterName = stageChapterName}))
  chapterTree:AddChild(RedDotTreeUtils.GetMainStageGroupHardRedDotTree({stageChapterName = stageChapterName}))
  chapterTree:AddChild(RedDotTreeUtils.GetMainStageGroupNightmareRedDotTree({stageChapterName = stageChapterName}))
  chapterTree:AddChild(RedDotTreeUtils.GetStageGroupRememberRedDotTree())
  return rst
end

function RedDotTreeUtils.GetStageGroupsStarsCameRightChapterEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.StageGroupstarsCameRightChapterEntry, "星辰篇主线章节红点")
  local chapterTree = RedDotStageGroupsStarsCameRightChapterEntryWork()
  rst:AddChild(chapterTree)
  local stageChapterName = cd.StageChapterName.StageChapterStarsCameRight
  chapterTree:AddChild(RedDotTreeUtils.GetMainStageGroupSimpleRedDotTree({stageChapterName = stageChapterName}))
  chapterTree:AddChild(RedDotTreeUtils.GetMainStageGroupHardRedDotTree({stageChapterName = stageChapterName}))
  chapterTree:AddChild(RedDotTreeUtils.GetMainStageGroupNightmareRedDotTree({stageChapterName = stageChapterName}))
  chapterTree:AddChild(RedDotTreeUtils.GetStageGroupRememberRedDotTree())
  return rst
end

function RedDotTreeUtils.GetRecallEntryRedDotTree()
  local rst = RedDotSequenceFlow(RedDotID.RecallEntry, "记忆回响入口红点")
  rst:AddChild(RedDotRecallEntryWork())
  return rst
end

function RedDotTreeUtils.GetGamePassportEntryRedDotTree()
  local rst = RedDotSequenceFlow(RedDotID.GamePassportEntry, "守密纪行入口红点")
  local activityTidList = ActivityManager.Instance.model:GetGamePassports()
  for _, activityData in pairs(activityTidList) do
    rst:AddChild(RedDotTreeUtils.GetActivityTabListRedDotTree({
      activityTid = activityData.activityTid
    }))
  end
  return rst
end

function RedDotTreeUtils.GetRedDotConversionRemainRedDotTree(conversionIdList)
  conversionIdList = conversionIdList or AlchemyCompositeExtModel.Instance:GetCompositeConversionIdList()
  local rst = RedDotSequenceFlow(DynamicRedDotID.RedDotConversionRemain, "炼金剩余次数红点")
  rst:AddChild(RedDotConversionRemainWork(conversionIdList))
  return rst
end

function RedDotTreeUtils.GetDynamicFuncNewRedDotTree(func)
  local rst = RedDotSequenceFlow(DynamicRedDotID.DynamicFuncNew, "默认新红点")
  rst:AddChild(RedDotDefaultNewWork(func))
  return rst
end

function RedDotTreeUtils.GetMainStageGroupDiffcultyTree(redDotId, difficulty, stageChapterName)
  stageChapterName = stageChapterName and stageChapterName or cd.StageChapterName.StageChapterMorimens
  local rst = RedDotOrFlow(redDotId, "主线章节难度红点")
  local difficultyWork = RedDotMainStageGroupDifficultyEntryWork({difficulty = difficulty, stageChapterName = stageChapterName})
  rst:AddChild(difficultyWork)
  for _, stageGroupId in pairs(CopyDataUtils.CalculateChapterIndex(difficulty, stageChapterName)) do
    if MainCopyDataUtils.IsStageGroupUnlock(stageGroupId) then
      local stageGroupTree = RedDotTreeUtils.GetStageGroupRedDotTree({stageGroupTid = stageGroupId})
      difficultyWork:AddChild(stageGroupTree)
    end
  end
  return rst
end

function RedDotTreeUtils.GetMainStageGroupSimpleRedDotTree(args)
  local stageChapterName = args and args.stageChapterName or cd.StageChapterName.StageChapterMorimens
  do return RedDotTreeUtils.GetMainStageGroupDiffcultyTree, DynamicRedDotID.MainStageGroupSimpleRedDotEntry, Difficulty.Normal end
  return RedDotTreeUtils.GetMainStageGroupDiffcultyTree, DynamicRedDotID.MainStageGroupSimpleRedDotEntry, Difficulty.Normal, stageChapterName
end

function RedDotTreeUtils.GetMainStageGroupHardRedDotTree(args)
  local stageChapterName = args and args.stageChapterName or cd.StageChapterName.StageChapterMorimens
  do return RedDotTreeUtils.GetMainStageGroupDiffcultyTree, DynamicRedDotID.MainStageGroupHardRedDotEntry, Difficulty.Hard end
  return RedDotTreeUtils.GetMainStageGroupDiffcultyTree, DynamicRedDotID.MainStageGroupHardRedDotEntry, Difficulty.Hard, stageChapterName
end

function RedDotTreeUtils.GetMainStageGroupNightmareRedDotTree(args)
  local stageChapterName = args and args.stageChapterName or cd.StageChapterName.StageChapterMorimens
  do return RedDotTreeUtils.GetMainStageGroupDiffcultyTree, DynamicRedDotID.MainStageGroupNorNightmareRedDotEntry, Difficulty.Super end
  return RedDotTreeUtils.GetMainStageGroupDiffcultyTree, DynamicRedDotID.MainStageGroupNorNightmareRedDotEntry, Difficulty.Super, stageChapterName
end

function RedDotTreeUtils.GetStageGroupRememberRedDotTree()
  local rst = RedDotOrFlow(DynamicRedDotID.StageGroupRememberRedDotEntry, "溯梦模式红点")
  rst:AddChild(RedDotStageGroupRememberEntryWork())
  return rst
end

function RedDotTreeUtils.GetStageGroupRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.StageGroupRedDot, "关卡组")
  local stageGroupTree = RedDotStageGroupTreeWork(args)
  rst:AddChild(stageGroupTree)
  local groupData = CopyMainModel.Instance:GetGroupData(args.stageGroupTid)
  if groupData and groupData.stageList then
    for _, stageData in ipairs(groupData.stageList) do
      local groupTree = RedDotTreeUtils.GetStageNewRedDotTree({
        stageTid = stageData.stageID
      })
      stageGroupTree:AddChild(groupTree)
    end
  end
  local starsProgTree = RedDotTreeUtils.GetStageGroupStarsProgRedDotTree(args)
  stageGroupTree:AddChild(starsProgTree)
  local archievementTree = RedDotTreeUtils.GetStageGroupArchivementRedDotTree(args)
  stageGroupTree:AddChild(archievementTree)
  if args.stageGroupTid then
    local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(args.stageGroupTid)
    local resoanceGroupTree = RedDotTreeUtils.GetResonanceGroupRedDotTree({resonanceGroupTid = resonanceGroupId})
    stageGroupTree:AddChild(resoanceGroupTree)
  end
  return rst
end

function RedDotTreeUtils.GetResonanceRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.ResonanceRedDot, "共鸣点")
  rst:AddChild(RedDotResonanceWork(args))
  return rst
end

function RedDotTreeUtils.GetResonanceGroupRedDotTree(args)
  local resonanceGroupTree = RedDotResonanceGroupWork(args)
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(args.resonanceGroupTid)
  for k, v in pairs(resonanceConfigs or {}) do
    local resonanceTree = RedDotTreeUtils.GetResonanceRedDotTree({
      resonanceTid = v.ID,
      useExtraItem = args.useExtraItem
    })
    resonanceGroupTree:AddChild(resonanceTree)
  end
  local rst = RedDotOrFlow(DynamicRedDotID.ResonanceGroupRedDot, "共鸣组")
  rst:AddChild(resonanceGroupTree)
  return rst
end

function RedDotTreeUtils.GetStageGroupStarsProgRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.StageGroupGetAwardRedDot, "关卡组星级奖励")
  rst:AddChild(RedDotStageGroupStarsProgTreeWork(args))
  return rst
end

function RedDotTreeUtils.GetStageGroupArchivementRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.StageGroupGetAwardRedDot, "关卡组成就")
  rst:AddChild(RedDotStageGroupAchievementTreeWork(args))
  return rst
end

function RedDotTreeUtils.GetStageNewRedDotTree(args)
  local rst = RedDotOrFlow(ServerRedDotID.StageNewRedDot, "新关卡")
  rst:AddChild(RedDotStageNewTreeWork(args))
  return rst
end

function RedDotTreeUtils.GetSubplotStageGroupEntryRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.SubplotStageGroupEntryRedDot, "单个支线关卡组入口")
  if args.stageGroupTid then
    rst:AddChild(RedDotStageGroupAllDiffWork({
      args.stageGroupTid
    }))
  end
  local stageGroupTree = RedDotSubplotStageGroupEntryWork(args)
  rst:AddChild(stageGroupTree)
  for _, hardModeIndex in pairs(CommonDefine.StageGroupHardModeIndex) do
    local stageGroupId = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(hardModeIndex, args.stageGroupTid)
    if stageGroupId and stageGroupId > 0 then
      local groupTree = RedDotTreeUtils.GetSubplotStageGroupRedDotTree({stageGroupTid = stageGroupId, withResonanceGroup = true})
      stageGroupTree:AddChild(groupTree)
    end
  end
  return rst
end

function RedDotTreeUtils.GetSubplotStageGroupRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.SubplotStageGroupRedDot, "支线关卡组")
  local stageGroupTree = RedDotSubplotStageGroupTreeWork(args)
  rst:AddChild(stageGroupTree)
  local groupData = CopyMainModel.Instance:GetGroupData(args.stageGroupTid)
  if groupData and groupData.stageList then
    for _, stageData in ipairs(groupData.stageList) do
      local groupTree = RedDotTreeUtils.GetSubplotStageRedDotTree({
        stageTid = stageData.stageID
      })
      stageGroupTree:AddChild(groupTree)
    end
  end
  local starsProgTree = RedDotTreeUtils.GetStageGroupStarsProgRedDotTree(args)
  stageGroupTree:AddChild(starsProgTree)
  local archievementTree = RedDotTreeUtils.GetStageGroupArchivementRedDotTree(args)
  stageGroupTree:AddChild(archievementTree)
  if args.withResonanceGroup and args.stageGroupTid then
    local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(args.stageGroupTid)
    local resoanceGroupTree = RedDotTreeUtils.GetResonanceGroupRedDotTree({resonanceGroupTid = resonanceGroupId})
    stageGroupTree:AddChild(resoanceGroupTree)
  end
  return rst
end

function RedDotTreeUtils.GetSubplotStageRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.SubplotStageRedDot, "支线关卡")
  rst:AddChild(RedDotSubplotStageTreeWork(args))
  return rst
end

function RedDotTreeUtils.GetArtCollectionCGTabRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.ArtCollectionCGTab, "CG图鉴Toggle红点")
  rst:AddChild(RedDotDefaultRedWork(function()
    do return RedPointDataUtils.NewCollectionReward end
    return RedPointDataUtils.NewCollectionReward, args.rewardType
  end))
  rst:AddChild(RedDotDefaultNewWork(function()
    do return RedPointDataUtils.IsShowCollectionFeature, args.feature, args.page end
    return RedPointDataUtils.IsShowCollectionFeature, args.feature, args.page, true
  end))
  return rst
end

function RedDotTreeUtils.GetShopTypeTabRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.ShopTypeTabRedDot, "商店类型Tab红点")
  rst:AddChild(RedDotShopTypeTabWork(args.shopTypeTid))
  return rst
end

function RedDotTreeUtils.GetAnnouncementNoticeItemRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.AnnouncementNoticeItem, "公告列表项红点")
  rst:AddChild(RedDotAnnouncementNoticeWork(args))
  return rst
end

function RedDotTreeUtils.GetAnnouncementPageTabRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.AnnouncementPageTab, "公告页签红点")
  rst:AddChild(RedDotAnnouncementPageWork(args))
  return rst
end

function RedDotTreeUtils.GetAnnouncementEntranceRedDotTree()
  local rst = RedDotOrFlow(DynamicRedDotID.AnnouncementEntrance, "公告入口红点")
  rst:AddChild(RedDotAnnouncementEnterWork())
  return rst
end

function RedDotTreeUtils.GetTutorialMainTabRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.TutorialMainTabRedDot, "教程页签红点")
  rst:AddChild(RedDotDefaultRedWork(function()
    do return TutorialMainModel.Instance.HasTabReceiveRed, TutorialMainModel.Instance end
    return TutorialMainModel.Instance.HasTabReceiveRed, TutorialMainModel.Instance, args.tabType
  end))
  return rst
end

function RedDotTreeUtils.GetTutorialMainItemRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.TutorialMainItemRedDot, "教程列表项红点")
  rst:AddChild(RedDotDefaultRedWork(function()
    do return TutorialMainModel.Instance.HasItemReceiveRed, TutorialMainModel.Instance end
    return TutorialMainModel.Instance.HasItemReceiveRed, TutorialMainModel.Instance, args.tid
  end))
  return rst
end

function RedDotTreeUtils.GetTutorialMainNextPageRedDotTree(args)
  local rst = RedDotSequenceFlow(DynamicRedDotID.TutorialMainNextPageRedDot, "教程下一页红点")
  rst:AddChild(RedDotDefaultRedWork(function()
    do return TutorialMainModel.Instance.HasItemReceiveRed, TutorialMainModel.Instance end
    return TutorialMainModel.Instance.HasItemReceiveRed, TutorialMainModel.Instance, args.tid
  end))
  return rst
end

function RedDotTreeUtils.GetTreasureMailEntryRedDotTree()
  local rst = RedDotOrFlow(RedDotID.TreasureMailEntry, "珍藏邮箱入口红点")
  rst:AddChild(RedDotDefaultRedWork(function()
    do return MailModel.Instance.HasTreasureRed end
    return MailModel.Instance.HasTreasureRed, MailModel.Instance
  end))
  return rst
end

function RedDotTreeUtils.GetMailItemUnreadRedDotTree(args)
  local rst = RedDotOrFlow(DynamicRedDotID.MailItemUnread, "邮件列表项未读红点")
  rst:AddChild(RedDotDefaultRedWork(function()
    return not MailModel.Instance:IsMailRead(args.mailUid)
  end))
  return rst
end

return RedDotTreeUtils
