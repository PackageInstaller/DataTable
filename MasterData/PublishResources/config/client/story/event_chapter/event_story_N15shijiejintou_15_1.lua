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
      FitSize = false,
      Name = "丧失麦格芬",
      Resource = "xielong_n15_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "炽焰之牙",
      Resource = "StoryBGchiyanzhiya.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      Name = "利刃打击",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      Name = "攻击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "空间禁锢",
      Resource = "uieff_Story_DarkMagic.prefab",
      Type = "Effect"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "青瞳edge",
      Resource = "qingtong_n15_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "泽塔edge",
      Resource = "zeta_n15_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [11] = {
      EntityID = 12,
      FitSize = false,
      Name = "约拿",
      Resource = "1600601_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 13,
      FitSize = true,
      Name = "齐心协力CG",
      Resource = "CGqixinxieli.Prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 14,
      FitSize = false,
      Name = "丧失麦格芬edge",
      Resource = "xielong_n15_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [14] = {
      EntityID = 15,
      FitSize = false,
      Name = "沙尘暴特效",
      Resource = "uieff_Story_SandStorm.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "利刃打击2",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "利刃打击3",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 18,
      FitSize = false,
      Name = "子弹",
      Resource = "10137",
      Type = "Sound"
    },
    [18] = {
      EntityID = 19,
      FitSize = false,
      Name = "开枪2",
      Resource = "10138",
      Type = "Sound"
    },
    [19] = {
      EntityID = 20,
      FitSize = false,
      Name = "暗鬼叫声",
      Resource = "10069",
      Type = "Sound"
    },
    [20] = {
      EntityID = 21,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [21] = {
      EntityID = 22,
      FitSize = false,
      Name = "雷吉娜切条",
      Resource = "1500181_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [22] = {
      EntityID = 23,
      FitSize = false,
      Name = "芭芭拉切条",
      Resource = "hongyoutianxin_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [23] = {
      EntityID = 24,
      FitSize = false,
      Name = "红油BGM替代",
      Resource = "69",
      Type = "Sound"
    }
  },
  ID = 50221501,
  Name = "event_story_N15shijiejintou_15_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_1_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1}
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
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Scaling = {400, 1},
                Time = 1
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 18
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 24,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xielonghakuduo"
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
                Position = {0, -200},
                Scaling = {1.5, 1.5},
                Time = 0.2
              }
            },
            RefEntityID = 3
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
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Position = {0, -200},
                Time = 0.5
              }
            },
            RefEntityID = 7
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
                EffectFullScreen = true,
                Layer = 30,
                Scaling = {1, 1},
                Time = 0.6
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.3
              }
            },
            RefEntityID = 8
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.5
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 19
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_3_dialog_content",
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
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_4_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_mock",
                Position = {-500, 0},
                Scaling = {0.9, 0.9},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {100, -310},
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_6_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zeta"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_surprise",
                Position = {500, 0},
                Scaling = {0.8, 0.8},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -300},
                Time = 0
              }
            },
            RefEntityID = 10
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
            RefEntityID = 9
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
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
            RefEntityID = 10
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_9_dialog_content",
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
            RefEntityID = 9
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_10_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
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
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
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
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 1.6,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Scale = {
                  Duration = 1.6,
                  EndValue = {0.7, 0.7},
                  StartValue = {0.65, 0.65}
                },
                Time = 1.9,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, -150},
                  StartValue = {0, -200}
                }
              },
              [2] = {
                Active = true,
                Time = 2.3,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, -200},
                  StartValue = {0, -150}
                }
              },
              [3] = {
                Active = true,
                Time = 2.7,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, -150},
                  StartValue = {0, -200}
                }
              },
              [4] = {
                Active = true,
                Time = 3.1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, -200},
                  StartValue = {0, -150}
                }
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.9}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.9}
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.9}
            },
            RefEntityID = 9
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 1.6,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.9
              }
            },
            RefEntityID = 4
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 52,
                Position = {0, 300},
                Scaling = {400, 1},
                Time = 0.9
              },
              [2] = {Active = false, Time = 0},
              [3] = {Active = false, Time = 1.9}
            },
            RefEntityID = 6
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 52,
                Position = {0, -300},
                Scaling = {400, 1},
                Time = 1.1
              },
              [2] = {Active = false, Time = 1.9}
            },
            RefEntityID = 16
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 52,
                Position = {0, 0},
                Scaling = {400, 1},
                Time = 1.3
              },
              [2] = {Active = false, Time = 1.9}
            },
            RefEntityID = 17
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9},
              [2] = {PlaySound = "Once", Time = 1.1},
              [3] = {PlaySound = "Once", Time = 1.3}
            },
            RefEntityID = 18
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.3},
              [2] = {PlaySound = "Once", Time = 3.1}
            },
            RefEntityID = 21
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_12_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zeta"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 40,
                LoopAnimation = "Story_laugh",
                Position = {500, 0},
                Scaling = {0.8, 0.8},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -300},
                Time = 0
              }
            },
            RefEntityID = 10
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
            RefEntityID = 12
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 9
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
            RefEntityID = 10
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.3
              },
              [2] = {ShowContent = 0.02, Time = 2.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
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
                Time = 0.2
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.3
              }
            },
            RefEntityID = 2
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
            RefEntityID = 9
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
            RefEntityID = 10
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Time = 1.2}
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 20,
                Scaling = {1.1, 1.1},
                Time = 1.2
              }
            },
            RefEntityID = 13
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Time = 1.2}
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 15
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_babala"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_17_dialog_content",
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
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_19_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_20_dialog_content",
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
                Layer = 40,
                Position = {500, 0},
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
            RefEntityID = 22
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_21_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_22_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leijina"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_babala"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 41,
                Position = {100, 0},
                Scaling = {1.1, 1.1},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -150},
                Time = 0
              }
            },
            RefEntityID = 23
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
            RefEntityID = 22
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zeta"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              }
            }
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
            RefEntityID = 22
          },
          [4] = {
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
            RefEntityID = 23
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_25_dialog_content",
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
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_28_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xielonghakuduo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {600, 0},
                Scaling = {1.5, 1.5},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {-50, -200},
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
          },
          [2] = {
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
            RefEntityID = 14
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50221501_31_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [32] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
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
