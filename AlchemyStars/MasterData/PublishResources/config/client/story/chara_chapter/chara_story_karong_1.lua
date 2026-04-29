return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "StoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 28,
      FitSize = true,
      Name = "过道",
      Resource = "StoryBGFengchuan.prefab",
      Type = "Picture"
    },
    [3] = {
      Effect = "",
      EntityID = 29,
      Name = "卡戎立绘",
      Resource = "1600251_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 30,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 31,
      FitSize = true,
      Name = "房间",
      Resource = "StoryBGjuxiangroom.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 32,
      FitSize = true,
      Name = "储仓",
      Resource = "StoryBGguangnengchucang.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 33,
      FitSize = true,
      Name = "舰桥",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 34,
      Name = "启光士兵1",
      Resource = "qiguangshibing_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 35,
      Name = "启光士兵2",
      Resource = "qiguangshibing2_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 36,
      FitSize = false,
      Name = "日常bgm",
      Resource = "38",
      Type = "Sound"
    },
    [11] = {
      EntityID = 37,
      FitSize = false,
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [12] = {
      EntityID = 38,
      FitSize = false,
      Name = "诙谐",
      Resource = "37",
      Type = "Sound"
    }
  },
  ID = 30250401,
  Name = "chara_story_karong_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.4
              },
              [2] = {ShowContent = 0.04, Time = 1.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 11,
                LoopAnimation = "Story_norm",
                Position = {0, -500},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 29
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
                Time = 0.5
              },
              [2] = {
                Active = true,
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 30
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
                Layer = 5,
                Time = 0.5
              }
            },
            RefEntityID = 33
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 36, Time = 1},
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
            DialogContentStr = "ui_story_30250401_2_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_3_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_4_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_5_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_6_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_7_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_8_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_9_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_10_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_11_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_12_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_13_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_14_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "ui_story_30250401_15_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_30250401_18_option_content",
                NextParagraphID = 3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 29
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
            DialogContentStr = "ui_story_30250401_16_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_17_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_19_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          NextParagraphID = 4
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_20_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {400, -500},
                  StartValue = {0, -500}
                }
              }
            },
            RefEntityID = 29
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.4},
              [3] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 37
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_21_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_22_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_23_dialog_content",
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
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 30
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_24_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1.9},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
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
                Layer = 12,
                Position = {300, -400},
                Scaling = {0.45, 0.45},
                Time = 1
              }
            },
            RefEntityID = 34
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 12,
                Position = {-300, -400},
                Scaling = {0.45, 0.45},
                Time = 1
              }
            },
            RefEntityID = 35
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 6,
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
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 30
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_25_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 34
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 35
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_26_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_27_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
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
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_28_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 34
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 35
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_29_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_30_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_31_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_32_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
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
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_33_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 34
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 35
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_34_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_35_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
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
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_36_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
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
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_37_dialog_content",
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
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [19] = {
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
            RefEntityID = 34
          },
          [2] = {
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
            RefEntityID = 35
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
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              },
              [3] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              },
              [5] = {Scaling = 1, Time = 3.5}
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
                Time = 2
              }
            },
            RefEntityID = 30
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1},
              [2] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 37
          }
        },
        [20] = {
          [1] = {
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
            RefEntityID = 30
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 7,
                Time = 0
              }
            },
            RefEntityID = 32
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_38_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_39_dialog_content",
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
                  Duration = 0.2,
                  EndValue = {0, -500},
                  StartValue = {400, -500}
                }
              }
            },
            RefEntityID = 29
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_40_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_41_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_42_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_43_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_44_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_45_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [29] = {
          [1] = {
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
            RefEntityID = 29
          },
          [2] = {
            DialogContentStr = "ui_story_30250401_46_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_47_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_48_dialog_content",
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
              [1] = {Time = 0}
            },
            RefEntityID = 29
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_49_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_50_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_51_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_52_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_53_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "ui_story_30250401_54_option_content",
                NextParagraphID = 5
              },
              [2] = {
                Content = "ui_story_30250401_59_option_content",
                NextParagraphID = 6
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 29
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
            DialogContentStr = "ui_story_30250401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 29
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_56_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_57_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 29
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_58_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
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
          NextParagraphID = 7
        }
      }
    },
    [6] = {
      ID = 6,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 29
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_61_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_62_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_63_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_64_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_65_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          NextParagraphID = 7
        }
      }
    },
    [7] = {
      ID = 7,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_66_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_67_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_68_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_69_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
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
                  EndValue = 0,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -500},
                  StartValue = {0, -500}
                }
              }
            },
            RefEntityID = 29
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.4},
              [3] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 37
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_70_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_71_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 12,
                Time = 0
              }
            },
            RefEntityID = 34
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_73_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 34
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_74_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
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
            RefEntityID = 34
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_75_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
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
            RefEntityID = 34
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
                  EndValue = 0.2,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_76_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 35
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_77_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_79_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_80_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_81_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_82_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_83_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_84_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_85_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_86_dialog_content",
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
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_87_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
          },
          [2] = {
            KeyFrames = {},
            RefEntityID = 34
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
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_88_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 34
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 35
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_89_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguanga"
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
                Time = 0.2
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 34
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 35
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_90_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiguangb"
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
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 35
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_91_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_92_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 34
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
            RefEntityID = 35
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {100, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {100, 0}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {-100, 0}
                }
              },
              [4] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-100, 0},
                  StartValue = {0, 0}
                }
              },
              [5] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {-100, 0}
                }
              },
              [6] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-100, 0},
                  StartValue = {0, 0}
                }
              },
              [7] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {100, 0}
                }
              },
              [8] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {100, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [28] = {
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
              },
              [2] = {Time = 1.4}
            },
            RefEntityID = 30
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 3,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0.2,
                Time = 1.2
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
            RefEntityID = 34
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
            RefEntityID = 35
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 31
          },
          [5] = {
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
            RefEntityID = 30
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_94_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 34
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
            RefEntityID = 35
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_95_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_96_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_97_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_98_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {40, 40},
                  Vibrato = 40
                },
                Time = 0
              }
            }
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_99_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -500},
                  StartValue = {400, -500}
                }
              }
            },
            RefEntityID = 29
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 38, Time = 0}
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_100_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_101_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_102_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_103_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_104_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_105_dialog_content",
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
              [1] = {Time = 0}
            },
            RefEntityID = 29
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_106_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_107_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_108_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_109_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_110_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [47] = {
          [1] = {
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
            RefEntityID = 29
          },
          [2] = {
            DialogContentStr = "ui_story_30250401_111_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_112_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [49] = {
          [1] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          },
          [2] = {
            DialogContentStr = "ui_story_30250401_113_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_114_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_115_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
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
            RefEntityID = 29
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_116_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Affinity = 30,
                Content = "ui_story_30250401_117_option_content",
                NextParagraphID = 8,
                PetID = 1600251
              },
              [2] = {
                Affinity = 50,
                Content = "ui_story_30250401_120_option_content",
                NextParagraphID = 9,
                PetID = 1600251
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 29
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
            DialogContentStr = "ui_story_30250401_118_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_119_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          NextParagraphID = 10
        }
      }
    },
    [9] = {
      ID = 9,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_121_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_122_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [3] = {
          [1] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 29
          },
          [2] = {
            DialogContentStr = "ui_story_30250401_123_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_124_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          },
          NextParagraphID = 10
        }
      }
    },
    [10] = {
      ID = 10,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
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
            RefEntityID = 29
          },
          [2] = {
            DialogContentStr = "ui_story_30250401_125_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_126_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
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
            RefEntityID = 29
          }
        },
        [3] = {
          [1] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 29
          },
          [2] = {
            DialogContentStr = "ui_story_30250401_127_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_charon"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_128_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
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
                  EndValue = 0,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -500},
                  StartValue = {0, -500}
                }
              }
            },
            RefEntityID = 29
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.4},
              [3] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 37
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_129_dialog_content",
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
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_130_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 29
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_131_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 29
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_132_dialog_content",
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
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30250401_133_dialog_content",
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
                Layer = 50,
                Time = 0
              },
              [2] = {Time = 2.5}
            },
            RefEntityID = 30
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 29
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
