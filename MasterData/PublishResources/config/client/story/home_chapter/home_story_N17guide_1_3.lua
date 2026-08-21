return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 109,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [3] = {
      EntityID = 113,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 116,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [5] = {
      EntityID = 120,
      Name = "空奔奔",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [6] = {
      EntityID = 123,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 129,
      Name = "轨道相机1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 133,
      Name = "轨道镜头10",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 135,
      Name = "高兴bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [10] = {
      EntityID = 137,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 138,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 139,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 140,
      Name = "轨道镜头1010-2",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 141,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 142,
      Name = "对话bubble",
      Resource = "eff_jy_meme_duihua2.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 143,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [17] = {
      EntityID = 145,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [18] = {
      EntityID = 146,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 90000103,
  Name = "home_story_N17guide_1_3",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 133,
                  Style = 0
                }
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {Active = false, Time = 0.7}
            },
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 1,
                  Ease = 15,
                  Position = 0
                },
                Time = 0.7
              },
              [2] = {
                Active = true,
                Position3D = {
                  -1.85,
                  6.3,
                  13.3
                },
                Rotation3D = {
                  -5,
                  8.76,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 133
          },
          [4] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_1_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                Layer = 51,
                Time = 0.5
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 137
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.94,
                  5.5,
                  12.11
                },
                Rotation3D = {
                  0,
                  5.2,
                  0
                },
                Time = 0
              },
              [2] = {
                Bubble = {
                  ID = 135,
                  Offset = {
                    0.2,
                    -1,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 1.5
              },
              [3] = {PlayAnimation = "idle", Time = 3}
            },
            RefEntityID = 120
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.1,
                  5.18,
                  13.5
                },
                Rotation3D = {
                  0,
                  -131.52,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 113
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -2.4,
                  5.18,
                  13.8
                },
                Rotation3D = {
                  0,
                  -212.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 116
          },
          [9] = {
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
            RefEntityID = 135
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 145
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 146
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_2_dialog_content",
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
                VC = {
                  Duration = 0,
                  EntityID = 129,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 109,
                OpenPath = {Duration = 15, Position = 0},
                Position3D = {
                  -5.28,
                  6.1,
                  13.35
                },
                Rotation3D = {
                  180,
                  -35.02,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 129
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.9,
                  5.82,
                  12.86
                },
                Time = 0
              }
            },
            RefEntityID = 109
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 135
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000103_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 135,
                  Offset = {
                    0,
                    0.15,
                    0.2
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 143
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1021001_shy",
            DialogContentStr = "str_homestory_N17guide_90000103_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 1.8}
            },
            RefEntityID = 120
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_5_dialog_content",
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
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    112.7,
                    0
                  },
                  StartValue = {
                    0,
                    142.24,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.8}
            },
            RefEntityID = 116
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 113
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000103_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 11, Time = 0}
            },
            RefEntityID = 113
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 135
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -28.69,
                    0
                  },
                  StartValue = {
                    0,
                    16,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -1.9,
                    5.5,
                    12.38
                  },
                  StartValue = {
                    -1.9,
                    5.5,
                    12.1
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 1.2}
            },
            RefEntityID = 120
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    161.9,
                    0
                  },
                  StartValue = {
                    0,
                    122.5,
                    0
                  }
                },
                Time = 0.5
              },
              [2] = {PlayAnimator = "idle", Time = 1.3}
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -3.2,
                  6.3,
                  14.1
                },
                Rotation3D = {
                  12.41,
                  133.42,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 139
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 139,
                  Style = 0
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    249.4,
                    0
                  },
                  StartValue = {
                    0,
                    228.5,
                    0
                  }
                },
                Time = 0.4
              },
              [2] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 113
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "idle", Time = 2.5},
              [2] = {
                Bubble = {
                  ID = 135,
                  Offset = {
                    0.3,
                    -1,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0
              }
            },
            RefEntityID = 120
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 143
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 138,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -3.6,
                  6.2,
                  13.14
                },
                Rotation3D = {
                  8.91,
                  -274.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 138
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 113
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_14_dialog_content",
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
                FaceSeq = 4,
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.37,
                  6.12,
                  12.9
                },
                Time = 0
              }
            },
            RefEntityID = 109
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.1, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 109,
                OpenPath = {Duration = 20, Position = 0},
                Position3D = {
                  -2.4,
                  6.2,
                  12.3
                },
                Rotation3D = {
                  9.07,
                  2.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 140
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 140,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 142,
                  Offset = {
                    -0.2,
                    -0.15,
                    0.5
                  }
                },
                FaceSeq = 2,
                Time = 0
              }
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.6,
                  6.3,
                  14.3
                },
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              }
            },
            RefEntityID = 142
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimator = "think",
                Time = 0.5
              },
              [2] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 116
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 142
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_18_dialog_content",
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
        [19] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_19_dialog_content",
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
                FaceSeq = 6,
                PlayAnimator = "happy",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1021001_shy",
            DialogContentStr = "str_homestory_N17guide_90000103_20_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 135
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 135,
                  Offset = {
                    0.2,
                    -1,
                    0.2
                  }
                },
                PlayAnimation = "happy",
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 120
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 139,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 143
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_21_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 138,
                  Style = 3
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -3.2,
                  6.2,
                  13.13
                },
                Rotation3D = {
                  8.85,
                  62.68,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 138
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    277.2,
                    0
                  },
                  StartValue = {
                    0,
                    249.4,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 0.6}
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    104.6,
                    0
                  },
                  StartValue = {
                    0,
                    161.9,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {PlayAnimator = "idle", Time = 1.4}
            },
            RefEntityID = 116
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000103_22_dialog_content",
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
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [23] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000103_23_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 139,
                  Style = 2
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -4,
                  6.12,
                  13.28
                },
                Rotation3D = {
                  5.4,
                  90,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 139
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    317.8,
                    0
                  },
                  StartValue = {
                    0,
                    331.3,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -1.77,
                    5.5,
                    12.59
                  },
                  StartValue = {
                    -1.9,
                    5.5,
                    12.4
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 1.6}
            },
            RefEntityID = 120
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    126.3,
                    0
                  },
                  StartValue = {
                    0,
                    104.6,
                    0
                  }
                },
                Time = 1.6
              },
              [2] = {PlayAnimator = "idle", Time = 2.2}
            },
            RefEntityID = 116
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    251.9,
                    0
                  },
                  StartValue = {
                    0,
                    277.2,
                    0
                  }
                },
                Time = 1.7
              },
              [2] = {PlayAnimation = "stand", Time = 2.3}
            },
            RefEntityID = 113
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000103_24_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 141,
                  Offset = {
                    0.14,
                    0.21,
                    0.03
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              },
              [2] = {Active = false, Time = 1}
            },
            RefEntityID = 141
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 143
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 116
          }
        },
        [25] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000103_25_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [26] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.2
              },
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
