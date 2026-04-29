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
      Name = "红油扳手营地",
      Resource = "StoryBGrediesel.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "比比比约恩立绘",
      Resource = "baozhakuang_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "小不点",
      Resource = "1400081_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "醒山",
      Resource = "xingshanjuqing_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "青瞳",
      Resource = "qingtong_n15_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      Name = "红油帮众立绘",
      Resource = "hongyoushibing_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "红油小兵2",
      Resource = "hongyoushibing2_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "人群立绘",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [13] = {
      Effect = "EMI",
      EntityID = 13,
      FitSize = false,
      Name = "狡木edge",
      Resource = "1300531_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "泽塔Edge",
      Resource = "zeta_n15_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "库玛edge",
      Resource = "1600041_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "卡夫卡edge",
      Resource = "1400161_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "弗劳尔edge",
      Resource = "fulaoer_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [18] = {
      Effect = "EMI",
      EntityID = 18,
      FitSize = false,
      Name = "欧缇edge",
      Resource = "1500751_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "日常BGM",
      Resource = "17",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "衣服摩擦",
      Resource = "10057",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "连接",
      Resource = "10078",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "电磁",
      Resource = "10039",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    }
  },
  ID = 50220802,
  Name = "event_story_N15shijiejintou_8_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.6
              },
              [2] = {ShowContent = 0.02, Time = 3.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bbb"
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
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
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
          [5] = {
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
                Time = 1.7,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -420},
                  StartValue = {-300, -420}
                }
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 7,
                LoopAnimation = "Story_serious",
                Scaling = {0.5, 0.5},
                Time = 1.9,
                Translate = {
                  Duration = 1,
                  EndValue = {450, -500},
                  StartValue = {200, -500}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 3.6
              }
            },
            RefEntityID = 6
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
                Layer = 6,
                Scaling = {0.9, 0.9},
                Time = 2.1,
                Translate = {
                  Duration = 1,
                  EndValue = {-350, -310},
                  StartValue = {-550, -310}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 3.5
              }
            },
            RefEntityID = 7
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 19,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
                LoopAnimation = "Story_happy",
                Scaling = {0.45, 0.45},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {450, -320},
                  StartValue = {750, -320}
                }
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
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
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.96,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
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
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 7,
                Position = {-450, -350},
                Scaling = {0.45, 0.45},
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 7,
                Position = {-450, -400},
                Scaling = {0.45, 0.45},
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.94,
                  StartValue = 0.96
                },
                Time = 0
              }
            }
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -290},
                  StartValue = {450, -320}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -290},
                  StartValue = {450, -320}
                }
              },
              [3] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -320},
                  StartValue = {450, -290}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -320},
                  StartValue = {450, -290}
                }
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
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
                Brightness = 0.5,
                Layer = 8,
                Position = {-450, -200},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.92,
                  StartValue = 0.94
                },
                Time = 0
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 20
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hongyoubangzhong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -170},
                  StartValue = {-450, -200}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -200},
                  StartValue = {-450, -170}
                }
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-750, -200},
                  StartValue = {-450, -200}
                }
              }
            },
            RefEntityID = 10
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
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
                LoopAnimation = "Story_norm",
                Position = {-450, -500},
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.92
                },
                Time = 0
              }
            }
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
            RefEntityID = 6
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
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
                LoopAnimation = "Story_excited",
                Time = 0
              }
            },
            RefEntityID = 6
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
              },
              [2] = {LoopAnimation = "Story_norm", Time = 0.2}
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_9X1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xingshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_pain",
                Shake = {
                  Duration = 1,
                  Strength = {30, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {250, -320},
                  StartValue = {450, -320}
                }
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 21
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
            RefEntityID = 6
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
            RefEntityID = 5
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -320},
                  StartValue = {250, -320}
                }
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
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
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_13_dialog_content",
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
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_14_dialog_content",
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
            DialogContentStr = "ui_story_5022_50220802_14X1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.5, 0.5},
                  StartValue = {0.45, 0.45}
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 20},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0.5
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.45, 0.45},
                  StartValue = {0.5, 0.5}
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_16_dialog_content",
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
            RefEntityID = 5
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {
                ShowContent = 0.02,
                Time = 0.2,
                TypeTimeList = {
                  0.02,
                  0,
                  0
                }
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
            RefEntityID = 5
          }
        },
        [21] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.5, 0.5},
                  StartValue = {0.45, 0.45}
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [2] = {
            DialogContentStr = "ui_story_5022_50220802_S18_dialog_content",
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
            DialogContentStr = "ui_story_5022_50220802_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
            RefEntityID = 5
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_21_dialog_content",
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
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
            RefEntityID = 5
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_23_dialog_content",
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
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
            RefEntityID = 5
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_25_dialog_content",
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
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xiaobudian"
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
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Time = 0.3
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 15,
                LoopAnimation = "Story_happy",
                Scaling = {1, 1},
                Scroll = {
                  Duration = 0.5,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SliceHeightScale = 1.5,
                SliceWidthScale = 1.5,
                SpineOffset = {50, -350},
                Time = 0.4
              }
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
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
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 22
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_joke", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_29_dialog_content",
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
            RefEntityID = 13
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
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
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 14,
                Position = {-500, 0},
                Scaling = {1, 1},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "RightToLeft"
                },
                SpineOffset = {0, -400},
                Time = 0.2
              }
            },
            RefEntityID = 14
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "LeftToRight"
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 15,
                Position = {441.32, 0},
                Scaling = {1.2, 1.2},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "LeftToRight"
                },
                SliceWidthScale = 0.75,
                SpineOffset = {75, -400},
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 14,
                LoopAnimation = "Story_serious",
                Position = {750, 0},
                Scaling = {0.8, 0.8},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "LeftToRight"
                },
                SliceWidthScale = 0.75,
                SpineOffset = {0, -400},
                Time = 0.4
              }
            },
            RefEntityID = 16
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "RightToLeft"
                },
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "RightToLeft"
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 15,
                LoopAnimation = "Story_smile",
                Position = {-486, 0},
                Scaling = {1.3, 1.3},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "RightToLeft"
                },
                SpineOffset = {0, -550},
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "LeftToRight"
                },
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_37_dialog_content",
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
            RefEntityID = 13
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
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
            RefEntityID = 13
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_40_dialog_content",
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
            RefEntityID = 13
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
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
              },
              [2] = {
                LoopAnimation = "Story_surprise",
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {},
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 11
          },
          [5] = {
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
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiaomu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                SliceWidthScaleAnim = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1.5
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, 0},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 15,
                LoopAnimation = "Story_angry",
                Position = {-200, 0},
                Scaling = {1.65, 1.65},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {15, -400},
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_outi"
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
            RefEntityID = 18
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
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 24,
                Time = 0
              }
            }
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_outi"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5022_50220802_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_outi"
          }
        },
        [49] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.2
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
                Time = 0.2
              }
            }
          }
        }
      }
    }
  },
  StartParagraph = 1
}
