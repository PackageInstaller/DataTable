local empty = {}
return
{
  StoryId = 4040508,
  AlphaEffectEnd = true,
  Steps = {
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "4040508_1",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "4040508_2",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
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
            RoleImg = "SP_1001004",
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
            BodyAnim = {
              {
                InsertAnim = "B_shake"
              },
              {
                InsertAnim = "B_head",
                InsertAnimDelay = 3.5
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_mad2",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_mad2",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.54
              },
              {
                InsertAnim = "M_mad2",
                InsertAnimLifeTime = 0.15
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.77
              },
              {
                InsertAnim = "M_mad2",
                InsertAnimLifeTime = 0.41
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.85
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.18
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
        CharName = "1001004",
        Sound = "4-5xin_23",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "4040508_3",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    }
  },
}