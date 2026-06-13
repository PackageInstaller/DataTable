local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10802/sc08_prop_60a_mod",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10802/scene_timeline_1080201_estatuas",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
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

          ObjName = "/Root/Level_/Level/10802/scene_timeline_1080201_estatuas",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 8,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10803201,
                param = 1,
                Name = "全部杀死",
                CustomEventName = "castigado",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 10802101,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "标记1",
                Timeout = 1.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.0,
          TimeoutKey = "lEKJgixU"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "castigado",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 2,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10803202,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 10803203,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "标记2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "fought",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "标记1",
      Actions = {
        {

          CustomEventName = "win",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "怪物1",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "win",
      Actions = {
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_10803_vigilancia2",
          Fadein = 0.0,
          Fadeout = 3.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = true,
          DelayDestroy = false,
          BeforeBlackIn = 0.3,
          BeforeHold = 0.5,
          BeforeBlackOut = 0.3,
          IsWhite = false,
          Type = 6,
          Timeout = 1.0,
          TimeoutKey = "IjEsYkfG"
        },
        {

          StoryId = 4080405,
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
          Timeout = 2.0,
          TimeoutKey = "REPbGuAh"
        },
        {

          NPC = "Hero",
          Point = "cmr",
          Rotate = -90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.5,
          TimeoutKey = "ZuNYwzEt"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "fought",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "标记2",
      Actions = empty,
      FinishMarkVariable = "怪物2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "怪物1",
            "怪物2"
          },
          Actions = {
            {

              Type = 22,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_10803_vigilancia2",
              Fadein = 0.0,
              Fadeout = 3.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.3,
              BeforeHold = 0.5,
              BeforeBlackOut = 0.3,
              IsWhite = false,
              Type = 6,
              Timeout = 1.0,
              TimeoutKey = "PbOCkhmM"
            },
            {

              StoryId = 4080405,
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
              Timeout = 2.0,
              TimeoutKey = "shRdjVxw"
            },
            {

              NPC = "Hero",
              Point = "cmr",
              Rotate = -90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.5,
              TimeoutKey = "GPYHyfuY"
            }
          },
          FinishMarkVariable = "怪物3",
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "怪物3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4080405,
          Actions = {
            {

              PosKey = "tp4",
              NPCName = "iiNtcyUw",
              NpcParams = {
                InteractionArea = -1.0,
                UseEffect = "Fx_Transmit3_idel|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638732505862083444,
              IsRemove = false,
              Type = 92,
              Timeout = 0.0
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_10803_vigilancia2",
              Type = 7,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "finish",
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

          Key = "tp4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TaskId = 1080303,
              Type = 5,
              Timeout = 0.0
            },
            {

              StoryId = 1001080402,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = true,
              Type = 10,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "finish",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TaskId = 1080303,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 14,
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
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 10,
    MonsterInfo = {
      [ 20205501 ] = 4,
      [ 20105701 ] = 3,
      [ 20105601 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}