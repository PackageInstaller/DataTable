return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 3,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 4,
      Name = "莉莉卡",
      Resource = "1601721.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 5,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [5] = {
      EntityID = 6,
      Name = "米洛斯",
      Resource = "1601731.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [6] = {
      EntityID = 7,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 8,
      Name = "轨道镜头1003",
      Resource = "vc_1025.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 9,
      Name = "关注点4",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [9] = {
      EntityID = 10,
      Name = "轨道镜头1007",
      Resource = "vc_1027.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 11,
      Name = "关注点1",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [11] = {
      EntityID = 12,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 13,
      Name = "轨道相机1009",
      Resource = "vc_1027.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 14,
      Name = "关注点3",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 15,
      Name = "摄像机",
      Resource = "5273002.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 16,
      Name = "背景板",
      Resource = "5273001.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 17,
      Name = "魔镜",
      Resource = "5273003.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 18,
      Name = "丘布商人",
      Resource = "1021003.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [18] = {
      EntityID = 19,
      Name = "丘布长老",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [19] = {
      EntityID = 20,
      Name = "关注点5",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 21,
      Name = "轨道镜头1006",
      Resource = "vc_1025.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [21] = {
      EntityID = 22,
      Name = "轨道镜头1004",
      Resource = "vc_1028.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [22] = {
      EntityID = 23,
      Name = "关注点7",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [23] = {
      EntityID = 24,
      Name = "塞提",
      Resource = "1401691.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [24] = {
      EntityID = 25,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [25] = {
      EntityID = 26,
      Name = "轨道相机1001",
      Resource = "vc_1027.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [26] = {
      EntityID = 27,
      FitSize = false,
      Name = "丘布过场",
      Resource = "Uieff_zhuanchang.prefab",
      Type = "Effect"
    },
    [27] = {
      EntityID = 28,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [28] = {
      EntityID = 29,
      FitSize = true,
      Name = "阴云天空",
      Resource = "StoryBGyinyun.prefab",
      Type = "Picture"
    },
    [29] = {
      EntityID = 30,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [30] = {
      EntityID = 31,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [31] = {
      EntityID = 32,
      FitSize = false,
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [32] = {
      EntityID = 33,
      FitSize = false,
      Name = "问号",
      Resource = "1713",
      Type = "Sound"
    }
  },
  ID = 90040406,
  Name = "home_story_N23paixi_4_6",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601721_surprise",
            DialogContentStr = "str_homestory_N23paixi_90040406_1_dialog_content",
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "surprise",
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
            RefEntityID = 4
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
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    42.4,
                    0
                  },
                  StartValue = {
                    0,
                    42.4,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    6.3,
                    1.9,
                    50.2
                  },
                  StartValue = {
                    5.53,
                    1.9,
                    49.36
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  7.7,
                  0,
                  50.1
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  7.9,
                  1,
                  50.11
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  0.4,
                  8.2,
                  53.5
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 31,
                Time = 0.5
              }
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5},
              [2] = {PlaySound = "Once", Time = 1.1},
              [3] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 32
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_2_dialog_content",
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
                OpenPath = {
                  Duration = 1.5,
                  Ease = 3,
                  Position = 0
                },
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
              [1] = {Time = 0}
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  31,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 5
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040406_3_dialog_content",
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
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 11,
                Position3D = {
                  6.6,
                  2.9,
                  51.2
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 12,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1601721_think",
            DialogContentStr = "str_homestory_N23paixi_90040406_4_dialog_content",
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
                Look = 14,
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
            RefEntityID = 13
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 13,
                  Style = 0
                }
              }
            }
          },
          [4] = {
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
            RefEntityID = 14
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 9, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601721_angry",
            DialogContentStr = "str_homestory_N23paixi_90040406_5_dialog_content",
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
              [1] = {PlayAnimation = "angry", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040406_6_dialog_content",
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
                PlayAnimator = "awkward",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601721_surprise",
            DialogContentStr = "str_homestory_N23paixi_90040406_7_dialog_content",
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
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              }
            },
            RefEntityID = 30
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 30,
                  Offset = {
                    0.2,
                    0.15,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 33
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040406_8_dialog_content",
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
                FaceSeq = 5,
                PlayAnimator = "talk",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 30
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040406_9_dialog_content",
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
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_10_dialog_content",
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_11_dialog_content",
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
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1601721_cheerful",
            DialogContentStr = "str_homestory_N23paixi_90040406_12_dialog_content",
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
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040406_13_dialog_content",
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
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 11,
                Position3D = {
                  6.6,
                  2.9,
                  51.2
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 12,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlayAnimator = "happy", Time = 0}
            },
            RefEntityID = 5
          },
          [6] = {
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
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  -1.3,
                  108.4
                },
                Rotation3D = {
                  0,
                  180,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  -0.4,
                  108.6
                },
                Rotation3D = {
                  0,
                  180,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lilika"
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
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.6,
                  -1,
                  93.9
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.6,
                  -1.1,
                  94.2
                },
                Rotation3D = {
                  0,
                  98,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.3,
                  -1.1,
                  94.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 19
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0,
                  -0.4,
                  108.6
                },
                Time = 0.2
              }
            },
            RefEntityID = 20
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Look = 20,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -6.8,
                  0.7,
                  87.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 21
          },
          [8] = {
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
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601721_think",
            DialogContentStr = "str_homestory_N23paixi_90040406_15_dialog_content",
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
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    0,
                    0
                  },
                  StartValue = {
                    0,
                    98,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 18
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_16_dialog_content",
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
        [17] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_17_dialog_content",
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
                Look = 23,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -2,
                  0.9,
                  107.2
                },
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 22,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.5,
                  0.5,
                  108.6
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Position3D = {
                  -0.1,
                  0.7,
                  109
                },
                Rotation3D = {
                  0,
                  94,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    1.16,
                    -0.3,
                    109
                  },
                  StartValue = {
                    -0.1,
                    -0.3,
                    109
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.5},
              [3] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    180,
                    0
                  },
                  StartValue = {
                    0,
                    94,
                    0
                  }
                },
                Time = 1.9
              },
              [4] = {PlayAnimation = "stand", Time = 2.7}
            },
            RefEntityID = 24
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4},
              [2] = {PlaySound = "Once", Time = 0.9},
              [3] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 32
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_18_dialog_content",
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
                  0.5,
                  -0.3,
                  93.9
                },
                Time = 0
              }
            },
            RefEntityID = 25
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 25,
                OpenPath = {
                  Duration = 1,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  0.5,
                  1.9,
                  96.7
                },
                Time = 0
              }
            },
            RefEntityID = 26
          },
          [4] = {
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
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1601721_norm",
            DialogContentStr = "str_homestory_N23paixi_90040406_19_dialog_content",
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
        [20] = {
          [1] = {
            Body = "base_icon_1601721_cheerful",
            DialogContentStr = "str_homestory_N23paixi_90040406_20_dialog_content",
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
                Active = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 27
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
                Layer = 17,
                Time = 0.2
              }
            },
            RefEntityID = 28
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1401691_smile",
            DialogContentStr = "str_homestory_N23paixi_90040406_21_dialog_content",
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
                Active = true,
                Layer = 5,
                Scaling = {1.1, 1.1},
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 29
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 28
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1401691_smile",
            DialogContentStr = "str_homestory_N23paixi_90040406_22_dialog_content",
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
          }
        },
        [23] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 3
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
