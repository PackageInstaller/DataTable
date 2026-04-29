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
      Name = "领域背景图2",
      Resource = "storybglingyu2_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "皇后",
      Resource = "huanghou_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      Name = "黑幕22",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      Name = "黑幕23",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      Name = "国王",
      Resource = "guowang_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      Name = "暗能释放",
      Resource = "uieff_shumoer_spine_idle.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "烟雾",
      Resource = "uieff_posuibaiye.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "紫红色闪光国王特效",
      Resource = "uieff_Story_Shock.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "BGM",
      Resource = "19",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "爆炸",
      Resource = "10049",
      Type = "Sound"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "暗能1",
      Resource = "10088",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "暗能2",
      Resource = "10088",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "钝击",
      Resource = "10073",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "锐气",
      Resource = "10076",
      Type = "Sound"
    }
  },
  ID = 50043301,
  Name = "event_story_xiahuo2021_1_33_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {40, 40},
                  Vibrato = 20
                },
                Time = 0
              }
            }
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 13,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Position = {-2500, 0},
                Time = 0
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 4,
                  EndValue = {-4000, 0},
                  StartValue = {-2500, 0}
                }
              }
            },
            RefEntityID = 5
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 52,
                Position = {2500, 0},
                Time = 0
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 4,
                  EndValue = {4000, 0},
                  StartValue = {2500, 0}
                }
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 60,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
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
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                StopShake = {Duration = 6, FadeOut = true},
                Time = 0.1
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -200},
                Scaling = {0.8, 0.8},
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_unhappy",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1
              }
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
                Brightness = 0.2,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 7,
                Position = {0, 100},
                Scale = {
                  Duration = 1.5,
                  EndValue = {0.7, 0.7},
                  StartValue = {0.65, 0.65}
                },
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 60,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Scaling = {1.1, 1.1},
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 14
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.1, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijingjunwang"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling = {2, 2},
                Time = 1
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 15
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          },
          [2] = {
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
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                LoopAnimation = "Story_norm",
                Time = 0.5
              }
            },
            RefEntityID = 4
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.5
              }
            }
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
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
                Scaling = {0.6, 0.6},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -200},
                  StartValue = {-750, -200}
                }
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {450, -200},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 60,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 80
                },
                Time = 0.2
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 18
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 17
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_fury", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {60, 0},
                  Vibrato = 60
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50043301_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaluolin"
          },
          [2] = {
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
                  EndValue = {300, 75},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [17] = {
          [1] = {
            KeyFrames = {
              [1] = {
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
