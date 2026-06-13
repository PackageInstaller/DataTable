local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          CustomEventName = "召唤装饰怪物组1",
          Type = 19,
          Timeout = 0.0
        },
        {

          StoryId = 2216105,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 10206,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10206,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2216107,
          Actions = {
            {

              StoryId = 2216108,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 1.0,
              StopStayTime = 2.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0,
              TimeoutKey = "NjUqdCJH"
            },
            {

              TimelineName = "timeline_316010403",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 5.5,
              TimeoutKey = "PqWLEUzr"
            },
            {

              TimelineName = "timeline_316010407",
              IsPlay = true,
              Type = 110,
              Timeout = 5.5,
              TimeoutKey = "RzJAlQHL"
            },
            {

              NPC = "Hero",
              Point = "teleportation1",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 5.5,
              TimeoutKey = "VXCQxRvn"
            },
            {

              CustomEventName = "移除装饰怪物组2",
              Type = 19,
              Timeout = 5.5,
              TimeoutKey = "DfkmRivl"
            },
            {

              FadeIn = 3.5,
              Hold = 2.0,
              FadeOut = 3.5,
              IsWhite = false,
              Type = 59,
              Timeout = 1.5,
              TimeoutKey = "iValNuhf"
            },
            {

              TimelineName = "timeline_316010403",
              Type = 7,
              Timeout = 25.0,
              TimeoutKey = "xiVPjsDP"
            },
            {

              FadeIn = 2.0,
              Hold = 4.5,
              FadeOut = 0.0,
              IsWhite = false,
              Type = 59,
              Timeout = 18.0,
              TimeoutKey = "mnbziIzx"
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2216105,
          Actions = {
            {

              TimelineName = "timeline_316010402",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_316010401",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0,
              TimeoutKey = "MkKaSmAy"
            },
            {

              TimelineName = "timeline_316010406",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              CustomEventName = "移除装饰怪物组1",
              Type = 19,
              Timeout = 0.0,
              TimeoutKey = "IaoIEZLh"
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2216106,
          Actions = {
            {

              StoryId = 2216107,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 1.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.0,
              StopStayTime = 1.0,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2216108,
          Actions = {
            {

              Key = "PqWLEUzr",
              Type = 52,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Key = "KLXEyukd",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "VXCQxRvn",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "FdONyxEZ",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "mnbziIzx",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "NjUqdCJH",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "iValNuhf",
              Type = 52,
              Timeout = 0.0
            },
            {

              Key = "xiVPjsDP",
              Type = 52,
              Timeout = 0.0
            },
            {

              CustomEventName = "移除装饰怪物组2",
              Type = 19,
              Timeout = 2.0,
              TimeoutKey = "cyHnkgDw"
            },
            {

              Key = "RzJAlQHL",
              Type = 52,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "召唤装饰怪物组1",
      Actions = {
        {

          PosKey = "Monster1",
          Rotation = 0,
          NPCId = 301603,
          NPCName = "Monster1_1",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "DfMLtOdH"
        },
        {

          PosKey = "Monster3",
          Rotation = 0,
          NPCId = 301606,
          NPCName = "Monster1_3",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "IhlufgKT"
        },
        {

          PosKey = "Monster5",
          Rotation = 0,
          NPCId = 301607,
          NPCName = "Monster1_5",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "hsEZyEJc"
        },
        {

          PosKey = "Monster7",
          Rotation = 0,
          NPCId = 301608,
          NPCName = "Monster1_7",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "BAdkuGuF"
        },
        {

          PosKey = "Monster9",
          Rotation = 0,
          NPCId = 301609,
          NPCName = "Monster1_9",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "icEcXkaY"
        },
        {

          PosKey = "Monster2",
          Rotation = 180,
          NPCId = 301610,
          NPCName = "Monster1_2",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "RmpiIXtV"
        },
        {

          PosKey = "Monster4",
          Rotation = 180,
          NPCId = 301611,
          NPCName = "Monster1_4",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "RRrbimGQ"
        },
        {

          PosKey = "Monster6",
          Rotation = 180,
          NPCId = 301612,
          NPCName = "Monster1_6",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "SpEtBDPC"
        },
        {

          PosKey = "Monster8",
          Rotation = 180,
          NPCId = 301613,
          NPCName = "Monster1_8",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "YqxpaKkU"
        },
        {

          PosKey = "Monster10",
          Rotation = 180,
          NPCId = 301614,
          NPCName = "Monster1_10",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "CTaNoqXm"
        },
        {

          PosKey = "Monster11",
          Rotation = -125,
          NPCId = 301615,
          NPCName = "Monster1_11",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "hDLNGbAE"
        },
        {

          PosKey = "Monster12",
          Rotation = -65,
          NPCId = 301616,
          NPCName = "Monster1_12",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "UYrOvXBl"
        },
        {

          PosKey = "BigMonster1",
          Rotation = -90,
          NPCId = 301604,
          NPCName = "BigMonster1_1",
          Type = 0,
          Timeout = 0.0,
          TimeoutKey = "VtfQOxWp"
        },
        {

          PosKey = "Soldier1",
          Rotation = 90,
          NPCId = 301605,
          NPCName = "Soldier1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "移除装饰怪物组1",
      Actions = {
        {

          NPCId = 301603,
          NPCName = "Monster1_1",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301606,
          NPCName = "Monster1_2",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301607,
          NPCName = "Monster1_3",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301608,
          NPCName = "Monster1_4",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301609,
          NPCName = "Monster1_5",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "YDShuuzE"
        },
        {

          NPCId = 301610,
          NPCName = "Monster1_6",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "ZrzneANq"
        },
        {

          NPCId = 301611,
          NPCName = "Monster1_7",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "FxLdhUgC"
        },
        {

          NPCId = 301612,
          NPCName = "Monster1_8",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "ljsXNqGT"
        },
        {

          NPCId = 301613,
          NPCName = "Monster1_9",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "lNOscVTP"
        },
        {

          NPCId = 301614,
          NPCName = "Monster1_10",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "OdkDNGdX"
        },
        {

          NPCId = 301615,
          NPCName = "Monster1_11",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "UzHxgLGG"
        },
        {

          NPCId = 301616,
          NPCName = "Monster1_12",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "tzNTCaHT"
        },
        {

          NPCId = 301604,
          NPCName = "BigMonster1_1",
          Type = 1,
          Timeout = 0.0,
          TimeoutKey = "eUAcMHUm"
        },
        {

          NPCId = 301605,
          NPCName = "Soldier1",
          Type = 1,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "召唤装饰怪物组2",
      Actions = {
        {

          PosKey = "Monster11",
          Rotation = -125,
          NPCId = 301615,
          NPCName = "Monster2_11",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster12",
          Rotation = -65,
          NPCId = 301616,
          NPCName = "Monster2_12",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "BigMonster1",
          Rotation = -90,
          NPCId = 301604,
          NPCName = "BigMonster2_1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Soldier2",
          Rotation = 197,
          NPCId = 301605,
          NPCName = "Soldier2",
          Type = 0,
          Timeout = 0.25,
          TimeoutKey = "UUZvPuuh"
        },
        {

          PosKey = "Monster1",
          Rotation = 0,
          NPCId = 301603,
          NPCName = "Monster1_1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster3",
          Rotation = 0,
          NPCId = 301606,
          NPCName = "Monster1_3",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster5",
          Rotation = 0,
          NPCId = 301607,
          NPCName = "Monster1_5",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster7",
          Rotation = 0,
          NPCId = 301608,
          NPCName = "Monster1_7",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster9",
          Rotation = 0,
          NPCId = 301609,
          NPCName = "Monster1_9",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster2",
          Rotation = 180,
          NPCId = 301610,
          NPCName = "Monster1_2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster4",
          Rotation = 180,
          NPCId = 301611,
          NPCName = "Monster1_4",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster6",
          Rotation = 180,
          NPCId = 301612,
          NPCName = "Monster1_6",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster8",
          Rotation = 180,
          NPCId = 301613,
          NPCName = "Monster1_8",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Monster10",
          Rotation = 180,
          NPCId = 301614,
          NPCName = "Monster1_10",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "移除装饰怪物组2",
      Actions = {
        {

          NPCId = 301615,
          NPCName = "Monster2_11",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301616,
          NPCName = "Monster2_12",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301604,
          NPCName = "BigMonster2_1",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301605,
          NPCName = "Soldier2",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301603,
          NPCName = "Monster1_1",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301606,
          NPCName = "Monster1_2",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301607,
          NPCName = "Monster1_3",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301608,
          NPCName = "Monster1_4",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301609,
          NPCName = "Monster1_5",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301610,
          NPCName = "Monster1_6",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301611,
          NPCName = "Monster1_7",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301612,
          NPCName = "Monster1_8",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301613,
          NPCName = "Monster1_9",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 301614,
          NPCName = "Monster1_10",
          Type = 1,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_316010402",
          Actions = {
            {

              Type = 60,
              Timeout = 1.0,
              TimeoutKey = "lMxLPudi"
            },
            {

              PosKey = "drop",
              Rotation = 0,
              NPCId = 301601,
              NPCName = "KeyDrop",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "zwEJrbou"
            },
            {

              TaskId = 31604,
              Type = 5,
              Timeout = 0.2,
              TimeoutKey = "LLfMLgDm"
            },
            {

              KeyName = "drop",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "KqXzkgYd"
            },
            {

              TimelineName = "timeline_316010401",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_316010406",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              CustomEventName = "召唤装饰怪物组2",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_316010403",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          CollectionId = 560210,
          Actions = {
            {

              StoryId = 2216106,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {

              TaskId = 31605,
              Type = 5,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 29,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterLockEnemyCount = 0,
    MonsterGroupId = 0,
    MonsterWave = 0,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true
  },
  FinishiConditionDict = {
    [ 4 ] = {
      StoryId = 2216108,
      Name = "播放剧情"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}