return {
  ComponentID = "0",
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "UIN25IdolStoryDialog.prefab",
      Type = "IdolDialog"
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
      Name = "训练室背景图",
      Resource = "StoryBGxunlianshi.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "歌尔蒂",
      Resource = "geerdi_n23_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = true,
      Name = "训练室",
      Resource = "StoryBGxunlianshi.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "贡露",
      Resource = "gonglu_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = true,
      Name = "影镇街道",
      Resource = "StoryBGyingzhenjiedao.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      FitSize = true,
      Name = "咖啡馆",
      Resource = "StoryJiari.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "影镇女",
      Resource = "yingzhennv_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      FitSize = true,
      Name = "走廊",
      Resource = "StoryBGzoulang.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "涉",
      Resource = "she_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 14,
      FitSize = true,
      Name = "事务所",
      Resource = "StoryBGshiwusuo.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "歌尔蒂切条",
      Resource = "geerdi_n23_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [16] = {
      EntityID = 16,
      Name = "狗仔",
      Resource = "gouzai_n25_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [17] = {
      EntityID = 17,
      Name = "狗仔",
      Resource = "gouzai_n25_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 18,
      Name = "N25暖场BGM",
      Resource = "84",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      Name = "敲门声",
      Resource = "10108",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "开门声",
      Resource = "10112",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "关门",
      Resource = "10211",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 50370901,
  Name = "event_story_N25wanfa_9_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_1_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
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
            DialogContentStr = "ui_story_5037_50370901_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                Position = {0, -300},
                Scaling = {0.83, 0.83},
                Time = 0
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
            RefEntityID = 5
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 18, Time = 0}
            }
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_4_dialog_content",
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
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_5_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_6_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_7_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -300},
                  StartValue = {0, -300}
                }
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
                LoopAnimation = "Story_happy",
                Position = {400, -400},
                Scaling = {0.95, 0.95},
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_8_dialog_content",
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
            RefEntityID = 4
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
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_9_dialog_content",
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
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_10_dialog_content",
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
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_12_dialog_content",
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
            RefEntityID = 6
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_13_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370901_14_dialog_content",
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
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_15_dialog_content",
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
            RefEntityID = 6
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_16_dialog_content",
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
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gonglu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -350},
                  StartValue = {400, -400}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, -400},
                  StartValue = {400, -350}
                }
              }
            },
            RefEntityID = 6
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_19_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 4
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
            DialogContentStr = "ui_story_5037_50370901_20_dialog_content",
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
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_21_dialog_content",
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
            RefEntityID = 6
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_22_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {800, -400},
                  StartValue = {400, -400}
                }
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
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -300},
                  StartValue = {-400, -300}
                }
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 20
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_23_dialog_content",
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
            RefEntityID = 4
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_24_dialog_content",
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
            RefEntityID = 4
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_25_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370901_26_dialog_content",
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
            RefEntityID = 4
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_27_dialog_content",
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
            RefEntityID = 4
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_28_dialog_content",
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
            RefEntityID = 4
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_32_dialog_content",
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
            RefEntityID = 4
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_33_dialog_content",
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
            RefEntityID = 4
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_34_dialog_content",
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
            RefEntityID = 4
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_35_dialog_content",
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
            RefEntityID = 4
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_37_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
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
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_38_dialog_content",
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
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_39_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370901_40_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1
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
              }
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
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cantingfuwuyuan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Position = {0, -350},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 22, Time = 0}
            }
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_42_dialog_content",
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
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_43_dialog_content",
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
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 25,
                LoopAnimation = "Story_serious",
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
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
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_45_dialog_content",
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
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
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
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_46_dialog_content",
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
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_47_dialog_content",
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
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_Sheol"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
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
              [1] = {
                Active = true,
                Layer = 48,
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                LoopAnimation = "Story_serious",
                Position = {-400, -500},
                Scaling = {1, 1},
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 24,
                Position = {400, -300},
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_Sheol"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
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
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 25,
                LoopAnimation = "Story_surprise",
                Position = {0, -300},
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
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
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
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
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_54_dialog_content",
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
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cantingfuwuyuan"
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
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_56_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -350},
                  StartValue = {0, -350}
                }
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
            RefEntityID = 10
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_57_dialog_content",
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
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_58_dialog_content",
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
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_59_dialog_content",
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
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_60_dialog_content",
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
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_61_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1}
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
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_62_dialog_content",
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_63_dialog_content",
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
                Brightness = 0.2,
                Layer = 18,
                Position = {400, 0},
                Scaling = {0.83, 0.83},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -300},
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Position = {-400, 0},
                Scaling = {0.95, 0.95},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -320},
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
          }
        },
        [66] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
          }
        },
        [67] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_67_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 16
          },
          [4] = {
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
            RefEntityID = 15
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
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
            RefEntityID = 4
          },
          [3] = {
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
            RefEntityID = 16
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
            RefEntityID = 15
          }
        },
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
          }
        },
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_70_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 16
          },
          [4] = {
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
            RefEntityID = 15
          }
        },
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_71_dialog_content",
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
            RefEntityID = 4
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
            RefEntityID = 15
          },
          [4] = {
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
            RefEntityID = 16
          }
        },
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_72_dialog_content",
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
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_73_dialog_content",
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
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
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
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {400, -300},
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                Position = {-400, -320},
                Scaling = {0.95, 0.95},
                Time = 0.2
              }
            },
            RefEntityID = 17
          }
        },
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_75_dialog_content",
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
            RefEntityID = 17
          }
        },
        [76] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_76_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_embarrass",
                Time = 0.1
              }
            },
            RefEntityID = 17
          }
        },
        [77] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
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
            RefEntityID = 4
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
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [78] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_78_dialog_content",
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
                Content = "ui_story_5037_50370901_79_option_content",
                NextParagraphID = 2,
                ThreeD = true
              },
              [2] = {
                Content = "ui_story_5037_50370901_81_option_content",
                NextParagraphID = 3,
                ThreeD = true
              }
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
            RefEntityID = 17
          }
        }
      }
    },
    [2] = {
      ComponentID = "0",
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            AddThreeDView = true,
            DialogContentStr = "ui_story_5037_50370901_80_dialog_content",
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
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ComponentID = "0",
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            AddThreeDView = true,
            DialogContentStr = "ui_story_5037_50370901_82_dialog_content",
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
          NextParagraphID = 4
        }
      }
    },
    [4] = {
      ComponentID = "0",
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
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
            RefEntityID = 17
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_84_dialog_content",
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
            RefEntityID = 4
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
            RefEntityID = 17
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_85_dialog_content",
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
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
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
                LoopAnimation = "Story_lose",
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_baguajizhe"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
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
                LoopAnimation = "Story_norm",
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -300},
                  StartValue = {400, -300}
                }
              }
            },
            RefEntityID = 4
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
                  Duration = 0.5,
                  EndValue = {-600, -320},
                  StartValue = {-400, -320}
                }
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
            RefEntityID = 17
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_90_dialog_content",
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
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_91_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370901_92_dialog_content",
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
            RefEntityID = 4
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_94_dialog_content",
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
            RefEntityID = 4
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_95_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370901_96_dialog_content",
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
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_97_dialog_content",
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
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_98_dialog_content",
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
            RefEntityID = 4
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_99_dialog_content",
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
            RefEntityID = 4
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_100_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_105_dialog_content",
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
            RefEntityID = 4
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_106_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -300}
                }
              },
              [2] = {
                Layer = 8,
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -300},
                  StartValue = {0, -250}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_109_dialog_content",
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
            RefEntityID = 4
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_110_dialog_content",
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
            RefEntityID = 4
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_112_dialog_content",
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
            RefEntityID = 4
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_113_dialog_content",
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
            RefEntityID = 4
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370901_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
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
        [33] = {
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
