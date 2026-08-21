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
      Name = "蜡笔地图spine",
      Resource = "n2_storybglabiditu_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      Name = "戴发带的白青蛙",
      Resource = "daifadaiqingwa1.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      Name = "戴发带的白青蛙2",
      Resource = "daifadaiqingwa2.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "绘本碎片巨像",
      Resource = "juxiang.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      Name = "白色王子",
      Resource = "baisewangzi.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      Name = "蜡笔转场特效",
      Resource = "uieff_Story_labi.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      Name = "彩虹光特效",
      Resource = "uieff_wutaicaihong.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "浪漫背景",
      Resource = "StoryBGlangman2.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "浪漫气泡特效",
      Resource = "uieff_Story_Romantic.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 15,
      Name = "伊芙赛季皮肤",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      Name = "伊芙赛季皮肤edge",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "男主圆形切条",
      Resource = "nanzhu_zuzhou_spine_idle.prefab",
      Type = "SpineCircleEdge"
    },
    [18] = {
      EntityID = 18,
      FitSize = true,
      Name = "赤眼谷山顶背景图",
      Resource = "StoryBGchiyangushanding.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 19,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 20,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      Name = "丘布弹弹音效",
      Resource = "10260",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "翻书",
      Resource = "10146",
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
      Name = "写字音效",
      Resource = "10129",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      Name = "阳光2",
      Resource = "10037",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "电磁2",
      Resource = "10078",
      Type = "Sound"
    }
  },
  ID = 50559912,
  Name = "event_story_CN2xinshengzhilu_99_12",
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
              }
            },
            RefEntityID = 2
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 21, Time = 0.5}
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.5,
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
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 6,
                Position = {500, -100},
                Scaling = {0.7, 0.7},
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = {0.7, 0.75},
                  StartValue = {0.7, 0.7}
                },
                Time = 1.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {450, -50},
                  StartValue = {500, -100}
                }
              },
              [3] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = {0.7, 0.7},
                  StartValue = {0.7, 0.75}
                },
                Time = 1.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {400, -100},
                  StartValue = {450, -50}
                }
              },
              [4] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = {0.7, 0.75},
                  StartValue = {0.7, 0.7}
                },
                Time = 1.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {350, -50},
                  StartValue = {400, -100}
                }
              },
              [5] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = {0.7, 0.7},
                  StartValue = {0.7, 0.75}
                },
                Time = 2.2,
                Translate = {
                  Duration = 0.3,
                  EndValue = {300, -100},
                  StartValue = {350, -50}
                }
              },
              [6] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.8,
                Translate = {
                  Duration = 2,
                  EndValue = {200, -100},
                  StartValue = {300, -100}
                }
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Position = {-400, 0},
                Time = 0
              },
              [2] = {
                BrightnessChange = {
                  Duration = 1,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 2.8,
                Translate = {
                  Duration = 2,
                  EndValue = {-300, 0},
                  StartValue = {-400, 0}
                }
              }
            },
            RefEntityID = 7
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 2.8
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 6,
                Scaling = {0.7, 0.7},
                Time = 2.8,
                Translate = {
                  Duration = 2,
                  EndValue = {200, -100},
                  StartValue = {300, -100}
                }
              }
            },
            RefEntityID = 6
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.5}
            },
            RefEntityID = 23
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.6},
              [2] = {PlaySound = "Once", Time = 2.2}
            },
            RefEntityID = 22
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              }
            },
            RefEntityID = 1
          }
        },
        [3] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                PlayAnimation = "uieff_Story_labi_out",
                Time = 0
              },
              [2] = {Active = true, Time = 1.5}
            },
            RefEntityID = 9
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
                Layer = 8,
                Time = 1
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 2.3
              }
            },
            RefEntityID = 1
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
                Layer = 50,
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
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "uieff_Story_labi_in",
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
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
                Time = 0.2
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 7,
                Time = 0.2
              }
            },
            RefEntityID = 12
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
                Layer = 18,
                Time = 0.2
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 26
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_surprise",
                Position = {-500, 0},
                Scaling = {0.85, 0.85},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -270},
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_excited",
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 1.5,
                  EndValue = {-150, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_sad", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
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
                  Duration = 1,
                  EndValue = {0, 0},
                  StartValue = {-150, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0,
                Layer = 20,
                LoopAnimation = "Story_heiying",
                Position = {550, 100},
                Scaling = {0.6, 0.6},
                Scroll = {
                  Background = {
                    Offset = {0, 0},
                    Resource = "StoryBGchiyangushanding.prefab"
                  },
                  Duration = 0.5,
                  Radius = 350,
                  Shadow = {
                    Offset = {0, 0},
                    ShowShadow = false
                  },
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -250},
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [4] = {
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
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Time = 0
              },
              [2] = {Active = false, Time = 0.6}
            },
            RefEntityID = 19
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_13_dialog_content",
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
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_14_dialog_content",
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
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_16_dialog_content",
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
            RefEntityID = 16
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                LoopAnimation = "Story_norm",
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 0},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0.2
              }
            },
            RefEntityID = 16
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_22_dialog_content",
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
            RefEntityID = 16
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                LoopAnimation = "Story_scare",
                Time = 0.3
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 0},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0.5
              }
            },
            RefEntityID = 16
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 19
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559912_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.04, Time = 0.2}
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
            RefEntityID = 16
          }
        },
        [27] = {
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
              [2] = {Active = true, Time = 2.8}
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
