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
      Name = "浮空甲板背景",
      Resource = "StoryBGfukongfeitingjiabanfei.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "涉",
      Resource = "she_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_Sheol",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "维吉尔",
      Resource = "weijier_n39_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "维吉尔切条",
      Resource = "weijier_n39_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_weijier",
      Type = "SpineSliceEdge"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "一叠手稿",
      Resource = "DTyidieshougao.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "反色特效",
      Resource = "uieff_Story_AntiDeColor.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "黑幕3",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "信纸背景",
      Resource = "tongyongxinzhi.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "信纸字迹",
      Resource = "xinzhiziji.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "信纸背景2",
      Resource = "tongyongxinzhi.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "字迹2",
      Resource = "xinzhiziji.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "信纸背景3",
      Resource = "tongyongxinzhi.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "字迹3",
      Resource = "xinzhiziji.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "手稿1分镜1",
      Resource = "shougaoA3.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "手稿1分镜1 2",
      Resource = "shougaoA3.prefab",
      Type = "Picture"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "手稿1分镜3",
      Resource = "shougaoA5.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "手稿1分镜3 2",
      Resource = "shougaoA5.prefab",
      Type = "Picture"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "速度线特效",
      Resource = "uieff_Story_SpeedLine.prefab",
      Type = "Effect"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "17",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "闪回",
      Resource = "10020",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "翻书",
      Resource = "10146",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "N39bgm",
      Resource = "102",
      Type = "Sound"
    }
  },
  ID = 50710501,
  Name = "event_story_N39yingzhen_5_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_Sheol"
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
                LoopAnimation = "Story_doubt",
                Position = {400, -500},
                Time = 1
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 7,
                Position = {-400, -250},
                Scaling = {0.65, 0.65},
                Time = 1
              }
            },
            RefEntityID = 5
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 23,
                Time = 0.8
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weijier"
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
            RefEntityID = 4
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
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 0.3
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
                Layer = 50,
                Time = 0
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
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 15,
                Time = 0.2
              }
            },
            RefEntityID = 8
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weijier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Position = {-500, 0},
                Scaling = {0.65, 0.65},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -250},
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weijier"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_6_dialog_content",
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
            RefEntityID = 7
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weijier"
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
            RefEntityID = 7
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_8_dialog_content",
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
            RefEntityID = 7
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
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
            RefEntityID = 7
          },
          [3] = {
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
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
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Decolor"
                  },
                  [2] = {
                    Duration = 0.2,
                    EndValue = 0,
                    StartValue = 0,
                    Var = "_AntiColor"
                  }
                },
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                FullScreen = true,
                Layer = 20,
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 21,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 12,
                Time = 0.5
              }
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                FullScreen = true,
                Layer = 17,
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 18,
                Time = 0.5
              }
            },
            RefEntityID = 15
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 16,
                Time = 0.5
              }
            },
            RefEntityID = 17
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                FullScreen = true,
                Layer = 15,
                Time = 0.5
              }
            },
            RefEntityID = 16
          },
          [12] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0.5
              }
            }
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 26,
                Time = 0
              }
            }
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Rotate = {
                  Duration = 0.5,
                  EndValue = 5,
                  StartValue = 0
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-150, 120},
                  StartValue = {0, 0}
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
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 35,
                Rotate = {
                  Duration = 0.5,
                  EndValue = 5,
                  StartValue = 0
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-150, 120},
                  StartValue = {0, 0}
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
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Rotate = {
                  Duration = 0.5,
                  EndValue = 5,
                  StartValue = 0
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-150, 120},
                  StartValue = {0, 0}
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
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Rotate = {
                  Duration = 0.5,
                  EndValue = 5,
                  StartValue = 0
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-150, 120},
                  StartValue = {0, 0}
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
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shougao"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
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
                Layer = 20,
                Position = {0, -200},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 18
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
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
                Layer = 25,
                Position = {0, 40},
                Scaling = {1.5, 1.5},
                Time = 0
              }
            },
            RefEntityID = 19
          },
          [3] = {
            KeyFrames = {
              [1] = {
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.5,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_Decolor"
                  },
                  [2] = {
                    Duration = 0.2,
                    EndValue = 0,
                    StartValue = 0,
                    Var = "_AntiColor"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kbaiyeweibing"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {700, 40},
                  StartValue = {0, 40}
                }
              }
            },
            RefEntityID = 19
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 18
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 40},
                  StartValue = {700, 40}
                }
              }
            },
            RefEntityID = 19
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
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
            RefEntityID = 19
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kbaiyeweibing"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Position = {700, 40},
                Time = 0
              }
            },
            RefEntityID = 19
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
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
            RefEntityID = 19
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kbaiyeweibing"
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kbaiyeweibing"
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kwenruoqingnian"
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kbairenchizhuchiren"
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
                Layer = 25,
                Scaling = {1.5, 1.5},
                Time = 0.5,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 20
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 9
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {5, 5},
                  Vibrato = 1
                },
                Time = 0.5
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kbairenchizhuchiren"
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kshizhongzhongren"
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
                Scale = {
                  Duration = 1.5,
                  EndValue = {1.01, 1.01},
                  StartValue = {1.05, 1.05}
                },
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 1, FadeOut = true},
                Time = 0
              }
            }
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kshizhongzhongren"
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kshizhongzhongren"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kbairenchiguanzhong"
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kshizhongzhongren"
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kshizhongzhongren"
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kshizhongzhongren"
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kshizhongzhongren"
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5071_50710501_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kkuiwuqingnian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Position = {500, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1.6, 1.6},
                  StartValue = {1.5, 1.5}
                },
                Scaling = {1.5, 1.5},
                Time = 0,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 20
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 26,
                Scaling = {1.35, 1.35},
                Time = 0
              }
            },
            RefEntityID = 22
          }
        },
        [57] = {
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
              [2] = {Active = true, Time = 2.5}
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
