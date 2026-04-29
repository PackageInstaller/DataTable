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
      FitSize = true,
      Name = "驿站清扫后背景图",
      Resource = "StoryBGyizhanqingsaohou.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "纳努塞尔立绘",
      Resource = "nanusaier_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "塔塔立绘",
      Resource = "tataputong_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      Name = "多孚立绘",
      Resource = "1300521_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "塔塔切条",
      Resource = "tataputong_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [8] = {
      EntityID = 8,
      Name = "对话Slice阴影",
      Resource = "StorySliceEdge.prefab",
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
      Name = "受击效果1",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      Name = "受击效果2",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      Name = "受击效果3",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "衣服摩擦的声音",
      Resource = "10057",
      Type = "Sound"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "水打击新音效",
      Resource = "10093",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "受击音效",
      Resource = "10073",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "传送带",
      Resource = "10151",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 50081201,
  Name = "event_story_N6wanshengjiewanfa_12_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_norm",
                Position = {-450, -320},
                Scaling = {1.05, 1.05},
                Time = 1.1
              }
            },
            RefEntityID = 4
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
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 13, Time = 0.5}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
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
                Position = {400, -100},
                Scaling = {0.4, 0.4},
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
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
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
            RefEntityID = 4
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
                Position = {-500, -180},
                Scaling = {0.75, 0.75},
                Time = 0
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -180},
                  StartValue = {-500, -180}
                }
              },
              [3] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -180},
                  StartValue = {-400, -180}
                }
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
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-500, -130},
                  StartValue = {-500, -180}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -180},
                  StartValue = {-500, -130}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
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
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.9
              },
              [2] = {ShowContent = 0.02, Time = 2.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-500, -80},
                  StartValue = {-500, -180}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-500, -130},
                  StartValue = {-500, -80}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 1,
                  EndValue = {-700, 0},
                  StartValue = {-500, -130}
                }
              },
              [4] = {
                Time = 1.6,
                Translate = {
                  Duration = 2,
                  EndValue = {-1000, 0},
                  StartValue = {-700, 0}
                }
              },
              [5] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3
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
                Time = 1.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -50},
                  StartValue = {400, -100}
                }
              },
              [2] = {
                Time = 1.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -100},
                  StartValue = {400, -50}
                }
              },
              [3] = {
                Time = 1.9,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -100},
                  StartValue = {400, -100}
                }
              }
            },
            RefEntityID = 6
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {15, 15},
                  Vibrato = 15
                },
                Time = 0.2
              },
              [2] = {
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
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 17
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_happy",
                Position = {-450, 0},
                Scaling = {0.75, 0.75},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -180},
                Time = 0
              }
            },
            RefEntityID = 7
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
                Position = {-450, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0.5, FadeOut = true},
                Time = 0
              }
            }
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
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
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -100},
                  StartValue = {200, -100}
                }
              }
            },
            RefEntityID = 6
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
            RefEntityID = 7
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
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.4
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.6
                },
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {100, 0},
                Time = 0.5
              },
              [2] = {Active = false, Time = 1}
            },
            RefEntityID = 10
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {15, 15},
                  Vibrato = 15
                },
                Time = 0.5
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 15
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 16
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.6
                },
                Time = 0.1
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Time = 0.7
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.6
                },
                Time = 0.8
              },
              [5] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Time = 1.1
              },
              [6] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.6
                },
                Time = 1.2
              },
              [7] = {Active = false, Time = 1.8}
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {400, 0},
                Time = 0.1
              },
              [2] = {Active = false, Time = 0.7}
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {0, 0},
                Time = 0.7
              },
              [2] = {Active = false, Time = 1.3}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-400, 0},
                Time = 1.2
              },
              [2] = {Active = false, Time = 1.8}
            },
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -100},
                  StartValue = {400, -100}
                }
              },
              [2] = {
                Time = 0.9,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -100},
                  StartValue = {0, -100}
                }
              },
              [3] = {
                Time = 1.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -100},
                  StartValue = {-400, -100}
                }
              }
            },
            RefEntityID = 6
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {15, 15},
                  Vibrato = 15
                },
                Time = 0.1
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {15, 15},
                  Vibrato = 15
                },
                Time = 0.8
              },
              [3] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {15, 15},
                  Vibrato = 15
                },
                Time = 1.2
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 15
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 16
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_norm",
                Position = {-450, 0},
                Scaling = {0.75, 0.75},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -180},
                Time = 0
              }
            },
            RefEntityID = 7
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
                Position = {-450, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
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
                  EndValue = {400, -100},
                  StartValue = {200, -100}
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
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
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
                LoopAnimation = "Story_confused",
                SpineOffset = {0, -180},
                Time = 0
              }
            },
            RefEntityID = 7
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
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
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
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.3,
                Translate = {
                  Duration = 0.4,
                  EndValue = {1500, 400},
                  StartValue = {-1500, 400}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-1500, 400},
                  StartValue = {1500, 400}
                }
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.4
              }
            },
            RefEntityID = 5
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.4,
                  fadeOut = false,
                  Strength = {15, 15},
                  Vibrato = 15
                },
                Time = 0.3
              },
              [2] = {
                Shake = {
                  Duration = 0.4,
                  fadeOut = false,
                  Strength = {15, 15},
                  Vibrato = 15
                },
                Time = 1.2
              },
              [3] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, 0},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -50},
                  StartValue = {400, -100}
                }
              },
              [2] = {
                Time = 2.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -100},
                  StartValue = {400, -50}
                }
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3},
              [2] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 18
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-500, -180},
                  StartValue = {-600, -180}
                }
              }
            },
            RefEntityID = 5
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 0},
                  StartValue = {100, 0}
                }
              }
            }
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
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
            RefEntityID = 5
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
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
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tata"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
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
            RefEntityID = 5
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
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
                Brightness = 1,
                Layer = 8,
                Position = {0, -320},
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -180},
                  StartValue = {-500, -180}
                }
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -100},
                  StartValue = {400, -100}
                }
              }
            },
            RefEntityID = 6
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5008_50081201_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [32] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
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
