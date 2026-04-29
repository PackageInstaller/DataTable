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
      Name = "下城通用夜",
      Resource = "StoryBGxiacheng2.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "威廉",
      Resource = "weilian_n48_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_weilian",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [6] = {
      EntityID = 6,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "黑幕-高层",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "维多利亚",
      Resource = "xixueguishenfu_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_victoria",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "真理殿堂",
      Resource = "StoryBGzhenlidiantang.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "戴维·波菲里奥",
      Resource = "daiwei_n48_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_daiwei",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "星空墓穴",
      Resource = "StoryBGxingkongmuxue.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "克莱维斯替代",
      Resource = "kelaiweisi_n48_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_kelaiweisi",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "魔女",
      Resource = "monv_n48_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_monv",
      Type = "Spine"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "蛇夫",
      Resource = "shefu_n48_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_shefu",
      Type = "Spine"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "浮士德立绘",
      Resource = "1500091_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_fushide",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "真理结社BGM",
      Resource = "41",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "晕倒",
      Resource = "10016",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "风声",
      Resource = "10042",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "瓷器碎裂",
      Resource = "10364",
      Type = "Sound"
    }
  },
  ID = 50840802,
  Name = "event_story_N48zhenli_8_2",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              },
              [2] = {ShowContent = 0.02, Time = 1.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weilian"
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
              [1] = {StopBgm = true, Time = 0},
              [2] = {
                FadeTime = 1,
                StartBgm = 16,
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
            RefEntityID = 3
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
                Layer = 8,
                LoopAnimation = "Story_serious",
                Position = {0, -450},
                Scaling = {0.92, 0.92},
                Time = 1
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 3
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
                Alpha = 1,
                Layer = 8,
                LoopAnimation = "Story_pain",
                Position = {0, -200},
                Scaling = {0.85, 0.85},
                Time = 0.2
              }
            },
            RefEntityID = 8
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_3_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_4_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
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
            RefEntityID = 8
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weilian"
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_pain",
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.02, Time = 1.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_daiwei"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -650},
                  StartValue = {0, -450}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.5
              }
            }
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
                Position = {0, 0},
                Scaling = {1.1, 1.1},
                Time = 1
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 17
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_daiwei"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
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
                LoopAnimation = "Story_serious",
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 3,
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kelaiweisi"
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.2
              }
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
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -330},
                Scaling = {0.8, 0.8},
                Time = 0.2
              }
            },
            RefEntityID = 12
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kelaiweisi"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kelaiweisi"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kelaiweisi"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kelaiweisi"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kelaiweisi"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kelaiweisi"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 2,
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -330},
                Scaling = {0.8, 0.8},
                Time = 0.2
              }
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_20_dialog_content",
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
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
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
            RefEntityID = 8
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [27] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.2
              },
              [2] = {ShowSpeakerName = 0.2, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          },
          [2] = {
            KeyFrames = {
              [1] = {
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
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 9
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
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_monv"
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
                Scaling = {0.85, 0.85},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {500, -200},
                  StartValue = {0, -200}
                }
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
                Layer = 8,
                Position = {-300, -330},
                Scaling = {0.8, 0.8},
                Time = 0.2
              }
            },
            RefEntityID = 13
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_monv"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_daiwei"
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
                LoopAnimation = "Story_calm",
                Position = {-600, 0},
                Time = 0
              }
            },
            RefEntityID = 10
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
            RefEntityID = 13
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_32_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
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
            RefEntityID = 10
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
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
            RefEntityID = 8
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiazhumen"
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
                Position = {-100, -330},
                Scaling = {0.8, 0.8},
                Time = 0
              }
            },
            RefEntityID = 14
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
            RefEntityID = 8
          },
          [4] = {
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
            RefEntityID = 10
          },
          [5] = {
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
            RefEntityID = 13
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_35_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_36_dialog_content",
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
                  Duration = 0.5,
                  Strength = {40, 0},
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 13
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
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fushide"
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
                Position = {750, -250},
                Scaling = {0.52, 0.52},
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {300, -200},
                  StartValue = {500, -200}
                }
              }
            },
            RefEntityID = 8
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shefu"
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
            RefEntityID = 15
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
            RefEntityID = 14
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_daiwei"
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
            RefEntityID = 14
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
                LoopAnimation = "Story_surprise",
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_monv"
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
                  Duration = 0.2,
                  EndValue = {-400, -330},
                  StartValue = {-300, -330}
                }
              }
            },
            RefEntityID = 13
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
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_daiwei"
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
            RefEntityID = 13
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
            RefEntityID = 10
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
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
            RefEntityID = 10
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
            RefEntityID = 8
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5084_50840802_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_victoria"
          }
        },
        [46] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Time = 2.5}
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
