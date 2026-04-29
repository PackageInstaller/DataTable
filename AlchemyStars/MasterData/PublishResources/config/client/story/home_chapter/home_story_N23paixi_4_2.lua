return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
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
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "塞提",
      Resource = "1401691.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [6] = {
      EntityID = 6,
      Name = "轨道镜头1",
      Resource = "vc_1027.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "轨道镜头2",
      Resource = "vc_1022.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 8,
      Name = "关注点1",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [9] = {
      EntityID = 9,
      Name = "摄像机",
      Resource = "5273002.prefab",
      Type = "Model"
    },
    [10] = {
      EntityID = 10,
      Name = "背景板",
      Resource = "5273001.prefab",
      Type = "Model"
    },
    [11] = {
      EntityID = 11,
      Name = "魔镜",
      Resource = "5273003.prefab",
      Type = "Model"
    },
    [12] = {
      EntityID = 13,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 14,
      Name = "轨道镜头3",
      Resource = "vc_1025.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 15,
      Name = "塞提2",
      Resource = "1401691.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [15] = {
      EntityID = 16,
      Name = "轨道镜头1004",
      Resource = "vc_1004.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 17,
      FitSize = true,
      Name = "浪漫背景图",
      Resource = "StoryBGlangman2.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 18,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 19,
      FitSize = false,
      Name = "粒子特效",
      Resource = "uieff_beijinggainian.prefab",
      Type = "Effect"
    },
    [19] = {
      EntityID = 20,
      FitSize = false,
      Name = "氛围特效",
      Resource = "uieff_Story_Romantic.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 21,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [21] = {
      EntityID = 22,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [22] = {
      EntityID = 23,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [23] = {
      EntityID = 24,
      Name = "定点镜头0003",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [24] = {
      EntityID = 25,
      FitSize = false,
      Name = "音效",
      Resource = "10083",
      Type = "Sound"
    },
    [25] = {
      EntityID = 26,
      FitSize = false,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [26] = {
      EntityID = 27,
      FitSize = false,
      Name = "魔法音效",
      Resource = "10313",
      Type = "Sound"
    },
    [27] = {
      EntityID = 28,
      FitSize = false,
      Name = "闪亮音效",
      Resource = "10037",
      Type = "Sound"
    },
    [28] = {
      EntityID = 29,
      FitSize = false,
      Name = "叹号",
      Resource = "1714",
      Type = "Sound"
    },
    [29] = {
      EntityID = 30,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [30] = {
      EntityID = 31,
      Name = "薇丝2",
      Resource = "1601221.prefab",
      SubType = "Pet",
      Type = "Model"
    }
  },
  ID = 90040402,
  Name = "home_story_N23paixi_4_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1401691_norm",
            DialogContentStr = "str_homestory_N23paixi_90040402_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_saiti"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 4,
                Position3D = {
                  -1.1,
                  1.8,
                  18
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    43.8,
                    0
                  },
                  StartValue = {
                    0,
                    43.8,
                    0
                  }
                },
                Time = 0.3
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
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
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.1,
                  2.5,
                  18
                },
                Time = 0.3
              }
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -1.9,
                  3.3,
                  20
                },
                Time = 0.3
              }
            },
            RefEntityID = 6
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 30,
                Time = 0.4
              }
            }
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1401691_norm",
            DialogContentStr = "str_homestory_N23paixi_90040402_2_dialog_content",
            DialogDir = 1,
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    69,
                    0
                  },
                  StartValue = {
                    0,
                    43.8,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.1,
                  1.7,
                  18
                },
                Rotation3D = {
                  0,
                  -87,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2},
              [2] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 25
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_3_dialog_content",
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
                Look = 8,
                Position3D = {
                  -0.5,
                  2.6,
                  20.7
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 7,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -6.2,
                  2.5,
                  13.56
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1401691_serious",
            DialogContentStr = "str_homestory_N23paixi_90040402_4_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
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
                Position3D = {
                  0,
                  0,
                  103.6
                },
                Rotation3D = {
                  0,
                  180,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  -0.3,
                  108.4
                },
                Rotation3D = {
                  0,
                  180,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  0.6,
                  108.6
                },
                Rotation3D = {
                  0,
                  180,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0,
                  1.7,
                  138.3
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 14,
                  Style = 0
                }
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Look = 13,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -1.5,
                  1.5,
                  104.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 14
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1401691_watchful",
            DialogContentStr = "str_homestory_N23paixi_90040402_5_dialog_content",
            DialogDir = 1,
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                PlayAnimation = "walk",
                Position3D = {
                  0,
                  0,
                  0
                },
                Rotation3D = {
                  0,
                  90,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0.13,
                    0.7,
                    103.8
                  },
                  StartValue = {
                    -0.48,
                    0.7,
                    103.8
                  }
                }
              },
              [2] = {
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    0,
                    0
                  },
                  StartValue = {
                    0,
                    90,
                    0
                  }
                },
                Time = 1
              },
              [3] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3},
              [2] = {PlaySound = "Once", Time = 0.9},
              [3] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 25
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1401691_serious",
            DialogContentStr = "str_homestory_N23paixi_90040402_6_dialog_content",
            DialogDir = 1,
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 13,
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Time = 0}
            }
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
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 18
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
                Layer = 25,
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 26
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 28
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1401691_shy",
            DialogContentStr = "str_homestory_N23paixi_90040402_7_dialog_content",
            DialogDir = 1,
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
            RefEntityID = 18
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Time = 0
              }
            },
            RefEntityID = 19
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 37,
                Time = 0
              }
            },
            RefEntityID = 20
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.1,
                  1.8,
                  18
                },
                Rotation3D = {
                  0,
                  77,
                  0
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
                Position3D = {
                  -1.1,
                  2.5,
                  18
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -1.9,
                  3.3,
                  20
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [9] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1401691_smile",
            DialogContentStr = "str_homestory_N23paixi_90040402_8_dialog_content",
            DialogDir = 1,
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.1,
                  1.8,
                  18.1
                },
                Rotation3D = {
                  0,
                  -104,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_9_dialog_content",
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
                Position3D = {
                  -0.74,
                  1.7,
                  15.07
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 8,
                Position3D = {
                  -0.4,
                  3,
                  20.5
                },
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 21,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlayAnimator = "talk", Time = 0}
            },
            RefEntityID = 3
          },
          [6] = {
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
            RefEntityID = 19
          },
          [7] = {
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
            RefEntityID = 20
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1401691_fear",
            DialogContentStr = "str_homestory_N23paixi_90040402_10_dialog_content",
            DialogDir = 1,
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
                Bubble = {
                  ID = 22,
                  Offset = {
                    -0.1,
                    0.1,
                    0
                  }
                },
                FaceSeq = 5,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              },
              [2] = {Active = false, Time = 1.9}
            },
            RefEntityID = 22
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 29
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_11_dialog_content",
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
              [1] = {PlayAnimator = "awkward", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
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
                Position3D = {
                  0,
                  0.5,
                  138.3
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 23,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 15
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Look = 13,
                Position3D = {
                  0,
                  1.3,
                  104.9
                },
                Time = 0.2
              }
            },
            RefEntityID = 23
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1401691_norm",
            DialogContentStr = "str_homestory_N23paixi_90040402_13_dialog_content",
            DialogDir = 1,
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
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_14_dialog_content",
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
                Active = true,
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
                Position3D = {
                  -0.74,
                  1.7,
                  15.07
                },
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 8,
                Position3D = {
                  -0.4,
                  3,
                  20.5
                },
                Time = 0.2
              }
            },
            RefEntityID = 21
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 21,
                  Style = 0
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0.2
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1401691_norm",
            DialogContentStr = "str_homestory_N23paixi_90040402_15_dialog_content",
            DialogDir = 1,
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
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_16_dialog_content",
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
                FaceSeq = 1,
                PlayAnimator = "idle",
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 31
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_17_dialog_content",
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
        [18] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_18_dialog_content",
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
              [1] = {PlayAnimator = "talk", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1401691_smile",
            DialogContentStr = "str_homestory_N23paixi_90040402_19_dialog_content",
            DialogDir = 1,
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
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1401691_surprise",
            DialogContentStr = "str_homestory_N23paixi_90040402_20_dialog_content",
            DialogDir = 1,
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.1,
                  2.5,
                  18
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                Position3D = {
                  -1.9,
                  3.3,
                  20
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 9,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 29
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1401691_serious",
            DialogContentStr = "str_homestory_N23paixi_90040402_21_dialog_content",
            DialogDir = 1,
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
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1401691_smile",
            DialogContentStr = "str_homestory_N23paixi_90040402_22_dialog_content",
            DialogDir = 1,
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -83,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040402_23_dialog_content",
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
                Position3D = {
                  11,
                  2.5,
                  12
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 8,
                Position3D = {
                  -1,
                  2.7,
                  18.5
                },
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 24,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
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
            KeyFrames = {
              [1] = {PlayAnimator = "idle", Time = 1}
            },
            RefEntityID = 3
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
