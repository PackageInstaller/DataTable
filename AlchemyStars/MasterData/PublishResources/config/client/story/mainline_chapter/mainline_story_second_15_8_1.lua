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
      Name = "启光实验室背景图",
      Resource = "StoryBGqiguangshiyan.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "贡露立绘",
      Resource = "gonglu_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "启光科学家",
      Resource = "kexuejianan_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      Name = "卡莲",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "临空者立绘",
      Resource = "bahamosi_spine_idle.prefab",
      Type = "Spine"
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
      Name = "黑场灰尘",
      Resource = "uieff_blacksmoke.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      FitSize = true,
      Name = "启光科技园区背景图",
      Resource = "StoryBGqiguangkejiyuanqu.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "莺歌",
      Resource = "yingge_n24_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      FitSize = true,
      Name = "启光科技园区背景图2",
      Resource = "StoryBGqiguangkejiyuanqu.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "暗鬼群1",
      Resource = "anguiqun_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "暗鬼群2",
      Resource = "anguiqun_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "阴间特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "启光BGM",
      Resource = "31",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      Name = "敲门声",
      Resource = "10108",
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
      FitSize = false,
      Name = "衣服摩擦的声音",
      Resource = "10057",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "滴滴声",
      Resource = "10217",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "敌人低吼",
      Resource = "10013",
      Type = "Sound"
    }
  },
  ID = 10150801,
  Name = "mainline_story_second_15_8_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1
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
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_think",
                Position = {0, -400},
                Scaling = {0.95, 0.95},
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 20},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.2
                },
                Time = 0.1
              }
            },
            RefEntityID = 5
          },
          [4] = {
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
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangkexuejia"
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
                Scaling = {1.1, 1.1},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -350},
                  StartValue = {-600, -350}
                }
              }
            },
            RefEntityID = 6
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
                  EndValue = {400, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangkexuejia"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 6
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
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_surprise",
                Time = 0.8
              }
            },
            RefEntityID = 4
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
                Layer = 7,
                Scaling = {0.6, 0.6},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-350, -200},
                  StartValue = {-600, -200}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 12,
                Position = {0, 50},
                Scaling = {0.5, 0.5},
                Time = 0.1
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 17,
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
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
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Scaling = {1.5, 1.5},
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 12,
                Time = 0.1
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 17,
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
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
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 10,
                Scaling = {1.5, 1.5},
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0.6
              }
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 4
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 4
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
                LoopAnimation = "Story_swear",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
              }
            },
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 4
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 4
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.4
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_norm",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {300, -400},
                  StartValue = {400, -400}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Time = 0.4
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.2
                },
                Time = 0.5
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Time = 1.1
              },
              [4] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.2
                },
                Time = 1.2
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4},
              [2] = {StopSound = true, Time = 1.5}
            },
            RefEntityID = 21
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -400},
                  StartValue = {300, -400}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -350},
                  StartValue = {400, -400}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -400},
                  StartValue = {400, -350}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 7
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 3
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.8
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.3}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.3}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.3}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 1.3
              }
            },
            RefEntityID = 11
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 1.8
              }
            }
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 22, Time = 1.8}
            }
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
                Brightness = 1,
                Layer = 7,
                Scaling = {0.6, 0.6},
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {50, -200},
                  StartValue = {-250, -200}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1
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
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
                LoopAnimation = "Story_rebuke",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 1.8,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-350, -200},
                  StartValue = {-550, -200}
                }
              }
            },
            RefEntityID = 7
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Position = {0, -450},
                Scaling = {0.95, 0.95},
                Time = 0.4
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1.8,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -450},
                  StartValue = {0, -450}
                }
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {Layer = 3, Time = 0},
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 11
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
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
            RefEntityID = 7
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
            RefEntityID = 12
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
                LoopAnimation = "Story_swear",
                Time = 0
              }
            },
            RefEntityID = 7
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
            RefEntityID = 12
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
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
            RefEntityID = 7
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
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
                Layer = 6,
                Position = {-450, -150},
                Scale = {
                  Duration = 1,
                  EndValue = {0.9, 0.9},
                  StartValue = {0.8, 0.8}
                },
                Time = 0
              }
            },
            RefEntityID = 14
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
                Layer = 5,
                Position = {450, -150},
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.9, 0.9},
                  StartValue = {0.8, 0.8}
                },
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [4] = {
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
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 4,
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
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
            RefEntityID = 12
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_1015_10150801_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 7
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
            RefEntityID = 12
          }
        },
        [54] = {
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
              [2] = {Active = true, Time = 2.5}
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
