local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 3,
            MonsterCount = 20,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 106110101,
                param = 2,
                Name = "剩余",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 1,
                Id = 106110102,
                param = 2,
                Name = "剩余",
                CustomEventName = "dialog",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 106110103,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "end",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
            MonsterLockEnemyInfoList = empty,
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "PCpzdTGE"
        },
        {

          Point = "center",
          Type = 3,
          Timeout = 0.0
        },
        {

          FadeIn = 0.0,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          GroupId = 10611101,
          Type = 27,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_chapter6_elite",
          Type = 76,
          Timeout = 0.0
        },
        {

          GroupId = 10611102,
          Type = 27,
          Timeout = 0.0
        },
        {

          TaskGroupId = 10610,
          Type = 21,
          Timeout = 0.0
        },
        {

          StoryId = 5061802,
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
          Timeout = 1.5,
          TimeoutKey = "qzoUBISR"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 106000,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 106000,
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
        },
        {

          Key = "cancel_born_skill",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
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

      Actions = {
        {

          Key = "statue_break",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "statue",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "statue_break",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 12,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "end",
      Actions = {
        {

          Type = 69,
          Timeout = 0.75,
          TimeoutKey = "EpuBGVdh"
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.75,
          TimeoutKey = "wNsQeZuf"
        },
        {

          Group = 106110104,
          Type = 65,
          Timeout = 0.75,
          TimeoutKey = "cWZnZZaE"
        },
        {

          Group = 10611101,
          Type = 65,
          Timeout = 0.75,
          TimeoutKey = "gIdnyeqc"
        },
        {

          TimelineName = "TIMELINE6_2_1_0",
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
          BeforeBlackIn = 0.5,
          BeforeHold = 1.0,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          TaskId = 1061001,
          Type = 5,
          Timeout = 0.0
        },
        {

          Group = 10611102,
          Type = 65,
          Timeout = 0.75,
          TimeoutKey = "bbohnMlP"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "statue",
      Actions = {
        {

          Tips = "966",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 1.5,
          TimeoutKey = "XaKudQGZ"
        },
        {

          CustomEventName = "清理关卡",
          Type = 19,
          Timeout = 2.25,
          TimeoutKey = "xlHgqhnZ"
        },
        {

          NPC = "Hero",
          Point = "bornpoint",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 2.5,
          TimeoutKey = "GaXwYhOl"
        },
        {

          Target = "Hero",
          MagicId = 103314,
          Level = 0,
          Type = 16,
          Timeout = 2.5,
          TimeoutKey = "NoNVjjfs"
        },
        {

          CustomEventName = "布置关卡",
          Type = 19,
          Timeout = 2.5,
          TimeoutKey = "PAuLMOrI"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "布置关卡",
      Actions = {
        {

          Tips = "967",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.5,
          TimeoutKey = "EhyMWOIH"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 1,
            MonsterGroupId = 0,
            MonsterWave = 3,
            MonsterCount = 20,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 106110101,
                param = 2,
                Name = "剩余",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 1,
                Id = 106110102,
                param = 2,
                Name = "剩余",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 106110103,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "end",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
            MonsterLockEnemyInfoList = {
              {
                Target = "3001071",
                Weight = 999,
                Behit = 1,
                IgnoreDistance = true
              }
            },
          },
          Type = 8,
          Timeout = 1.0,
          TimeoutKey = "KSWaGtWB"
        },
        {

          Point = "center",
          Type = 3,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 2,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 106110104,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "statue",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        },
        {

          GroupId = 10611101,
          Type = 27,
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

      EventName = "清理关卡",
      Actions = {
        {

          Type = 69,
          Timeout = 0.0
        },
        {

          Group = 106110104,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 10611101,
          Type = 65,
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

      EventName = "dialog",
      Actions = {
        {

          StoryId = 5061801,
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "TIMELINE6_2_1_0",
          Actions = {
            {

              StoryId = 1001061802,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = true,
              Type = 10,
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

          TimelineName = "TIMELINE6_2_1_0",
          Actions = {
            {

              Path = "/Root/Level/Level_01/sc06_house_06a_pre (1)/scene_timeline_breakdoor",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              PlayBgm = "storybgm_055",
              Type = 76,
              Timeout = 2.5,
              TimeoutKey = "YKLIYdzO"
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
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
    [ 7 ] = {
      StoryId = 1001061802,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 42,
    MonsterInfo = {
      [ 20204601 ] = 4,
      [ 20204401 ] = 6,
      [ 20105201 ] = 2,
      [ 20204301 ] = 12,
      [ 20104901 ] = 2,
      [ 20204901 ] = 6,
      [ 20205001 ] = 4,
      [ 20105001 ] = 4,
      [ 3001071 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}