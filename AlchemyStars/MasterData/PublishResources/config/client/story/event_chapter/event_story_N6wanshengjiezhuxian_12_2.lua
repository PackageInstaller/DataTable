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
      FitSize = true,
      Name = "空谷昏暗背景",
      Resource = "StoryBGkongguyewan.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "彼亚塔曼替代",
      Resource = "weien_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = true,
      Name = "白夜城背景",
      Resource = "StoryBGshangcheng.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "修女立绘替代",
      Resource = "xiunv_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "裂屏特效",
      Resource = "uieff_suiping.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "反色特效",
      Resource = "uieff_Story_AntiDeColor.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "普律玛替代",
      Resource = "pulvma_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "伊伦汀",
      Resource = "1600891_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "黑白特效",
      Resource = "UIeff_bahamosi_02.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "奥托立绘",
      Resource = "aotuo1_spine_idle.prefab",
      Type = "Spine"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "索尔拉德立绘",
      Resource = "1600141_spine_idle.prefab",
      Type = "Spine"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "神秘营地背景",
      Resource = "StoryBGshenmiyingdi.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "灰尘特效",
      Resource = "uieff_Story_Dust.prefab",
      Type = "Effect"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "塌陷声音",
      Resource = "10024",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "震动声音",
      Resource = "10015",
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
      Name = "打碎玻璃",
      Resource = "10086",
      Type = "Sound"
    }
  },
  ID = 50091202,
  Name = "event_story_N6wanshengjiezhuxian_12_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 1
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
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.4
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 9,
                Position = {-400, -200},
                Scaling = {0.6, 0.6},
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
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 8,
                Position = {400, -350},
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 22,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
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
                Layer = 7,
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_3_dialog_content",
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
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_4_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_sigh",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
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
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Brightness = 0,
                Layer = 21,
                Position = {0, -350},
                Time = 0.2
              }
            },
            RefEntityID = 8
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                MeshMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Path"
                  },
                  [2] = {
                    Duration = 0.2,
                    StartValue = 0.4,
                    Var = "_NormalScale"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 41,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
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
              [1] = {
                Active = true,
                Layer = 40,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Decolor"
                  },
                  [2] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 1,
                    Var = "_AntiColor"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          },
          [7] = {
            KeyFrames = {
              [1] = {Brightness = 1, Time = 0.1}
            },
            RefEntityID = 8
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                MeshMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Path"
                  },
                  [2] = {
                    Duration = 1,
                    EndValue = 0.45,
                    StartValue = 0.4,
                    Var = "_NormalScale"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 9
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
                Layer = 45,
                Position = {0, -350},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0.6,
                  StartValue = 0
                },
                Layer = 41,
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
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
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 12
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
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 6
          },
          [9] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 9,
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [10] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 8,
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [11] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 13
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -200},
                  StartValue = {-400, -200}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {600, -350},
                  StartValue = {400, -350}
                }
              }
            },
            RefEntityID = 5
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
                Layer = 10,
                LoopAnimation = "Story_serious",
                Position = {-600, -400},
                Scaling = {0.42, 0.42},
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
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
                Layer = 11,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_13_dialog_content",
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
            RefEntityID = 5
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_14_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_15_dialog_content",
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
            DialogContentStr = "ui_story_5009_50091202_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_17_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 13,
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
                Layer = 7,
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_18_dialog_content",
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_19_dialog_content",
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
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_20_dialog_content",
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
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_21_dialog_content",
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
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 11,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Layer = 8, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 40,
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 4
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.8,
                  StartValue = 0.95
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-300, 0},
                  StartValue = {0, 0}
                }
              }
            }
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
                Time = 0
              }
            },
            RefEntityID = 4
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
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 4.1
              },
              [2] = {ShowContent = 0.02, Time = 4.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 4,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Time = 0,
                Translate = {
                  Duration = 4,
                  EndValue = {-200, 0},
                  StartValue = {-300, 0}
                }
              },
              [2] = {
                Time = 3.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, 0},
                  StartValue = {-200, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 3.8
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
                Layer = 20,
                Position = {0, -300},
                Scaling = {2.1, 2.1},
                Time = 1.1
              },
              [2] = {
                Active = true,
                Layer = 0,
                Time = 0
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.6
              }
            },
            RefEntityID = 15
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 38,
                Time = 1
              },
              [2] = {Active = false, Time = 3.6}
            },
            RefEntityID = 16
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 39,
                Time = 1
              },
              [2] = {Active = false, Time = 3.6}
            },
            RefEntityID = 17
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
                Layer = 21,
                Position = {0, -850},
                Scaling = {2, 2},
                Time = 1.8
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.3
              }
            },
            RefEntityID = 18
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
                Layer = 22,
                Position = {0, -1300},
                Time = 2.6
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3.1
              }
            },
            RefEntityID = 19
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
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 9,
                Position = {300, -200},
                Time = 3.8
              }
            },
            RefEntityID = 4
          },
          [10] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 7,
                Time = 3.8
              }
            },
            RefEntityID = 14
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.1
              },
              [2] = {ShowContent = 0.02, Time = 2.4}
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
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.62, 0.62},
                  StartValue = {0.6, 0.6}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {300, -210},
                  StartValue = {300, -200}
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
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0.3,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -400},
                  StartValue = {-600, -400}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.44, 0.44},
                  StartValue = {0.42, 0.42}
                },
                Time = 0.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -420},
                  StartValue = {-400, -400}
                }
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.2
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.8
              }
            },
            RefEntityID = 2
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 2.2,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 0},
                  StartValue = {0, 20}
                }
              },
              [3] = {
                Time = 2.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 2.8,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 0},
                  StartValue = {0, 20}
                }
              },
              [5] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 1.7
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.2,
                  EndValue = {1.1, 1.1},
                  StartValue = {1, 1}
                },
                Time = 1.9
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Scale = {
                  Duration = 1.2,
                  EndValue = {1.1, 1.1},
                  StartValue = {1, 1}
                },
                Time = 1.9
              }
            },
            RefEntityID = 20
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.2},
              [2] = {PlaySound = "Once", Time = 2.8}
            },
            RefEntityID = 23
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_26_dialog_content",
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
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Position = {50, -400},
                Scaling = {0.42, 0.42},
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_28_dialog_content",
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
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {40, 40},
                  Vibrato = 2
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
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
            RefEntityID = 14
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-350, -400},
                  StartValue = {50, -400}
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
                  EndValue = 1,
                  StartValue = 0
                },
                LoopAnimation = "Story_angry",
                Position = {450, -350},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {20, 20},
                  Vibrato = 10
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.6
              },
              [2] = {ShowContent = 0.02, Time = 2.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 2, FadeOut = true},
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 2
              },
              [3] = {
                StopShake = {Duration = 2, FadeOut = false},
                Time = 2.3
              }
            }
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
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 2.6
              }
            },
            RefEntityID = 14
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
                Layer = 6,
                Time = 0
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
            RefEntityID = 21
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_32_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {50, -400},
                  StartValue = {-350, -400}
                }
              }
            },
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {550, -350},
                  StartValue = {450, -350}
                }
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 15,
                Position = {-500, -200},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Layer = 7,
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
            RefEntityID = 14
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Shake = {
                  Duration = 0.2,
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
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 26
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_34_dialog_content",
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
            RefEntityID = 14
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_biyataman"
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
            RefEntityID = 5
          },
          [3] = {
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
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_36_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5009_50091202_37_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [38] = {
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
