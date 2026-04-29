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
      EntityID = 2,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 3,
      Name = "绘本碎片巨像",
      Resource = "juxiang.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "赤眼谷",
      Resource = "StoryBGchiyangu.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      Name = "伊芙赛季皮肤",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "热浪特效",
      Resource = "uieff_relang.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "后处理",
      Resource = "UIDistortion.asset",
      Type = "PostProcessing"
    },
    [8] = {
      EntityID = 8,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "反色特效",
      Resource = "uieff_Story_AntiDeColor.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      FitSize = true,
      Name = "舰桥背景图",
      Resource = "StoryBGjuxiangjianqiao2.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "男主立绘",
      Resource = "nanzhu_zuzhou_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 14,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 15,
      FitSize = true,
      Name = "蜂网背景",
      Resource = "StoryBGhive.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 16,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "翻书",
      Resource = "10146",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      Name = "电磁音效",
      Resource = "10039",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "暗鬼低语",
      Resource = "10014",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "电磁1",
      Resource = "10077",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "黑烟火星",
      Resource = "uieff_heiyanhuoxing.prefab",
      Type = "Effect"
    }
  },
  ID = 50559909,
  Name = "event_story_CN2xinshengzhilu_99_9",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.2
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 17, Time = 0.5}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Position = {-50, 50},
                Rotation = 20,
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.8, 0.8},
                  StartValue = {1, 1}
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 18
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Position = {-400, -270},
                Scaling = {0.85, 0.85},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {350, 50},
                  StartValue = {-50, 50}
                }
              }
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0,
                    EndValue = 1,
                    StartValue = 1,
                    Var = "_Decolor"
                  }
                },
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 0,
                  EndValue = 0.5,
                  StartValue = 0.5
                },
                Layer = 20,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 11,
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 19,
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 20,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 11,
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_pain",
                Shake = {
                  Duration = 1,
                  Strength = {60, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.8
              }
            },
            RefEntityID = 5
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 11,
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              },
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 17,
                Time = 0.1
              }
            },
            RefEntityID = 14
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 13,
                LoopAnimation = "Story_heiying",
                Position = {0, -250},
                Scaling = {0.95, 0.95},
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 11,
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              },
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 17,
                Time = 0.1
              }
            },
            RefEntityID = 14
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_scare",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 11,
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              },
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 17,
                Time = 0.1
              }
            },
            RefEntityID = 14
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559909_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [12] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 1.5}
            },
            RefEntityID = 2
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              }
            }
          }
        }
      }
    }
  },
  StartParagraph = 1
}
