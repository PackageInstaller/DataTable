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
      EntityID = 23,
      FitSize = true,
      Name = "野外场景",
      Resource = "StoryBGnorm2.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 24,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 25,
      FitSize = true,
      Name = "舰桥背景图",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 26,
      Name = "降落声",
      Resource = "10006",
      Type = "Sound"
    },
    [7] = {
      EntityID = 27,
      Name = "薇丝立绘",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 28,
      Name = "暗鬼立绘",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 29,
      Name = "暗鬼立绘2",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 30,
      Name = "暗鬼立绘3",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 31,
      Name = "薇丝切条",
      Resource = "weisi_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [12] = {
      EntityID = 32,
      Name = "对话Slice阴影-薇丝",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 33,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [14] = {
      EntityID = 34,
      FitSize = false,
      Name = "巴哈莫斯着陆",
      Resource = "10006",
      Type = "Sound"
    },
    [15] = {
      EntityID = 35,
      FitSize = false,
      Name = "暗鬼低吼",
      Resource = "10013",
      Type = "Sound"
    },
    [16] = {
      EntityID = 36,
      FitSize = false,
      Name = "风声",
      Resource = "10042",
      Type = "Sound"
    },
    [17] = {
      EntityID = 37,
      FitSize = false,
      Name = "爆炸",
      Resource = "10049",
      Type = "Sound"
    },
    [18] = {
      EntityID = 38,
      FitSize = false,
      Name = "爆炸2",
      Resource = "10001",
      Type = "Sound"
    }
  },
  ID = 10020201,
  Name = "main_story_2_2_1",
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
              [2] = {Active = true, Time = 0.5}
            },
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              },
              [2] = {
                Active = true,
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Scaling = {1.25, 1.25},
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 200},
                  StartValue = {0, -500}
                }
              }
            },
            RefEntityID = 23
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {60, 60},
                  Vibrato = 2
                },
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 90,
                Time = 0.5
              },
              [2] = {Active = true, Time = 2}
            },
            RefEntityID = 24
          },
          [5] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 26
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 33, Time = 1}
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 34
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 36
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 37
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 38
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_2_2_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.5,
                  StartValue = 0.5
                },
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 25
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
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0
              }
            }
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
                Layer = 21,
                LoopAnimation = "Story_itai",
                Position = {0, -800},
                Scaling = {0.7, 0.7},
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 40
                },
                Time = 0
              },
              [2] = {
                Active = true,
                LoopAnimation = "Story_surprise",
                Time = 1.6
              }
            },
            RefEntityID = 27
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_2_2_3_dialog_content",
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
            RefEntityID = 27
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_2_2_A1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.42, 0.42},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.3,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -400},
                  StartValue = {0, -800}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -750},
                  StartValue = {0, -800}
                }
              },
              [3] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -800},
                  StartValue = {0, -750}
                }
              }
            },
            RefEntityID = 27
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_2_2_A2_dialog_content",
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
            RefEntityID = 27
          }
        },
        [7] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 27
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
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 0.5
                },
                Layer = 35,
                Position = {400, -350},
                Scaling = {0.3, 0.3},
                Time = 0.3
              }
            },
            RefEntityID = 28
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Layer = 36,
                Position = {-400, -350},
                Scaling = {0.35, 0.35},
                Time = 0.8
              }
            },
            RefEntityID = 29
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
                Layer = 37,
                Position = {0, -250},
                Scaling = {0.4, 0.4},
                Time = 1.3
              }
            },
            RefEntityID = 30
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 35
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_2_2_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                LoopAnimation = "Story_shocked",
                Position = {-400, 0},
                Scaling = {0.7, 0.7},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {50, -900},
                Time = 0.5
              }
            },
            RefEntityID = 31
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 39,
                Position = {-400, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0.5
              }
            },
            RefEntityID = 32
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 30
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_2_2_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 31
          },
          [3] = {
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
        [10] = {
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
