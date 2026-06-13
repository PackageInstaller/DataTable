local empty = {}
return
{
  StoryId = 100102132,
  Steps = {
    {
      UseSpineRes = true,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        ShowEffect = {
          AnimTime = 0.6
        },
        HideEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        BackgroundBlurType = 1,
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002005",
            ChangeParentName = "",
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 1.2
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.8
              },
              {
                InsertAnim = "M_serious"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.23
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.82
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.54
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.67
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.63
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.54
              }
            },
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001007",
        Sound = "2-13saerweisi-5",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102132_1",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      ChangeScene = {
        OpenAnimTime = 1.0,
        CloseAnim = true,
        CloseDelay = 1.5
      }
    }
  },
}