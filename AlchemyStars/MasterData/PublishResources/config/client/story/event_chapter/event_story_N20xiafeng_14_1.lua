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
      Name = "马戏团核心",
      Resource = "StoryBGmaxituanhexin.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "艾维斯",
      Resource = "aiweisi_n20_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "帕托",
      Resource = "qinweiduizhang_n20_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "杰诺edge",
      Resource = "jienuo_n20_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [7] = {
      Effect = "",
      EntityID = 7,
      Name = "薇丝edge",
      Resource = "weisi_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "卡莲edge",
      Resource = "kalianyuhun_n20_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [9] = {
      EntityID = 9,
      Name = "暗能释放",
      Resource = "uieff_shumoer_spine_idle.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "风吹特效",
      Resource = "UIeff_cg_heifengchuan_1.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "菲雅edge",
      Resource = "feiya_n19_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [12] = {
      EntityID = 12,
      Name = "黑幕底图",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "黑场灰尘",
      Resource = "uieff_blacksmoke.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 15,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 16,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 17,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 18,
      FitSize = false,
      Name = "守护者",
      Resource = "mofangrenou_n20_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 20,
      FitSize = false,
      Name = "尘土抖落",
      Resource = "uieff_Story_Dust2.prefab",
      Type = "Effect"
    },
    [19] = {
      EntityID = 21,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 22,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [21] = {
      EntityID = 23,
      FitSize = false,
      Name = "神秘2BGM",
      Resource = "36",
      Type = "Sound"
    },
    [22] = {
      EntityID = 24,
      FitSize = false,
      Name = "风声",
      Resource = "10085",
      Type = "Sound"
    },
    [23] = {
      EntityID = 25,
      FitSize = false,
      Name = "恐怖氛围音效",
      Resource = "10099",
      Type = "Sound"
    },
    [24] = {
      EntityID = 26,
      FitSize = false,
      Name = "启动",
      Resource = "10252",
      Type = "Sound"
    },
    [25] = {
      EntityID = 27,
      FitSize = false,
      Name = "机甲启动",
      Resource = "10291",
      Type = "Sound"
    },
    [26] = {
      EntityID = 28,
      FitSize = false,
      Name = "连接音效",
      Resource = "10078",
      Type = "Sound"
    },
    [27] = {
      EntityID = 29,
      FitSize = false,
      Name = "降落音效",
      Resource = "10024",
      Type = "Sound"
    },
    [28] = {
      EntityID = 30,
      FitSize = false,
      Name = "机器说话",
      Resource = "10177",
      Type = "Sound"
    },
    [29] = {
      EntityID = 31,
      Name = "警报 音效",
      Resource = "10002",
      Type = "Sound"
    }
  },
  ID = 50311401,
  Name = "event_story_N20xiafeng_14_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                LoopAnimation = "Story_serious",
                Position = {0, -450},
                Scaling = {1.05, 1.05},
                SpineSkin = "dark",
                Time = 0
              },
              [2] = {
                Active = true,
                Shake = {
                  Duration = 0.2,
                  Strength = {0, 30},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 1
              },
              [3] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {0, 20},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 1.4
              }
            },
            RefEntityID = 4
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 22,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -450},
                  StartValue = {0, -450}
                }
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
                Layer = 8,
                Scaling = {1, 1},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -400},
                  StartValue = {600, -400}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 5
          }
        },
        [6] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
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
            RefEntityID = 4
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 5
          }
        },
        [8] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
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
            RefEntityID = 4
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [9] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
          }
        },
        [10] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 5
          }
        },
        [11] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
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
            RefEntityID = 4
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [12] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 5
          }
        },
        [13] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
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
            RefEntityID = 4
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [14] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 5
          }
        },
        [15] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [16] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [17] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
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
            RefEntityID = 4
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [18] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_patuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {600, -400},
                  StartValue = {400, -400}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -457},
                  StartValue = {-400, -457}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [19] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_rebuke",
                Position = {-500, 0},
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
            RefEntityID = 6
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
            RefEntityID = 5
          }
        },
        [20] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [21] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [22] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [23] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_23_dialog_content",
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
                Layer = 40,
                LoopAnimation = "Story_shocked",
                Position = {500, 0},
                Scaling = {0.42, 0.42},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {50, -400},
                Time = 0
              }
            },
            RefEntityID = 7
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
            RefEntityID = 4
          }
        },
        [24] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_24_dialog_content",
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
                Active = true,
                Layer = 40,
                Position = {-500, 0},
                Scaling = {0.85, 0.85},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {-50, -330},
                Time = 0
              }
            },
            RefEntityID = 8
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
            RefEntityID = 7
          }
        },
        [25] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_25_dialog_content",
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
        [26] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_26_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 7
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
            RefEntityID = 8
          }
        },
        [27] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_27_dialog_content",
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
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -450},
                  StartValue = {0, -450}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [28] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_28_dialog_content",
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
            RefEntityID = 7
          }
        },
        [29] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_29_dialog_content",
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
        [30] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
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
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {500, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          }
        },
        [31] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [32] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [33] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [34] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [35] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [36] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
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
                LoopAnimation = "Story_upset",
                Time = 0
              }
            },
            RefEntityID = 6
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
            RefEntityID = 4
          }
        },
        [37] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [38] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [39] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [40] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [41] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [42] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [43] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [44] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
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
            RefEntityID = 6
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
            RefEntityID = 4
          }
        },
        [45] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_45_dialog_content",
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
            RefEntityID = 6
          }
        },
        [46] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_46_dialog_content",
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
        [47] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
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
                LoopAnimation = "Story_sad",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [48] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {500, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0.2
              }
            },
            RefEntityID = 8
          }
        },
        [49] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_49_dialog_content",
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
        [50] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                LoopAnimation = "Story_surprise",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -450},
                  StartValue = {-400, -450}
                }
              }
            },
            RefEntityID = 4
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
            RefEntityID = 8
          }
        },
        [51] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [52] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
        [53] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [54] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [55] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_55_dialog_content",
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
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 5
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Position = {0, 0},
                Scaling = {2, 2},
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Position = {0, 0},
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                SpineSkin = "blue",
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 25
          }
        },
        [56] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_surprise",
                Position = {-500, 0},
                Scaling = {0.6, 0.6},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -200},
                Time = 0
              }
            },
            RefEntityID = 11
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
            RefEntityID = 4
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 23,
                Time = 0
              }
            }
          }
        },
        [57] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_57_dialog_content",
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
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 8
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
            RefEntityID = 11
          }
        },
        [58] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 8
          }
        },
        [59] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [60] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [61] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [62] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_62_dialog_content",
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
                Brightness = 1,
                LoopAnimation = "Story_surprise",
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 7
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
            RefEntityID = 4
          }
        },
        [63] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_63_dialog_content",
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [64] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_64_dialog_content",
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
        [65] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
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
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [66] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [67] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aiweisi"
          }
        },
        [68] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.2
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2}
            },
            RefEntityID = 15
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.5
              },
              [2] = {Active = false, Time = 0.8},
              [3] = {Active = true, Time = 1.5},
              [4] = {Active = false, Time = 1.8}
            },
            RefEntityID = 16
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 35,
                Time = 0.6
              }
            },
            RefEntityID = 17
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 4
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 10
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {-600, 700},
                Scaling = {2, 2},
                Time = 0.6
              },
              [2] = {
                Active = true,
                Position = {600, -900},
                Time = 1.6
              }
            },
            RefEntityID = 18
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 26
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 27
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 28
          }
        },
        [69] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_69_dialog_content",
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
                Layer = 30,
                Time = 0
              },
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 16
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {300, -300},
                Scaling = {1.2, 1.2},
                Time = 0.2
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 28
          }
        },
        [70] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.1
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 17
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {300, -300},
                  StartValue = {300, 300}
                }
              }
            },
            RefEntityID = 18
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.3
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.8
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 39,
                Time = 0.8
              }
            },
            RefEntityID = 20
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0.3
              }
            },
            RefEntityID = 21
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 29
          }
        },
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_5031_50311401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 11
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
            RefEntityID = 18
          }
        },
        [72] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_rebuke",
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 6
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
            RefEntityID = 11
          }
        },
        [73] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [74] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hexinshouhuzhe"
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
            RefEntityID = 6
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
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 30
          }
        },
        [75] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_75_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hexinshouhuzhe"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 31
          }
        },
        [76] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hexinshouhuzhe"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [77] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_77_dialog_content",
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
            RefEntityID = 18
          }
        },
        [78] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5031_50311401_78_dialog_content",
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
        [79] = {
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
              [2] = {Active = true, Time = 3}
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
