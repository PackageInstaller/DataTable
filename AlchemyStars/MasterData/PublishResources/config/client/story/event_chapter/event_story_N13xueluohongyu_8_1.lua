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
      Name = "城下町街道日",
      Resource = "StoryBGjiangfujiedaori.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "日光背景",
      Resource = "StoryBGriguang.prefab",
      Type = "Picture"
    },
    [5] = {
      Effect = "",
      EntityID = 5,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "凛音替代",
      Resource = "linyin_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "雨森替代",
      Resource = "yusen_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "瑶替代",
      Resource = "yao_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "柏乃替代",
      Resource = "bonai_n13_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      Name = "黑幕-底图用",
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
      EntityID = 14,
      FitSize = false,
      Name = "凛音edge",
      Resource = "linyin_n13_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "江富野外",
      Resource = "StoryBGjiangfuyewai.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 16,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "阴间特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "鬼edge",
      Resource = "shigui_n13_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "电磁1",
      Resource = "10039",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "flash1",
      Resource = "10018",
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
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "暗鬼低语",
      Resource = "10014",
      Type = "Sound"
    },
    [29] = {
      EntityID = 29,
      FitSize = false,
      Name = "恐怖氛围",
      Resource = "10099",
      Type = "Sound"
    }
  },
  ID = 50170801,
  Name = "event_story_N13xueluohongyu_8_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_anger",
                Position = {0, -400},
                Scaling = {0.42, 0.42},
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0,
                  EndValue = 0.9,
                  StartValue = 0.9
                },
                Time = 0.4
              }
            }
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 19, Time = 0.5}
            }
          }
        },
        [2] = {
          [1] = {
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
                Time = 0.6
              }
            },
            RefEntityID = 2
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
                Scaling = {1, 1},
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {450, -400},
                  StartValue = {450, -399.9}
                }
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Position = {-450, -400},
                Time = 0.5
              }
            },
            RefEntityID = 5
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
                Position = {50, -300},
                Scaling = {1.15, 1.15},
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.5
              }
            }
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_2_dialog_content",
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
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_3_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yao"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_4_dialog_content",
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
                Layer = 8,
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 5
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
            RefEntityID = 8
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_5_dialog_content",
            KeyFrames = {
              [1] = {
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
            DialogContentStr = "ui_story_5017_50170801_6_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {50, -270},
                  StartValue = {50, -300}
                }
              },
              [2] = {
                Active = true,
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {50, -300},
                  StartValue = {50, -270}
                }
              }
            },
            RefEntityID = 8
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_7_dialog_content",
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
                Layer = 8,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 5
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
            RefEntityID = 8
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_8_dialog_content",
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
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 0.5
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 1
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 31,
                Time = 0.4
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 31,
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 1
              }
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 3,
                Time = 1
              }
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 5
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 7
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 8
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 45,
                LoopAnimation = "Story_serious",
                Scaling = {0.95, 0.95},
                Scroll = {
                  Duration = 0.5,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -380},
                Time = 1.6
              }
            },
            RefEntityID = 14
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_10_dialog_content",
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
              [1] = {Active = true, Time = 0.1},
              [2] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_11_dialog_content",
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
              [1] = {Active = true, Time = 0.1},
              [2] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
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
            DialogContentStr = "ui_story_5017_50170801_12_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.1},
              [2] = {Active = false, Time = 0}
            },
            RefEntityID = 10
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
                Time = 1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {650, -420},
                  StartValue = {-650, -420}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.2
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.5,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 14
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
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 1
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 22
          },
          [7] = {
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
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_13_dialog_content",
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
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_14_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1.8}
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
                Time = 0.5
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 1.8
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 31,
                Time = 0.4
              },
              [2] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 31,
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 13
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 1
              }
            },
            RefEntityID = 5
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 1
              }
            },
            RefEntityID = 8
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 12
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0,
                Time = 1.8,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-650, -420},
                  StartValue = {650, -420}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2
              }
            },
            RefEntityID = 9
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.8}
            },
            RefEntityID = 22
          },
          [14] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 26, Time = 0.5}
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_15_dialog_content",
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
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_16_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_17_dialog_content",
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
            RefEntityID = 8
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_18_dialog_content",
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
            RefEntityID = 8
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_19_dialog_content",
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
                Layer = 8,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_20_dialog_content",
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
            RefEntityID = 5
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_21_dialog_content",
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
                Layer = 8,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_22_dialog_content",
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
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              }
            }
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_23_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0.5
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 5
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
                Layer = 8,
                Position = {0, -380},
                Scaling = {0.95, 0.95},
                Time = 0.5
              }
            },
            RefEntityID = 6
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_25_dialog_content",
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
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_26_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0,
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {650, -420},
                  StartValue = {-650, -420}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_27_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_29_dialog_content",
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
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              }
            }
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_30_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0,
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-650, -420},
                  StartValue = {650, -420}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_31_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 50,
                Time = 0.5
              }
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 4
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_33_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1
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
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.2
              }
            },
            RefEntityID = 12
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.1,
                  StartValue = 0
                },
                Position = {0, -420},
                Shake = {
                  Duration = 1,
                  Strength = {80, 0},
                  Vibrato = 80,
                  fadeOut = true
                },
                Time = 0.2
              }
            },
            RefEntityID = 9
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_34_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 2.4},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.2
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
              [1] = {Active = true, Time = 0.2},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {650, -400},
                  StartValue = {450, -400}
                }
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.3,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, -300},
                  StartValue = {50, -300}
                }
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2},
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.5
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 13
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
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_scary",
                Position = {0, -600},
                Scaling = {1.3, 1.3},
                Time = 2.2
              },
              [2] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [10] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 2.2
              }
            }
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0.4,
                  StartValue = 0
                },
                Layer = 3,
                Time = 0.2
              }
            },
            RefEntityID = 17
          },
          [12] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.2}
            },
            RefEntityID = 29
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice&zhujue"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.4
              },
              [3] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 2
                },
                Time = 0.6
              }
            }
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {1.3, 1.3}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {450, -420},
                  StartValue = {0, -600}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.2
              }
            },
            RefEntityID = 9
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
                LoopAnimation = "Story_surprise",
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 10
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 4.1
              },
              [2] = {ShowContent = 0.02, Time = 4.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_tear_shoot",
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 4.1
              },
              [2] = {
                Active = true,
                LoopAnimation = "Story_tear_shock",
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -400},
                  StartValue = {-450, -400}
                }
              },
              [3] = {
                Active = true,
                Time = 2.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-550, -400},
                  StartValue = {-500, -400}
                }
              }
            },
            RefEntityID = 5
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -370},
                  StartValue = {450, -420}
                }
              },
              [2] = {
                Active = true,
                Time = 0.7,
                Translate = {
                  Duration = 0.5,
                  EndValue = {350, -420},
                  StartValue = {400, -370}
                }
              },
              [3] = {
                Active = true,
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {300, -370},
                  StartValue = {350, -420}
                }
              },
              [4] = {
                Active = true,
                Time = 2.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {250, -420},
                  StartValue = {300, -370}
                }
              },
              [5] = {
                Active = true,
                Time = 2.9,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, -370},
                  StartValue = {250, -420}
                }
              },
              [6] = {
                Active = true,
                Time = 3.6,
                Translate = {
                  Duration = 0.5,
                  EndValue = {150, -420},
                  StartValue = {200, -370}
                }
              },
              [7] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 4.1
              }
            },
            RefEntityID = 9
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
                StopShake = {Duration = 0, FadeOut = false},
                Time = 4.1
              },
              [2] = {
                Shake = {
                  Duration = 0.4,
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 4.3
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2},
              [2] = {PlaySound = "Once", Time = 4.1}
            },
            RefEntityID = 24
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.7}
            },
            RefEntityID = 25
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
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
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 0.4
                },
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [6] = {
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
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_38_dialog_content",
            KeyFrames = {
              [1] = {
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
                LoopAnimation = "Story_sad",
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {450, -420},
                  StartValue = {150, -420}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_39_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_40_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Layer = 8,
                Scaling = {0.95, 0.95},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -380},
                  StartValue = {0, -430}
                }
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {550, -420},
                  StartValue = {450, -420}
                }
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_tear_joy",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 27, Time = 0}
            }
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_41_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
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
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_smile",
                Position = {-500, -300},
                Time = 0
              }
            },
            RefEntityID = 8
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
            RefEntityID = 6
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_42_dialog_content",
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
            RefEntityID = 8
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_43_dialog_content",
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
                  EndValue = 0,
                  StartValue = 1
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_serious",
                Position = {-500, -400},
                Time = 0
              }
            },
            RefEntityID = 5
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
            RefEntityID = 6
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_44_dialog_content",
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
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
            RefEntityID = 6
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_45_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hebo"
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_47_dialog_content",
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
            RefEntityID = 9
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hebo"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_49_dialog_content",
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
            RefEntityID = 9
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hebo"
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
            RefEntityID = 9
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_51_dialog_content",
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
            RefEntityID = 9
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_52_dialog_content",
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
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hebo"
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
                LoopAnimation = "Story_sad",
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_54_dialog_content",
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
                Active = true,
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
          },
          [4] = {
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
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_55_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lin"
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_56_dialog_content",
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
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_57_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                Position = {450, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -180},
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.4
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 28
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_58_dialog_content",
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_serious",
                Time = 0.2
              }
            },
            RefEntityID = 5
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_59_dialog_content",
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
            RefEntityID = 5
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5017_50170801_60_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_angry",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -300},
                  StartValue = {-600, -300}
                }
              }
            },
            RefEntityID = 8
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
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.2
              }
            }
          },
          [4] = {
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
            RefEntityID = 5
          }
        },
        [62] = {
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
