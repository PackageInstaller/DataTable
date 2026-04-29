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
      Name = "莉莉卡",
      Resource = "1601721.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [6] = {
      EntityID = 6,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "轨道镜头1003",
      Resource = "vc_1027.prefab",
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
      Name = "关注点3",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [10] = {
      EntityID = 10,
      Name = "轨道镜头1002",
      Resource = "vc_1027.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "摄像机",
      Resource = "5273002.prefab",
      Type = "Model"
    },
    [12] = {
      EntityID = 12,
      Name = "背景板",
      Resource = "5273001.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 14,
      Name = "普律玛",
      Resource = "1601211.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [14] = {
      EntityID = 15,
      Name = "关注点4",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 16,
      Name = "轨道镜头1003",
      Resource = "vc_1025.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 17,
      Name = "莉莉卡2",
      Resource = "1601721.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [17] = {
      EntityID = 18,
      Name = "关注点5",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [18] = {
      EntityID = 20,
      Name = "轨道镜头1003",
      Resource = "vc_1027.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 21,
      Name = "定点镜头0003",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [20] = {
      EntityID = 22,
      Name = "关注点7",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [21] = {
      EntityID = 23,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [22] = {
      EntityID = 24,
      Name = "普律玛2",
      Resource = "1601211.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [23] = {
      EntityID = 25,
      Name = "波娜瑟",
      Resource = "1501131.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [24] = {
      EntityID = 26,
      Name = "定点镜头0003",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [25] = {
      EntityID = 27,
      Name = "高兴bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [26] = {
      EntityID = 28,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [27] = {
      EntityID = 29,
      FitSize = false,
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [28] = {
      EntityID = 30,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [29] = {
      EntityID = 31,
      FitSize = false,
      Name = "开心音效",
      Resource = "1717",
      Type = "Sound"
    }
  },
  ID = 90040501,
  Name = "home_story_N23paixi_5_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601721_think",
            DialogContentStr = "str_homestory_N23paixi_90040501_1_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 4,
                PlayAnimation = "angry",
                Position3D = {
                  7.3,
                  1.9,
                  51.1
                },
                Rotation3D = {
                  0,
                  -122,
                  0
                },
                Time = 0.4
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimator = "walk",
                Position3D = {
                  6.3,
                  1.9,
                  50.2
                },
                Rotation3D = {
                  0,
                  31,
                  0
                },
                Time = 0.4,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    6.36,
                    1.9,
                    50.26
                  },
                  StartValue = {
                    6,
                    1.9,
                    49.8
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  11,
                  2.04,
                  47.1
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  3.7,
                  3.7,
                  53.6
                },
                Time = 0.4
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
                StartBgm = 28,
                Time = 0.5
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1},
              [2] = {PlaySound = "Once", Time = 1.6}
            },
            RefEntityID = 29
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_2_dialog_content",
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
                  6,
                  2.5,
                  48
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
                  6.6,
                  2.9,
                  51.2
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
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_3_dialog_content",
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
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_4_dialog_content",
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
                FaceSeq = 5,
                PlayAnimator = "awkward",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601721_embarrass",
            DialogContentStr = "str_homestory_N23paixi_90040501_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  12,
                  1.9,
                  53
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                Position3D = {
                  4.5,
                  3.8,
                  52.1
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 10,
                  Style = 0
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_6_dialog_content",
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
                  2.04,
                  47.1
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                Position3D = {
                  3.7,
                  3.7,
                  53.6
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601721_think",
            DialogContentStr = "str_homestory_N23paixi_90040501_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 5,
                PlayAnimation = "sad",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601721_think",
            DialogContentStr = "str_homestory_N23paixi_90040501_8_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimator = "idle",
                Time = 0
              }
            },
            RefEntityID = 5
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
              [1] = {PlayAnimation = "stand", Time = 0.2}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  -1,
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
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  -1,
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
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Time = 0.2,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    -2.6,
                    -1,
                    94.2
                  },
                  StartValue = {
                    -2.6,
                    -1,
                    93
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 3.1}
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -6.25,
                  4.57,
                  110.72
                },
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Look = 15,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -3,
                  -0.1,
                  93.3
                },
                Time = 0.2
              }
            },
            RefEntityID = 16
          },
          [10] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 16,
                  Style = 0
                }
              }
            }
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -6.9,
                  -1,
                  92.9
                },
                Rotation3D = {
                  0,
                  69,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 17
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601721_sad",
            DialogContentStr = "str_homestory_N23paixi_90040501_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -6.9,
                  0,
                  92.9
                },
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 20,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 18,
                OpenPath = {
                  Duration = 2,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -2.8,
                  0.7,
                  95.5
                },
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601721_sad",
            DialogContentStr = "str_homestory_N23paixi_90040501_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Look = 22,
                Position3D = {
                  -5.7,
                  0,
                  93
                },
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -50,
                  -1,
                  89.48
                },
                Time = 0
              }
            },
            RefEntityID = 22
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
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601721_surprise",
            DialogContentStr = "str_homestory_N23paixi_90040501_11_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
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
              [1] = {Time = 0.2}
            },
            RefEntityID = 4
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              },
              [2] = {
                Time = 1.5,
                VC = {
                  Duration = 1,
                  EntityID = 23,
                  Style = 1
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                Position3D = {
                  3.7,
                  3.7,
                  53.6
                },
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 9,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -156,
                    0
                  },
                  StartValue = {
                    0,
                    -122,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 0.8},
              [3] = {Active = true, Time = 3}
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    168,
                    0
                  },
                  StartValue = {
                    0,
                    31,
                    0
                  }
                },
                Time = 0.4
              },
              [2] = {PlayAnimator = "idle", Time = 1.5}
            },
            RefEntityID = 5
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 22,
                Position3D = {
                  4.7,
                  3.8,
                  42.1
                },
                Time = 1.4
              }
            },
            RefEntityID = 23
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.35,
                  1.8,
                  25.71
                },
                Time = 1.4
              }
            },
            RefEntityID = 22
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  1.8,
                  28
                },
                Rotation3D = {
                  0,
                  -89,
                  0
                },
                Time = 0.3
              }
            },
            RefEntityID = 24
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.5,
                  1.8,
                  28
                },
                Rotation3D = {
                  0,
                  51,
                  0
                },
                Time = 0.3
              }
            },
            RefEntityID = 25
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_12_dialog_content",
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
                Look = 30,
                Position3D = {
                  -0.1,
                  3,
                  29.8
                },
                Time = 0
              }
            },
            RefEntityID = 26
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 26,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.3,
                  1.8,
                  25.7
                },
                Time = 0
              }
            },
            RefEntityID = 30
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040501_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "sad", Time = 0}
            },
            RefEntityID = 24
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  100,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_14_dialog_content",
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
                  6,
                  2.5,
                  48
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
                  6.6,
                  2.9,
                  51.2
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
                FaceSeq = 2,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    31,
                    0
                  },
                  StartValue = {
                    0,
                    100,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.4}
            },
            RefEntityID = 5
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601721_surprise",
            DialogContentStr = "str_homestory_N23paixi_90040501_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  12,
                  1.9,
                  53
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                Position3D = {
                  4.5,
                  3.8,
                  52.1
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 10,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -122,
                    0
                  },
                  StartValue = {
                    0,
                    -156,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_16_dialog_content",
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
                  2.04,
                  47.1
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  3.7,
                  3.7,
                  53.6
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
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              }
            },
            RefEntityID = 27
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Bubble = {
                  ID = 27,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 6,
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 31
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1601721_angry",
            DialogContentStr = "str_homestory_N23paixi_90040501_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 27
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1601721_angry",
            DialogContentStr = "str_homestory_N23paixi_90040501_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040501_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040501_20_dialog_content",
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
                PlayAnimator = "think",
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
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 5
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
