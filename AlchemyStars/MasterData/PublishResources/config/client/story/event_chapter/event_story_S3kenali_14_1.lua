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
      Name = "海底街道背景",
      Resource = "StoryBGjiedaohaidi.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 13,
      FitSize = true,
      Name = "观景台背景2",
      Resource = "StoryBGyingzhenguanjingtai.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 14,
      FitSize = false,
      Name = "克娜莉空手",
      Resource = "kenalinvwang2_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 15,
      FitSize = false,
      Name = "白海豚",
      Resource = "kongyihaitun_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 16,
      FitSize = false,
      Name = "黑幕1",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 17,
      Name = "黑幕2",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 18,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 19,
      Name = "闪白2号",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 20,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 21,
      FitSize = false,
      Name = "弄臣1",
      Resource = "yurennongchen_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 22,
      FitSize = false,
      Name = "叹号",
      Resource = "uieff_tanhao.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 23,
      FitSize = false,
      Name = "乐谱特效",
      Resource = "uieff_Story_music.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 24,
      FitSize = false,
      Name = "光晕",
      Resource = "uieff_Story_colossus06.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 25,
      FitSize = false,
      Name = "克娜莉CG",
      Resource = "CGxinzhongdexuanlv.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 26,
      FitSize = false,
      Name = "弄臣切条",
      Resource = "yurennongchen_S3_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [18] = {
      EntityID = 27,
      FitSize = false,
      Name = "水形之主",
      Resource = "shuixingzhizhu_S3_spine_idle.prefab",
      Type = "Spine"
    },
    [19] = {
      EntityID = 28,
      FitSize = true,
      Name = "恐怖背景",
      Resource = "StoryBGtongyongkongbu.prefab",
      Type = "Picture"
    },
    [20] = {
      EntityID = 29,
      FitSize = false,
      Name = "黑幕特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [21] = {
      EntityID = 31,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [22] = {
      EntityID = 32,
      FitSize = false,
      Name = "叹号",
      Resource = "1714",
      Type = "Sound"
    },
    [23] = {
      EntityID = 33,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [24] = {
      EntityID = 34,
      FitSize = false,
      Name = "闪回音效",
      Resource = "10020",
      Type = "Sound"
    },
    [25] = {
      EntityID = 35,
      FitSize = false,
      Name = "缅怀",
      Resource = "29",
      Type = "Sound"
    },
    [26] = {
      EntityID = 36,
      FitSize = false,
      Name = "闪烁音效",
      Resource = "10037",
      Type = "Sound"
    },
    [27] = {
      EntityID = 37,
      FitSize = false,
      Name = "克娜莉BGM",
      Resource = "51",
      Type = "Sound"
    }
  },
  ID = 50661401,
  Name = "event_story_S3kenali_14_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.9
              },
              [2] = {ShowContent = 0.02, Time = 2.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
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
                StartBgm = 31,
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
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Position = {0, -380},
                Scaling = {0.85, 0.85},
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_2_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -380},
                  StartValue = {0, -380}
                }
              }
            },
            RefEntityID = 14
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
                Brightness = 0.2,
                Layer = 8,
                Position = {400, -200},
                Scaling = {0.5, 0.5},
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baihaitun"
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
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baihaitun"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_5_dialog_content",
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
            RefEntityID = 15
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baihaitun"
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
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.9
              },
              [2] = {ShowContent = 0.02, Time = 2.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
                  Duration = 0.5,
                  EndValue = {600, -200},
                  StartValue = {400, -200}
                }
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
                  EndValue = {-600, -380},
                  StartValue = {-400, -380}
                }
              }
            },
            RefEntityID = 14
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
                Layer = 7,
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -1750},
                  StartValue = {0, -1800}
                }
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 6,
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 1750},
                  StartValue = {0, 1800}
                }
              }
            },
            RefEntityID = 17
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0.3
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.9
              }
            },
            RefEntityID = 18
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.8
              }
            },
            RefEntityID = 19
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Time = 0.8
              }
            },
            RefEntityID = 20
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0,
                Layer = 3,
                Position = {0, -500},
                Time = 0.8
              }
            },
            RefEntityID = 21
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_8_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, 100},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 9,
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
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {Layer = 9, Time = 0}
            },
            RefEntityID = 15
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 4
              },
              [2] = {ShowContent = 0.02, Time = 4.2}
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
                Time = 4
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 0},
                  StartValue = {-200, 100}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 7,
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, -1400},
                  StartValue = {0, -1750}
                }
              },
              [2] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.2
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 6,
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 1400},
                  StartValue = {0, 1750}
                }
              },
              [2] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.2
              }
            },
            RefEntityID = 17
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
                Time = 2
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.3
              }
            },
            RefEntityID = 2
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 2.2}
            },
            RefEntityID = 19
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 2.2}
            },
            RefEntityID = 20
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 2.2},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Scaling = {0.7, 0.7},
                Time = 3.3,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -200},
                  StartValue = {600, -200}
                }
              },
              [3] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 4
              }
            },
            RefEntityID = 21
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3
              }
            },
            RefEntityID = 15
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_11_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -380},
                  StartValue = {-600, -380}
                }
              }
            },
            RefEntityID = 14
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
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
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Time = 0}
            }
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_16_dialog_content",
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
            RefEntityID = 21
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_17_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_18_dialog_content",
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
                Active = true,
                Layer = 18,
                Position = {-350, 320},
                Time = 0
              }
            },
            RefEntityID = 22
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
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_19_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [3] = {
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
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
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
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_23_dialog_content",
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
            RefEntityID = 21
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
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
                Time = 0
              }
            },
            RefEntityID = 21
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_25_dialog_content",
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
            RefEntityID = 21
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
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
                Time = 0
              }
            },
            RefEntityID = 21
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_28_dialog_content",
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
            RefEntityID = 21
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_29_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -371},
                  StartValue = {-400, -380}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -380},
                  StartValue = {-400, -371}
                }
              }
            },
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 33
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
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
                Time = 0
              }
            },
            RefEntityID = 21
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_31_dialog_content",
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
            RefEntityID = 21
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_32_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -380},
                  StartValue = {-400, -380}
                }
              }
            },
            RefEntityID = 14
          },
          [3] = {
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
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_33_dialog_content",
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
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_clarin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Shake = {
                  Duration = 1,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.3
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
                Layer = 50,
                Time = 0.3
              }
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 34
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_35_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 2.4}
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
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {0, -100},
                Scale = {
                  Duration = 2.5,
                  EndValue = {0.41, 0.41},
                  StartValue = {0.4, 0.4}
                },
                Time = 0
              }
            },
            RefEntityID = 25
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 35,
                Time = 0
              }
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_36_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Scaling = {0.7, 0.7},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Shake = {
                  Duration = 0.5,
                  Strength = {0, 0},
                  Vibrato = 10,
                  fadeOut = true
                },
                SpineOffset = {-50, -200},
                Time = 0
              }
            },
            RefEntityID = 26
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
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
                Time = 0.5
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
                Time = 0.5
              }
            },
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0.5
              }
            },
            RefEntityID = 26
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 46,
                Time = 0.5
              }
            },
            RefEntityID = 23
          },
          [6] = {
            KeyFrames = {
              [1] = {
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Scaling = {0.6, 0.6},
                Time = 0.5,
                Translate = {
                  Duration = 1.5,
                  EndValue = {-50, -380},
                  StartValue = {-50, -400}
                }
              }
            },
            RefEntityID = 25
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_39_dialog_content",
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
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_40_dialog_content",
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
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_41_dialog_content",
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
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_42_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.5}
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
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {0, -200},
                Scale = {
                  Duration = 2.5,
                  EndValue = {0.44, 0.44},
                  StartValue = {0.45, 0.45}
                },
                Time = 0.5
              }
            },
            RefEntityID = 25
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 36
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_43_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1.1}
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
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 34
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_44_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_45_dialog_content",
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
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 18
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 25
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 14
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Time = 0
              }
            },
            RefEntityID = 28
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
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
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Position = {-400, -380},
                Time = 1
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {400, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 27
          },
          [5] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_47_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_48_dialog_content",
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
            RefEntityID = 27
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_49_dialog_content",
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
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_50_dialog_content",
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
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_51_dialog_content",
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
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_52_dialog_content",
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
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_53_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_57_dialog_content",
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
            RefEntityID = 27
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, 0},
                  StartValue = {50, 0}
                }
              }
            }
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_58_dialog_content",
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
                LoopAnimation = "Story_sad",
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_59_dialog_content",
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
            RefEntityID = 27
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_60_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_65_dialog_content",
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
            RefEntityID = 27
          }
        },
        [66] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_66_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [67] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_67_dialog_content",
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
            RefEntityID = 27
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_68_dialog_content",
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
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_69_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_74_dialog_content",
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
                Shake = {
                  Duration = 0.5,
                  Strength = {20, 20},
                  Vibrato = 40,
                  fadeOut = true
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0.2
              }
            }
          }
        },
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_75_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [76] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_76_dialog_content",
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
            RefEntityID = 27
          }
        },
        [77] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_77_dialog_content",
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
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [78] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_78_dialog_content",
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
            RefEntityID = 27
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 37,
                Time = 0
              }
            }
          }
        },
        [79] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_79_dialog_content",
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
        [80] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_80_dialog_content",
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
        [81] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_81_dialog_content",
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [82] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shuixingzhizhu"
          }
        },
        [83] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_83_dialog_content",
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
            RefEntityID = 27
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [84] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_84_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          },
          [3] = {
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
            RefEntityID = 27
          },
          [4] = {
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
            RefEntityID = 28
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
                Layer = 7,
                Time = 0
              }
            },
            RefEntityID = 21
          }
        },
        [85] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_85_dialog_content",
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
        [86] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
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
                Time = 0
              }
            },
            RefEntityID = 21
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
            RefEntityID = 27
          }
        },
        [87] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {50, 0},
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
        [88] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [89] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
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
              [1] = {
                Position = {0, -200},
                Time = 0.2
              }
            },
            RefEntityID = 21
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0.2
              }
            },
            RefEntityID = 29
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.2
              }
            }
          }
        },
        [90] = {
          [1] = {
            DialogContentStr = "ui_story_5066_50661401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nongchen"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.6,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 100},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [91] = {
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
