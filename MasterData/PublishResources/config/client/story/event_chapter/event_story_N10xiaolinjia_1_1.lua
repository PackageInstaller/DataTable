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
      Name = "北境室外荒野雪",
      Resource = "StoryBGbeijinghuangyexue.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "沙滩日",
      Resource = "StoryBGshatanri.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = true,
      Name = "影镇室外背景",
      Resource = "StoryBGyingzhenjiedao.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = true,
      Name = "假日咖啡馆背景",
      Resource = "StoryJiari.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = true,
      Name = "沙漠背景",
      Resource = "StoryBGhongyoushamo.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "传送门特效",
      Resource = "uieff_Story_Trans.prefab",
      Type = "Effect"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "过曝特效",
      Resource = "uieff_Story_Light.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      Name = "托尔",
      Resource = "1601331_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "康纳",
      Resource = "1601341_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      Name = "艾露玛",
      Resource = "1501351_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "影镇居民女",
      Resource = "yingzhennv_spine_idle.prefab",
      Type = "Spine"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "露科亚",
      Resource = "1501361_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "人群立绘",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "人群立绘2",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "法夫纳",
      Resource = "1401371_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 18,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "沙尘暴特效",
      Resource = "uieff_Story_SandStorm.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "下雪特效",
      Resource = "uieff_cg_snow.prefab",
      Type = "Effect"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "风声",
      Resource = "10042",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "海浪声",
      Resource = "10113",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "海鸥叫声",
      Resource = "10114",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "人群嘈杂声",
      Resource = "10156",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      Name = "脚步声音效",
      Resource = "10082",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "脚步声2",
      Resource = "10083",
      Type = "Sound"
    },
    [29] = {
      EntityID = 29,
      FitSize = false,
      Name = "魔法音效",
      Resource = "10037",
      Type = "Sound"
    }
  },
  ID = 50130101,
  Name = "event_story_N10xiaolinjia_1_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
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
              [1] = {Scaling = 0.7, Time = 0}
            }
          },
          [4] = {
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
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 5.5
              },
              [2] = {ShowContent = 0.02, Time = 5.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Time = 0.3
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 4.4
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 55,
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
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
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 3,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0.3
              }
            }
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
                Layer = 60,
                Scale = {
                  Duration = 1.2,
                  EndValue = {1.1, 1.1},
                  StartValue = {1, 1}
                },
                Time = 3.7,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 4,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              },
              [3] = {
                Time = 4.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [4] = {
                Time = 4.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              },
              [5] = {
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 5.5
              },
              [6] = {
                Active = true,
                Alpha = 0,
                Layer = 60,
                Time = 1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              }
            },
            RefEntityID = 10
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.3
              }
            },
            RefEntityID = 20
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 21, Time = 0.5}
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.3}
            },
            RefEntityID = 23
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 29
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_why", Time = 0}
            },
            RefEntityID = 10
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.8
              },
              [2] = {ShowContent = 0.02, Time = 3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kangna"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.6
              }
            },
            RefEntityID = 4
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.8,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
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
                LoopAnimation = "Story_why",
                Scaling = {0.7, 0.7},
                Time = 1.6,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -175},
                  StartValue = {-200, -175}
                }
              },
              [2] = {
                Active = true,
                Alpha = 0,
                Layer = 8,
                LoopAnimation = "Story_why",
                Scaling = {0.7, 0.7},
                Time = 0.5
              }
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 20
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 24
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 25
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kangna"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kangna"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_sorry",
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.1, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kangna"
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
              [1] = {LoopAnimation = "Story_norm", Time = 0.7}
            },
            RefEntityID = 11
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kangna"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.1
              },
              [2] = {ShowContent = 0.02, Time = 2.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailuma"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 2,
                Time = 0.6
              }
            },
            RefEntityID = 4
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.8,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              },
              [3] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 1.7
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.6
              }
            },
            RefEntityID = 5
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
                LoopAnimation = "Story_anger",
                Position = {0, -300},
                Scaling = {1, 1},
                Time = 1.7
              },
              [2] = {
                Active = true,
                Alpha = 0,
                Layer = 8,
                LoopAnimation = "Story_anger",
                Position = {0, -300},
                Scaling = {1, 1},
                Time = 1
              }
            },
            RefEntityID = 12
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailuma"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 20},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailuma"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailuma"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_how",
                Shake = {
                  Duration = 1,
                  Strength = {60, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_luren"
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
                Position = {450, -350},
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-450, -300},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 12
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ailuma"
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
                LoopAnimation = "Story_shy",
                Time = 0
              }
            },
            RefEntityID = 12
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.1
              },
              [2] = {ShowContent = 0.02, Time = 3.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lukeya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 2
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
              },
              [2] = {
                Scaling = 0.9,
                Time = 0.8,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {-50, 0}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 2,
                Time = 0.6
              }
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 13
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_think",
                Scaling = {0.9, 0.9},
                Time = 2.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-300, -260},
                  StartValue = {-400, -310}
                }
              },
              [2] = {
                Time = 2.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -310},
                  StartValue = {-300, -260}
                }
              },
              [3] = {
                Time = 2.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, -260},
                  StartValue = {-200, -310}
                }
              },
              [4] = {
                Time = 2.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -310},
                  StartValue = {-100, -260}
                }
              },
              [5] = {
                Active = true,
                Alpha = 0,
                Layer = 8,
                LoopAnimation = "Story_think",
                Scaling = {0.9, 0.9},
                Time = 0.9
              }
            },
            RefEntityID = 14
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Scaling = {0.6, 0.6},
                Time = 0.8,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-500, -150},
                  StartValue = {-600, -200}
                }
              },
              [2] = {
                Time = 1.1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-400, -200},
                  StartValue = {-500, -150}
                }
              },
              [3] = {
                Time = 1.4,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-300, -150},
                  StartValue = {-400, -200}
                }
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.7,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-200, -200},
                  StartValue = {-300, -150}
                }
              }
            },
            RefEntityID = 15
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
                Layer = 8,
                Scaling = {0.6, 0.6},
                Time = 1.2,
                Translate = {
                  Duration = 0.3,
                  EndValue = {300, -150},
                  StartValue = {200, -200}
                }
              },
              [2] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {400, -200},
                  StartValue = {300, -150}
                }
              },
              [3] = {
                Time = 1.8,
                Translate = {
                  Duration = 0.3,
                  EndValue = {500, -150},
                  StartValue = {400, -200}
                }
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {600, -200},
                  StartValue = {500, -150}
                }
              }
            },
            RefEntityID = 16
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8}
            },
            RefEntityID = 26
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lukeya"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lukeya"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lukeya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lukeya"
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fafuna"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.9
              }
            },
            RefEntityID = 2
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
              },
              [2] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.7
                },
                Time = 0.9
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 2,
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Position = {280, -210},
                Scaling = {0.95, 0.95},
                Time = 0.8
              }
            },
            RefEntityID = 17
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.7
              }
            },
            RefEntityID = 7
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.7
              }
            },
            RefEntityID = 19
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fafuna"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fafuna"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {30, 30},
                  Vibrato = 30,
                  fadeOut = false
                },
                Time = 0
              }
            }
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
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
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 2
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
                Time = 0.8
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 17
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                LoopAnimation = "Story_why",
                Time = 0.6
              }
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 3
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 19
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.6
              }
            },
            RefEntityID = 20
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_ze", Time = 0}
            },
            RefEntityID = 10
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              },
              [4] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 28
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 27
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5013_50130101_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tuoer"
          },
          [2] = {
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [34] = {
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
              [2] = {Active = true, Time = 2.7}
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
