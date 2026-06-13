local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          StatisticsIndex = 1,
          StatisticsType = 0,
          ManualCount = 60,
          FinishNotAdd = true,
          ChangeRoomReset = true,
          EventName = "qb",
          UnitIdStr = "",
          Type = 99,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 120,
          Timeout = 0.0
        },
        {

          Type = 49,
          Timeout = 0.0
        },
        {

          CustomEventName = "start",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "VyRQhwOY"
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Tips = "962",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 1.0,
          TimeoutKey = "GltSTlHg"
        },
        {

          Key = "V",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "V",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 17.0,
          TimeoutKey = "fYVwkNTl"
        },
        {

          Key = "B",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "B",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 47.0,
          TimeoutKey = "QoXWFUtr"
        },
        {

          Key = "on",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "Bstart",
          Type = 19,
          Timeout = 18.0,
          TimeoutKey = "NEqQYuEo"
        },
        {

          CustomEventName = "Nstart",
          Type = 19,
          Timeout = 48.0,
          TimeoutKey = "RkZHnUWw"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
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
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "B3",
      Actions = {
        {

          GroupId = 403310,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "XhHVZAaJ"
        },
        {

          CustomEventName = "B4",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "OuWhDNVy"
        },
        {

          Group = 403310,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "ATIdEoSB"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "B",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m13",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033013,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m9",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m10",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033010,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m11",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m9",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033009,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m10",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "Vstart",
      Actions = {
        {

          GroupId = 403305,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "BBAnfzUv"
        },
        {

          CustomEventName = "V2",
          Type = 19,
          Timeout = 0.0,
          TimeoutKey = "MoxBKfoi"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "V",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "B4",
      Actions = {
        {

          GroupId = 403311,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "byaBOpUT"
        },
        {

          CustomEventName = "B1",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "IujdoLRp"
        },
        {

          Group = 403311,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "qSBenccq"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "B",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "V3",
      Actions = {
        {

          GroupId = 403307,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "GBKZCMgg"
        },
        {

          CustomEventName = "V1",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "OeqpBxYg"
        },
        {

          Group = 403307,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "otvfznKJ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "V",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "B2",
      Actions = {
        {

          GroupId = 403309,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "zMPpgvYi"
        },
        {

          CustomEventName = "B3",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "oKxWLzRz"
        },
        {

          Group = 403309,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "EMcPDZJH"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "B",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m7",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033007,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m8",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m8",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033008,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m5",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          Key = "on",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          Group = 403301,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033005,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033007,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033008,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033002,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403302,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403303,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403304,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033009,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033010,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033011,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033012,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4033013,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403305,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403306,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403307,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403308,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403309,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403310,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403311,
          Type = 65,
          Timeout = 0.0
        },
        {

          Key = "V",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "B",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

      EventName = "chong3",
      Actions = {
        {

          GroupId = 403303,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "teIHvNXi"
        },
        {

          CustomEventName = "chong4",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "fhVciSRl"
        },
        {

          Group = 403303,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "OqEIimHx"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "chong2",
      Actions = {
        {

          GroupId = 403302,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "CCXsijLS"
        },
        {

          CustomEventName = "chong3",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "kjUwvmSo"
        },
        {

          Group = 403302,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "UZucJohr"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "V2",
      Actions = {
        {

          GroupId = 403306,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "eTNucktI"
        },
        {

          CustomEventName = "V3",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "YavXNKVv"
        },
        {

          Group = 403306,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "wLOYQpUF"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "V",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m6",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033006,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m7",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m12",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033012,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m13",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m11",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033011,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m12",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "Nstart",
      Actions = {
        {

          GroupId = 403301,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "fjrQGQKl"
        },
        {

          CustomEventName = "chong2",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "zBMJRCke"
        },
        {

          Group = 403308,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403309,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403310,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403311,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "Bstart",
      Actions = {
        {

          GroupId = 403308,
          Type = 27,
          Timeout = 0.0
        },
        {

          CustomEventName = "B2",
          Type = 19,
          Timeout = 0.0
        },
        {

          Group = 403305,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403306,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 403307,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "B",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "B1",
      Actions = {
        {

          GroupId = 403308,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "SfrQQLUl"
        },
        {

          CustomEventName = "B2",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "SpRTilCE"
        },
        {

          Group = 403308,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "jdSDbaok"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "B",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "V1",
      Actions = {
        {

          GroupId = 403305,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "zOvxGrTU"
        },
        {

          CustomEventName = "V2",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "NmuvjrzD"
        },
        {

          Group = 403305,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "oZPoVICf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "V",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "chong1",
      Actions = {
        {

          GroupId = 403301,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "rImuZKgD"
        },
        {

          CustomEventName = "chong2",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "VabDAIlN"
        },
        {

          Group = 403301,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "ZkvrPpcT"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "start",
      Actions = {
        {

          Type = 48,
          Timeout = 0.0
        },
        {

          CustomEventName = "Vstart",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m2",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m3",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m5",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m6",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m7",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m9",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m12",
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

      EventName = "m1",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033001,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m2",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033002,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m3",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m3",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033003,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m4",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m4",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033004,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m1",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m5",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4033005,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m6",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "chong4",
      Actions = {
        {

          GroupId = 403304,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "SHvpHbri"
        },
        {

          CustomEventName = "chong1",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "RCzgrHzU"
        },
        {

          Group = 403304,
          Type = 65,
          Timeout = 2.5,
          TimeoutKey = "yhoDhqPY"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Target = "Hero",
          MagicId = 399933,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 2.0,
          TimeoutKey = "WghQSuxY"
        }
      },
      ValidInTower = false,
      Type = 35,
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
    EventCount = 13,
    MonsterCount = 13,
    MonsterInfo = {
      [ 20304302 ] = 2,
      [ 20304602 ] = 2,
      [ 20204401 ] = 2,
      [ 20204301 ] = 3,
      [ 20204601 ] = 3,
      [ 20304402 ] = 1
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}