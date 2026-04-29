return {
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
      Effect = "",
      EntityID = 3,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "舰桥",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [5] = {
      Effect = "EMI",
      EntityID = 5,
      Name = "雷吉娜切条",
      Resource = "1500181_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [6] = {
      EntityID = 6,
      Name = "对话Slice阴影",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [10] = {
      EntityID = 10,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      Name = "临空者立绘",
      Resource = "bahamosi_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [14] = {
      Effect = "EMI",
      EntityID = 14,
      Name = "比比比切条",
      Resource = "baozhakuang_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [15] = {
      EntityID = 15,
      Name = "对话Slice阴影-2",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 16,
      FitSize = true,
      Name = "红油沙漠背景图替代",
      Resource = "StoryBGhongyoushamo.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 17,
      Name = "醒山立绘",
      Resource = "xingshanjuqing_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 18,
      Name = "比比比约恩立绘",
      Resource = "baozhakuang_spine_idle.prefab",
      Type = "Spine"
    },
    [19] = {
      EntityID = 19,
      Name = "雷吉娜立绘",
      Resource = "1500181_spine_idle.prefab",
      Type = "Spine"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "醒山手动刹车CG",
      Resource = "CGXingshanshache.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 21,
      Name = "醒山横向slice",
      Resource = "1600301_spine_idle.prefab",
      Type = "SpineSliceHorizontal"
    },
    [22] = {
      EntityID = 22,
      Name = "通讯",
      Resource = "10078",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "电磁1",
      Resource = "10077",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "爆炸",
      Resource = "10049",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "船体破裂",
      Resource = "10033",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "红油扳手音乐",
      Resource = "39",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "震动破碎",
      Resource = "10024",
      Type = "Sound"
    },
    [29] = {
      EntityID = 29,
      FitSize = false,
      Name = "强烈震动",
      Resource = "10036",
      Type = "Sound"
    },
    [30] = {
      EntityID = 30,
      FitSize = false,
      Name = "降落音效",
      Resource = "2037",
      Type = "Sound"
    }
  },
  ID = 50010501,
  Name = "event_story_yifu_1_5_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
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
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 8, Time = 1}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1.2
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1.4
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 1.3
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 1.5
              },
              [5] = {Active = true, Time = 2.2}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 22
          }
        },
        [2] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.2
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.3
              },
              [5] = {Active = true, Time = 1}
            },
            RefEntityID = 10
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_A1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Layer = 8,
                LoopAnimation = "Story_serious",
                Position = {0, -400},
                Scaling = {0.42, 0.42},
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_A2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_7_dialog_content",
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
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_smile",
                Position = {450, 0},
                Scaling = {1.4, 1.4},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {150, -50},
                Time = 0
              }
            },
            RefEntityID = 5
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
                Layer = 19,
                Position = {450, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-450, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Time = 0
              },
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 3
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
            RefEntityID = 5
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 9, Time = 0}
            }
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
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
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                Position = {0, 50},
                Scaling = {0.45, 0.45},
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Time = 0.1
              }
            },
            RefEntityID = 13
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.1
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bbb"
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
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 49,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 40,
                Time = 0.1
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {Brightness = 0.2, Time = 0}
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Scaling = {0.9, 0.9},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -450},
                Time = 0.4
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 24,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0.4
              }
            },
            RefEntityID = 15
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 23
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 3
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
            RefEntityID = 5
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            Options = {
              [1] = {
                Content = "ui_story_5001_50010501_19_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_5001_50010501_21_option_content",
                NextParagraphID = 3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
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
            RefEntityID = 5
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          NextParagraphID = 4
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 3
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
            RefEntityID = 5
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
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
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                Position = {0, 50},
                Scaling = {0.45, 0.45},
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Time = 0.1
              }
            },
            RefEntityID = 13
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.1
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 49,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 45,
                Position = {0, 50},
                Scaling = {0.45, 0.45},
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 40,
                Time = 0.1
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_anger",
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-350, -400},
                  StartValue = {-450, -400}
                }
              }
            },
            RefEntityID = 3
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {Scaling = 0.9, Time = 0.1}
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 3
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
            RefEntityID = 5
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -400},
                  StartValue = {-350, -400}
                }
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_30_dialog_content",
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
                  Duration = 1,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 80
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
                  EndValue = 0.8,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.2
              },
              [2] = {Active = false, Time = 0.8}
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                LoopAnimation = "Story_serious",
                Time = 0.4
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 26
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bbb"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Scaling = {0.9, 0.9},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -450},
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
                Layer = 24,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
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
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.5,
                Layer = 45,
                Position = {0, 50},
                Scaling = {0.45, 0.45},
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Time = 0.1
              }
            },
            RefEntityID = 13
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.1
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
          }
        },
        [14] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 49,
                Time = 0.3
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3
              }
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 16
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 11
          },
          [6] = {
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
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 3
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 4
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 5
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 6
          },
          [11] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_serious",
                Position = {450, -450},
                Scaling = {0.5, 0.5},
                Time = 0.5
              }
            },
            RefEntityID = 17
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StartBgm = 27,
                Time = 0.5
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bbb"
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
                Position = {-450, -400},
                Scaling = {0.9, 0.9},
                Time = 0
              }
            },
            RefEntityID = 18
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
            RefEntityID = 17
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
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
                Time = 0
              }
            },
            RefEntityID = 18
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
                Layer = 8,
                Position = {-350, -30},
                Scaling = {1.4, 1.4},
                Time = 0
              }
            },
            RefEntityID = 19
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
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
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, 50},
                  StartValue = {0, 0}
                }
              }
            }
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
              },
              [2] = {
                LoopAnimation = "Story_anger",
                Time = 0.2
              }
            },
            RefEntityID = 17
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
            RefEntityID = 19
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
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
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                Position = {0, 50},
                Scaling = {0.45, 0.45},
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Time = 0.1
              }
            },
            RefEntityID = 13
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.1
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 19
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 17
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
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
                Layer = 50,
                Time = 0.6
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 49,
                Time = 0.9
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.9},
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 40,
                Time = 0.9
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 40,
                Scaling = {1.05, 1.05},
                Time = 0.5
              },
              [2] = {Active = true, Time = 4.5}
            },
            RefEntityID = 20
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 49,
                Time = 0.3
              },
              [2] = {Active = false, Time = 0.9}
            },
            RefEntityID = 2
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = 0.9,
                  StartValue = 0.5
                },
                Shake = {
                  Duration = 3,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 80
                },
                Time = 1
              },
              [2] = {
                Scale = {
                  Duration = 3,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 1.3
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 28
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 26
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 29
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 30
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_44_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bbb"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                Position = {0, 100},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "VerticalSpread"
                },
                SpineOffset = {0, -350},
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
          }
        },
        [27] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "VerticalSpread"
                },
                Time = 0
              },
              [2] = {Active = true, Time = 0.4}
            },
            RefEntityID = 21
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
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
                Brightness = 1,
                LoopAnimation = "Story_itai",
                Time = 0.9,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -450},
                  StartValue = {0, -550}
                }
              },
              [2] = {
                Time = 1.7,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -400},
                  StartValue = {0, -450}
                }
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.4
              }
            },
            RefEntityID = 20
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_norm",
                Position = {450, 0},
                Scaling = {1.4, 1.4},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {150, -50},
                Time = 0
              }
            },
            RefEntityID = 5
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
                Layer = 19,
                Position = {450, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-450, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Time = 0
              },
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
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
                Time = 0
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010501_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [34] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 2}
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
