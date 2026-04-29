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
      FitSize = true,
      Name = "环都市浅层背景图",
      Resource = "StoryBGqianceng.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 3,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 8,
      FitSize = false,
      Name = "芙罗琳",
      Resource = "fuluolin_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 9,
      Name = "希诺普",
      Resource = "xinuopu_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 11,
      Name = "艾莉法",
      Resource = "1501391_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 13,
      FitSize = true,
      Name = "公园背景图",
      Resource = "StoryBGgongyuan.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 14,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [9] = {
      EntityID = 16,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 19,
      FitSize = false,
      Name = "橙",
      Resource = "cheng_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 20,
      Name = "葛莉特",
      Resource = "gelite_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 23,
      FitSize = false,
      Name = "管家",
      Resource = "jiqiguanjia_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 25,
      FitSize = false,
      Name = "暗鬼战狂",
      Resource = "anguizhankuang_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 26,
      FitSize = false,
      Name = "机器人替代",
      Resource = "s256_n11_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 27,
      Name = "攻击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 28,
      FitSize = false,
      Name = "暗鬼大兵",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [17] = {
      EntityID = 29,
      FitSize = false,
      Name = "暗鬼大兵2",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 30,
      FitSize = false,
      Name = "暗鬼大兵3",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [19] = {
      EntityID = 31,
      Name = "n11环都市BGM",
      Resource = "62",
      Type = "Sound"
    },
    [20] = {
      EntityID = 32,
      FitSize = false,
      Name = "电磁1",
      Resource = "10077",
      Type = "Sound"
    },
    [21] = {
      EntityID = 33,
      FitSize = false,
      Name = "敌人低吼",
      Resource = "10013",
      Type = "Sound"
    },
    [22] = {
      EntityID = 34,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [23] = {
      EntityID = 35,
      FitSize = false,
      Name = "flash2",
      Resource = "10019",
      Type = "Sound"
    },
    [24] = {
      EntityID = 36,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [25] = {
      EntityID = 37,
      FitSize = false,
      Name = "电磁2",
      Resource = "10078",
      Type = "Sound"
    },
    [26] = {
      EntityID = 38,
      FitSize = false,
      Name = "暗鬼吼声",
      Resource = "10069",
      Type = "Sound"
    },
    [27] = {
      EntityID = 39,
      Name = "机器人受击",
      Resource = "10179",
      Type = "Sound"
    },
    [28] = {
      EntityID = 40,
      Name = "电磁音效",
      Resource = "10039",
      Type = "Sound"
    }
  },
  ID = 50141001,
  Name = "event_story_N11shaonvyuyiji_10_1",
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
                Layer = 60,
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
          [2] = {
            DialogContentStr = "ui_story_5014_50141001_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
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
                Scaling = {1.05, 1.05},
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -330},
                  StartValue = {-200, -330}
                }
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.4
              }
            },
            RefEntityID = 13
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 31, Time = 0.5}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_2_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_3_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
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
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0
              },
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.3
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 9
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
                Position = {0, -250},
                Scaling = {0.4, 0.4},
                Time = 0.3
              }
            },
            RefEntityID = 28
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 2
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 33
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_5_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Scaling = {0.3, 0.3},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -250},
                  StartValue = {-800, -250}
                }
              }
            },
            RefEntityID = 29
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
                Scaling = {0.3, 0.3},
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {600, -250},
                  StartValue = {800, -250}
                }
              }
            },
            RefEntityID = 30
          }
        },
        [6] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_serious",
                Time = 0.3
              }
            },
            RefEntityID = 9
          },
          [2] = {
            DialogContentStr = "ui_story_5014_50141001_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
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
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 28
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 29
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 30
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 16
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 13
          },
          [10] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 34, Time = 0.4}
            }
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 35
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_7_dialog_content",
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
            RefEntityID = 9
          }
        },
        [8] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_shocked",
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [2] = {
            DialogContentStr = "ui_story_5014_50141001_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fuluolin"
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
                Scaling = {1, 1},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -320},
                  StartValue = {-600, -320}
                }
              }
            },
            RefEntityID = 8
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -330},
                  StartValue = {0, -330}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [10] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [2] = {
            DialogContentStr = "ui_story_5014_50141001_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
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
            RefEntityID = 8
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailifa"
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
                Scaling = {0.96, 0.96},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-620, -310},
                  StartValue = {-820, -310}
                }
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -320},
                  StartValue = {-400, -320}
                }
              }
            },
            RefEntityID = 8
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {500, -330},
                  StartValue = {400, -330}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_12_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailifa"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fuluolin"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 8
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
            RefEntityID = 11
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailifa"
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
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 11
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
            RefEntityID = 8
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fuluolin"
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
            RefEntityID = 8
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
            RefEntityID = 11
          }
        },
        [16] = {
          [1] = {
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
            RefEntityID = 9
          },
          [2] = {
            DialogContentStr = "ui_story_5014_50141001_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
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
            RefEntityID = 8
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_17_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_18_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fuluolin"
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
            RefEntityID = 8
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
            RefEntityID = 9
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_guanjia"
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
                LoopAnimation = "Story_serious",
                Position = {0, -50},
                Scaling = {0.4, 0.4},
                Time = 0.5
              }
            },
            RefEntityID = 23
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 36, Time = 0.6}
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1}
            },
            RefEntityID = 37
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_21_dialog_content",
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Scaling = {1, 1},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -150},
                  StartValue = {-600, -150}
                }
              }
            },
            RefEntityID = 25
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {400, -50},
                  StartValue = {0, -50}
                }
              }
            },
            RefEntityID = 23
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 38
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_guanjia"
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {600, -50},
                  StartValue = {400, -50}
                }
              }
            },
            RefEntityID = 23
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
                Layer = 7,
                Time = 0
              },
              [2] = {
                Active = true,
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -150},
                  StartValue = {-400, -150}
                }
              }
            },
            RefEntityID = 25
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
                Layer = 7,
                Scaling = {0.8, 0.8},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -200},
                  StartValue = {200, -200}
                }
              },
              [2] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 26
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Position = {-200, 0},
                Time = 0.2
              }
            },
            RefEntityID = 27
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 39
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheng"
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 23
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 25
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
                LoopAnimation = "Story_angry",
                Scaling = {0.9, 0.9},
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -400},
                  StartValue = {-600, -400}
                }
              }
            },
            RefEntityID = 19
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
                Brightness = 0.2,
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Position = {400, -320},
                Scaling = {0.86, 0.86},
                Time = 0.3
              }
            },
            RefEntityID = 20
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 26
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gelite"
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
            RefEntityID = 20
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
            RefEntityID = 19
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_guanjia"
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -50},
                  StartValue = {-800, -50}
                }
              }
            },
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -400},
                  StartValue = {-400, -400}
                }
              }
            },
            RefEntityID = 19
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
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheng"
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
            RefEntityID = 23
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 19
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {600, -320},
                  StartValue = {400, -320}
                }
              }
            },
            RefEntityID = 20
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_27_dialog_content",
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
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.3
              }
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 23
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Time = 0.3,
                Translate = {
                  Duration = 0.5,
                  EndValue = {800, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 19
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 20
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0
              },
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 32
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 40
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_28_dialog_content",
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
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Layer = 8,
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  Strength = {60, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.2
              }
            },
            RefEntityID = 25
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -200},
                  StartValue = {400, -200}
                }
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  Strength = {60, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.2
              }
            },
            RefEntityID = 26
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Position = {0, 0},
                Time = 0.2
              },
              [2] = {Active = false, Time = 0}
            },
            RefEntityID = 27
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1,
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
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 39
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_29_dialog_content",
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
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Time = 0.2,
                Translate = {
                  Duration = 1,
                  EndValue = {600, -250},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 28
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Time = 0.2
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 25
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 26
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 33
          }
        },
        [30] = {
          [1] = {
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
          [2] = {
            DialogContentStr = "ui_story_5014_50141001_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
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
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0.4
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.4
              }
            },
            RefEntityID = 13
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
                Time = 0.4
              }
            },
            RefEntityID = 8
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
                Time = 0.4
              }
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 30,
                Time = 0.3
              }
            },
            RefEntityID = 16
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0
              },
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 14
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 2
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5014_50141001_31_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinuopu"
          }
        },
        [32] = {
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
