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
      Effect = "",
      EntityID = 83,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 105,
      FitSize = true,
      Name = "风船宕机背景图",
      Resource = "StoryBGFengchuan2.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 114,
      Name = "薇薇安立绘",
      Resource = "vivian_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 121,
      FitSize = true,
      Name = "宕机背景图2",
      Resource = "StoryBGFengchuan2.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 122,
      FitSize = true,
      Name = "宕机背景图3",
      Resource = "StoryBGFengchuan2.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 123,
      Name = "薇丝2",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 124,
      Name = "薇薇安2",
      Resource = "vivian_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 125,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 126,
      Name = "舒摩尔立绘",
      Resource = "shumoer_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 127,
      Name = "薇丝slice",
      Resource = "weisi_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [14] = {
      EntityID = 128,
      Name = "对话Slice阴影",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 129,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 130,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [17] = {
      EntityID = 131,
      FitSize = false,
      Name = "暗能攻击",
      Resource = "10047",
      Type = "Sound"
    },
    [18] = {
      EntityID = 132,
      FitSize = false,
      Name = "尖锐闪回",
      Resource = "10079",
      Type = "Sound"
    },
    [19] = {
      EntityID = 133,
      FitSize = false,
      Name = "轻微震动",
      Resource = "10035",
      Type = "Sound"
    },
    [20] = {
      EntityID = 134,
      FitSize = false,
      Name = "晕倒",
      Resource = "10016",
      Type = "Sound"
    },
    [21] = {
      EntityID = 135,
      Name = "紧张2BGM",
      Resource = "19",
      Type = "Sound"
    },
    [22] = {
      EntityID = 136,
      FitSize = false,
      Name = "电磁1",
      Resource = "10077",
      Type = "Sound"
    },
    [23] = {
      EntityID = 137,
      FitSize = false,
      Name = "暗鬼低语",
      Resource = "10014",
      Type = "Sound"
    },
    [24] = {
      EntityID = 138,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    }
  },
  ID = 10071302,
  Name = "main_story_7_13_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.4
              },
              [2] = {ShowContent = 0.04, Time = 2.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 105
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 2,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1.25, 1.25},
                  StartValue = {1, 1}
                },
                Time = 1.7
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Scale = {
                  Duration = 2,
                  EndValue = {1.5, 1.5},
                  StartValue = {1.25, 1.25}
                },
                Time = 1.9
              }
            },
            RefEntityID = 121
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0.7,
                  StartValue = 0
                },
                Layer = 3,
                Scale = {
                  Duration = 2,
                  EndValue = {1, 1},
                  StartValue = {1.5, 1.5}
                },
                Time = 1.9
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.7
                },
                Time = 2.9
              }
            },
            RefEntityID = 122
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.7,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1.8
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.7
                },
                Time = 1.9
              }
            },
            RefEntityID = 44
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 2.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 40
                },
                Time = 1.9
              }
            }
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 130, Time = 0.7}
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 131
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 132
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 133
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_2_dialog_content",
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
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_3_dialog_content",
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
                Layer = 8,
                LoopAnimation = "Story_serious",
                Scaling = {0.42, 0.42},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -400},
                  StartValue = {-450, -400}
                }
              }
            },
            RefEntityID = 83
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_4_dialog_content",
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
                LoopAnimation = "Story_serious",
                Position = {450, -250},
                Scaling = {0.4, 0.4},
                Time = 0
              }
            },
            RefEntityID = 114
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_5_dialog_content",
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
            RefEntityID = 114
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_6_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.04, Time = 1.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.8
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
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 2,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1.25, 1.25},
                  StartValue = {1, 1}
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Scale = {
                  Duration = 2,
                  EndValue = {1.5, 1.5},
                  StartValue = {1.25, 1.25}
                },
                Time = 0.2
              }
            },
            RefEntityID = 121
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0.7,
                  StartValue = 0
                },
                Layer = 3,
                Scale = {
                  Duration = 2,
                  EndValue = {1, 1},
                  StartValue = {1.5, 1.5}
                },
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.7
                },
                Time = 1.2
              }
            },
            RefEntityID = 122
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.7,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.1
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.7
                },
                Time = 0.2
              }
            },
            RefEntityID = 44
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 2.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 40
                },
                Time = 0.2
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 4,
                Scaling = {0.42, 0.42},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -400},
                  StartValue = {-400, -400}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.2,
                Translate = {
                  Duration = 2,
                  EndValue = {-400, -400},
                  StartValue = {-500, -400}
                }
              }
            },
            RefEntityID = 123
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 3,
                Scaling = {0.4, 0.4},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {350, -250},
                  StartValue = {450, -250}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.2,
                Translate = {
                  Duration = 2,
                  EndValue = {450, -250},
                  StartValue = {350, -250}
                }
              }
            },
            RefEntityID = 124
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 132
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 133
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 134
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_8_dialog_content",
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
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -250},
                  StartValue = {450, -250}
                }
              }
            },
            RefEntityID = 114
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
                LoopAnimation = "Story_surprise",
                Position = {0, -200},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 125
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_9_dialog_content",
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
                Layer = 11,
                Time = 0
              }
            },
            RefEntityID = 83
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
            RefEntityID = 125
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_10_dialog_content",
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 83
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
            RefEntityID = 125
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_11_dialog_content",
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
                Layer = 11,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 83
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
            RefEntityID = 125
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_12_dialog_content",
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
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 83
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 125
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_13_dialog_content",
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
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_14_dialog_content",
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
                Layer = 11,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 83
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
            RefEntityID = 125
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.5
              },
              [2] = {ShowContent = 0.04, Time = 3.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
            RefEntityID = 83
          },
          [3] = {
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
            RefEntityID = 125
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
            RefEntityID = 114
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 3,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                LoopAnimation = "Story_despise",
                Position = {0, -400},
                Scaling = {0.5, 0.5},
                Time = 1.5
              }
            },
            RefEntityID = 126
          },
          [7] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 105
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 60,
                Time = 1.3
              },
              [2] = {Active = false, Time = 2}
            },
            RefEntityID = 129
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 3,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.3}
            },
            RefEntityID = 136
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.3}
            },
            RefEntityID = 137
          },
          [12] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 14,
                Time = 1.4
              }
            },
            RefEntityID = 138
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_16_dialog_content",
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
            RefEntityID = 126
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 135, Time = 0}
            }
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_17_dialog_content",
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
                Layer = 20,
                LoopAnimation = "Story_anger",
                Position = {-300, 0},
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
            RefEntityID = 127
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
                Position = {-300, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 128
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_18_dialog_content",
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
            RefEntityID = 127
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_19_dialog_content",
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 127
          },
          [3] = {
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
            RefEntityID = 128
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                LoopAnimation = "Story_proud",
                Time = 0
              }
            },
            RefEntityID = 126
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_20_dialog_content",
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
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_21_dialog_content",
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
            RefEntityID = 126
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_22_dialog_content",
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
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 126
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_23_dialog_content",
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
            RefEntityID = 126
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_7_13_24_dialog_content",
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
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                LoopAnimation = "Story_despise",
                Time = 0
              }
            },
            RefEntityID = 126
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 0.7,
                  StartValue = 0.8
                },
                Time = 0,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [25] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
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
