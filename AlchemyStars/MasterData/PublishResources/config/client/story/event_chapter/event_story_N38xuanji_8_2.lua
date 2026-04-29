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
      Name = "黑场灰尘",
      Resource = "uieff_blacksmoke.prefab",
      Type = "Effect"
    },
    [3] = {
      EntityID = 3,
      FitSize = false,
      Name = "黑烟火星特效",
      Resource = "uieff_heiyanhuoxing.prefab",
      Type = "Effect"
    },
    [4] = {
      EntityID = 4,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "仲胥切条",
      Resource = "zhongxu_n26_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [6] = {
      EntityID = 6,
      FitSize = true,
      Name = "甲板背景",
      Resource = "StoryBGshifenghaojiabanye.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "璇极",
      Resource = "xuanjipingchang_n38_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "人群立绘",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "人群立绘2",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "厘青",
      Resource = "liqing_n26_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "缀户",
      Resource = "zhuihu_n38_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      Name = "利刃打击",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 13,
      Name = "火打击",
      Resource = "uieff_spine_huodaji.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "刀剑挥砍",
      Resource = "10192",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "火属性攻击",
      Resource = "10090",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "摩擦声",
      Resource = "10057",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "鼓BGM",
      Resource = "101",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "活下去打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    }
  },
  ID = 50700802,
  Name = "event_story_N38xuanji_8_2",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Scaling = {1.2, 1.2},
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
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
                Time = 1.1
              }
            },
            RefEntityID = 4
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 14,
                Time = 0.6
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_2_dialog_content",
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
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_3_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 8,
                Position = {0, -500},
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_4_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_5_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
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
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Scaling = {-400, 1},
                Time = 0
              }
            },
            RefEntityID = 12
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
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 15
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zhongxu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                LoopAnimation = "Story_angry",
                Scaling = {0.85, 0.85},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {40, -350},
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
                StartBgm = 19,
                Time = 0
              }
            }
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_7_dialog_content",
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
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {20, 50},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zhongxu"
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
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_9_dialog_content",
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
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_10_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zhongxu"
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
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xuanji"
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
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 5
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
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                LoopAnimation = "Story_suprise",
                Position = {0, -260},
                Scaling = {1.12, 1.12},
                Time = 0.5
              }
            },
            RefEntityID = 7
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liqing"
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
                Layer = 9,
                Position = {400, -200},
                Scaling = {0.7, 0.7},
                Time = 0
              }
            },
            RefEntityID = 8
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
                Layer = 9,
                Position = {-400, -200},
                Scaling = {0.7, 0.7},
                Time = 0
              }
            },
            RefEntityID = 9
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
                Layer = 5,
                Scaling = {0.78, 0.78},
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -300},
                  StartValue = {0, -350}
                }
              },
              [2] = {
                Active = true,
                Layer = 8,
                Scaling = {0.78, 0.78},
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -350},
                  StartValue = {0, -300}
                }
              },
              [3] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -300},
                  StartValue = {0, -350}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -350},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 10
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 100},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 17
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5070_50700802_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liqing"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 0,
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {600, -200},
                  StartValue = {400, -200}
                }
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-600, -200},
                  StartValue = {-400, -200}
                }
              }
            },
            RefEntityID = 9
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.75,
                  StartValue = 0.7
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 50},
                  StartValue = {0, 100}
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [15] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 4
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
