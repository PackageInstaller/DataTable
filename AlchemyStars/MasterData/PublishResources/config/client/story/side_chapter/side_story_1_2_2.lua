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
      EntityID = 6,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 29,
      FitSize = true,
      Name = "废土郊外背景图-新",
      Resource = "StoryBGnorm2.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 41,
      Name = "涡轮立绘",
      Resource = "heichao_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 43,
      Name = "米迦勒立绘",
      Resource = "1600271_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 44,
      Name = "红油帮众slice",
      Resource = "hongyoushibing_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [8] = {
      EntityID = 45,
      Name = "对话Slice阴影",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 46,
      Name = "拉斐尔立绘",
      Resource = "1600281_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 47,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 48,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [12] = {
      EntityID = 49,
      Name = "电流 音效",
      Resource = "10039",
      Type = "Sound"
    },
    [13] = {
      EntityID = 50,
      Name = "爆炸 音效",
      Resource = "10071",
      Type = "Sound"
    },
    [14] = {
      EntityID = 51,
      Name = "撞击音效",
      Resource = "10045",
      Type = "Sound"
    },
    [15] = {
      EntityID = 52,
      Name = "撞击音效2",
      Resource = "10044",
      Type = "Sound"
    },
    [16] = {
      EntityID = 53,
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 54,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    }
  },
  ID = 20010202,
  Name = "side_story_1_2_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "第二关战前第一段",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.2
              },
              [2] = {ShowContent = 0.02, Time = 2.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
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
                Time = 0.5
              },
              [2] = {
                Active = true,
                Layer = 50,
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                LoopAnimation = "Story_happy",
                Position = {-450, -300},
                Scaling = {0.7, 0.7},
                Time = 1.2
              }
            },
            RefEntityID = 41
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 29
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 9,
                Position = {400, -200},
                Scaling = {1.2, 1.2},
                Time = 1.2
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 2.2
              }
            },
            RefEntityID = 43
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 48, Time = 1.2},
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_18_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_19_dialog_content",
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
            RefEntityID = 43
          },
          [3] = {
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
            RefEntityID = 41
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 49
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hongyoubangzhong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Position = {0, 0},
                Scaling = {0.4, 0.4},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -300},
                Time = 0
              }
            },
            RefEntityID = 44
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
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 45
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
            RefEntityID = 43
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
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
            RefEntityID = 44
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
            RefEntityID = 45
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 41
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_22_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                LoopAnimation = "Story_surprise",
                Time = 0.3
              }
            },
            RefEntityID = 41
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 43
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
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.2
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.4
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              },
              [5] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              },
              [6] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              },
              [7] = {Active = false, Time = 2}
            },
            RefEntityID = 6
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1.5,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.5
              },
              [2] = {
                Position = {200, 0},
                Time = 0.1
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position = {0, 120},
                Scaling = {1.2, 1.2},
                Time = 0.1
              }
            },
            RefEntityID = 29
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 50
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_23_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1
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
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 8,
                Position = {600, -200},
                Time = 0
              }
            },
            RefEntityID = 43
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
                Layer = 9,
                LoopAnimation = "Story_surprise",
                Position = {-200, -250},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 46
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_24_dialog_content",
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
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -200},
                  StartValue = {-200, -250}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -250},
                  StartValue = {-200, -200}
                }
              }
            },
            RefEntityID = 46
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
            RefEntityID = 43
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_25_dialog_content",
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiale"
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
            RefEntityID = 46
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 9,
                Time = 0
              }
            },
            RefEntityID = 43
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                Position = {-1000, -300},
                Time = 0
              }
            },
            RefEntityID = 41
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-600, 0},
                  StartValue = {200, 0}
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
            RefEntityID = 43
          },
          [5] = {
            KeyFrames = {
              [1] = {Layer = 9, Time = 0}
            },
            RefEntityID = 46
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-300, 228.6},
                  StartValue = {0, 228.6}
                }
              }
            },
            RefEntityID = 29
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_27_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 41
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_28_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_29_dialog_content",
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
            RefEntityID = 46
          },
          [3] = {
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
            RefEntityID = 41
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.4
              },
              [2] = {ShowContent = 0.04, Time = 1.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 46
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
                Layer = 9,
                LoopAnimation = "Story_norm",
                Position = {-200, -200},
                Scaling = {0.55, 0.55},
                Time = 0.2
              }
            },
            RefEntityID = 47
          },
          [4] = {
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
          },
          [5] = {
            KeyFrames = {
              [1] = {Layer = 8, Time = 1.4}
            },
            RefEntityID = 41
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_31_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_32_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 41
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
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.7
              }
            },
            RefEntityID = 47
          },
          [4] = {
            KeyFrames = {
              [1] = {
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
                Layer = 11,
                Time = 1.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -200},
                  StartValue = {100, -200}
                }
              }
            },
            RefEntityID = 43
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1.5,
                  Strength = {80, 80},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 1.9
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1.8
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 2
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.9
              },
              [4] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.1
              },
              [5] = {Active = false, Time = 3.1}
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 49,
                Time = 2.1
              }
            },
            RefEntityID = 2
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 51
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.1}
            },
            RefEntityID = 52
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 41
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiale"
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
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Time = 0.5
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.8
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
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
                Position = {-300, 200},
                Scaling = 0.5,
                Time = 0
              },
              [2] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {20, 20},
                  Vibrato = 2
                },
                Time = 0.1
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.5,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 29
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 1.5,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 53
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 17,
                Time = 0
              }
            },
            RefEntityID = 54
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_37_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 43
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_2001_2_38_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Time = 0.8
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 1.2
              },
              [4] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.9
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
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Position = {-200, -200},
                Time = 0
              }
            },
            RefEntityID = 47
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 1.5,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Layer = 18,
                Time = 0
              },
              [2] = {
                Blink = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 0.6
                },
                Time = 2
              }
            },
            RefEntityID = 53
          }
        },
        [24] = {
          [1] = {
            KeyFrames = {
              [1] = {Layer = 51, Time = 1}
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
