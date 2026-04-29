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
      EntityID = 3,
      FitSize = true,
      Name = "江富城堡房间",
      Resource = "StoryBGjiangfuchengbaofangjian.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "薙",
      Resource = "ti_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "过曝特效",
      Resource = "uieff_Story_Light.prefab",
      Type = "Effect"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "尘土抖落",
      Resource = "uieff_Story_Dust2.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "火打击-大",
      Resource = "uieff_spine_huodaji01.prefab",
      Type = "Effect"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "勾玉单图",
      Resource = "gouyu1_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      Name = "雨森edge",
      Resource = "yusen_n13_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [11] = {
      EntityID = 11,
      Name = "雨森",
      Resource = "yusen_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "瑶",
      Resource = "yao_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "凛音",
      Resource = "linyin_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      Effect = "",
      EntityID = 14,
      Name = "薇丝edge",
      Resource = "weisi_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "阴间特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 16,
      Name = "利刃打击",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "刀光一闪",
      Resource = "uieff_Story_Hit.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 18,
      Name = "受击效果",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "受击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "爆炸",
      Resource = "10015",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "火属性",
      Resource = "10090",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "神秘BGM2",
      Resource = "36",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "勾玉2",
      Resource = "gouyu2_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "摩擦声",
      Resource = "10057",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "出鞘",
      Resource = "10191",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "攻击",
      Resource = "10004",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "刀剑",
      Resource = "10190",
      Type = "Sound"
    }
  },
  ID = 150171401,
  Name = "event_story_N13xueluohongyu_re_14_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.9
              }
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Time = 0.5
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 1.1
              }
            },
            RefEntityID = 6
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Scaling = 0.9, Time = 0},
              [2] = {
                Shake = {
                  Duration = 2,
                  Strength = {80, 80},
                  Vibrato = 80,
                  fadeOut = true
                },
                Time = 1
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 20
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_2_dialog_content",
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
                Active = true,
                Layer = 18,
                Time = 0.2
              }
            },
            RefEntityID = 8
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
                Layer = 50,
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 0.3
              }
            },
            RefEntityID = 7
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 3,
                  Strength = {0, 80},
                  Vibrato = 80,
                  fadeOut = true
                },
                Time = 0.2
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0,
                Layer = 8,
                Position = {0, -350},
                Scaling = {1, 1},
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 21
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 20
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.1, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 22,
                Time = 0
              }
            }
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
                Layer = 9,
                Position = {100, 0},
                Scaling = {0.5, 0.51},
                Time = 0
              }
            },
            RefEntityID = 9
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
                Layer = 10,
                Position = {-100, 0},
                Scaling = {0.5, 0.5},
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.9
              },
              [2] = {ShowContent = 0.02, Time = 3.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.7
              }
            },
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.7
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_angry",
                Position = {450, 0},
                Scaling = {1, 1},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -400},
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
            RefEntityID = 4
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -352},
                  StartValue = {0, -352}
                }
              }
            },
            RefEntityID = 4
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
            RefEntityID = 10
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
                LoopAnimation = "Story_serious",
                Scaling = {1, 1},
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -400},
                  StartValue = {600, -400}
                }
              }
            },
            RefEntityID = 11
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.1, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 11
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
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_sleep",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
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
                LoopAnimation = "Story_sad",
                Time = 0
              }
            },
            RefEntityID = 11
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
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
              }
            },
            RefEntityID = 11
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
                LoopAnimation = "Story_smile",
                Time = 0.9
              }
            },
            RefEntityID = 4
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
                Scaling = {1.15, 1.15},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {450, -300},
                  StartValue = {600, -300}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0.9
              }
            },
            RefEntityID = 12
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {150, 0},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 0},
                  StartValue = {150, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0.3
              }
            },
            RefEntityID = 12
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 12
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_sleep",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
              }
            },
            RefEntityID = 12
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
                Layer = 7,
                Position = {400, -380},
                Scaling = {0.95, 0.95},
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.1, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 13
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-200, -352},
                  StartValue = {-400, -352}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {100, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
                LoopAnimation = "Story_angry",
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  Strength = {0, 60},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 13
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
            RefEntityID = 13
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -352},
                  StartValue = {-200, -352}
                }
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
            RefEntityID = 13
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {100, 0}
                }
              }
            }
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-500, -352},
                  StartValue = {-400, -352}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.4
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
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {300, -380},
                  StartValue = {400, -380}
                }
              }
            },
            RefEntityID = 13
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  Strength = {60, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_serious",
                Scaling = {0.42, 0.42},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {30, -400},
                Time = 0
              }
            },
            RefEntityID = 14
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
            RefEntityID = 13
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
            RefEntityID = 13
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
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 13
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
            RefEntityID = 13
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 13
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Layer = 3,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_53_dialog_content",
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
            RefEntityID = 4
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
                LoopAnimation = "Story_shocked",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -380},
                  StartValue = {300, -380}
                }
              }
            },
            RefEntityID = 13
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_55_dialog_content",
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
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -352},
                  StartValue = {-500, -352}
                }
              }
            },
            RefEntityID = 4
          },
          [5] = {
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 26
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
                Layer = 8,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 13
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {150, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -352},
                  StartValue = {-400, -352}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -380},
                  StartValue = {400, -380}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
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
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_angry",
                Position = {0, -400},
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.2
              },
              [2] = {Active = false, Time = 0}
            },
            RefEntityID = 16
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-200, 0},
                Time = 0.3
              }
            },
            RefEntityID = 18
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {200, 0},
                Time = 0.4
              }
            },
            RefEntityID = 19
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.2
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.4
              },
              [3] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.5
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.3
              }
            },
            RefEntityID = 7
          },
          [9] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {150, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 1.5,
                  Strength = {80, 80},
                  Vibrato = 80,
                  fadeOut = true
                },
                Time = 0.2
              }
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 27
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -400},
                  StartValue = {0, -400}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [4] = {
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
                Time = 0.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -352},
                  StartValue = {-500, -352}
                }
              }
            },
            RefEntityID = 4
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
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
            RefEntityID = 11
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
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 11
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
            RefEntityID = 4
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
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
                LoopAnimation = "Story_sad",
                Time = 0
              }
            },
            RefEntityID = 11
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
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          }
        },
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          }
        },
        [66] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 11
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
            RefEntityID = 4
          }
        },
        [67] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_sleep",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
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
            RefEntityID = 11
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
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.1,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_sad", Time = 0}
            },
            RefEntityID = 11
          }
        },
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yusen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
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
            RefEntityID = 11
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
                LoopAnimation = "Story_sleep",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_75_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [76] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0.5,
                  StartValue = 0.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.2
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [77] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [78] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mingtuyoudao"
          }
        },
        [79] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {450, -300},
                  StartValue = {750, -300}
                }
              }
            },
            RefEntityID = 12
          }
        },
        [80] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [81] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_anger",
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 14
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
        [82] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50171401_82_dialog_content",
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
            RefEntityID = 14
          }
        },
        [83] = {
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
