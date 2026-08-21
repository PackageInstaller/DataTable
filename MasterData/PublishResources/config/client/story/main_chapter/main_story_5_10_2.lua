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
      EntityID = 78,
      FitSize = true,
      Name = "风船背景图",
      Resource = "StoryBGmendeersong2.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 79,
      Name = "舒摩尔立绘",
      Resource = "shumoer_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 104,
      Name = "攻击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [6] = {
      EntityID = 105,
      Name = "贡露立绘",
      Resource = "gonglu_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 106,
      Name = "舒摩尔切条",
      Resource = "shumoer_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [8] = {
      EntityID = 107,
      Name = "对话Slice阴影-舒摩尔",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 108,
      Name = "暗鬼打击",
      Resource = "uieff_spine_anyingqiu.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 109,
      Name = "击打音效",
      Resource = "10073",
      Type = "Sound"
    },
    [11] = {
      EntityID = 110,
      Name = "崩塌音效",
      Resource = "10024",
      Type = "Sound"
    },
    [12] = {
      EntityID = 111,
      Name = "暗能攻击音效",
      Resource = "10066",
      Type = "Sound"
    },
    [13] = {
      EntityID = 112,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [14] = {
      EntityID = 113,
      FitSize = true,
      Name = "背景图2",
      Resource = "StoryBGmendeersong2.prefab",
      Type = "Picture"
    },
    [15] = {
      Effect = "",
      EntityID = 114,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 115,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [17] = {
      EntityID = 116,
      Name = "利刃打击",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 117,
      FitSize = false,
      Name = "物理攻击",
      Resource = "10004",
      Type = "Sound"
    },
    [19] = {
      EntityID = 118,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [20] = {
      EntityID = 119,
      FitSize = false,
      Name = "利刃新音效",
      Resource = "10094",
      Type = "Sound"
    }
  },
  ID = 10051002,
  Name = "main_story_5_10_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
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
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.5,
                  StartValue = 0.5
                },
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 78
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
                Layer = 40,
                Position = {-100, -400},
                Scaling = {0.55, 0.55},
                Time = 1.5
              }
            },
            RefEntityID = 79
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 112, Time = 0.9},
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
            DialogContentStr = "ui_story_5_10_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
            RefEntityID = 79
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                Time = 0
              }
            },
            RefEntityID = 104
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 80},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_sullen",
                Time = 1
              }
            },
            RefEntityID = 79
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 109
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 110
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
                Time = 0
              }
            },
            RefEntityID = 79
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 45,
                LoopAnimation = "Story_surprise",
                Position = {0, -350},
                Scaling = {0.9, 0.9},
                Time = 0.5
              }
            },
            RefEntityID = 105
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_22_dialog_content",
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
                Active = true,
                Layer = 60,
                Position = {450, 0},
                Scaling = {0.6, 0.6},
                Scroll = {
                  Duration = 0.3,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {-100, -500},
                Time = 0
              }
            },
            RefEntityID = 106
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 59,
                Position = {450, 0},
                Scale = {
                  Duration = 0.3,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 107
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 105
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
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
            RefEntityID = 106
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 107
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 105
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 70,
                Time = 0
              }
            },
            RefEntityID = 108
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_pain",
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 80},
                  Vibrato = 40
                },
                Time = 0
              },
              [2] = {
                LoopAnimation = "Story_faint",
                Time = 1
              }
            },
            RefEntityID = 105
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 111
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
                Time = 0
              }
            },
            RefEntityID = 105
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                LoopAnimation = "Story_proud",
                Time = 0.5
              }
            },
            RefEntityID = 79
          }
        },
        [9] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 99,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.8
              }
            },
            RefEntityID = 79
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 78
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_A3_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_norm",
                Position = {-300, -200},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 115
          },
          [3] = {
            KeyFrames = {
              [1] = {Layer = 1, Time = 0}
            },
            RefEntityID = 78
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 118, Time = 0}
            }
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_A4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
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
                Layer = 9,
                LoopAnimation = "Story_norm",
                Position = {400, -400},
                Scaling = {0.42, 0.42},
                Time = 1.2
              }
            },
            RefEntityID = 114
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 80
                },
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1.2
              }
            },
            RefEntityID = 115
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 117
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 119
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_A5_dialog_content",
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 7,
                Time = 0
              }
            },
            RefEntityID = 114
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_sigh",
                Time = 0
              }
            },
            RefEntityID = 115
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5_10_A6_dialog_content",
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
            RefEntityID = 115
          }
        },
        [14] = {
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
