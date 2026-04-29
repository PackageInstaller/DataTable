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
      Name = "水族馆",
      Resource = "StoryBGshuizuguan1.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 3,
      FitSize = false,
      Name = "塞提",
      Resource = "saiti_n23_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "歌尔蒂",
      Resource = "geerdi_n23_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "失踪者的同伴替代",
      Resource = "shangchengnan_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "昏迷的游客替代",
      Resource = "yingzhennan2_n23_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "游客B替代",
      Resource = "yingzhennv_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "摩耶",
      Resource = "moye_n50_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      Name = "上城女立绘",
      Resource = "juminnv_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "米洛斯",
      Resource = "miluosi_n18_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "影镇老头",
      Resource = "yingzhenlaotou_n22_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "斯特兰汀",
      Resource = "sitelanting1_n50_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "斯特兰定 yuan",
      Resource = "sitelanting2_n50_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [14] = {
      EntityID = 14,
      Name = "攻击特效",
      Resource = "uieff_spine_shouji.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "影镇小男孩立绘替代",
      Resource = "yingzhen_younan_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "亚人男性",
      Resource = "yarendianyuan_cn6_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "bg",
      Resource = "20",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    }
  },
  ID = 50861201,
  Name = "event_story_N50moye_12_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
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
                Position = {0, -300},
                Scaling = {0.83, 0.83},
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StopBgm = true, Time = 0},
              [2] = {
                FadeTime = 2,
                StartBgm = 17,
                Time = 0.3
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.3
              }
            },
            RefEntityID = 18
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_saiti"
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
                Position = {0, -270},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_saiti"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_saiti"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shizongzhedetongban"
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
                Position = {0, -500},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hunmideyouke"
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
                  Duration = 0.2,
                  EndValue = {-400, -500},
                  StartValue = {0, -500}
                }
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
                Layer = 8,
                Position = {350, -400},
                Scaling = {1.15, 1.15},
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shizongzhedetongban"
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
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_youkeb"
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
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -350},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_9_dialog_content",
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {0, -400},
                Scaling = {0.85, 0.85},
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 7
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_11_dialog_content",
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
            RefEntityID = 8
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_12_dialog_content",
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
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_13_dialog_content",
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
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
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
            RefEntityID = 8
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_15_dialog_content",
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
            RefEntityID = 8
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_youkec"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 8
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
                Position = {0, -300},
                Scaling = {1.2, 1.2},
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_youkeb"
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
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 9
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_youkeb"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
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
                Layer = 8,
                Position = {0, -430},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_21_dialog_content",
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
            RefEntityID = 10
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
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
            RefEntityID = 10
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_youkea"
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
                Position = {0, -400},
                Scaling = {0.75, 0.75},
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
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
                Position = {0, -430},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 11
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_31_dialog_content",
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
            RefEntityID = 10
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
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
            RefEntityID = 10
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_34_dialog_content",
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
                Position = {0, -380},
                Scaling = {0.83, 0.83},
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_saiti"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
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
                Position = {0, -270},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
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
                Position = {0, -300},
                Scaling = {0.83, 0.83},
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_everyone"
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
                Time = 0
              }
            },
            RefEntityID = 6
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
                Time = 0
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
                Brightness = 0.2,
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.2,
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {0, -380},
                Scaling = {0.8, 0.8},
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
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
                  Duration = 0.2,
                  EndValue = {-400, -380},
                  StartValue = {0, -380}
                }
              }
            },
            RefEntityID = 13
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
                Position = {350, -430},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
            RefEntityID = 13
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
            RefEntityID = 10
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
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
            RefEntityID = 13
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
            RefEntityID = 10
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {700, -430},
                  StartValue = {350, -430}
                }
              },
              [2] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {350, -430},
                  StartValue = {700, -430}
                }
              },
              [3] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {350, 0},
                Time = 0.4
              }
            },
            RefEntityID = 14
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
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
            RefEntityID = 13
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
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 18,
                Position = {350, 0},
                Time = 0.4
              }
            },
            RefEntityID = 14
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
            RefEntityID = 13
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
            RefEntityID = 10
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
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
            RefEntityID = 13
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
            RefEntityID = 10
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
            RefEntityID = 13
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
            RefEntityID = 10
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 10
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
                Brightness = 1,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
          }
        },
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 8
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
                Position = {0, -430},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [66] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_miluosi"
          }
        },
        [67] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 10
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
              }
            },
            RefEntityID = 8
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
                  Duration = 0.2,
                  EndValue = {350, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 8
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
                Position = {-400, -380},
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
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
            RefEntityID = 8
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
            RefEntityID = 13
          }
        },
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
            RefEntityID = 13
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
            RefEntityID = 8
          }
        },
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
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
            RefEntityID = 8
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
            RefEntityID = 13
          }
        },
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
            RefEntityID = 13
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
            RefEntityID = 8
          }
        },
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_75_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [76] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [77] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [78] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
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
            RefEntityID = 8
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
            RefEntityID = 13
          }
        },
        [79] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
            RefEntityID = 13
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
            RefEntityID = 8
          }
        },
        [80] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [81] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_moye"
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
            RefEntityID = 8
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
            RefEntityID = 13
          }
        },
        [82] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_82_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Position = {0, -380},
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 8
          }
        },
        [83] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_83_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
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
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [84] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fulaode"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
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
                Position = {0, -150},
                Scaling = {0.9, 0.9},
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [85] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fulaode"
          }
        },
        [86] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fulaode"
          }
        },
        [87] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fulaode"
          }
        },
        [88] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_dianyuan"
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
                Position = {350, -350},
                Scaling = {0.9, 0.9},
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [3] = {
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
                  EndValue = {-350, -150},
                  StartValue = {0, -150}
                }
              }
            },
            RefEntityID = 15
          }
        },
        [89] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_youkeb"
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
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 16
          }
        },
        [90] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_90_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [91] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_91_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [92] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
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
              }
            },
            RefEntityID = 13
          }
        },
        [93] = {
          [1] = {
            DialogContentStr = "ui_story_5086_50861201_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sitelanting"
          }
        },
        [94] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 18
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
