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
      EntityID = 4,
      FitSize = false,
      Name = "北境荒原",
      Resource = "StoryBGbeijinghuangye.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 5,
      FitSize = false,
      Name = "耶利亚替代",
      Resource = "yeliya_n27_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      Effect = "DISSOLVE",
      EntityID = 6,
      Name = "暗鬼小兵",
      Resource = "rishixiaobing_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 7,
      Name = "消散特效-消失",
      Resource = "uieff_spine_mendelssohn_dissolve.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 8,
      FitSize = false,
      Name = "暗鬼小兵2",
      Resource = "rishixiaobing_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 9,
      Name = "攻击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [9] = {
      EntityID = 10,
      FitSize = false,
      Name = "受击音效",
      Resource = "10073",
      Type = "Sound"
    },
    [10] = {
      Effect = "DISSOLVE",
      EntityID = 11,
      FitSize = false,
      Name = "暗鬼大兵",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 12,
      FitSize = false,
      Name = "暗鬼嚎叫",
      Resource = "10028",
      Type = "Sound"
    },
    [12] = {
      EntityID = 13,
      FitSize = false,
      Name = "暗鬼叫声2",
      Resource = "10069",
      Type = "Sound"
    },
    [13] = {
      EntityID = 14,
      FitSize = false,
      Name = "暗鬼大兵2",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 15,
      FitSize = false,
      Name = "暗鬼新娘普通",
      Resource = "anguixinniang_n27_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "塔拉",
      Resource = "tala_n27_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "hug",
      Resource = "10058",
      Type = "Sound"
    },
    [17] = {
      EntityID = 18,
      FitSize = false,
      Name = "亚度尼斯edge",
      Resource = "yadunisi_n27_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [18] = {
      EntityID = 19,
      FitSize = false,
      Name = "凯雅edge",
      Resource = "kaiya_n27_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [19] = {
      EntityID = 20,
      FitSize = false,
      Name = "耶利亚edge",
      Resource = "yeliya_n27_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [20] = {
      EntityID = 21,
      Name = "闪白图片（上）",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 22,
      FitSize = false,
      Name = "魔药",
      Resource = "moyaoman.prefab",
      Type = "Picture"
    },
    [22] = {
      EntityID = 23,
      FitSize = false,
      Name = "魔药破（替代）",
      Resource = "moyaoposui.prefab",
      Type = "Picture"
    },
    [23] = {
      EntityID = 24,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [24] = {
      EntityID = 25,
      FitSize = false,
      Name = "闪白（底层）",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [25] = {
      EntityID = 26,
      FitSize = false,
      Name = "阴间特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [26] = {
      EntityID = 29,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [27] = {
      EntityID = 31,
      FitSize = false,
      Name = "暗鬼低语音效",
      Resource = "10013",
      Type = "Sound"
    },
    [28] = {
      EntityID = 32,
      FitSize = false,
      Name = "受击",
      Resource = "10095",
      Type = "Sound"
    },
    [29] = {
      EntityID = 34,
      FitSize = false,
      Name = "打碎瓷器",
      Resource = "10364",
      Type = "Sound"
    },
    [30] = {
      EntityID = 35,
      FitSize = false,
      Name = "滋滋声",
      Resource = "10119",
      Type = "Sound"
    }
  },
  ID = 50400201,
  Name = "event_story_N27guanyue_2_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1
              }
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
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 29,
                Time = 0.5
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Position = {-400, -400},
                Scaling = {0.9, 0.9},
                Time = 0
              },
              [2] = {
                Active = true,
                Time = 0.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -400},
                  StartValue = {-400, -400}
                }
              },
              [3] = {
                Active = true,
                Time = 1.1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -400},
                  StartValue = {-200, -400}
                }
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -250},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Active = true,
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 1.2
              },
              [3] = {
                Active = true,
                Dissolve = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.7
              },
              [4] = {
                Active = true,
                Alpha = 1,
                Layer = 8,
                Position = {0, -250},
                Scaling = {0.3, 0.3},
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 29,
                Position = {400, 0},
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 29,
                Position = {-100, 0},
                Time = 1
              },
              [2] = {Active = false, Time = 1.6}
            },
            RefEntityID = 9
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 10
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 31
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
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
                Scaling = {0.3, 0.3},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -250},
                  StartValue = {600, -250}
                }
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
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5040_50400201_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
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
                Scaling = {0.4, 0.4},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -250},
                  StartValue = {600, -250}
                }
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -250},
                  StartValue = {400, -250}
                }
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 12
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5040_50400201_4_dialog_content",
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
            RefEntityID = 11
          }
        },
        [5] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yeliya"
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
            RefEntityID = 5
          }
        },
        [6] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yeliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguaideangui"
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
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 8,
                Position = {-400, -250},
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {400, -250},
                Scaling = {0.4, 0.4},
                Time = 0.2
              }
            },
            RefEntityID = 14
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
                Layer = 8,
                LoopAnimation = "Story_angry",
                Scaling = {0.95, 0.95},
                Time = 0.5,
                Translate = {
                  Duration = 1,
                  EndValue = {-50, -510},
                  StartValue = {-50, -610}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 1.5
              },
              [3] = {
                Active = true,
                Time = 1.7,
                Translate = {
                  Duration = 1,
                  EndValue = {-50, -410},
                  StartValue = {-50, -510}
                }
              }
            },
            RefEntityID = 15
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 3,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.2
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 31
          }
        },
        [8] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yadunisi"
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
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 7,
                Scale = {
                  Duration = 1,
                  EndValue = {0.4, 0.4},
                  StartValue = {0.35, 0.35}
                },
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [3] = {
                Active = true,
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 15
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Position = {0, -300},
                Scaling = {0.8, 0.8},
                Time = 0.2
              }
            },
            RefEntityID = 16
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 17
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_angry",
                Position = {-550, 0},
                Scaling = {0.95, 0.95},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -360},
                Time = 0.5
              }
            },
            RefEntityID = 18
          }
        },
        [9] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tala"
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
                LoopAnimation = "Story_angry",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {500, -300},
                  StartValue = {0, -300}
                }
              },
              [2] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -300},
                  StartValue = {500, -300}
                }
              }
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {0, 0},
                Time = 0.5
              },
              [2] = {Active = false, Time = 1.1}
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -250},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Active = true,
                Dissolve = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.7
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 32
          }
        },
        [10] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {550, 0},
                Scaling = {0.84, 0.84},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -430},
                Time = 0
              }
            },
            RefEntityID = 19
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
            RefEntityID = 16
          }
        },
        [11] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguaideangui"
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
                Scaling = {0.95, 0.95},
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-550, -410},
                  StartValue = {-650, -410}
                }
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, -300},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 16
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
            RefEntityID = 19
          }
        },
        [12] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguaideangui"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-450, -410},
                  StartValue = {-550, -410}
                }
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -300},
                  StartValue = {200, -300}
                }
              }
            },
            RefEntityID = 16
          }
        },
        [13] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguaideangui"
          }
        },
        [14] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tala"
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
            RefEntityID = 16
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
            RefEntityID = 15
          }
        },
        [15] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_15_dialog_content",
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
            RefEntityID = 16
          }
        },
        [16] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yeliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_think",
                Scaling = {0.9, 0.9},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -416},
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [17] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tala"
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
            RefEntityID = 16
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
            RefEntityID = 20
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5040_50400201_18_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, -410},
                  StartValue = {-450, -410}
                }
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              },
              [2] = {LoopAnimation = "Story_pain", Time = 0.2}
            },
            RefEntityID = 16
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
                Layer = 49,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.2
              }
            },
            RefEntityID = 21
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {300, 0},
                Time = 0.2
              },
              [2] = {Active = false, Time = 0.8}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 10
          }
        },
        [19] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yadunisi"
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
            RefEntityID = 18
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
            RefEntityID = 16
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
            RefEntityID = 15
          }
        },
        [20] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yeliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Position = {-550, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -416},
                Time = 0.2
              }
            },
            RefEntityID = 20
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
            RefEntityID = 18
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5040_50400201_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 4.6
              }
            },
            RefEntityID = 1
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
            RefEntityID = 20
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {300, -410},
                  StartValue = {100, -410}
                }
              },
              [2] = {
                Active = true,
                Position = {100, -410},
                Time = 1.5
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.2
              },
              [2] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -300},
                  StartValue = {400, -300}
                }
              },
              [3] = {
                Position = {0, -300},
                Time = 1.5
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 11,
                Scaling = {0.2, 0.2},
                Time = 0.4,
                Translate = {
                  Duration = 0.5,
                  EndValue = {650, -300},
                  StartValue = {600, 0}
                }
              },
              [2] = {
                Active = true,
                Rotate = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = -20
                },
                Scaling = {0.3, 0.3},
                Time = 1.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, -200},
                  StartValue = {0, 100}
                }
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3.7
              }
            },
            RefEntityID = 22
          },
          [6] = {
            KeyFrames = {
              [1] = {Time = 1.5},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 11,
                Position = {0, -200},
                Rotate = {
                  Duration = 0,
                  EndValue = -20,
                  StartValue = 0
                },
                Scaling = {0.3, 0.3},
                Time = 3.7
              }
            },
            RefEntityID = 23
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 49,
                Time = 0.5
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.6
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Time = 3.5
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 3.7
              }
            },
            RefEntityID = 21
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, -300},
                Scale = {
                  Duration = 2,
                  EndValue = 0.6,
                  StartValue = 0.7
                },
                Time = 1.5
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 3.7
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 1.5
              }
            },
            RefEntityID = 24
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 0.6,
                Layer = 9,
                Time = 1.5
              }
            },
            RefEntityID = 25
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Layer = 10,
                Time = 4.6
              }
            },
            RefEntityID = 26
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 3.7}
            },
            RefEntityID = 34
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 4.6}
            },
            RefEntityID = 35
          }
        },
        [22] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tala"
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
                Brightness = 1,
                Layer = 8,
                Position = {500, -300},
                Shake = {
                  Duration = 0.3,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.2
              },
              [2] = {
                Time = 0.5,
                Translate = {
                  Duration = 1,
                  EndValue = {500, -400},
                  StartValue = {500, -300}
                }
              }
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 25
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
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
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 24
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 23
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position = {300, -410},
                Time = 0.2
              }
            },
            RefEntityID = 15
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5040_50400201_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguaideangui"
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
            RefEntityID = 16
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
                LoopAnimation = "Story_surprise",
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-400, -410},
                  StartValue = {300, -410}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          }
        },
        [24] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
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
                Time = 0.2
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-800, -410},
                  StartValue = {-400, -410}
                }
              },
              [2] = {
                Active = true,
                Time = 0.7,
                Translate = {
                  Duration = 1,
                  EndValue = {-800, -410},
                  StartValue = {800, -410}
                }
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.5
              },
              [4] = {
                Active = false,
                Layer = 9,
                Time = 0.4
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Dissolve = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Layer = 8,
                Position = {500, -200},
                Time = 0.4
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 7,
                Position = {150, -250},
                Time = 0.4
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Dissolve = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Layer = 7,
                Position = {-150, -250},
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {-500, -200},
                Time = 0.4
              },
              [2] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Shake = {
                  Duration = 0.2,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 2
              },
              [3] = {
                Active = true,
                Time = 2.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-800, -200},
                  StartValue = {-500, -200}
                }
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 16
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 13
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5040_50400201_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -200},
                  StartValue = {500, -200}
                }
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
            RefEntityID = 11
          }
        },
        [26] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_27_dialog_content",
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
        [27] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yeliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Position = {550, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -416},
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [28] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5040_50400201_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yeliya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Position = {-550, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 18
          }
        },
        [29] = {
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
