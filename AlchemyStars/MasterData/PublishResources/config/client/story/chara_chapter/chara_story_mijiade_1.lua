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
      FitSize = false,
      Name = "弥加德立绘替代",
      Resource = "1600931_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "舰桥背景",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "贡露立绘",
      Resource = "gonglu_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = true,
      Name = "巨像走廊背景",
      Resource = "StoryBGFengchuan.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "奈弥西斯立绘",
      Resource = "1500121_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "莉莉姆立绘替代",
      Resource = "1400831_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "黑条背景",
      Resource = "AnguiqunCG.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      Name = "红色遮罩",
      Resource = "RedPic.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 12,
      FitSize = true,
      Name = "启光整备厂背景",
      Resource = "JQ_BGQiguangzhengbei1.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = true,
      Name = "启光走廊背景",
      Resource = "StoryBGenlightment.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      FitSize = true,
      Name = "启光大厅背景",
      Resource = "StoryBGenlightment3.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "诙谐BGM",
      Resource = "37",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "拳击声音",
      Resource = "10073",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "按钮音效",
      Resource = "10009",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "吸尘器音效",
      Resource = "10107",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "警告音",
      Resource = "10065",
      Type = "Sound"
    }
  },
  ID = 30930401,
  Name = "chara_story_mijiade_1",
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
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Position = {0, -400},
                Scaling = {1.5, 1.5},
                Time = 1.5
              }
            },
            RefEntityID = 3
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
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 2,
                Scale = {
                  Duration = 1.6,
                  EndValue = {1.05, 1.05},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 20}
                }
              },
              [3] = {
                Time = 0.8,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 20}
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4},
              [2] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 15
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StartBgm = 16,
                Time = 0.5
              }
            }
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_2_dialog_content",
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
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_4_dialog_content",
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
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_5_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
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
                Layer = 23,
                LoopAnimation = "Story_anger",
                Position = {0, -350},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0.9, 0.9}
                },
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-550, -350},
                  StartValue = {-650, -350}
                }
              },
              [2] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1.5
              }
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 6
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
                Layer = 22,
                LoopAnimation = "Story_anger",
                Scale = {
                  Duration = 0.2,
                  EndValue = {-0.35, 0.35},
                  StartValue = {-0.3, 0.3}
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {500, -230},
                  StartValue = {650, -230}
                }
              },
              [2] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 7
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
                Layer = 25,
                Position = {0, -500},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1.1, 1.1},
                  StartValue = {0.9, 0.9}
                },
                Time = 1.5
              },
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 8
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 17
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                LoopAnimation = "Story_think",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_7_dialog_content",
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
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_8_dialog_content",
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_9_dialog_content",
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
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_12_dialog_content",
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2}
            },
            RefEntityID = 9
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
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Position = {-400, -350},
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {-300, 200},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {200, 200},
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
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
                  EndValue = 1,
                  StartValue = 1
                },
                Position = {300, -230},
                Time = 0.2
              }
            },
            RefEntityID = 7
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.4
              },
              [2] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
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
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_18_dialog_content",
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
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_21_dialog_content",
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
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_23_dialog_content",
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
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_24_dialog_content",
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
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_26_dialog_content",
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_28_dialog_content",
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
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_30_dialog_content",
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
            RefEntityID = 3
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_33_dialog_content",
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
            RefEntityID = 3
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
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
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_35_dialog_content",
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
            RefEntityID = 3
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_smile",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_37_dialog_content",
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
            RefEntityID = 3
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_38_dialog_content",
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
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_40_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_30930401_75_option_content",
                NextParagraphID = 3
              },
              [3] = {
                Content = "ui_story_30930401_99_option_content",
                NextParagraphID = 4
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 5
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
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StartBgm = 10,
                Time = 0
              },
              [2] = {
                FadeTime = 1,
                StartBgm = 18,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 20
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                  EndValue = 1,
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2},
              [3] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.1
              },
              [2] = {ShowContent = 0.02, Time = 0.3}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
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
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.1
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {30, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_75_option_content",
                NextParagraphID = 5
              },
              [2] = {
                Content = "ui_story_30930401_99_option_content",
                NextParagraphID = 6
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          }
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.6
              },
              [3] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
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
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StartBgm = 10,
                Time = 0
              },
              [2] = {
                FadeTime = 1,
                StartBgm = 18,
                Time = 0.5
              }
            }
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StartBgm = 10,
                Time = 0
              },
              [2] = {
                FadeTime = 1,
                StartBgm = 18,
                Time = 0.5
              }
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.1
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {50, 0},
                  StartValue = {-50, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.1
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
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
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0.5
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.2
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Time = 0.5
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.7
              },
              [5] = {Active = false, Time = 1}
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.3
              }
            }
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
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_91_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.8,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_40_option_content",
                NextParagraphID = 7
              },
              [2] = {
                Content = "ui_story_30930401_99_option_content",
                NextParagraphID = 8
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          }
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.9
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
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
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.9
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StartBgm = 10,
                Time = 0
              },
              [2] = {
                FadeTime = 1,
                StartBgm = 18,
                Time = 0.5
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 19
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 1.2
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
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
                  StartValue = 1
                },
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_105_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_113_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_115_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_116_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_117_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_118_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_119_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_120_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_121_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_122_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_124_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_125_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_126_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_127_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_128_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.95,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_129_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_40_option_content",
                NextParagraphID = 9
              },
              [2] = {
                Content = "ui_story_30930401_75_option_content",
                NextParagraphID = 10
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.95
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
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
                Time = 0.2
              }
            },
            RefEntityID = 14
          }
        }
      }
    },
    [5] = {
      ID = 5,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.6
              },
              [3] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
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
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.1
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {50, 0},
                  StartValue = {-50, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.1
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
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
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0.5
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.2
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Time = 0.5
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.7
              },
              [5] = {Active = false, Time = 1}
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.3
              }
            }
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
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_91_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.8,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_99_option_content",
                NextParagraphID = 11
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          }
        }
      }
    },
    [6] = {
      ID = 6,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.9
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
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
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.9
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 19
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 1.2
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
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
                  StartValue = 1
                },
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_105_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_113_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_115_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_116_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_117_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_118_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_119_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_120_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_121_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_122_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_124_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_125_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_126_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_127_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_128_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.95,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_129_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_75_option_content",
                NextParagraphID = 12
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.95
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
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
                Time = 0.2
              }
            },
            RefEntityID = 14
          }
        }
      }
    },
    [7] = {
      ID = 7,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 5
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
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 12
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 20
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                  EndValue = 1,
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2},
              [3] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.1
              },
              [2] = {ShowContent = 0.02, Time = 0.3}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
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
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.1
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {30, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_99_option_content",
                NextParagraphID = 13
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          }
        }
      }
    },
    [8] = {
      ID = 8,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.9
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
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
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.9
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 19
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 1.2
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
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
                  StartValue = 1
                },
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_105_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_113_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_115_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_116_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_117_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_118_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_119_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_120_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_121_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_122_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_124_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_125_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_126_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_127_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_128_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.95,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_129_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_40_option_content",
                NextParagraphID = 14
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.95
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
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
                Time = 0.2
              }
            },
            RefEntityID = 14
          }
        }
      }
    },
    [9] = {
      ID = 9,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 5
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
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 12
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 20
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                  EndValue = 1,
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2},
              [3] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.1
              },
              [2] = {ShowContent = 0.02, Time = 0.3}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
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
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.1
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {30, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_75_option_content",
                NextParagraphID = 15
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          }
        }
      }
    },
    [10] = {
      ID = 10,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.6
              },
              [3] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
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
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.1
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {50, 0},
                  StartValue = {-50, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.1
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
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
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0.5
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.2
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Time = 0.5
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.7
              },
              [5] = {Active = false, Time = 1}
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.3
              }
            }
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
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_91_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.8,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_40_option_content",
                NextParagraphID = 16
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          }
        }
      }
    },
    [11] = {
      ID = 11,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.9
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
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
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.9
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 19
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 1.2
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
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
                  StartValue = 1
                },
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_105_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_113_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_115_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_116_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_117_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_118_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_119_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_120_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_121_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_122_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_124_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_125_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_126_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_127_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_128_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.95,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_129_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_130_option_content",
                NextParagraphID = 17
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.95
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
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
                Time = 0.2
              }
            },
            RefEntityID = 14
          }
        }
      }
    },
    [12] = {
      ID = 12,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.6
              },
              [3] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
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
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.1
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {50, 0},
                  StartValue = {-50, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.1
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
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
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0.5
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.2
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Time = 0.5
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.7
              },
              [5] = {Active = false, Time = 1}
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.3
              }
            }
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
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_91_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.8,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_130_option_content",
                NextParagraphID = 17
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          }
        }
      }
    },
    [13] = {
      ID = 13,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.9
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
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
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.9
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 19
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 1.2
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
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
                  StartValue = 1
                },
                LoopAnimation = "Story_norm",
                Time = 1
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_105_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_113_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_115_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_116_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_117_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_118_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_119_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_120_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_121_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_122_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_124_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_125_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_126_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_naimikuohao"
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
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_127_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_128_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.95,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_129_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_130_option_content",
                NextParagraphID = 17
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.95
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
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
                Time = 0.2
              }
            },
            RefEntityID = 14
          }
        }
      }
    },
    [14] = {
      ID = 14,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 5
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
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 12
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 20
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                  EndValue = 1,
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2},
              [3] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.1
              },
              [2] = {ShowContent = 0.02, Time = 0.3}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
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
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.1
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {30, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_130_option_content",
                NextParagraphID = 17
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          }
        }
      }
    },
    [15] = {
      ID = 15,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.6
              },
              [3] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
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
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.1
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {50, 0},
                  StartValue = {-50, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 30
                },
                Time = 1.1
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
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
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0.5
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 5,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.2
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Time = 0.5
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.7
              },
              [5] = {Active = false, Time = 1}
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.3
              }
            }
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
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_91_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
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
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.8,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_lilimukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_130_option_content",
                NextParagraphID = 17
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          }
        }
      }
    },
    [16] = {
      ID = 16,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 5
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
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 3,
                Time = 0.5
              }
            },
            RefEntityID = 12
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 20
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                  EndValue = 1,
                  StartValue = 1
                },
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2},
              [3] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 20
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.1
              },
              [2] = {ShowContent = 0.02, Time = 0.3}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
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
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.1
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerBGColor = "blue",
            SpeakerNameStr = "ui_story_name_gonglukuohao"
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {30, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            Options = {
              [1] = {
                Content = "ui_story_30930401_130_option_content",
                NextParagraphID = 17
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1,
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
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          }
        }
      }
    },
    [17] = {
      ID = 17,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_131_dialog_content",
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
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_132_dialog_content",
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
            DialogContentStr = "ui_story_30930401_133_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_134_dialog_content",
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_135_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_136_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_137_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
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
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 18,
                Time = 0
              }
            }
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_138_dialog_content",
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
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_139_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_140_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            Options = {
              [1] = {
                Affinity = 50,
                Content = "ui_story_30930401_141_option_content",
                NextParagraphID = 18,
                PetID = 1600931
              },
              [2] = {
                Affinity = 50,
                Content = "ui_story_30930401_148_option_content",
                NextParagraphID = 19,
                PetID = 1600931
              }
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
            RefEntityID = 3
          }
        }
      }
    },
    [18] = {
      ID = 18,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_142_dialog_content",
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
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_143_dialog_content",
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
            DialogContentStr = "ui_story_30930401_144_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_145_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_146_dialog_content",
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
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_147_dialog_content",
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
          NextParagraphID = 20
        }
      }
    },
    [19] = {
      ID = 19,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_149_dialog_content",
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
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_150_dialog_content",
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
            DialogContentStr = "ui_story_30930401_151_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_152_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_153_dialog_content",
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
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_154_dialog_content",
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
          NextParagraphID = 20
        }
      }
    },
    [20] = {
      ID = 20,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_155_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 100},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0.8
                },
                Time = 0.2
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 4
                },
                Time = 0.3
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
                LoopAnimation = "Story_smile",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_156_dialog_content",
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
            RefEntityID = 3
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
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_157_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Time = 0}
            }
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_158_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 200},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.65,
                  StartValue = 0.65
                },
                Time = 0.2
              }
            }
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_159_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_160_dialog_content",
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
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_161_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_162_dialog_content",
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
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_163_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_164_dialog_content",
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
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_165_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiade"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 150},
                Scale = {
                  Duration = 1,
                  EndValue = 0.75,
                  StartValue = 0.8
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30930401_166_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.8,
                  StartValue = 0.75
                },
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
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
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
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
                  EndValue = {0, 100},
                  StartValue = {0, 150}
                }
              }
            }
          },
          [2] = {
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
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 2
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
        }
      }
    }
  },
  StartParagraph = 1
}
