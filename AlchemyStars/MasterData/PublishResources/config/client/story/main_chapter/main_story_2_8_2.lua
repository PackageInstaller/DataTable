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
      EntityID = 15,
      Name = "醒山立绘",
      Resource = "xingshanjuqing_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 16,
      Name = "卡戎横条",
      Resource = "1600251_spine_idle.prefab",
      Type = "SpineSliceHorizontal"
    },
    [5] = {
      EntityID = 17,
      FitSize = true,
      Name = "野外背景",
      Resource = "StoryBGnorm2.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 18,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 19,
      Name = "打击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 20,
      FitSize = true,
      Name = "野外场景1",
      Resource = "StoryBGnorm2.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 21,
      Name = "黑蹄立绘",
      Resource = "heiti_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 22,
      Name = "红色遮罩",
      Resource = "RedPic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 23,
      Name = "卡戎立绘",
      Resource = "1600251_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 24,
      Name = "比比比约恩切条",
      Resource = "baozhakuang_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [13] = {
      EntityID = 25,
      Name = "对话Slice阴影-比比比",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 26,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 27,
      Name = "麦格芬立绘",
      Resource = "2900021_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      Effect = "EMI",
      EntityID = 28,
      Name = "舒摩尔切条",
      Resource = "shumoer_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [17] = {
      EntityID = 29,
      Name = "对话Slice阴影-舒摩尔",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [18] = {
      Effect = "EMI",
      EntityID = 30,
      Name = "吞罗切条",
      Resource = "tunluo_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [19] = {
      EntityID = 31,
      Name = "对话Slice阴影-吞罗",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [20] = {
      EntityID = 32,
      FitSize = false,
      Name = "卡戎逃生音效",
      Resource = "10010",
      Type = "Sound"
    },
    [21] = {
      EntityID = 34,
      FitSize = false,
      Name = "攻击",
      Resource = "10004",
      Type = "Sound"
    },
    [22] = {
      EntityID = 35,
      Name = "击打音效",
      Resource = "10073",
      Type = "Sound"
    },
    [23] = {
      EntityID = 36,
      FitSize = false,
      Name = "敌人低吼",
      Resource = "10013",
      Type = "Sound"
    },
    [24] = {
      EntityID = 37,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [25] = {
      EntityID = 38,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [26] = {
      EntityID = 39,
      FitSize = false,
      Name = "电磁2",
      Resource = "10078",
      Type = "Sound"
    },
    [27] = {
      EntityID = 40,
      FitSize = false,
      Name = "电磁1",
      Resource = "10077",
      Type = "Sound"
    },
    [28] = {
      EntityID = 41,
      Name = "怪物音效",
      Resource = "10028",
      Type = "Sound"
    },
    [29] = {
      EntityID = 42,
      FitSize = false,
      Name = "利刃打击",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [30] = {
      EntityID = 43,
      FitSize = false,
      Name = "物理攻击",
      Resource = "10004",
      Type = "Sound"
    },
    [31] = {
      EntityID = 44,
      FitSize = false,
      Name = "利刃新音效",
      Resource = "10094",
      Type = "Sound"
    }
  },
  ID = 10020802,
  Name = "main_story_2_8_2",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              },
              [3] = {Active = true, Time = 1.2}
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.4,
                  StartValue = 0.4
                },
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [3] = {
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
        [2] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 20,
                Position = {0, -150},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.5, 0.5},
                  StartValue = {0.4, 0.4}
                },
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 41
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1.5,
                  fadeOut = true,
                  Strength = {0, 60},
                  Vibrato = 60
                },
                Time = 0.2
              }
            }
          }
        },
        [3] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 80,
                Scaling = {0.6, 0.6},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "LeftToRight"
                },
                SliceHeightScale = 2,
                SpineOffset = {0, -570},
                Time = 0
              },
              [2] = {
                LoopAnimation = "Story_anger",
                Time = 1
              }
            },
            RefEntityID = 16
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.7,
                  StartValue = 0.9
                },
                Time = 1
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              },
              [3] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.6,
                  StartValue = 0.7
                },
                Shake = {
                  Duration = 1.5,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 80
                },
                Time = 2
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Layer = 95,
                Time = 2
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.6
                },
                Time = 2.1
              },
              [3] = {Active = true, Time = 3.8}
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 97,
                Time = 1
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 2
              }
            },
            RefEntityID = 22
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 96,
                Time = 2
              }
            },
            RefEntityID = 42
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 43
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 44
          }
        },
        [4] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.5,
                  StartFromCover = false,
                  Toward = "VerticalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 70,
                Time = 0.7
              }
            },
            RefEntityID = 19
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.4
                },
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.7
                },
                Time = 0
              }
            }
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
                Layer = 20,
                Position = {0, -150},
                Scaling = {0.5, 0.5},
                Time = 0
              },
              [2] = {
                Active = true,
                Shake = {
                  Duration = 1.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.7
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.5
              },
              [4] = {Active = true, Time = 3.2}
            },
            RefEntityID = 21
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 34
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 35
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 36
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
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
                Layer = 20,
                LoopAnimation = "Story_surprise",
                Position = {0, -500},
                Scaling = {0.5, 0.5},
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 37, Time = 0.5}
            }
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_12_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_13_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.04, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {400, -500},
                  StartValue = {0, -500}
                }
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 21,
                LoopAnimation = "Story_norm",
                Position = {-400, -550},
                Scaling = {0.63, 0.63},
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_16_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 22,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_18_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 22,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_19_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_21_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                LoopAnimation = "Story_angry",
                Scaling = {1, 1},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -500},
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 24,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 25
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bbb"
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
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_23_dialog_content",
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 25
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 22,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_24_dialog_content",
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_25_dialog_content",
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
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_26_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 24,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 25
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B37_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 22,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 25
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B38_dialog_content",
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
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B39_dialog_content",
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B40_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B41_dialog_content",
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
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B42_dialog_content",
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
            DialogContentStr = "ui_story_2_8_B43_dialog_content",
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B44_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B48_dialog_content",
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B49_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_excited",
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B50_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 15
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B51_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 15
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B52_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 15
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B54_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 23,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_B56_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 23,
                LoopAnimation = "Story_excited",
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_28_dialog_content",
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
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_29_dialog_content",
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
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_excited",
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {100, -500},
                  StartValue = {400, -500}
                }
              }
            },
            RefEntityID = 15
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.85,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.2
              },
              [2] = {ShowContent = 0.02, Time = 3.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2
              }
            },
            RefEntityID = 15
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 70,
                Time = 3
              }
            },
            RefEntityID = 26
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
                Layer = 30,
                LoopAnimation = "Story_norm",
                Position = {-300, -600},
                Scaling = {0.8, 0.8},
                Time = 1.5
              },
              [2] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 3
              }
            },
            RefEntityID = 27
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {-550, 0},
                Scaling = {0.7, 0.7},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {-100, -600},
                Time = 3
              }
            },
            RefEntityID = 28
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 39,
                Position = {-550, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 3
              }
            },
            RefEntityID = 29
          },
          [9] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.3,
                  StartValue = 0.3
                },
                Time = 2
              }
            },
            RefEntityID = 17
          },
          [10] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 38, Time = 3.2}
            }
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 3}
            },
            RefEntityID = 39
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_maigefen"
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
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 28
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 29
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 26
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_hood_idle",
                Position = {600, 0},
                Scaling = {0.7, 0.7},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {30, -500},
                Time = 0
              }
            },
            RefEntityID = 30
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 39,
                Position = {600, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 31
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 26
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 40
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_maigefen"
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
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 30
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
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
                Time = 0
              }
            },
            RefEntityID = 30
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 26
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_maigefen"
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
                Time = 0.5
              }
            },
            RefEntityID = 27
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 30
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 31
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_maigefen"
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_maigefen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 1,
                  EndValue = 0.2,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 20
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 100},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_maigefen"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_2_8_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_maigefen"
          }
        },
        [51] = {
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
