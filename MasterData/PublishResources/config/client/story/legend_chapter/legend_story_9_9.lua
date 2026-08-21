return {
  ComponentID = "0",
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "StoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 3,
      FitSize = false,
      Name = "十字遮罩",
      Resource = "uieff_Story_Mask.prefab",
      Type = "Effect"
    },
    [3] = {
      EntityID = 7,
      FitSize = false,
      Name = "遮罩",
      Resource = "",
      Type = "CrackMask"
    },
    [4] = {
      EntityID = 8,
      FitSize = true,
      Name = "舰桥背景图",
      Resource = "StoryBGjuxiangjianqiao2.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 9,
      FitSize = false,
      Name = "休息室背景",
      Resource = "StoryBGjuxiangxiuxishi.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 11,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      Effect = "",
      EntityID = 13,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 14,
      FitSize = false,
      Name = "测试",
      Resource = "1400071_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 15,
      FitSize = false,
      Name = "黑暗气息",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 16,
      FitSize = false,
      Name = "圆形遮罩",
      Resource = "1600061_spine_idle.prefab",
      Type = "SpineCircleEdge"
    },
    [11] = {
      EntityID = 17,
      FitSize = false,
      Name = "蒙版",
      Resource = "SpotLightBlack.prefab",
      Type = "SpotLight"
    },
    [12] = {
      EntityID = 18,
      FitSize = false,
      Name = "遮罩",
      Resource = "SpotLightMask.prefab",
      Type = "SpotLight"
    },
    [13] = {
      EntityID = 19,
      FitSize = false,
      Name = "冰霜",
      Resource = "uieff_Story_junlie.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 20,
      FitSize = true,
      Name = "水坝",
      Resource = "StoryBGshuiba.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 21,
      FitSize = true,
      Name = "水坝2",
      Resource = "StoryBGshuibaye.prefab",
      Type = "Picture"
    }
  },
  ID = 66666666,
  Name = "legend_story_9_9",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Time = 0
              }
            },
            RefEntityID = 21
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 99,
                PlayAnimation = "uieff_Story_junlie_out",
                Time = 0
              }
            },
            RefEntityID = 19
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Background = {
                    Offset = {0, 0},
                    Resource = ""
                  },
                  Duration = 0.2,
                  Radius = 350,
                  Shadow = {
                    Offset = {0, 0},
                    ShowShadow = false
                  },
                  StartFromCover = false
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          NextParagraphID = 2
        }
      }
    },
    [2] = {
      ComponentID = "0",
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          }
        }
      }
    }
  },
  SkipBlockIDs = {2},
  StartParagraph = 1
}
