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
      Name = "巨像维修区",
      Resource = "StoryBGkonggujuxiangweixiuqu.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "暗鬼大兵1",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "暗鬼大兵2",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "暗鬼大兵3",
      Resource = "angui_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "巨大消散特效2",
      Resource = "uieff_hailongge_spine_dissolve.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "空谷地下通道",
      Resource = "StoryBGkonggudixiatongdao.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "吞罗",
      Resource = "tunluo_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      Name = "暗鬼小兵",
      Resource = "rishixiaobing_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "尘土抖落",
      Resource = "uieff_Story_Dust2.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 13,
      Name = "巴顿",
      Resource = "badun_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "大消散音效",
      Resource = "10201",
      Type = "Sound"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [16] = {
      EntityID = 17,
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [17] = {
      EntityID = 20,
      Name = "土石崩塌",
      Resource = "10174",
      Type = "Sound"
    },
    [18] = {
      EntityID = 21,
      Name = "利刃打击",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [19] = {
      EntityID = 23,
      FitSize = false,
      Name = "利刃攻击",
      Resource = "10068",
      Type = "Sound"
    },
    [20] = {
      EntityID = 24,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [21] = {
      EntityID = 25,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [22] = {
      EntityID = 26,
      FitSize = false,
      Name = "阴间特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [23] = {
      EntityID = 27,
      FitSize = false,
      Name = "风船BGM",
      Resource = "27",
      Type = "Sound"
    }
  },
  ID = 10120202,
  Name = "mainline_story_second_12_2_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3
              },
              [2] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 3.2
              }
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
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
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
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 1,
                Layer = 8,
                Position = {0, -250},
                Scaling = {0.45, 0.45},
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.8
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.7,
                Layer = 7,
                Position = {-500, -250},
                Scaling = {0.4, 0.4},
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.1
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.7,
                Layer = 7,
                Position = {500, -250},
                Scaling = {0.4, 0.4},
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.4
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Scaling = {1.2, 1.2},
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 14
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [10] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1.5,
                  Strength = {80, 80},
                  Vibrato = 80,
                  fadeOut = true
                },
                Time = 1
              }
            }
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 1.1
              }
            },
            RefEntityID = 25
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_2_dialog_content",
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
                StartBgm = 27,
                Time = 0
              }
            }
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
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
                  Duration = 0.5,
                  EndValue = {0, -200},
                  StartValue = {200, -200}
                }
              }
            },
            RefEntityID = 8
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_4_dialog_content",
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
          }
        },
        [5] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_5_dialog_content",
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
          }
        },
        [6] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_6_dialog_content",
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
        [7] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_7_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_8_dialog_content",
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
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [9] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_9_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.5
              },
              [2] = {ShowContent = 0.02, Time = 2.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
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
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Scale = {
                  Duration = 2,
                  EndValue = {0.5, 0.5},
                  StartValue = {0.45, 0.45}
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -250},
                  StartValue = {0, -300}
                }
              },
              [2] = {
                Active = true,
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -300},
                  StartValue = {0, -250}
                }
              },
              [3] = {
                Active = true,
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -250},
                  StartValue = {0, -300}
                }
              },
              [4] = {
                Active = true,
                Time = 2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -300},
                  StartValue = {0, -250}
                }
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 8
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
                Time = 2.5
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5},
              [2] = {PlaySound = "Once", Time = 2.5}
            },
            RefEntityID = 17
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 0.5,
                Layer = 5,
                Time = 0.6
              }
            },
            RefEntityID = 26
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 16,
                Time = 0.5
              }
            }
          }
        },
        [11] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [12] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [13] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [14] = {
          [1] = {
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
            RefEntityID = 10
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [15] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.2
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
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
                Time = 1
              }
            },
            RefEntityID = 10
          }
        },
        [16] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_15_dialog_content",
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
                Scaling = {0.3, 0.3},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -250},
                  StartValue = {600, -250}
                }
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -300},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 10
          }
        },
        [17] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
          }
        },
        [18] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
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
            RefEntityID = 10
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
        [19] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [20] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [21] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tunluo"
          }
        },
        [22] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_21_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
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
            RefEntityID = 10
          }
        },
        [23] = {
          [1] = {
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
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 8,
                LoopAnimation = "Story_impatient",
                Scaling = {1.3, 1.3},
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -650},
                  StartValue = {200, -650}
                }
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [6] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [24] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [25] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              },
              [2] = {Active = false, Time = 0.4},
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -650},
                  StartValue = {400, -650}
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
                Time = 0.2
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 8,
                Position = {0, -250},
                Time = 0.4
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -250},
                  StartValue = {0, -250}
                }
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Position = {0, 0},
                Scaling = {-1.2, 1.2},
                Time = 0.8
              }
            },
            RefEntityID = 21
          },
          [6] = {
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
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.2
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 23
          }
        },
        [26] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_impatient",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -650},
                  StartValue = {200, -650}
                }
              }
            },
            RefEntityID = 13
          }
        },
        [27] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [28] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_1012_10120202_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Scale = {
                  Duration = 1,
                  EndValue = {1.45, 1.45},
                  StartValue = {1.3, 1.3}
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -600},
                  StartValue = {0, -650}
                }
              },
              [2] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -750},
                  StartValue = {0, -600}
                }
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 24
          }
        },
        [29] = {
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
