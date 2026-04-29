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
      FitSize = false,
      Name = "影镇街道（海底）",
      Resource = "StoryBGjiedaohaidi.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "火打击-大",
      Resource = "uieff_spine_huodaji01.prefab",
      Type = "Effect"
    },
    [5] = {
      EntityID = 5,
      Name = "克娜莉立绘替代",
      Resource = "kenalinvwang2_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      Name = "烈雀鱼",
      Resource = "qiyu_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 9,
      FitSize = false,
      Name = "海底居民B替代",
      Resource = "yurenjumin2_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 10,
      FitSize = false,
      Name = "海底居民A替代",
      Resource = "yurenjumin1_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 11,
      FitSize = false,
      Name = "水形之主替代",
      Resource = "shuixingzhizhu_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 12,
      FitSize = false,
      Name = "切屏转场",
      Resource = "uieff_Story_blackscreen.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 13,
      FitSize = false,
      Name = "鱼人国王替代",
      Resource = "yurenguowang_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 14,
      FitSize = false,
      Name = "速度线特效",
      Resource = "uieff_Story_SpeedLine.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 16,
      Name = "知更替代",
      Resource = "zhigengyhaoyu_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 17,
      FitSize = false,
      Name = "克娜莉切条",
      Resource = "kenalinvwang2_S3_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [15] = {
      EntityID = 18,
      FitSize = false,
      Name = "鱼人国王替代切条",
      Resource = "yurenguowang_S3_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [16] = {
      EntityID = 19,
      FitSize = false,
      Name = "鱼人卫兵A替代",
      Resource = "yurenweibinga_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [17] = {
      EntityID = 20,
      FitSize = false,
      Name = "鱼人卫兵B替代",
      Resource = "yurenweibingb_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 21,
      FitSize = false,
      Name = "斩击特效",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [19] = {
      EntityID = 22,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [20] = {
      EntityID = 23,
      FitSize = false,
      Name = "爆炸音效",
      Resource = "10046",
      Type = "Sound"
    },
    [21] = {
      EntityID = 24,
      FitSize = false,
      Name = "摩擦",
      Resource = "10057",
      Type = "Sound"
    },
    [22] = {
      EntityID = 25,
      FitSize = true,
      Name = "恐怖背景",
      Resource = "StoryBGtongyongkongbu.prefab",
      Type = "Picture"
    },
    [23] = {
      EntityID = 26,
      FitSize = false,
      Name = "嗖",
      Resource = "10207",
      Type = "Sound"
    },
    [24] = {
      EntityID = 27,
      FitSize = false,
      Name = "阴风",
      Resource = "10329",
      Type = "Sound"
    },
    [25] = {
      EntityID = 28,
      FitSize = false,
      Name = "轰",
      Resource = "10015",
      Type = "Sound"
    },
    [26] = {
      EntityID = 29,
      FitSize = false,
      Name = "攻击",
      Resource = "10004",
      Type = "Sound"
    },
    [27] = {
      EntityID = 30,
      FitSize = false,
      Name = "砰",
      Resource = "10044",
      Type = "Sound"
    },
    [28] = {
      EntityID = 31,
      FitSize = false,
      Name = "悲痛BGM",
      Resource = "20",
      Type = "Sound"
    }
  },
  ID = 50661102,
  Name = "event_story_S3kenali_11_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_1_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 1.9},
              [2] = {ShowContent = 0.02, Time = 2.1}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
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
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 22,
                Time = 0.5
              },
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 1.9
              },
              [2] = {Active = true, Time = 3.9}
            },
            RefEntityID = 4
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 1.9
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.9}
            },
            RefEntityID = 23
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                Position = {-30, -380},
                Scaling = {0.85, 0.85},
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Time = 0.4}
            },
            RefEntityID = 24
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
                Position = {450, -150},
                Scaling = {0.7, 0.7},
                Time = 0.2
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
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-450, -380},
                  StartValue = {0, -380}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_4_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 5
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
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_5_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [6] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-550, -300},
                  StartValue = {-450, -300}
                }
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {550, -150},
                  StartValue = {450, -150}
                }
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
                Layer = 8,
                LoopAnimation = "Story_sad",
                Position = {0, 0},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 11
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
            RefEntityID = 2
          },
          [6] = {
            KeyFrames = {
              [1] = {Brightness = 0.5, Time = 0}
            },
            RefEntityID = 3
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
                Layer = 5,
                Time = 0
              }
            },
            RefEntityID = 25
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_7_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_8_dialog_content",
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
                Layer = 20,
                Position = {-450, 0},
                Scaling = {0.85, 0.85},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -380},
                Time = 0
              }
            },
            RefEntityID = 17
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
            RefEntityID = 11
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
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
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 1.6
              }
            },
            RefEntityID = 11
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
            RefEntityID = 17
          }
        },
        [11] = {
          [1] = {
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
            RefEntityID = 11
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 1
              }
            },
            RefEntityID = 3
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
            RefEntityID = 25
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_haidijumina"
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
                Position = {-450, -200},
                Scaling = {0.7, 0.7},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -100},
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_haidijuminb"
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
                Position = {450, -200},
                Scaling = {0.7, 0.7},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -50},
                Time = 0
              }
            },
            RefEntityID = 9
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
            RefEntityID = 10
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yurenguowang"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              },
              [2] = {
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_out",
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 5
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
                Layer = 8,
                Position = {0, -260},
                Scaling = {0.85, 0.85},
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0.9,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 100},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 10
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_13_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yurenguowang"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_14_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yurenguowang"
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
                EffectFullScreen = true,
                Layer = 18,
                Position = {0, 200},
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 26
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.4
              },
              [2] = {ShowContent = 0.02, Time = 1.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              },
              [2] = {
                PlayAnimation = "uieff_Story_blackscreen_right_out",
                Time = 0.6
              }
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 13
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.6
              }
            }
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
                Brightness = 1,
                LoopAnimation = "Story_poor",
                Position = {450, -150},
                Time = 1.4
              }
            },
            RefEntityID = 6
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_robine"
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
                LoopAnimation = "Story_angry",
                Position = {-450, 0},
                Scaling = {0.9, 0.9},
                Time = 0
              }
            },
            RefEntityID = 16
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yurenguowang"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Scaling = {0.85, 0.85},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {-200, -260},
                Time = 0
              }
            },
            RefEntityID = 18
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
            RefEntityID = 16
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_18_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 1.5},
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 21,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              },
              [2] = {
                PlayAnimation = "uieff_Story_blackscreen_right_out",
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 8,
                Position = {0, -380},
                Scaling = {0.85, 0.85},
                Time = 0.5
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 16
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 18
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 1.5
              }
            },
            RefEntityID = 4
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 1.5
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 28
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              },
              [2] = {
                PlayAnimation = "uieff_Story_blackscreen_right_out",
                Time = 0.5
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
                Layer = 8,
                Scaling = {0.7, 0.7},
                Time = 0.9,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-450, -200},
                  StartValue = {-450, -600}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 2.1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-550, -200},
                  StartValue = {-450, -200}
                }
              }
            },
            RefEntityID = 19
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Scaling = {0.7, 0.7},
                Time = 0.9,
                Translate = {
                  Duration = 0.4,
                  EndValue = {450, -130},
                  StartValue = {450, -500}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 2.1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {550, -130},
                  StartValue = {450, -130}
                }
              }
            },
            RefEntityID = 20
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 5
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
                Brightness = 1,
                Layer = 8,
                Position = {0, -150},
                Time = 2.1
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 4
          }
        },
        [22] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 21
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
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              },
              [2] = {
                Time = 1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-550, -800},
                  StartValue = {-550, -200}
                }
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.2
              }
            },
            RefEntityID = 19
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
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              },
              [2] = {
                Time = 1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {550, -800},
                  StartValue = {550, -130}
                }
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.2
              }
            },
            RefEntityID = 20
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
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 1.3
              },
              [3] = {Time = 1.9}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 29
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 30
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_robine"
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
                  EndValue = {450, -150},
                  StartValue = {0, -150}
                }
              }
            },
            RefEntityID = 6
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
                Time = 0.2
              }
            },
            RefEntityID = 16
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
            RefEntityID = 16
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
          }
        },
        [25] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {800, -150},
                  StartValue = {450, -150}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          }
        },
        [26] = {
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
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 16
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_22_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 0.7},
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.7}
            },
            RefEntityID = 4
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.7
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 28
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.02, Time = 1.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                Time = 0.7
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
                  EndValue = {-450, -380},
                  StartValue = {-30, -380}
                }
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {450, -150},
                  StartValue = {800, -150}
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
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_25_dialog_content",
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
            RefEntityID = 5
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
            RefEntityID = 5
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
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_27_dialog_content",
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
            RefEntityID = 5
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
            RefEntityID = 5
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
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_29_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_30_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.1, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-600, 200},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.5,
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.6
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
                Time = 0.6
              }
            },
            RefEntityID = 5
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {600, 200},
                  StartValue = {-600, 200}
                }
              }
            }
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
            RefEntityID = 5
          },
          [5] = {
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
            RefEntityID = 3
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-600, 200},
                  StartValue = {600, 200}
                }
              }
            }
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
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          }
        },
        [39] = {
          [1] = {
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
              }
            },
            RefEntityID = 2
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_34_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.7
              },
              [2] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0
              }
            }
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
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 23
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
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.06, Time = 0.7}
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
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {-30, -380},
                Scaling = {0.85, 0.85},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 31,
                Time = 0
              }
            }
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_36_dialog_content",
            KeyFrames = {
              [1] = {
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
                  Duration = 0.5,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 200},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_37_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.5
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.2,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_38_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [45] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661102_39_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.04,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          }
        },
        [47] = {
          [1] = {
            KeyFrames = {
              [1] = {Time = 2}
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
