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
      FitSize = false,
      Name = "艾蕾雅皮肤",
      Resource = "aileiyapifu_S4_spine_idle.prefab",
      Type = "Spine"
    },
    [3] = {
      EntityID = 3,
      Name = "克娜丽立绘替代",
      Resource = "kenali_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "假日咖啡馆背景",
      Resource = "StoryJiari.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 6,
      FitSize = false,
      Name = "简立绘",
      Resource = "jianzhengren_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 7,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 8,
      FitSize = false,
      Name = "饮料代替",
      Resource = "wenjian.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 9,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 10,
      FitSize = false,
      Name = "双榭城街道西侧",
      Resource = "StoryBGshuangxiechengxice.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 11,
      FitSize = false,
      Name = "闪回音效",
      Resource = "10020",
      Type = "Sound"
    },
    [11] = {
      EntityID = 12,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 13,
      FitSize = false,
      Name = "转场",
      Resource = "uieff_Story_blackscreen.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 14,
      FitSize = false,
      Name = "艾蕾雅",
      Resource = "1500991_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 15,
      FitSize = true,
      Name = "影镇室外背景",
      Resource = "StoryBGyingzhenjiedao.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "邪剑使代替",
      Resource = "xiejianlongzhou_S4_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "写字",
      Resource = "10129",
      Type = "Sound"
    },
    [17] = {
      EntityID = 20,
      FitSize = true,
      Name = "双榭城港口东侧街道",
      Resource = "StoryBGshuangxiegangkoudong.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 22,
      FitSize = false,
      Name = "茶杯碰撞",
      Resource = "10167",
      Type = "Sound"
    },
    [19] = {
      EntityID = 23,
      FitSize = false,
      Name = "彩虹光",
      Resource = "uieff_wutaicaihong.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 24,
      FitSize = false,
      Name = "海鸥叫声",
      Resource = "10114",
      Type = "Sound"
    },
    [21] = {
      EntityID = 25,
      FitSize = false,
      Name = "闪烁音效",
      Resource = "10038",
      Type = "Sound"
    },
    [22] = {
      EntityID = 26,
      FitSize = false,
      Name = "海浪声",
      Resource = "10113",
      Type = "Sound"
    },
    [23] = {
      EntityID = 27,
      FitSize = false,
      Name = "极光cg",
      Resource = "CGnuanyangzhixia.prefab",
      Type = "Picture"
    },
    [24] = {
      EntityID = 28,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [25] = {
      EntityID = 29,
      FitSize = false,
      Name = "温馨BGM",
      Resource = "29",
      Type = "Sound"
    },
    [26] = {
      EntityID = 30,
      Name = "跑步音效",
      Resource = "10082",
      Type = "Sound"
    },
    [27] = {
      EntityID = 32,
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [28] = {
      EntityID = 33,
      FitSize = false,
      Name = "n26bgm",
      Resource = "86",
      Type = "Sound"
    },
    [29] = {
      EntityID = 34,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [30] = {
      EntityID = 35,
      Name = "黑幕底图",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    }
  },
  ID = 30990602,
  Name = "chara_story_aileiya_3",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                LoopAnimation = "Story_smile",
                Position = {-50, -270},
                Scaling = {0.45, 0.45},
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 7,
                Position = {-600, -450},
                Scaling = {1.04, 1.04},
                Time = 0
              }
            },
            RefEntityID = 6
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
                Brightness = 0.2,
                Layer = 7,
                LoopAnimation = "Story_happy",
                Position = {600, -300},
                Scaling = {0.95, 0.95},
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 28,
                Time = 0
              }
            }
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -400},
                  StartValue = {-600, -450}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -450},
                  StartValue = {-500, -400}
                }
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
                Layer = 7,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_worried",
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                LoopAnimation = "Story_nervous",
                Shake = {
                  Duration = 1,
                  Strength = {40, 20},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 7,
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_think",
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
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -250},
                  StartValue = {600, -300}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -300},
                  StartValue = {600, -250}
                }
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
                LoopAnimation = "Story_norm",
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-600, -450},
                  StartValue = {-450, -450}
                }
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                LoopAnimation = "Story_smile",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-150, -250},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -270},
                  StartValue = {-150, -250}
                }
              },
              [3] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-150, -250},
                  StartValue = {-200, -270}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -270},
                  StartValue = {-150, -250}
                }
              },
              [5] = {
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -250},
                  StartValue = {-50, -270}
                }
              },
              [6] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, -270},
                  StartValue = {50, -250}
                }
              },
              [7] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -250},
                  StartValue = {100, -270}
                }
              },
              [8] = {
                Time = 1.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -270},
                  StartValue = {50, -250}
                }
              }
            },
            RefEntityID = 2
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.5},
              [3] = {PlaySound = "Once", Time = 1},
              [4] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 30
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-400, -450},
                  StartValue = {-600, -450}
                }
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {500, -300},
                  StartValue = {600, -300}
                }
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
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
            RefEntityID = 6
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
            RefEntityID = 2
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
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
            RefEntityID = 3
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
            RefEntityID = 6
          }
        },
        [13] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Time = 0.5
              }
            }
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Time = 0}
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_worried",
                Shake = {
                  Duration = 1,
                  Strength = {40, 30},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 2
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
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
                LoopAnimation = "Story_think",
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
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_norm",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {600, -300},
                  StartValue = {500, -300}
                }
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
                LoopAnimation = "Story_norm",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -450},
                  StartValue = {-400, -450}
                }
              }
            },
            RefEntityID = 6
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
                LoopAnimation = "Story_nervous",
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-100, -270},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {100, -270},
                  StartValue = {-100, -270}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-50, -270},
                  StartValue = {100, -270}
                }
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.3},
              [3] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 30
          }
        },
        [19] = {
          [1] = {
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
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 9
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
                Layer = 4,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, -100},
                  StartValue = {0, 100}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 18,
                Time = 0.5
              }
            },
            RefEntityID = 12
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [22] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_left_in",
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -100}
                }
              }
            }
          }
        },
        [23] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_out",
                Time = 1
              }
            },
            RefEntityID = 13
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Time = 1
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 1
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -250},
                  StartValue = {600, -300}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -300},
                  StartValue = {600, -250}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -250},
                  StartValue = {600, -300}
                }
              },
              [4] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -300},
                  StartValue = {600, -250}
                }
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 30
          }
        },
        [25] = {
          [1] = {
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
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 9
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
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
                  StartValue = 0.8
                },
                Layer = 18,
                Time = 0.5
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
                Brightness = 0.2,
                Layer = 20,
                Position = {0, -150},
                Scaling = {1.1, 1.1},
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 4,
                Time = 0.5
              }
            },
            RefEntityID = 15
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [28] = {
          [1] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 12
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_suprise",
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 15
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 14
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 1
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 2
              }
            },
            RefEntityID = 7
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-150, -250},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -270},
                  StartValue = {-150, -250}
                }
              },
              [3] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-150, -250},
                  StartValue = {-200, -270}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -270},
                  StartValue = {-150, -250}
                }
              },
              [5] = {
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -250},
                  StartValue = {-50, -270}
                }
              },
              [6] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, -270},
                  StartValue = {50, -250}
                }
              },
              [7] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -250},
                  StartValue = {100, -270}
                }
              },
              [8] = {
                Time = 1.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -270},
                  StartValue = {50, -250}
                }
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.5},
              [3] = {PlaySound = "Once", Time = 1},
              [4] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 30
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
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                LoopAnimation = "Story_happy",
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scaling = 0.3,
                Time = 0.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 300},
                  StartValue = {0, 500}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.8,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.8
              }
            },
            RefEntityID = 7
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 33,
                Time = 0
              }
            }
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scaling = 0.3,
                Time = 0.5,
                Translate = {
                  Duration = 3,
                  EndValue = {0, 400},
                  StartValue = {0, -500}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.8,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.8
              }
            },
            RefEntityID = 7
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.5
              }
            }
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
                LoopAnimation = "Story_nervous",
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                LoopAnimation = "Story_norm",
                Time = 0.5
              }
            },
            RefEntityID = 3
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jianandkenali"
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
                LoopAnimation = "Story_worried",
                Shake = {
                  Duration = 1,
                  Strength = {40, 20},
                  Vibrato = 40,
                  fadeOut = true
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
                Layer = 8,
                LoopAnimation = "Story_think",
                Shake = {
                  Duration = 1,
                  Strength = {40, 20},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 6
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
            RefEntityID = 2
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = 0.4,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {1700, 500},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {-1500, 500},
                Scaling = 0.4,
                Time = 0.5
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          }
        },
        [42] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scaling = 1,
                Time = 0.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 0},
                  StartValue = {0, 100}
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 2
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 4
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
                Brightness = 0.2,
                Layer = 20,
                Position = {40, -400},
                Scaling = {0.9, 0.9},
                Time = 0.5
              }
            },
            RefEntityID = 16
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 0.5
              }
            },
            RefEntityID = 35
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [47] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                PlayAnimation = "uieff_Story_blackscreen_left_in",
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.5
              }
            }
          }
        },
        [48] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                PlayAnimation = "uieff_Story_blackscreen_right_out",
                Time = 1
              }
            },
            RefEntityID = 13
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 1}
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 16
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 35
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                LoopAnimation = "Story_depress",
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-100, -270},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {100, -270},
                  StartValue = {-100, -270}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-50, -270},
                  StartValue = {100, -270}
                }
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                LoopAnimation = "Story_worried",
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.3},
              [3] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 30
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
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
            RefEntityID = 2
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
            RefEntityID = 2
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
            RefEntityID = 6
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 17
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
                Layer = 9,
                Position = {200, -300},
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 6
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-50, -220},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-50, -270},
                  StartValue = {-50, -220}
                }
              }
            },
            RefEntityID = 2
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 8
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
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -300},
                  StartValue = {600, -300}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {680, -300},
                  StartValue = {500, -300}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {600, -300},
                  StartValue = {680, -300}
                }
              }
            },
            RefEntityID = 3
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
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.3},
              [3] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 30
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
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
            RefEntityID = 3
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 3,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -450},
                  StartValue = {-600, -450}
                }
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                LoopAnimation = "Story_smile",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-50, -220},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-50, -270},
                  StartValue = {-50, -220}
                }
              }
            },
            RefEntityID = 2
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
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 6
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jianandkenali"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.5
              }
            }
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
                LoopAnimation = "Story_think",
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -450},
                  StartValue = {-450, -450}
                }
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_worried",
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 2
          }
        },
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
        [66] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [67] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                  EndValue = {-50, -300},
                  StartValue = {-50, -270}
                }
              }
            },
            RefEntityID = 2
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
            RefEntityID = 6
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-50, -350},
                  StartValue = {-50, -300}
                }
              }
            },
            RefEntityID = 2
          }
        },
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
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
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          }
        },
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -270},
                  StartValue = {-50, -350}
                }
              },
              [2] = {
                LoopAnimation = "Story_suprise",
                Shake = {
                  Duration = 0.4,
                  Strength = {40, 20},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.2
              }
            },
            RefEntityID = 2
          }
        },
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                LoopAnimation = "Story_worried",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -250},
                  StartValue = {600, -300}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, -300},
                  StartValue = {600, -250}
                }
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
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
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
            RefEntityID = 3
          }
        },
        [76] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
            RefEntityID = 2
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
            RefEntityID = 6
          }
        },
        [77] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scaling = 1,
                Time = 0.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 2
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 4
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [78] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Time = 0}
            }
          }
        },
        [79] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, 300},
                  StartValue = {0, 0}
                }
              },
              [3] = {
                Time = 1.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, 0},
                  StartValue = {-100, 300}
                }
              },
              [4] = {
                Time = 2.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, 200},
                  StartValue = {100, 0}
                }
              },
              [5] = {
                Time = 2.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 200},
                  StartValue = {200, 200}
                }
              }
            }
          }
        },
        [80] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.7
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, 200}
                }
              }
            }
          }
        },
        [81] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [82] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [83] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 50,
                PlayAnimation = "uieff_Story_blackscreen_left_in",
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.5
              }
            }
          }
        },
        [84] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                PlayAnimation = "uieff_Story_blackscreen_right_out",
                Time = 1
              }
            },
            RefEntityID = 13
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 20
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = true, Time = 1}
            },
            RefEntityID = 4
          }
        },
        [85] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-550, -400},
                  StartValue = {-600, -450}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -450},
                  StartValue = {-550, -400}
                }
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [86] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                LoopAnimation = "Story_suprise",
                Shake = {
                  Duration = 1,
                  Strength = {40, 30},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 2
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
            RefEntityID = 6
          }
        },
        [87] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {550, -250},
                  StartValue = {600, -300}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -300},
                  StartValue = {550, -250}
                }
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
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [88] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_75_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2},
              [2] = {PlaySound = "Once", Time = 2.2}
            },
            RefEntityID = 22
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0
              }
            }
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
              }
            },
            RefEntityID = 2
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
              }
            },
            RefEntityID = 3
          }
        },
        [89] = {
          [1] = {
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
            RefEntityID = 7
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 4
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.5
              }
            }
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0.5
              }
            }
          }
        },
        [90] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1
          }
        },
        [91] = {
          [1] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 20
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_nervous",
                Position = {-50, -270},
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          }
        },
        [92] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-150, -270},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {100, -270},
                  StartValue = {-150, -270}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-50, -270},
                  StartValue = {100, -270}
                }
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 29,
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.3},
              [3] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 30
          }
        },
        [93] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_78_dialog_content",
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
                Scale = {
                  Duration = 0.7,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 30},
                  StartValue = {0, -30}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 30}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 30},
                  StartValue = {0, -30}
                }
              },
              [4] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 30}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2},
              [3] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 30
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [94] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-50, -220},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-50, -270},
                  StartValue = {-50, -220}
                }
              }
            },
            RefEntityID = 2
          }
        },
        [95] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_80_dialog_content",
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
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              }
            }
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
            RefEntityID = 2
          }
        },
        [96] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_81_dialog_content",
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
        [97] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [98] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [99] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Scale = {
                  Duration = 0.4,
                  EndValue = {0.54, 0.54},
                  StartValue = {0.45, 0.45}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -220},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -270},
                  StartValue = {-50, -220}
                }
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [100] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_85_dialog_content",
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
            RefEntityID = 2
          }
        },
        [101] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Affinity = 30,
                Content = "ui_story_30990602_87_option_content",
                NextParagraphID = 2,
                PetID = 1500991
              },
              [2] = {
                Affinity = 50,
                Content = "ui_story_30990602_91_option_content",
                NextParagraphID = 3,
                PetID = 1500991
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        }
      }
    },
    [2] = {
      ComponentID = "0",
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          },
          [4] = {
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
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ComponentID = "0",
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 26
          },
          NextParagraphID = 4
        }
      }
    },
    [4] = {
      ComponentID = "0",
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_95_dialog_content",
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
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
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
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 9
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 3,
                  EndValue = 1,
                  StartValue = 1.1
                },
                Scaling = 1,
                Time = 0.5,
                Translate = {
                  Duration = 3,
                  EndValue = {0, 0},
                  StartValue = {0, 100}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 20
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Position = {0, -10},
                Scaling = {1.2, 1.2},
                Time = 0.5
              }
            },
            RefEntityID = 27
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.5
              }
            },
            RefEntityID = 23
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 34
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_99_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_100_dialog_content",
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
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_104_dialog_content",
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
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_105_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_108_dialog_content",
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
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_110_dialog_content",
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
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_111_dialog_content",
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_112_dialog_content",
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
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_113_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_115_dialog_content",
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
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_116_dialog_content",
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
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_117_dialog_content",
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
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_118_dialog_content",
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
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_119_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_120_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [28] = {
          [1] = {
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
            RefEntityID = 7
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 27
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 23
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 20
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.5
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                LoopAnimation = "Story_norm",
                Position = {-50, -270},
                Scaling = {0.45, 0.45},
                Time = 0.5
              }
            },
            RefEntityID = 2
          }
        },
        [29] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 7
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_121_dialog_content",
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
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              }
            }
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_122_dialog_content",
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
        [32] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {400, 1000},
                Scale = {
                  Duration = 0,
                  EndValue = 0.3,
                  StartValue = 0.3
                },
                Time = 0.5
              }
            }
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
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 9
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
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 34
          }
        },
        [33] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {400, 200},
                  StartValue = {400, 1000}
                }
              }
            }
          }
        },
        [34] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 800},
                  StartValue = {0, -1500}
                }
              }
            }
          }
        },
        [35] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Time = 0
              }
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_124_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_125_dialog_content",
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
            RefEntityID = 2
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_126_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              }
            }
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_127_dialog_content",
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
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_128_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_suprise",
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-100, -270},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {100, -270},
                  StartValue = {-100, -270}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-50, -270},
                  StartValue = {100, -270}
                }
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.3},
              [3] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 30
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_129_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_130_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_131_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_suprise",
                Shake = {
                  Duration = 1,
                  Strength = {40, 30},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_132_dialog_content",
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
            RefEntityID = 2
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_133_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
            RefEntityID = 2
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_134_dialog_content",
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
            RefEntityID = 2
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_135_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
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
            RefEntityID = 2
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_136_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_137_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_138_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = {0.55, 0.55},
                  StartValue = {0.45, 0.45}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -220},
                  StartValue = {-50, -270}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, -270},
                  StartValue = {-50, -220}
                }
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_139_dialog_content",
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
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              }
            }
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
            RefEntityID = 2
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_140_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
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
            RefEntityID = 2
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_141_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_142_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aileiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_143_dialog_content",
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
            RefEntityID = 2
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_30990602_144_dialog_content",
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
        [58] = {
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
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 7
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
