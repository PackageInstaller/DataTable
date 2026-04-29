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
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [4] = {
      EntityID = 4,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [5] = {
      EntityID = 5,
      FitSize = true,
      Name = "蜂网背景图",
      Resource = "StoryBGhive.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "伊芙立绘",
      Resource = "yifu_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "CGYiwai",
      Resource = "CGYiwai.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "CGYifugelicang",
      Resource = "CGYifugelicang.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      FitSize = true,
      Name = "启光实验室",
      Resource = "StoryBGqiguangshiyan.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 12,
      FitSize = true,
      Name = "启光地下城背景-沦陷",
      Resource = "StoryBGenlightment2.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "黑场灰尘",
      Resource = "uieff_blacksmoke.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 15,
      Name = "吞罗",
      Resource = "tunluoshiyan_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "裂屏特效",
      Resource = "uieff_suiping.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "风船BGM",
      Resource = "27",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "强力转场",
      Resource = "10111",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "电磁1",
      Resource = "10077",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      Name = "电磁音效",
      Resource = "10039",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "暗鬼低语",
      Resource = "10014",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "诡异童谣",
      Resource = "10109",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "破裂",
      Resource = "10033",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "暗能攻击",
      Resource = "10088",
      Type = "Sound"
    }
  },
  ID = 50020100,
  Name = "event_story_yifu_2_1_0",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.8
              },
              [2] = {ShowContent = 0.04, Time = 3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 18,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.5
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 24, Time = 1}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_2_dialog_content",
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
            DialogContentStr = "ui_story_5001_50020100_3_dialog_content",
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
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.1
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1
              },
              [5] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.7
              },
              [6] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1.6
              },
              [7] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Time = 2.4
              },
              [8] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.6
                },
                Time = 2.5
              },
              [9] = {Active = true, Time = 4}
            },
            RefEntityID = 7
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.5
              },
              [2] = {Active = true, Time = 2.3},
              [3] = {Active = false, Time = 1.2},
              [4] = {Active = false, Time = 3.1}
            },
            RefEntityID = 3
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
                Layer = 6,
                Time = 0.5
              }
            },
            RefEntityID = 12
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
                Brightness = 0.5,
                Layer = 8,
                Position = {0, -200},
                Scaling = {1, 1},
                Time = 0.7
              }
            },
            RefEntityID = 15
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.5
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 2.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -300}
                }
              },
              [3] = {
                Position = {0, -300},
                Scaling = 0.5,
                Time = 1.7
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Position = {-850, 0},
                Scaling = {1.5, 1.5},
                Time = 1.1
              }
            },
            RefEntityID = 9
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 11,
                Time = 1.7
              }
            },
            RefEntityID = 10
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 1.1
              }
            },
            RefEntityID = 6
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                Time = 1.1
              }
            },
            RefEntityID = 4
          },
          [12] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 21,
                MeshMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Path"
                  },
                  [2] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_NormalScale"
                  }
                },
                Time = 2.3
              }
            },
            RefEntityID = 16
          },
          [13] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.5}
            },
            RefEntityID = 19
          },
          [14] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.3}
            },
            RefEntityID = 20
          },
          [15] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          },
          [16] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          },
          [17] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 1},
              [3] = {PlaySound = "Once", Time = 1.6},
              [4] = {PlaySound = "Once", Time = 2.4}
            },
            RefEntityID = 23
          },
          [18] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.5}
            },
            RefEntityID = 26
          },
          [19] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              },
              [2] = {ShowContent = 0.02, Time = 1.9}
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.4
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 12
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 15
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 16
          },
          [11] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 17
          },
          [12] = {
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
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_5_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_6_dialog_content",
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
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.1, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
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
                Layer = 8,
                LoopAnimation = "Story_sad",
                Position = {0, -300},
                Scaling = {0.9, 0.9},
                Time = 0.3
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 1,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
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
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 18, Time = 0}
            }
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_8_dialog_content",
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
            RefEntityID = 8
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50020100_9_dialog_content",
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
            DialogContentStr = "ui_story_5001_50020100_10_dialog_content",
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
                Content = "ui_story_5001_50020100_11_option_content",
                NextParagraphID = 2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
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
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.3
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 49,
                Time = 4
              },
              [2] = {Active = true, Time = 5.5},
              [3] = {
                Active = true,
                Alpha = 1,
                Layer = 49,
                Time = 2.2
              }
            },
            RefEntityID = 2
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 3,
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
