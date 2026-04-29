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
      FitSize = false,
      Name = "诺维亚立绘替代",
      Resource = "nuoweiya_n9_spine_idle.prefab",
      Type = "Spine"
    },
    [3] = {
      EntityID = 3,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "灯塔（暗）",
      Resource = "StoryBGdengtayean.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "小伯利恒替代立绘",
      Resource = "xiaoboliheng_n9_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "暗鬼大兵",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "下雪特效",
      Resource = "uieff_cg_snow.prefab",
      Type = "Effect"
    },
    [9] = {
      EntityID = 9,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "暗鬼大兵2",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "暗鬼大兵3",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 13,
      Name = "攻击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 15,
      Name = "水打击特效",
      Resource = "uieff_spine_huodaji.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "水打击特效2",
      Resource = "uieff_spine_huodaji.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "水打击特效3",
      Resource = "uieff_spine_huodaji.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "暗鬼大兵4",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "暗鬼大兵5",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "粒子光点特效",
      Resource = "uieff_beijinggainian.prefab",
      Type = "Effect"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "伯利恒立绘",
      Resource = "1600771_spine_idle.prefab",
      Type = "Spine"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "灰尘特效",
      Resource = "uieff_blacksmoke.prefab",
      Type = "Effect"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "缅怀BGM",
      Resource = "29",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "暗鬼叫声",
      Resource = "10069",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "攻击音效",
      Resource = "10073",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "暗鬼叫声2",
      Resource = "10028",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "火属性音效",
      Resource = "10090",
      Type = "Sound"
    },
    [29] = {
      EntityID = 29,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    }
  },
  ID = 150121301,
  Name = "event_story_N9shaloudenvwang_re_13_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
                LoopAnimation = "Story_surprise",
                Position = {-400, -269},
                Scaling = {1.01, 1.01},
                Time = 0.4
              }
            },
            RefEntityID = 2
          },
          [3] = {
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.6,
                Layer = 1,
                Time = 0.4
              }
            },
            RefEntityID = 4
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
                Brightness = 0.2,
                Layer = 7,
                Position = {400, -200},
                Scaling = {0.55, 0.55},
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [7] = {
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
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shaya"
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
                LoopAnimation = "Story_sad",
                Time = 0
              }
            },
            RefEntityID = 5
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
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_4_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shaya"
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
            RefEntityID = 2
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shaya"
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
            RefEntityID = 2
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_8_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shaya"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_10_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shaya"
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
            RefEntityID = 2
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
            RefEntityID = 2
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_13_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
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
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 3
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
                Position = {0, -250},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.4, 0.4},
                  StartValue = {0.35, 0.35}
                },
                Time = 0.8
              }
            },
            RefEntityID = 7
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
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 2
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.6,
                Layer = 7,
                Position = {600, -250},
                Scale = {
                  Duration = 0.4,
                  EndValue = {0.35, 0.35},
                  StartValue = {0.3, 0.3}
                },
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.6,
                Layer = 7,
                Position = {-600, -250},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.35, 0.35},
                  StartValue = {0.3, 0.3}
                },
                Time = 0.7
              }
            },
            RefEntityID = 11
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [11] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 25
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_15_dialog_content",
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
                Active = true,
                Brightness = 1,
                Time = 0.2
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Position = {0, -269},
                Time = 0.2
              },
              [2] = {
                Active = true,
                Time = 0.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -269},
                  StartValue = {0, -269}
                }
              }
            },
            RefEntityID = 2
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 31,
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 10
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 11
          },
          [9] = {
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 8,
                Time = 0.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {800, -250},
                  StartValue = {1000, -250}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.4,
                  EndValue = 0,
                  StartValue = 1
                },
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 1.1
              },
              [3] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 31,
                Position = {400, 0},
                Time = 1
              },
              [2] = {Active = false, Time = 1.3}
            },
            RefEntityID = 13
          },
          [11] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 24,
                Time = 0
              }
            }
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 26
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_16_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -250},
                  StartValue = {-800, -250}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.8
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -269},
                  StartValue = {200, -269}
                }
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {-400, 0},
                Time = 0.5
              },
              [2] = {Active = false, Time = 0.8}
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 26
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_17_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, -269},
                  StartValue = {-200, -269}
                }
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_18_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 35,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 1,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Width"
                  },
                  [2] = {
                    Duration = 1,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Rotation"
                  },
                  [3] = {
                    Duration = 1,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  },
                  [4] = {
                    Duration = 1,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Decolor"
                  },
                  [5] = {
                    Duration = 1,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_AntiColor"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 20,
                  Strength = {40, 40},
                  Vibrato = 1
                },
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_Width"
                  },
                  [2] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_Rotation"
                  },
                  [3] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "AlphaValue"
                  },
                  [4] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_Decolor"
                  },
                  [5] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_AntiColor"
                  }
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
            RefEntityID = 3
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.2
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
                Brightness = 1,
                Layer = 8,
                Position = {0, -250},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.4, 0.4},
                  StartValue = {0.35, 0.35}
                },
                Time = 0.8
              }
            },
            RefEntityID = 7
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
                Brightness = 0.6,
                Position = {600, -250},
                Scale = {
                  Duration = 0.4,
                  EndValue = {0.35, 0.35},
                  StartValue = {0.3, 0.3}
                },
                Time = 0.5
              }
            },
            RefEntityID = 10
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
                Brightness = 0.6,
                Position = {-600, -250},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.35, 0.35},
                  StartValue = {0.3, 0.3}
                },
                Time = 0.7
              }
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 2
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 27
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 32,
                Position = {600, 0},
                Time = 0
              },
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 33,
                Position = {-600, 0},
                Time = 0.2
              },
              [2] = {Active = false, Time = 0.7}
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 34,
                Position = {0, 100},
                Time = 0.4
              },
              [2] = {Active = false, Time = 0.9}
            },
            RefEntityID = 17
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.4
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
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
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [8] = {
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
                LoopAnimation = "Story_warn",
                Time = 0.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -269},
                  StartValue = {400, -269}
                }
              }
            },
            RefEntityID = 2
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2},
              [3] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 28
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_21_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1.06, 1.06},
                  StartValue = {1.01, 1.01}
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_22_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_23_dialog_content",
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
            RefEntityID = 2
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_24_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_25_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_27_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_28_dialog_content",
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
            RefEntityID = 2
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_29_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_30_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_31_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_33_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 1,
                  EndValue = {1.01, 1.01},
                  StartValue = {1.06, 1.06}
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_34_dialog_content",
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
            RefEntityID = 2
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_35_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_36_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [37] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_Width"
                  },
                  [2] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_Rotation"
                  },
                  [3] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "AlphaValue"
                  },
                  [4] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_Decolor"
                  },
                  [5] = {
                    Duration = 1,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "_AntiColor"
                  }
                },
                Time = 0.3
              }
            },
            RefEntityID = 14
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 8,
                Scale = {
                  Duration = 1.2,
                  EndValue = {0.4, 0.4},
                  StartValue = {0.35, 0.35}
                },
                Time = 0.2,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -220},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -250},
                  StartValue = {0, -220}
                }
              },
              [3] = {
                Active = true,
                Time = 0.8,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -220},
                  StartValue = {0, -250}
                }
              },
              [4] = {
                Active = true,
                Time = 1.1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -250},
                  StartValue = {0, -220}
                }
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.6,
                Position = {-600, -250},
                Scaling = {0.3, 0.3},
                Time = 0.2
              },
              [2] = {
                Active = true,
                Scale = {
                  Duration = 1.2,
                  EndValue = {0.35, 0.35},
                  StartValue = {0.3, 0.3}
                },
                Time = 0.7,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-600, -220},
                  StartValue = {-600, -250}
                }
              },
              [3] = {
                Active = true,
                Time = 1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-600, -250},
                  StartValue = {-600, -220}
                }
              },
              [4] = {
                Active = true,
                Time = 1.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-600, -220},
                  StartValue = {-600, -250}
                }
              },
              [5] = {
                Active = true,
                Time = 1.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -250},
                  StartValue = {-600, -220}
                }
              }
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Position = {600, -250},
                Scaling = {0.3, 0.3},
                Time = 0.2
              },
              [2] = {
                Active = true,
                Scale = {
                  Duration = 1.2,
                  EndValue = {0.35, 0.35},
                  StartValue = {0.3, 0.3}
                },
                Time = 0.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {600, -220},
                  StartValue = {600, -250}
                }
              },
              [3] = {
                Active = true,
                Time = 1.2,
                Translate = {
                  Duration = 0.3,
                  EndValue = {600, -250},
                  StartValue = {600, -220}
                }
              },
              [4] = {
                Active = true,
                Time = 1.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {600, -220},
                  StartValue = {600, -250}
                }
              },
              [5] = {
                Active = true,
                Time = 1.8,
                Translate = {
                  Duration = 0.3,
                  EndValue = {600, -250},
                  StartValue = {600, -220}
                }
              }
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 2
          },
          [8] = {
            DialogContentStr = "ui_story_5012_50121301_37_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_38_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Brightness = 0.2,
                Layer = 6,
                Scale = {
                  Duration = 1.2,
                  EndValue = {0.45, 0.45},
                  StartValue = {0.4, 0.4}
                },
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {300, -220},
                  StartValue = {300, -250}
                }
              },
              [2] = {
                Active = true,
                Time = 0.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {300, -250},
                  StartValue = {300, -220}
                }
              },
              [3] = {
                Active = true,
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {300, -220},
                  StartValue = {300, -250}
                }
              },
              [4] = {
                Active = true,
                Time = 0.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {300, -250},
                  StartValue = {300, -220}
                }
              }
            },
            RefEntityID = 18
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
                Brightness = 0.2,
                Layer = 6,
                Scale = {
                  Duration = 1.2,
                  EndValue = {0.45, 0.45},
                  StartValue = {0.4, 0.4}
                },
                Time = 0.2,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-300, -220},
                  StartValue = {-300, -250}
                }
              },
              [2] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-300, -250},
                  StartValue = {-300, -220}
                }
              },
              [3] = {
                Active = true,
                Time = 0.8,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-300, -220},
                  StartValue = {-300, -250}
                }
              },
              [4] = {
                Active = true,
                Time = 1.1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-300, -250},
                  StartValue = {-300, -220}
                }
              }
            },
            RefEntityID = 19
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
                Time = 0.1
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 19
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 7
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
          },
          [9] = {
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
                Time = 0.3
              }
            },
            RefEntityID = 2
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_40_dialog_content",
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
            RefEntityID = 2
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_41_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
            RefEntityID = 2
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_43_dialog_content",
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
            RefEntityID = 2
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_44_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_46_dialog_content",
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
            RefEntityID = 2
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
            RefEntityID = 2
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_48_dialog_content",
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
            RefEntityID = 2
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_49_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_51_dialog_content",
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
            RefEntityID = 2
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_52_dialog_content",
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
                  Duration = 0.4,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Scaling = {0.4, 0.4},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {1000, -250},
                  StartValue = {1200, -250}
                }
              },
              [2] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {800, -250},
                  StartValue = {1000, -250}
                }
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 1.1
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0.9,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -269},
                  StartValue = {0, -269}
                }
              },
              [2] = {
                Active = true,
                Time = 1.3,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, -269},
                  StartValue = {200, -269}
                }
              },
              [3] = {Active = true, Time = 0}
            },
            RefEntityID = 2
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
                Position = {200, 0},
                Time = 1.1
              },
              [2] = {Active = true, Time = 1.4}
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1}
            },
            RefEntityID = 26
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_53_dialog_content",
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
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
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
            RefEntityID = 2
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
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
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
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
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 0.6,
                  StartValue = 0.2
                },
                Layer = 8,
                Scaling = {1.15, 1.15},
                Time = 0.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -530},
                  StartValue = {0, -550}
                }
              },
              [2] = {
                Active = true,
                Time = 0.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -550},
                  StartValue = {0, -530}
                }
              },
              [3] = {
                Active = true,
                Time = 1.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -530},
                  StartValue = {0, -550}
                }
              },
              [4] = {
                Active = true,
                Time = 1.7,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -550},
                  StartValue = {0, -530}
                }
              }
            },
            RefEntityID = 21
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
                Time = 0.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, -400},
                  StartValue = {0, -500}
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 39,
                Time = 0.5
              }
            },
            RefEntityID = 20
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 8
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Scaling = {1.2, 1.2},
                Time = 0.5
              }
            },
            RefEntityID = 22
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9},
              [2] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 29
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Position = {0, -269},
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 21
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 20
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 9
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0.5
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 8
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 22
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_surprise",
                Time = 0.5
              }
            },
            RefEntityID = 2
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_57_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_58_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
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
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 20
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
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
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 0.8,
                  StartValue = 0.6
                },
                Layer = 8,
                Scale = {
                  Duration = 1.2,
                  EndValue = {1.15, 1.15},
                  StartValue = {1.1, 1.1}
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -530},
                  StartValue = {0, -550}
                }
              },
              [2] = {
                Active = true,
                Time = 0.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -550},
                  StartValue = {0, -530}
                }
              },
              [3] = {
                Active = true,
                Time = 1.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -530},
                  StartValue = {0, -550}
                }
              },
              [4] = {
                Active = true,
                Time = 1.7,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -550},
                  StartValue = {0, -530}
                }
              }
            },
            RefEntityID = 21
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 22
          },
          [9] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.5,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 0},
                  StartValue = {0, -100}
                }
              }
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9},
              [2] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 29
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_60_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {-200, -500},
                Scale = {
                  Duration = 0,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_61_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 3
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.6
                },
                Time = 0.2
              }
            },
            RefEntityID = 21
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Position = {0, -269},
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 21
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 20
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 9
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0.5
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 8
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 22
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_63_dialog_content",
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
            RefEntityID = 2
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_5012_50121301_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {
                ShowContent = 0.02,
                Time = 0.2,
                TypeTimeList = {
                  0.02,
                  0,
                  0
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nuoweiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [65] = {
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
            RefEntityID = 3
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
