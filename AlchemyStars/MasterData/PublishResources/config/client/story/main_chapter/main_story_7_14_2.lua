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
      EntityID = 44,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 78,
      FitSize = true,
      Name = "风船背景图",
      Resource = "StoryBGjiaban.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 82,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      Effect = "",
      EntityID = 83,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 114,
      Name = "薇薇安立绘",
      Resource = "vivian_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 117,
      Name = "对话Slice阴影",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 119,
      Name = "舒摩尔立绘",
      Resource = "shumoer_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 120,
      Name = "吞罗立绘",
      Resource = "tunluo_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 121,
      Name = "舒摩尔slice",
      Resource = "shumoer_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [12] = {
      EntityID = 122,
      Name = "薇薇安slice",
      Resource = "vivian_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [13] = {
      EntityID = 123,
      Name = "吞罗揭面CG",
      Resource = "TunluoCG.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 124,
      Name = "卡莲slice",
      Resource = "1600061_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [15] = {
      EntityID = 125,
      Name = "黑风船CG-底",
      Resource = "1003_spine_cg_2_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 126,
      Name = "黑风船CG-表",
      Resource = "1003_spine_cg_1_idle.prefab",
      Type = "Spine"
    },
    [17] = {
      EntityID = 127,
      Name = "黑风船CG特效",
      Resource = "UIeff_cg_heifengchuan_1.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 128,
      Name = "舒摩尔横向slice",
      Resource = "shumoer_spine_idle.prefab",
      Type = "SpineSliceHorizontal"
    },
    [19] = {
      EntityID = 129,
      Name = "紧张2BGM",
      Resource = "19",
      Type = "Sound"
    },
    [20] = {
      EntityID = 130,
      FitSize = false,
      Name = "震动循环",
      Resource = "10007",
      Type = "Sound"
    },
    [21] = {
      EntityID = 131,
      FitSize = false,
      Name = "拍地板",
      Resource = "10024",
      Type = "Sound"
    },
    [22] = {
      EntityID = 132,
      FitSize = false,
      Name = "风声",
      Resource = "10042",
      Type = "Sound"
    },
    [23] = {
      EntityID = 133,
      FitSize = false,
      Name = "flash1",
      Resource = "10018",
      Type = "Sound"
    },
    [24] = {
      EntityID = 134,
      FitSize = false,
      Name = "暗能攻击",
      Resource = "10047",
      Type = "Sound"
    },
    [25] = {
      EntityID = 135,
      FitSize = false,
      Name = "晕倒",
      Resource = "10016",
      Type = "Sound"
    },
    [26] = {
      EntityID = 136,
      FitSize = false,
      Name = "暗鬼低语",
      Resource = "10014",
      Type = "Sound"
    }
  },
  ID = 10071402,
  Name = "main_story_7_14_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3
              },
              [2] = {ShowContent = 0.04, Time = 3.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {Active = false, Time = 0.7}
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.5,
                  StartValue = 0.5
                },
                Layer = 9,
                LoopAnimation = "Story_sullen",
                Position = {-50, -400},
                Scaling = {0.55, 0.55},
                Time = 0.5
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 3
              }
            },
            RefEntityID = 119
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 78
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
                Layer = 51,
                Time = 0.5
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 44
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 10
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.7
              }
            }
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 129, Time = 0.7}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.04, Time = 0.6}
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
                Layer = 50,
                Time = 0
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.2
              }
            },
            RefEntityID = 119
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
                Position = {-400, -400},
                Scaling = {0.42, 0.42},
                Time = 0.4
              }
            },
            RefEntityID = 83
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.04, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 83
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
                Layer = 9,
                LoopAnimation = "Story_rebuke",
                Scaling = {0.6, 0.6},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -250},
                  StartValue = {400, -300}
                }
              },
              [2] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -200},
                  StartValue = {400, -250}
                }
              }
            },
            RefEntityID = 82
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_69_dialog_content",
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
            RefEntityID = 82
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -200},
                  StartValue = {400, -200}
                }
              }
            },
            RefEntityID = 82
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -400},
                  StartValue = {-400, -400}
                }
              }
            },
            RefEntityID = 83
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                LoopAnimation = "Story_nervous",
                Position = {0, -250},
                Scaling = {0.4, 0.4},
                Time = 0
              }
            },
            RefEntityID = 114
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_A7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
            RefEntityID = 114
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_sullen",
                Position = {0, 0},
                Scaling = {0.55, 0.55},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {-50, -400},
                Time = 0
              }
            },
            RefEntityID = 121
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
                Layer = 19,
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 117
          },
          [5] = {
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
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.04, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
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
                Time = 0
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 8,
                Position = {-400, -400},
                Time = 0.2
              }
            },
            RefEntityID = 119
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.2
              }
            },
            RefEntityID = 83
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.2
              }
            },
            RefEntityID = 82
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.2
              }
            },
            RefEntityID = 114
          },
          [7] = {
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
            RefEntityID = 121
          },
          [8] = {
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
            RefEntityID = 117
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 9,
                LoopAnimation = "Story_hood_idle",
                Position = {450, -350},
                Scaling = {0.55, 0.55},
                Time = 0.6
              }
            },
            RefEntityID = 120
          },
          [10] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scaling = 1,
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.2
              }
            }
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Scaling = {1.1, 1.1},
                Time = 0.2
              }
            },
            RefEntityID = 78
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_75_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 119
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
            RefEntityID = 120
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
            RefEntityID = 119
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_serious",
                Position = {0, 0},
                Scaling = {0.4, 0.4},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -250},
                Time = 0
              }
            },
            RefEntityID = 122
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
                Layer = 19,
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 117
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
                LoopAnimation = "Story_despise",
                Time = 0
              }
            },
            RefEntityID = 119
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
            RefEntityID = 122
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 119
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
            RefEntityID = 122
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.04, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 119
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 122
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
            RefEntityID = 117
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {200, 50},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 1
              }
            },
            RefEntityID = 120
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Position = {-200, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 122
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Position = {-200, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 117
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
            RefEntityID = 120
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_81_dialog_content",
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
            RefEntityID = 122
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
            RefEntityID = 122
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_83_dialog_content",
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 122
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
            RefEntityID = 120
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
            RefEntityID = 122
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
            RefEntityID = 120
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_85_dialog_content",
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 122
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
            RefEntityID = 120
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 122
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
            RefEntityID = 120
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, 100},
                  StartValue = {200, 50}
                }
              }
            }
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_87_dialog_content",
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
            RefEntityID = 122
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_88_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 120
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.04,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 122
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
            RefEntityID = 120
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_91_dialog_content",
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 122
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
            RefEntityID = 120
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 122
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
            RefEntityID = 120
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.5
              },
              [2] = {ShowContent = 0.02, Time = 3.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
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
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 122
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 117
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                FullScreen = true,
                Layer = 40,
                Time = 0.7
              }
            },
            RefEntityID = 123
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 4,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.7
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 136
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_95_dialog_content",
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
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_F3_dialog_content",
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
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_98_dialog_content",
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
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_99_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_100_dialog_content",
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
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_101_dialog_content",
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
            DialogContentStr = "ui_story_7_14_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.04,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
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
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.7
              }
            },
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
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
                Time = 0.8
              }
            },
            RefEntityID = 2
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.7
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_idle",
                Position = {450, -300},
                Time = 0.7
              }
            },
            RefEntityID = 120
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_despise",
                Time = 0.7
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 10,
                Time = 1.5
              }
            },
            RefEntityID = 119
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_A8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_105_dialog_content",
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
            RefEntityID = 119
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
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
            RefEntityID = 120
          },
          [3] = {
            KeyFrames = {
              [1] = {Layer = 8, Time = 0}
            },
            RefEntityID = 119
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_A9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
            RefEntityID = 120
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 10,
                LoopAnimation = "Story_proud",
                Time = 0
              }
            },
            RefEntityID = 119
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_113_dialog_content",
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
            RefEntityID = 119
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_rebuke",
                Position = {0, 0},
                Scaling = {0.6, 0.6},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {50, -200},
                Time = 0
              }
            },
            RefEntityID = 124
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
                Layer = 19,
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 117
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_sullen",
                Time = 0
              }
            },
            RefEntityID = 119
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
            RefEntityID = 124
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
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 117
          },
          [5] = {
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
                  EndValue = {-200, 50},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_115_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3
              },
              [2] = {ShowContent = 0.02, Time = 3.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {-200, 50}
                }
              },
              [2] = {
                Scale = {
                  Duration = 4,
                  EndValue = 1,
                  StartValue = 0.9
                },
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 10
                },
                Time = 0.5
              }
            }
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0.1
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0.2
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0.3
              },
              [5] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0.4
              },
              [6] = {
                AlphaChange = {
                  Duration = 3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              },
              [7] = {Active = false, Time = 4}
            },
            RefEntityID = 44
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 30,
                Time = 0.5
              }
            },
            RefEntityID = 125
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 31,
                Time = 0.5
              }
            },
            RefEntityID = 126
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {-25, -50},
                Scaling = {0.75, 0.75},
                Time = 0.5
              }
            },
            RefEntityID = 127
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 124
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 120
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 119
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 117
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Loop", Time = 0}
            },
            RefEntityID = 130
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 131
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 132
          },
          [14] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 133
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_116_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_117_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_118_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_119_dialog_content",
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
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_120_dialog_content",
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
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_121_dialog_content",
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
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_122_dialog_content",
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
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.04, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [58] = {
          [1] = {
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
                Time = 0.2
              },
              [3] = {Active = false, Time = 1}
            },
            RefEntityID = 44
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
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 8,
                LoopAnimation = "Story_nervous",
                Position = {0, -250},
                Scaling = {0.4, 0.4},
                Time = 0.8
              }
            },
            RefEntityID = 114
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scaling = 0.8,
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {15, 15},
                  Vibrato = 10
                },
                Time = 0.2
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.8
                },
                Time = 0.8
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                FullScreen = false,
                Time = 0.1
              }
            },
            RefEntityID = 125
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 126
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 127
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_128_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_129_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiweian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_friendly",
                Time = 0
              }
            },
            RefEntityID = 114
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_130_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 114
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.7
                },
                Time = 0
              }
            }
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_131_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.04, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
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
                Layer = 25,
                LoopAnimation = "Story_sullen",
                Position = {0, 100},
                Scaling = {0.9, 0.9},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "VerticalSpread"
                },
                SpineOffset = {-100, -1000},
                Time = 0
              }
            },
            RefEntityID = 128
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_133_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.8
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
                  Toward = "VerticalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 128
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
                Layer = 50,
                Time = 0.1
              }
            },
            RefEntityID = 44
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 133
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 134
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_7_14_134_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.04,
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
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 55,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 135
          }
        },
        [65] = {
          [1] = {
            KeyFrames = {
              [1] = {Active = true, Time = 3}
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
