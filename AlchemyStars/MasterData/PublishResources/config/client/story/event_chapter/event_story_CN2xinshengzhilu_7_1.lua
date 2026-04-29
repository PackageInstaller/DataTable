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
      FitSize = true,
      Name = "天空背景",
      Resource = "StoryBGriguang.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "热浪特效",
      Resource = "uieff_relang.prefab",
      Type = "Effect"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "后处理",
      Resource = "UIDistortion.asset",
      Type = "PostProcessing"
    },
    [6] = {
      EntityID = 6,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "红油扳手帮众立绘",
      Resource = "hongyoushibing_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [8] = {
      EntityID = 8,
      Name = "红油扳手帮众立绘",
      Resource = "hongyoushibing_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      Name = "伊芙赛季皮肤",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      Name = "残破玩偶",
      Resource = "niuqubuou_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "阴间特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      FitSize = true,
      Name = "红油扳手营地背景",
      Resource = "StoryBGrediesel.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      Name = "陆行者号CG1",
      Resource = "CGluxingzhehao1.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      Name = "陆行者号CG2",
      Resource = "CGluxingzhehao2.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 15,
      Name = "陆行者号CG3",
      Resource = "CGluxingzhehao3.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 16,
      Name = "陆行者号CG4",
      Resource = "CGluxingzhehao4.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 17,
      Name = "陆行者号CG5",
      Resource = "CGluxingzhehao5.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 18,
      Name = "陆行者号CG6",
      Resource = "CGluxingzhehao6.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "沙尘暴特效",
      Resource = "uieff_Story_SandStorm.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "红油扳手BGM",
      Resource = "39",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "蝉鸣",
      Resource = "10409",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      Name = "建筑物形变倒塌氛围音",
      Resource = "10183",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "呼啸风声",
      Resource = "10085",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "暗鬼低语",
      Resource = "10014",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    }
  },
  ID = 50550701,
  Name = "event_story_CN2xinshengzhilu_7_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.2
              },
              [2] = {ShowContent = 0.02, Time = 2.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
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
                  Duration = 1,
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
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 21
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.5
              },
              [2] = {ShowContent = 0.02, Time = 3.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 51,
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 40,
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 45,
                Time = 0.3
              }
            },
            RefEntityID = 14
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 44,
                Scale = {
                  Duration = 3,
                  EndValue = {1.05, 1.05},
                  StartValue = {1, 1}
                },
                Time = 0.4
              }
            },
            RefEntityID = 15
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 43,
                Scale = {
                  Duration = 3,
                  EndValue = {1.02, 1.02},
                  StartValue = {1, 1}
                },
                Time = 0.4
              }
            },
            RefEntityID = 16
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 41,
                Rotate = {
                  Duration = 3,
                  EndValue = 3,
                  StartValue = 0
                },
                Scale = {
                  Duration = 3,
                  EndValue = {1, 1},
                  StartValue = {0.95, 0.95}
                },
                Time = 0.4
              }
            },
            RefEntityID = 17
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 42,
                Scale = {
                  Duration = 3,
                  EndValue = {1, 1},
                  StartValue = {0.95, 0.95}
                },
                Time = 0.4
              }
            },
            RefEntityID = 18
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 49,
                Time = 0.4
              }
            },
            RefEntityID = 19
          },
          [12] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -50},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.3
              }
            }
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 22
          },
          [14] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 20, Time = 0.3}
            }
          },
          [15] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 23
          },
          [16] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 24
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_5_dialog_content",
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
            DialogContentStr = "ui_story_5055_50550701_6_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_8_dialog_content",
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
            DialogContentStr = "ui_story_5055_50550701_9_dialog_content",
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
            DialogContentStr = "ui_story_5055_50550701_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_linjudage"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Position = {-400, 0},
                Scaling = {0.45, 0.45},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -350},
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.02, Time = 1.5}
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
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 8,
                Scaling = {0.45, 0.45},
                Time = 0.8,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -350},
                  StartValue = {600, -350}
                }
              }
            },
            RefEntityID = 8
          },
          [4] = {
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
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 4
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 5
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 14
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [12] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 16
          },
          [13] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 17
          },
          [14] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 18
          },
          [15] = {
            KeyFrames = {
              [1] = {
                Active = false,
                EffectFullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 19
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_linjudage"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_linjudage"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_15_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_angry",
                Time = 0
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -220},
                  StartValue = {-400, -270}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -270},
                  StartValue = {-400, -220}
                }
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_16_dialog_content",
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
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.1, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaoxiongwanou"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_angry",
                Position = {0, -50},
                Scaling = {0.45, 0.45},
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-500, -270},
                  StartValue = {-400, -270}
                }
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {500, -350},
                  StartValue = {400, -350}
                }
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 25
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 26,
                Time = 0
              }
            }
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_21_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_scare",
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_22_dialog_content",
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
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_linjudage"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_24_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-500, -220},
                  StartValue = {-500, -270}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-500, -270},
                  StartValue = {-500, -220}
                }
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.1, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaoxiongwanou"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_26_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50550701_27_dialog_content",
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
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-150, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [21] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 2.8}
            },
            RefEntityID = 2
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
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
