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
      Name = "庆典街",
      Resource = "StoryBGqingdianjie.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "梅尔特",
      Resource = "meierte_n20_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "萨布莉",
      Resource = "sabuli_n20_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "菲尔姆",
      Resource = "feiermu_n20_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 8,
      FitSize = false,
      Name = "脚步声3",
      Resource = "10082",
      Type = "Sound"
    },
    [8] = {
      EntityID = 9,
      FitSize = false,
      Name = "领域空间1",
      Resource = "StoryBGlingyu1.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 10,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 11,
      FitSize = false,
      Name = "划痕蒙版2",
      Resource = "uieff_ScratchPlot01.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 12,
      FitSize = false,
      Name = "皇后",
      Resource = "guaidan_huanghou_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 13,
      FitSize = false,
      Name = "菲雅",
      Resource = "feiya_n19_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 14,
      FitSize = false,
      Name = "人群立绘1",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 15,
      FitSize = false,
      Name = "人群立绘2",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "黑烟火星特效",
      Resource = "uieff_heiyanhuoxing.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "杂兵贴画1",
      Resource = "guaidan_za_spine_idle.prefab",
      Type = "Spine"
    },
    [17] = {
      EntityID = 18,
      FitSize = false,
      Name = "杂兵贴画2",
      Resource = "guaidan_za_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 19,
      FitSize = false,
      Name = "杂兵贴画3",
      Resource = "guaidan_za_spine_idle.prefab",
      Type = "Spine"
    },
    [19] = {
      EntityID = 21,
      FitSize = false,
      Name = "领域空间2",
      Resource = "StoryBGlingyu2.prefab",
      Type = "Picture"
    },
    [20] = {
      EntityID = 22,
      FitSize = false,
      Name = "膏状调料瓶",
      Resource = "gaozhuangtiaoliaoping.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 23,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [22] = {
      EntityID = 24,
      FitSize = false,
      Name = "单人闪光特效",
      Resource = "uieff_Story_Spark_Single.prefab",
      Type = "Effect"
    },
    [23] = {
      EntityID = 26,
      FitSize = false,
      Name = "蒸汽特效",
      Resource = "uieff_zhengqi.prefab",
      Type = "Effect"
    },
    [24] = {
      EntityID = 27,
      FitSize = false,
      Name = "氛围气泡特效",
      Resource = "uieff_Story_Romantic.prefab",
      Type = "Effect"
    },
    [25] = {
      EntityID = 28,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [26] = {
      EntityID = 29,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [27] = {
      EntityID = 30,
      Name = "阳光2",
      Resource = "10037",
      Type = "Sound"
    },
    [28] = {
      EntityID = 31,
      FitSize = false,
      Name = "蒸汽",
      Resource = "10119",
      Type = "Sound"
    },
    [29] = {
      EntityID = 32,
      Name = "人群隐约嘈杂",
      Resource = "10238",
      Type = "Sound"
    }
  },
  ID = 50300003,
  Name = "event_story_N20meishiche_3",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Scaling = {0.75, 0.75},
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -200},
                  StartValue = {200, -200}
                }
              }
            },
            RefEntityID = 5
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 28, Time = 0.5}
            }
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                LoopAnimation = "Story_shy",
                Scaling = {0.75, 0.75},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -200},
                  StartValue = {600, -200}
                }
              }
            },
            RefEntityID = 4
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
                  EndValue = {-400, -200},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
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
                Scaling = {0.75, 0.75},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {550, -200},
                  StartValue = {750, -200}
                }
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-550, -200},
                  StartValue = {-400, -200}
                }
              }
            },
            RefEntityID = 5
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
                  EndValue = {0, -200},
                  StartValue = {400, -200}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 6
          }
        },
        [7] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [8] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [9] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Shake = {
                  Duration = 0.5,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_10_dialog_content",
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
            RefEntityID = 4
          }
        },
        [11] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_11_dialog_content",
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
        [12] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_12_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_13_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [15] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
          }
        },
        [16] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
            RefEntityID = 6
          }
        },
        [17] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
          }
        },
        [18] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_18_dialog_content",
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
            RefEntityID = 5
          }
        },
        [19] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_19_dialog_content",
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
        [20] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_20_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_21_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
          }
        },
        [23] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [24] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_24_dialog_content",
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
            RefEntityID = 5
          }
        },
        [25] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
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
                LoopAnimation = "Story_happy",
                Shake = {
                  Duration = 1,
                  Strength = {0, 40},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [26] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
                LoopAnimation = "Story_norm",
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
            RefEntityID = 6
          }
        },
        [27] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_27_dialog_content",
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
            RefEntityID = 5
          }
        },
        [28] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
          }
        },
        [29] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
          }
        },
        [30] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                  Duration = 0.1,
                  EndValue = {0, -150},
                  StartValue = {0, -200}
                }
              },
              [2] = {
                Active = true,
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -150}
                }
              }
            },
            RefEntityID = 4
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
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 8
          }
        },
        [31] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 6
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
            RefEntityID = 4
          }
        },
        [32] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
            RefEntityID = 6
          }
        },
        [33] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
            RefEntityID = 4
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
            RefEntityID = 5
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
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [5] = {
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
          [6] = {
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
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_34_dialog_content",
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
            SpeakerNameStr = "ui_story_name_meierte"
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
                Time = 0.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 35,
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {Layer = 4, Time = 0}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 5
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 4
          },
          [10] = {
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
                LoopAnimation = "happy",
                Position = {0, -100},
                Scaling = {1, 1},
                Time = 1.1
              }
            },
            RefEntityID = 12
          },
          [11] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 29, Time = 0.1}
            }
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [37] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
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
                LoopAnimation = "doubt",
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [38] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "anger", Time = 0}
            },
            RefEntityID = 12
          }
        },
        [39] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          }
        },
        [40] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          }
        },
        [41] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "happy", Time = 0}
            },
            RefEntityID = 12
          }
        },
        [42] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          }
        },
        [43] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          }
        },
        [44] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          }
        },
        [45] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiahuanghou"
          }
        },
        [46] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                Scale = {
                  Duration = 1,
                  EndValue = {0.9, 0.9},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                Layer = 4,
                Time = 0.2
              }
            },
            RefEntityID = 16
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
                  Strength = {5, 5},
                  Vibrato = 1
                },
                Time = 0.2
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.2
              }
            },
            RefEntityID = 21
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                LoopAnimation = "soldier",
                Position = {0, -100},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 17
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
                Brightness = 0.7,
                Layer = 7,
                LoopAnimation = "soldier",
                Position = {500, -100},
                Scaling = {0.9, 0.9},
                Time = 0.5
              }
            },
            RefEntityID = 18
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
                Brightness = 0.7,
                Layer = 7,
                LoopAnimation = "soldier",
                Position = {-500, -100},
                Scaling = {0.9, 0.9},
                Time = 1
              }
            },
            RefEntityID = 19
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                Time = 0.5
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
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                Time = 0.1
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
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.1
              },
              [2] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                Time = 1
              }
            },
            RefEntityID = 17
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 19
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.3
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 5
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0.5
              }
            },
            RefEntityID = 4
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 6
          },
          [10] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 28, Time = 1}
            }
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                Layer = 31,
                Position = {0, 0},
                Scale = {
                  Duration = 1,
                  EndValue = {0.6, 0.6},
                  StartValue = {0.4, 0.4}
                },
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 35,
                Scaling = {1.2, 1.2},
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 30
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5030_50300003_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [59] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
                Time = 0.5
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
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.5, 0.5},
                  StartValue = {0.6, 0.6}
                },
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.5,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "AlphaValue"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 35,
                Scaling = {1.2, 1.2},
                Time = 0
              }
            },
            RefEntityID = 24
          }
        },
        [60] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
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
            RefEntityID = 6
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
            RefEntityID = 5
          }
        },
        [61] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_63_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
            RefEntityID = 6
          }
        },
        [62] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_64_dialog_content",
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
            RefEntityID = 5
          }
        },
        [63] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_65_dialog_content",
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
        [64] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_66_dialog_content",
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
        [65] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_66X_dialog_content",
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
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [66] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
          }
        },
        [67] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiermu"
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
            RefEntityID = 6
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
            RefEntityID = 5
          }
        },
        [68] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                LoopAnimation = "Story_nervous",
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 6
          }
        },
        [69] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [70] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_71_dialog_content",
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
            RefEntityID = 4
          }
        },
        [71] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_72_dialog_content",
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
        [72] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_73_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_74_dialog_content",
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Scaling = {0.5, 0.5},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 22
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.5,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [74] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_75_dialog_content",
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                EffectFullScreen = true,
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [75] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                LoopAnimation = "Story_smile",
                Time = 0.5,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -150},
                  StartValue = {0, -200}
                }
              },
              [2] = {
                Active = true,
                Time = 0.6,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -150}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -200},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 22
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.5,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "AlphaValue"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 27
          }
        },
        [76] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_77_dialog_content",
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
            RefEntityID = 4
          }
        },
        [77] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_78_dialog_content",
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
        [78] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_79_dialog_content",
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
        [79] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
                  EndValue = {550, -200},
                  StartValue = {750, -200}
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [80] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [81] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_82_dialog_content",
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
            RefEntityID = 13
          }
        },
        [82] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_83_dialog_content",
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
        [83] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
                LoopAnimation = "Story_shocked",
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [84] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [85] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [86] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {550, -150},
                  StartValue = {550, -200}
                }
              },
              [2] = {
                Active = true,
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {550, -200},
                  StartValue = {550, -150}
                }
              }
            },
            RefEntityID = 13
          }
        },
        [87] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
            RefEntityID = 13
          }
        },
        [88] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
            RefEntityID = 13
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
            RefEntityID = 5
          }
        },
        [89] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_90_dialog_content",
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
            RefEntityID = 13
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [90] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_91_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
                LoopAnimation = "Story_cry_surprise",
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [91] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sabuli"
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
            RefEntityID = 13
          }
        },
        [92] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [93] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {100, -200},
                  StartValue = {0, -200}
                }
              },
              [2] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -200},
                  StartValue = {100, -200}
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
                Scaling = {0.2, 0.2},
                Time = 0.2,
                Translate = {
                  Duration = 1,
                  EndValue = {300, 0},
                  StartValue = {100, 0}
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
            RefEntityID = 22
          }
        },
        [94] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [95] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
          }
        },
        [96] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
                LoopAnimation = "Story_happy",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {550, -150},
                  StartValue = {550, -200}
                }
              },
              [2] = {
                Active = true,
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {550, -200},
                  StartValue = {550, -150}
                }
              }
            },
            RefEntityID = 13
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
            RefEntityID = 4
          }
        },
        [97] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [98] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_99_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [99] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_100_dialog_content",
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
            RefEntityID = 13
          }
        },
        [100] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
                LoopAnimation = "Story_awkward",
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [101] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_102_dialog_content",
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
            RefEntityID = 13
          }
        },
        [102] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_meierte"
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
            RefEntityID = 4
          }
        },
        [103] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_104_dialog_content",
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
                Scaling = {0.5, 0.5},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -200},
                  StartValue = {0, 0}
                }
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
            RefEntityID = 22
          }
        },
        [104] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_105_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiguanqunzhong"
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
                Time = 1
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.3
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.2}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.2}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.2}
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                Position = {-500, -200},
                Scaling = {0.7, 0.7},
                Time = 1.2
              }
            },
            RefEntityID = 14
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 1,
                Layer = 8,
                Position = {500, -200},
                Scaling = {0.7, 0.7},
                Time = 1.2
              }
            },
            RefEntityID = 15
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 26
          },
          [9] = {
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
            RefEntityID = 27
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 30
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 31
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 32
          }
        },
        [105] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiguanqunzhong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [106] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5030_50300003_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_weiguanqunzhong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 15
          }
        },
        [107] = {
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
