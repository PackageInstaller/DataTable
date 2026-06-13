local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          Intensity = 0.03,
          Type = 105,
          Timeout = 0.0
        },
        {

          StartDistance = 30.0,
          Type = 123,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 102,
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

          KeyName = "MID",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          PosKey = "MID",
          Rotation = -90,
          NPCId = 302231,
          NPCName = "JIXIA",
          Type = 0,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Day/sc06_area_03/sc06_area_03a/prop/sc06_prop_02_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TaskGroupId = 32202,
          Type = 21,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 3220001,
          Level = 1,
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

          StoryId = 2222301,
          Actions = {
            {

              CustomEventName = "1",
              Type = 19,
              Timeout = 0.0
            },
            {

              NPCId = 302231,
              NPCName = "JIXIA",
              Type = 1,
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

          StoryId = 100222302,
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
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2222304,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 2222305,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 2222306,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 2222307,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 2222308,
          Actions = empty,
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

          NPCId = 302231,
          Actions = {
            {

              StoryId = 2222301,
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

              TaskId = 3220201,
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
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "剧情1",
      Actions = {
        {

          StoryId = 2222302,
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
      FinishMarkVariable = "J1",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "J1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "关闭全部机关组",
      Actions = {
        {

          Group = 2201,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2202,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2203,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2204,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2205,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2206,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2207,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2208,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2209,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2210,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2211,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2212,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 2213,
          Type = 65,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 399933,
          Type = 103,
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

      EventName = "剧情4",
      Actions = {
        {

          StoryId = 3222302,
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
      FinishMarkVariable = "J4",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "J4",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "2",
      Actions = {
        {

          Key = "12w",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "34w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "5w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "开启战斗UI",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "TTzzMlkj"
        },
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "oJKtabCw"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "PFIOHOJB"
        },
        {

          Target = "Hero",
          MagicId = 4010142,
          Level = 1,
          Type = 16,
          Timeout = 1.0,
          TimeoutKey = "gLwMiJqk"
        },
        {

          CustomEventName = "回血",
          Type = 19,
          Timeout = 1.5,
          TimeoutKey = "oJXmLevJ"
        },
        {

          CustomEventName = "关闭全部机关组",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "mVnSblLS"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 2201,
          Type = 27,
          Timeout = 0.6,
          TimeoutKey = "UFOkttdI"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.8,
          TimeoutKey = "OqRzIxAz"
        },
        {

          GroupId = 2211,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "aSVZvOMS"
        },
        {

          GroupId = 2203,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "genabWAz"
        },
        {

          GroupId = 2202,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "qVkggvMy"
        },
        {

          CustomEventName = "剧情2",
          Type = 19,
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

      EventName = "剧情2",
      Actions = {
        {

          StoryId = 2222303,
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

          TaskId = 3220202,
          Type = 5,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "J2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "J2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "4",
      Actions = {
        {

          Key = "12w",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "34w",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "5w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "开启战斗UI",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "BOlZWyYw"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "JFNtKIws"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "roOgTEzy"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "hYwZZAzq"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group4",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "CeZSGmEh"
        },
        {

          Target = "Hero",
          MagicId = 4010142,
          Level = 1,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "QQidorXN"
        },
        {

          CustomEventName = "回血",
          Type = 19,
          Timeout = 1.5,
          TimeoutKey = "jbvKTSKs"
        },
        {

          CustomEventName = "关闭全部机关组",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "FManfVTx"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 2205,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "GftbBvmn"
        },
        {

          GroupId = 2213,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "vSMzAgtT"
        },
        {

          CustomEventName = "剧情4",
          Type = 19,
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

      EventName = "回血",
      Actions = {
        {

          Target = "Hero",
          MagicId = 3220005,
          Level = 1,
          Type = 16,
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

      EventName = "重启1",
      Actions = {
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          StoryId = 2222304,
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
          Timeout = 1.0,
          TimeoutKey = "UXSUHQYS"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "oHmLMyty"
        },
        {

          FadeIn = 0.5,
          Hold = 2.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          CustomEventName = "1",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "efKYQNyJ"
        },
        {

          Key = "1w",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "QPvkYcsM"
        },
        {

          Key = "1f",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "mSRsevuY"
        }
      },
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

          StoryId = 100222302,
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
          TimeoutKey = "VavWiVLe"
        },
        {

          Camera = 102,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "lvdhCWTf"
        },
        {

          TaskId = 3220203,
          Type = 5,
          Timeout = 0.0
        },
        {

          CustomEventName = "关闭全部机关组",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "TpuGbBNx"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group5",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "KRzznwiq"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
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

      EventName = "1",
      Actions = {
        {

          Key = "12w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "34w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "5w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "开启战斗UI",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "RaWoZMil"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "mqBSFfnC"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "zkLyEWpv"
        },
        {

          Target = "Hero",
          MagicId = 4010142,
          Level = 1,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "MjbwnyrF"
        },
        {

          CustomEventName = "回血",
          Type = 19,
          Timeout = 1.5,
          TimeoutKey = "doVJbccw"
        },
        {

          CustomEventName = "关闭全部机关组",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "kSQsnxew"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 2201,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "okFmEkOc"
        },
        {

          GroupId = 2210,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "NTIFlWSr"
        },
        {

          CustomEventName = "剧情1",
          Type = 19,
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

      EventName = "剧情3",
      Actions = {
        {

          StoryId = 3222301,
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
      FinishMarkVariable = "J3",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "J3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "3",
      Actions = {
        {

          Key = "12w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "34w",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "5w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "开启战斗UI",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "pyfysQtE"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "HnTsdOxD"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group3",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "DdVLkmdq"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "CZiGQBGS"
        },
        {

          Target = "Hero",
          MagicId = 4010142,
          Level = 1,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "qaGcVMnE"
        },
        {

          CustomEventName = "回血",
          Type = 19,
          Timeout = 1.5,
          TimeoutKey = "bNjyHGrD"
        },
        {

          CustomEventName = "关闭全部机关组",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "PgqeAOEM"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 2204,
          Type = 27,
          Timeout = 0.6,
          TimeoutKey = "aSJmgLdT"
        },
        {

          GroupId = 2212,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "gttDtqTS"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.8,
          TimeoutKey = "hZZGXUdg"
        },
        {

          GroupId = 2202,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "neFanqMX"
        },
        {

          GroupId = 2203,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "DxJWfKzN"
        },
        {

          CustomEventName = "剧情3",
          Type = 19,
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

      EventName = "剧情5",
      Actions = {
        {

          StoryId = 3222303,
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
      FinishMarkVariable = "J5",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "J5",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "5",
      Actions = {
        {

          Key = "12w",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "34w",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "5w",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "开启战斗UI",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "vySvfFqD"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "yLOgrqoh"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group4",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "kxYsEspJ"
        },
        {

          ObjName = "/Root/Level/Level_02/322/32202/group5",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "fxqDQorb"
        },
        {

          Target = "Hero",
          MagicId = 4010142,
          Level = 1,
          Type = 16,
          Timeout = 1.5,
          TimeoutKey = "AzdLkRtu"
        },
        {

          CustomEventName = "回血",
          Type = 19,
          Timeout = 1.5,
          TimeoutKey = "PeEkKvug"
        },
        {

          CustomEventName = "关闭全部机关组",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "emfhYzwJ"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 2206,
          Type = 27,
          Timeout = 0.6,
          TimeoutKey = "xeKqQPBI"
        },
        {

          GroupId = 2209,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "UZFwOExv"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 5.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.9,
          TimeoutKey = "HztiYfSH"
        },
        {

          GroupId = 2208,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "uPfcPMgy"
        },
        {

          Key = "fire",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.2,
          TimeoutKey = "bNIlVQmI"
        },
        {

          GroupId = 2207,
          Type = 27,
          Timeout = 1.49,
          TimeoutKey = "QyFiyxTP"
        },
        {

          CustomEventName = "剧情5",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "5w",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "重启2",
      Actions = {
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          StoryId = 2222305,
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
          Timeout = 1.0,
          TimeoutKey = "aJkSfIXw"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "nTKZBUjY"
        },
        {

          FadeIn = 0.5,
          Hold = 2.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          CustomEventName = "2",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "AcxPpDuk"
        },
        {

          Key = "2w",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "dHKkOQSa"
        },
        {

          Key = "2f",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "LMYXvHdM"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "重启4",
      Actions = {
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          StoryId = 3222304,
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
          Timeout = 1.0,
          TimeoutKey = "iWBifYnr"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "XDvVuuNU"
        },
        {

          FadeIn = 0.5,
          Hold = 3.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Key = "4f",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "tjyzSoiu"
        },
        {

          Key = "4w",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "AgaVWlxX"
        },
        {

          CustomEventName = "4",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "ztQEZOfp"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "开启战斗UI",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "JoystickContent",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = true,
          Type = 32,
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

      EventName = "重启3",
      Actions = {
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          StoryId = 3222304,
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
          Timeout = 1.0,
          TimeoutKey = "RbBgHpuj"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "SDxNOsyH"
        },
        {

          FadeIn = 0.5,
          Hold = 3.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Key = "3f",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "oUpmDFHA"
        },
        {

          Key = "3w",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "RbGgoPvy"
        },
        {

          CustomEventName = "3",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "TGGTLmxK"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "关闭战斗UI",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "JoystickContent",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = false,
          Type = 32,
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

      EventName = "重启5",
      Actions = {
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          StoryId = 3222304,
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
          Timeout = 1.0,
          TimeoutKey = "PlLHVyTs"
        },
        {

          NPC = "Hero",
          Point = "MID",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "ZuZvsQaV"
        },
        {

          FadeIn = 0.5,
          Hold = 3.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Key = "5f",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "OUROthVD"
        },
        {

          Key = "5w",
          Type = 116,
          Timeout = 1.0,
          TimeoutKey = "eXJoDuLg"
        },
        {

          CustomEventName = "5",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "kXXfnDSH"
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

          StoryId = 100222302,
          StepId = 0,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2222301,
          StepId = 0,
          Actions = {
            {

              Camera = 32202,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            0,
            0,
            0
          },
          Key = "1w",
          IsEveryStepCheck = true,
          SuccessEvent = "2",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0,
            0,
            0
          },
          Key = "2w",
          IsEveryStepCheck = true,
          SuccessEvent = "3",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0,
            0,
            0,
            0
          },
          Key = "3w",
          IsEveryStepCheck = true,
          SuccessEvent = "4",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0,
            0,
            0,
            0,
            0
          },
          Key = "4w",
          IsEveryStepCheck = true,
          SuccessEvent = "5",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0,
            0,
            0,
            0,
            0,
            0
          },
          Key = "5w",
          IsEveryStepCheck = true,
          SuccessEvent = "win",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 33,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            0
          },
          Key = "1f",
          IsEveryStepCheck = false,
          SuccessEvent = "重启1",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0
          },
          Key = "2f",
          IsEveryStepCheck = false,
          SuccessEvent = "重启2",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0
          },
          Key = "3f",
          IsEveryStepCheck = false,
          SuccessEvent = "重启3",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0
          },
          Key = "4f",
          IsEveryStepCheck = false,
          SuccessEvent = "重启4",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0
          },
          Key = "5f",
          IsEveryStepCheck = false,
          SuccessEvent = "重启5",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 33,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      StoryID = 100222301,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 100222301,
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
      Type = 37,
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}