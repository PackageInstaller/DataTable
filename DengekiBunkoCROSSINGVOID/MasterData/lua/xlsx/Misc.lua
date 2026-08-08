local raw = {
  [1] = ProtobufI("Misc", {
    defaultLanguage = 1,
    maxCardGroupNum = 100,
    equipExpToResource = ProtobufI("STResource", {type = 7, count = 3}),
    dailyRefreshTime = "06:00:00",
    minAnyPurchase = 10,
    maxAnyPurchase = 30000,
    danMuIntervalSeconds = 2,
    maxSkillPoint = 20,
    maxRecentContact = 20,
    maxWorldSubChannelCapacity = 1000,
    maxPlayerMail = 99,
    maxGlobalMail = 99,
    maxWorldSubChannelWeight = 700,
    maxActorLevel = 60,
    maxActorGroup = 10,
    maxGoldActorGroup = 1,
    maxWorldSubChannelCount = 9999,
    maxOfflineChatNum = 5,
    maxTowerActorGroup = 3,
    towerShowNextAwardCount = 3,
    talentRatio = 30,
    maxNotifyDeployNum = 45,
    maxAccomplishDeployNum = 40,
    resetTalentIndexPos = 4,
    percentAttrNum = 4,
    spaceBooksCount = 23,
    playerHeadCount = 6,
    actorDecomposeTalentCoef = 0.016,
    maxActorCommentCountOneDay = 3,
    auraCooldown = 14400,
    auraRelationPointAddStranger = 20,
    auraRelationPointAddFriends = 25,
    maxUnlockPosterScore = 4,
    gachaRecordActorTalentScore = 70,
    gachaRecordActorMax = 10,
    mailAttachmentLevelLimit = 10,
    oneStarRewardCount = 3,
    dungeonBalanceFavour = 1,
    signboardFavourCycle = 3600,
    signboardFavourValue = 1,
    deployFavourCycle = 3600,
    maxRoleFavourLevel = 10,
    gachaMaxCountOnce = 100,
    gachaPointGenRation = 1000,
    monthCardIncreaseDays = 30,
    monthCardRewardDaily = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 7, count = 20000})
    },
    maxStarLevel = 6,
    pvpTickets = 1,
    pvpOneRandActorNum = 3,
    pvpRandTimes = 3,
    pvpMinRandTime = 5,
    pvpMaxRandTime = 10,
    pvpMaxWinNum = 5,
    pvpMaxDieNum = 3,
    maxCongratsRoleNum = 3,
    minCongratsFavourLv = 2,
    rolePresentInterval = 86400,
    rolePresentMaxNum = 3,
    racePvpMinRandTime = 5,
    racePvpMaxRandTime = 10,
    maxRacePvpPlyNum = 5,
    burstPvpActorStar = 1,
    burstPvpActorLevel = 1,
    burstPvpActorQuality = 1,
    maxAsyncPVPActorGroup = 1,
    maxRacePVPActorGroup = 1,
    notepadEventVoiceOpenLevel = 4,
    burstPvpMatchMaxWaitTime = 60,
    unlockNoticeSystemLevel = 12,
    maxNameLen = 7,
    maxChatLen = 128,
    gameCenterDSRewardType = 7,
    gameCenterDSRewardCount = 200,
    recallSinceLastLogin = 5,
    vipSuperDSRewardType = 7,
    vipSuperDSRewardCount = 200,
    maxFriendNum = 200,
    maxBlackContactNum = 200,
    maxFriendApplyListNum = 100,
    maxActorCommentCount = 1000,
    maxResetTalentCount = 10,
    fightInteractionInterval = 10,
    racePVPGroupMaxPlayer = 20,
    clickLikeLimit = 100,
    dailyRefreshZeroTime = "00:00:00",
    reportedRefreshTime = 24,
    reportedGuildNum = 2,
    maxReportedScore = 15,
    chatBanColdTime = 48,
    reportedIpLimit = 1,
    forceLimitedPoolCount = 30,
    racePVPTicketNum = 6,
    racePVPRoundNum = 8,
    teamDungeonTicket = {
      [23] = ProtobufI("STResource", {
        type = 11,
        id = 80005,
        count = 1
      }),
      [73] = ProtobufI("STResource", {
        type = 11,
        id = 80012,
        count = 1
      })
    },
    wxSubscribeMsgId = {
      [1] = 297
    },
    qqSubscribeSceneId = {
      [1] = 65
    },
    relationPointDailyLimit = 400,
    triggeredEventActiveInterval = 1,
    triggeredEventPassiveInterval = 300,
    triggeredEventTickets = {
      [1] = 80009
    },
    dayTriggeredEventActiveOpenTime = "00:00:00",
    dayTriggeredEventActiveCloseTime = "23:59:59",
    dayTriggeredEventPassiveOpenTime = "00:00:00",
    dayTriggeredEventPassiveCloseTime = "23:59:59",
    triggeredEventLastTime = 10800,
    dayTriggeredEventFinishLimit = 5,
    dayPassiveTriggeredEventLimit = 3,
    maxTriggeredEventOfflineMessageNum = 10,
    channels = {
      [1] = ProtobufI("Misc.ChannelInfo", {
        name = "bilibili",
        id = "10029304",
        privilegeIgnore = true
      }),
      [2] = ProtobufI("Misc.ChannelInfo", {
        name = "taptap",
        id = "10025553",
        privilegeIgnore = true
      }),
      [3] = ProtobufI("Misc.ChannelInfo", {
        name = "yingyongbao",
        id = "3",
        privilegeIgnore = true
      })
    },
    gameDataReportOnlineTimePeriod = 300,
    gameDataReportPurchaseTimePeriod = 300,
    notifyCD = ProtobufI("Misc.NotifyCDs", {powerFull = 60, deployFinish = 30}),
    maxActorWarningCount = 4500,
    maxEquipWarningCount = 4000,
    dailySubscribeCheckTime = "12:00:00",
    payTestRechargeEndTime = "2028-08-26 23:59:59",
    payTestRewardStartTime = "2028-08-27 06:00:00",
    maxDanmuVideoLength = 180,
    maxDanmuTextLength = 30,
    msdkFriendIcon = "https://down.qq.com/dianji/fci_notify/OB-icon-tx.jpg",
    modifyNameTutorialLevel = 6,
    unlockFightSpeedLevel = 5,
    taskPresentRewardBoxId = 121002,
    CreditsListScrollVelocity = 3.0,
    citySceneUpdateTime1 = 8,
    citySceneUpdateTime2 = 20,
    clawCraneCost = ProtobufI("STResource", {
      type = 11,
      id = 61001,
      count = 1
    }),
    clawCraneSupplyTime = "12:30:00",
    maxTriggeredEventOwnCount = 10,
    gachaFreeTime = "06:00:00",
    clawCraneTotalProbability = 10000000,
    gachaPurpleSameTypeCount = 3,
    gachaOrangeSameTypeCount = 2,
    normalGachaPurpleProbability = 500,
    limitGachaPurpleProbability = 1000,
    gachaForceOrangeProbabilitiy = 100,
    actorAttrsVersion = 5,
    friendApplyLevelMin = 6,
    friendApplyLevelMax = 99,
    mailWarningCount = 80,
    chipExchangeSet = {
      [1] = 20001,
      [2] = 20014,
      [3] = 20008,
      [4] = 20135,
      [5] = 20006,
      [6] = 20114,
      [7] = 20133,
      [8] = 20116
    },
    chipExchangeMaxModifyCount = 2,
    dungeonActorOverflowExp = 7000,
    purblePairsTotalCnt = 18,
    purblePairsPerGroupCnt = 2,
    purblePairsMaxCntPerDay = 3,
    cultivationPVPHideRanks = 10,
    guildDungeonCloseTime = "00:00:00",
    guildDungeonOpenTime = "06:00:00",
    talentCheckVersion = 1,
    taskWeekStepReward = {
      [1] = ProtobufI("Misc.TaskWeekStepReward", {
        step = 3,
        reward = {
          [1] = ProtobufI("STResource", {
            type = 11,
            id = 73002,
            count = 2
          }),
          [2] = ProtobufI("STResource", {type = 5, count = 150})
        }
      }),
      [2] = ProtobufI("Misc.TaskWeekStepReward", {
        step = 5,
        reward = {
          [1] = ProtobufI("STResource", {type = 5, count = 200})
        }
      }),
      [3] = ProtobufI("Misc.TaskWeekStepReward", {
        step = 7,
        reward = {
          [1] = ProtobufI("STResource", {
            type = 11,
            id = 90001,
            count = 5
          }),
          [2] = ProtobufI("STResource", {type = 5, count = 400})
        }
      })
    },
    taskWeekRefreshMaxCountPerDay = 1,
    starPhases = {
      [1] = 0,
      [2] = 2,
      [3] = 3,
      [4] = 4,
      [5] = 4,
      [6] = 0
    },
    TowerNewMaxFloor = 8,
    gachaCustomTotalCount = 10,
    gachaCustomActorCount = 5,
    gachaCustomForceDropActivity = 91,
    temadunFreeRewardSwitch = 1,
    teamdunFreeTicket = {
      [23] = ProtobufI("STResource", {
        type = 11,
        id = 80011,
        count = 1
      }),
      [73] = ProtobufI("STResource", {
        type = 11,
        id = 80014,
        count = 1
      })
    },
    taskWeekBeginTime = "2018-12-19 00:00:00",
    halfYearBackActiveDay = 14,
    halfYearBackDuration = 12,
    halfYearBackShowDay = 1,
    halfYearBackCDTime = 60,
    halfYearBackLowLevel = 10,
    extremeChallengeDrugLimit = 100,
    maxCookingPlateNum = 8,
    maxRecipeResearchIndex = 3,
    catchItemMiniGameConfig = ProtobufI("Misc.CatchItemMiniGameConfig", {
      maxUntriggerTimes = 2,
      maxTriggeredTimes = 3,
      triggerColdDown = 2,
      triggerChance = 10000,
      triggerLevelMax = 99
    }),
    maxCookingRoleLevel = 9,
    extremeChallengeTicket = ProtobufI("STResource", {
      type = 11,
      id = 80013,
      count = 1
    }),
    voteGroupPlayerCnt = 50,
    oldPlayerBackTimeConf = 604800,
    dungeonTeamWelfareLimitLv = 30,
    cookingEatingOverLimitExp = 10,
    dormMaxNameLen = 7,
    dormFeedSeatMax = 6,
    dormFeedSeatDefault = 3,
    dormLevelMax = 8,
    dormFoodCountDefault = 10000,
    dormFoodCountMax = 50000,
    weaponMisc = ProtobufI("Misc.WeaponMisc", {
      weaponMaxPhase = 6,
      weaponGachaOrangeProb = 160,
      weaponGachaPurpleProb = 600,
      weaponNoGoldMax = 80,
      weaponShowLevel = 45,
      weaponLevelToStory = {
        [1] = 0,
        [2] = 3,
        [3] = 5
      },
      weaponGachaOrangeProbFeatured = 130,
      weaponGachaPurpleProbFeatured = 600
    }),
    dormFoodActorCost = ProtobufI("Misc.DormFoodActorCost", {
      actorFoodConst = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6
      }
    }),
    dormFoodRefreshInterval = 10,
    dormActorShowSeatFloorMax = 4,
    dormActorExpConst = ProtobufI("Misc.DormActorExpConst", {
      staticConst = 1,
      playerLevelConst = 1,
      dormComfortConst = 1,
      actorCountConst = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6
      }
    }),
    recommendExpire = 86400,
    dormDefaultFurniture = {
      [1] = 100001,
      [2] = 100002
    },
    dormFoodShopId = 31,
    dormActorGiftInterval = {
      [1] = 14400,
      [2] = 21600
    },
    dormCustomSchemeMax = 5,
    dormCustomSchemeNameMax = 5,
    dormVisitorListLimit = 10,
    friendPvpConf = ProtobufI("Misc.FriendPvpConfig", {
      roomExpireTime = 900,
      readyTimeOut = 90,
      dungeonExpireTime = 3600,
      heartBeatTime = 5,
      toleranceRate = 2
    }),
    inputLimit = ProtobufI("Misc.InputLimit", {TeamRCMDDescription = 120, TeamRCMDComment = 120}),
    guildRecruitConfig = ProtobufI("Misc.GuildRecruitConfig", {
      minDuration = 1,
      maxDuration = 24,
      maxBulletinContentLength = 100,
      publishCost = ProtobufI("STResource", {type = 17, count = 100}),
      addRecruitInterval = 60,
      getRecruitInterval = 10,
      randomBatchCount = 10
    }),
    guildLoanActorContributionReward = 40000,
    GcNameTimeInterval = 15552000,
    GcNameReward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 80010,
        count = 1
      })
    },
    mazeMiscConf = ProtobufI("Misc.MazeMisc", {
      mazeConfs = {
        [34001] = ProtobufI("Misc.MazeMisc.MazeConf", {
          chaosPollutionPerStep = 5.0,
          balanceParams = {
            [1] = ProtobufI("Misc.MazeMisc.MazeConf.BalanceParam", {floor = 17.33, events = 1.0}),
            [2] = ProtobufI("Misc.MazeMisc.MazeConf.BalanceParam", {floor = 17.33, events = 1.0}),
            [3] = ProtobufI("Misc.MazeMisc.MazeConf.BalanceParam", {floor = 17.33, events = 1.0}),
            [4] = ProtobufI("Misc.MazeMisc.MazeConf.BalanceParam", {floor = 17.33, events = 1.0}),
            [5] = ProtobufI("Misc.MazeMisc.MazeConf.BalanceParam", {floor = 17.33, events = 1.0})
          },
          reward = {
            [1] = ProtobufI("STResource", {type = 41, count = 100}),
            [2] = ProtobufI("STResource", {
              type = 11,
              id = 55005,
              count = 225
            }),
            [3] = ProtobufI("STResource", {
              type = 11,
              id = 55006,
              count = 10
            }),
            [4] = ProtobufI("STResource", {type = 7, count = 40000})
          },
          scoreToPointTransferRate = 100,
          chaosPollutionMax = 100.0,
          hollowDropCount = 3,
          campAddHpPercent = 2000,
          totalScoreMax = 100
        }),
        [34002] = ProtobufI("Misc.MazeMisc.MazeConf", {
          balanceParams = {},
          reward = {},
          hollowDropCount = 3,
          campAddHpPercent = 2000
        })
      },
      mikuActivityId = 34002,
      mazeActivityId = 34001,
      quickFightMaxRound = 9,
      mazeDefaultSkeletonResRoleId = 108,
      mazeRoleSpeed = 20,
      mazeChaosRecureItemId = 92000
    }),
    ShareGroupPointId = 32003,
    ShareGroupMonthPoint = 10,
    ShareGroupUploadPoint = 1,
    ShareGroupOnePageNum = 5,
    ShareGroupCopyNewestNum = 10,
    ShareGroupLikeAddCredit = 1,
    ShareGroupDislikeDecCredit = 1,
    ShareGroupMaxCredit = 100,
    ShareGroupMonthAddCredit = 50,
    ShareGroupFirstCopyPoint = 1,
    ShareGroupHotScoreParamX = 1,
    ShareGroupHotScoreParamY = 1,
    ShareGroupHotScoreParamZ = 1,
    ShareGroupMaxDailyShareCount = 3,
    screenSetting = ProtobufI("Misc.ScreenSetting", {maxNotch = 130, recommandNotch = 90}),
    RDPVPMaxNum = 5,
    WeaponGachaAddRes = ProtobufI("STResource", {type = 23, count = 15}),
    ShareGroupCopyMonthPoint = 999,
    ShareGroupLikeMonthPoint = 999,
    ShareGroupLikePoint = 1,
    ShareGroupCommentMonthPoint = 999,
    ShareGroupCommentPoint = 1,
    progressTaskSwitchingTime = 7,
    playerBackPauseStartTime = "2019-05-17 00:00:00",
    playerBackPauseEndTime = "2019-05-31 00:00:00",
    randomSkinLimitNum = 5,
    friendFastDeleteTime = 30,
    guildMailTitleLimit = 14,
    guildMailContentLimit = 128,
    asyncPvpV2Info = ProtobufI("Misc.AsyncPvpV2Info", {
      upgradeSeg = 3000,
      downSeg = 7000,
      simpleTargetCoefficient = 1.0,
      normalTargetCoefficient = 1.1,
      difficultTargetCoefficient = 1.2,
      specialActorCoefficient = 1.3,
      battleRecordSaveCnt = 10,
      dungeonID = 9999,
      affixID = {},
      defendRewards = {
        [1] = ProtobufI("STResource", {type = 7, count = 1000})
      },
      matchCosts = {
        [1] = ProtobufI("STResource", {
          type = 11,
          id = 80001,
          count = 1
        })
      },
      balanceWeekDay = 1,
      balanceEndHour = 6,
      maxContinueWin = 5,
      maxRewardWinCnt = 5,
      dailyBattleCnt = 3,
      defualtActorGroup = 1,
      rankAndMatchExpireTime = 86400
    }),
    shareTimeInterval = 60,
    recallActivityLevelLimit = 20,
    recallActivityDayLimit = 14,
    UnforcedTutorialMaxLevel = 20,
    playerBackMailEffectiveDay = 30,
    skipTutorialDungeon = 16,
    dungeonStarConfigVersion = 1,
    gachaFreeDropCount = 5,
    ptTaskPresent = 8,
    allowActorDecomposeDungeon = 10,
    newPlayerSignInConfig = {
      [1] = ProtobufI("Misc.newPlayerSignInConfigMisc", {activityId = 10201, totalDays = 14})
    },
    applyListLimit = 20,
    PringlesGifts = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 74038,
        count = 3
      }),
      [3] = ProtobufI("STResource", {type = 7, count = 23333})
    },
    PringlesMedalId = 99000,
    ExchangeShopRefreshDayOfWeek = 1,
    ExchangeShopRefreshTimeInDay = "00:00:00"
  })
}
local indexed = {}
return {raw, indexed}
