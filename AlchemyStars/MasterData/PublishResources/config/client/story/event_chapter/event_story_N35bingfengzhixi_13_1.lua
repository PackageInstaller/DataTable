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
      EntityID = 5,
      FitSize = false,
      Name = "北境荒原",
      Resource = "StoryBGbeijingshiwaiye.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 6,
      FitSize = false,
      Name = "安顿",
      Resource = "andun_n35_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 7,
      FitSize = false,
      Name = "查莉娅",
      Resource = "chaliya_n35_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 8,
      Name = "33号",
      Resource = "33hao_n35_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 9,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 10,
      FitSize = false,
      Name = "极光天空",
      Resource = "StoryBGjinghuwaijing.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 11,
      FitSize = false,
      Name = "北境BGM",
      Resource = "35",
      Type = "Sound"
    },
    [10] = {
      EntityID = 12,
      FitSize = false,
      Name = "强烈震动",
      Resource = "10036",
      Type = "Sound"
    },
    [11] = {
      EntityID = 13,
      FitSize = false,
      Name = "去向何方CG",
      Resource = "CGqianwanghefang.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 14,
      FitSize = false,
      Name = "极光cg",
      Resource = "CGkaichangjiguang.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 15,
      FitSize = false,
      Name = "live灯光",
      Resource = "uieff_wutaicaihong.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 16,
      FitSize = false,
      Name = "去向何方CG2",
      Resource = "CGqianwanghefang.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 17,
      FitSize = false,
      Name = "北境女王CG",
      Resource = "CGbolihengtabing.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 18,
      FitSize = false,
      Name = "极光",
      Resource = "cg_beijingbingyuan_spine_idle.prefab",
      Type = "Spine"
    },
    [17] = {
      EntityID = 19,
      FitSize = false,
      Name = "北境女王CG2",
      Resource = "cg_beijingbingyuan_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 20,
      FitSize = true,
      Name = "舰桥背景",
      Resource = "StoryBGjuxiangjianqiao2.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 21,
      FitSize = false,
      Name = "光音效",
      Resource = "10038",
      Type = "Sound"
    },
    [20] = {
      EntityID = 22,
      FitSize = false,
      Name = "北境之歌",
      Resource = "59",
      Type = "Sound"
    },
    [21] = {
      EntityID = 23,
      FitSize = false,
      Name = "下雪",
      Resource = "uieff_cg_snow.prefab",
      Type = "Effect"
    }
  },
  ID = 50611301,
  Name = "event_story_N35bingfengzhixi_13_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_1_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 1},
              [2] = {ShowContent = 0.02, Time = 1.2}
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
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 5
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StopBgm = true, Time = 0},
              [2] = {StartBgm = 11, Time = 0.5}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -430},
                Scaling = {0.95, 0.95},
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.5
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_chaliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-550, -430},
                  StartValue = {0, -430}
                }
              }
            },
            RefEntityID = 6
          },
          [3] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.4,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_smile",
                Scaling = {0.82, 0.82},
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {530, -350},
                  StartValue = {780, -350}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
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
            RefEntityID = 7
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
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
            RefEntityID = 6
          },
          [3] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -300},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_6_dialog_content",
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
            RefEntityID = 8
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {
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
            RefEntityID = 6
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 6
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_11_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 6
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_12_dialog_content",
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
            RefEntityID = 6
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          },
          [2] = {
            IsSpeaking = true,
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
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_14_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 8
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_15_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 8
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_16_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 8
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_17_dialog_content",
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
            RefEntityID = 8
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          },
          [2] = {
            IsSpeaking = true,
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_19_dialog_content",
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
            RefEntityID = 8
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_20_dialog_content",
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
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
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
            RefEntityID = 8
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_22_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.08,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 8
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_23_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 8
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_24_dialog_content",
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
            RefEntityID = 8
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_25_dialog_content",
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
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_chaliya"
          },
          [2] = {
            IsSpeaking = true,
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
            RefEntityID = 7
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_27_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 0},
              [2] = {ShowContent = 0.08, Time = 0.2}
            },
            RefEntityID = 1
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
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 12
          },
          [4] = {
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_28_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 0.5},
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
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
                Active = true,
                Layer = 40,
                Position = {0, -500},
                Scaling = {1.4, 1.4},
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, -480},
                  StartValue = {0, -450}
                }
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_29_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 2.5},
              [2] = {ShowContent = 0.02, Time = 2.7}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {StopSound = true, Time = 0}
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 3,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 45,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [30] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 10
          },
          [3] = {
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
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_chaliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Time = 0
              }
            },
            RefEntityID = 20
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 18
          },
          [5] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 7
          }
        },
        [32] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_31_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_chaliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Scaling = {0.41, 0.41},
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_33_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_34_dialog_content",
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
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_36_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 47,
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_37_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          },
          [2] = {
            IsSpeaking = true,
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 6
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_38_dialog_content",
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
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_39_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
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
            RefEntityID = 14
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_40_dialog_content",
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
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_41_dialog_content",
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
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_42_dialog_content",
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
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_43_dialog_content",
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
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sanshisanhao"
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50611301_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_andun"
          }
        },
        [48] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 46,
                Position = {600, 0},
                Scaling = {0.65, 0.65},
                Time = 0,
                Translate = {
                  Duration = 1.5,
                  EndValue = {650, -400},
                  StartValue = {630, -400}
                }
              }
            },
            RefEntityID = 16
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
                Layer = 60,
                Time = 2.5
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3.7
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 51,
                Scaling = {1.2, 1.2},
                Time = 3.5,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                FullScreen = true,
                Layer = 53,
                LoopAnimation = "beijing",
                Scaling = {0.43, 0.43},
                Time = 5.5,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {Time = 0},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 54,
                LoopAnimation = "nvwang",
                Position = {-200, 0},
                Scaling = {1, 1},
                Time = 7.5
              }
            },
            RefEntityID = 19
          },
          [6] = {
            KeyFrames = {
              [1] = {Time = 0},
              [2] = {
                Active = true,
                Layer = 55,
                Time = 3.5
              }
            },
            RefEntityID = 23
          }
        },
        [49] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 70,
                Time = 1
              },
              [2] = {Active = true, Time = 6}
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
          },
          [3] = {
            DialogContentStr = "ui_story_5061_50611301_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.7
              },
              [2] = {ShowContent = 0.02, Time = 2.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_chaliya"
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.98,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 6}
            },
            RefEntityID = 19
          }
        }
      }
    }
  },
  StartParagraph = 1
}
