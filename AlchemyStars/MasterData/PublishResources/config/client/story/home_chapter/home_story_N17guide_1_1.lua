return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 108,
      Name = "轨道相机1001",
      Resource = "vc_1001.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [3] = {
      EntityID = 109,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [4] = {
      EntityID = 110,
      Name = "轨道镜头1002",
      Resource = "vc_1002.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [5] = {
      EntityID = 111,
      Name = "轨道镜头1003",
      Resource = "vc_1003.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [6] = {
      EntityID = 112,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 113,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [8] = {
      EntityID = 115,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 116,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [10] = {
      EntityID = 117,
      Name = "过曝特效",
      Resource = "uieff_Story_Light.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 118,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 119,
      Name = "轨道镜头1004",
      Resource = "vc_1004.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 120,
      Name = "空奔奔",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [14] = {
      EntityID = 121,
      Name = "轨道镜头1005",
      Resource = "vc_1005.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 122,
      Name = "轨道镜头1006",
      Resource = "vc_1006.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 123,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 124,
      Name = "白色遮罩",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 125,
      Name = "轨道镜头1007",
      Resource = "vc_1007.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 127,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 128,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [21] = {
      EntityID = 129,
      Name = "轨道相机1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [22] = {
      EntityID = 131,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [23] = {
      EntityID = 133,
      Name = "轨道镜头10",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [24] = {
      EntityID = 134,
      Name = "省略号bubble",
      Resource = "eff_jy_meme_duihua2.prefab",
      Type = "Model"
    },
    [25] = {
      EntityID = 135,
      Name = "高兴bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [26] = {
      EntityID = 136,
      Name = "空奔奔2",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [27] = {
      EntityID = 137,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    },
    [28] = {
      EntityID = 138,
      Name = "后宅BGM",
      Resource = "72",
      Type = "Sound"
    },
    [29] = {
      EntityID = 140,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [30] = {
      EntityID = 141,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [31] = {
      EntityID = 142,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 90000101,
  Name = "home_story_N17guide_1_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 117
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {Active = true, Time = 0.6}
            },
            RefEntityID = 123
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 138, Time = 0.5}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 109,
                Position3D = {
                  0,
                  39.3,
                  -77.4
                },
                Time = 0.3
              }
            },
            RefEntityID = 110
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -87.1,
                  26.5,
                  -101
                },
                Time = 0.1
              },
              [2] = {Active = true, Time = 0.2}
            },
            RefEntityID = 109
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 110,
                  Style = 0
                }
              }
            }
          }
        },
        [2] = {
          [1] = {
            KeyFrames = {
              [1] = {
                OpenPath = {Duration = 7},
                Time = 0
              }
            },
            RefEntityID = 110
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
              },
              [2] = {Active = true, Time = 5}
            },
            RefEntityID = 123
          }
        },
        [3] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 124
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 142
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 112,
                Position3D = {
                  -15.74,
                  30.1,
                  28.9
                },
                Time = 0.1
              }
            },
            RefEntityID = 111
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -8.6,
                  31.3,
                  -53
                },
                Time = 0
              },
              [2] = {Active = true, Time = 0.1}
            },
            RefEntityID = 112
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 111,
                  Style = 0
                }
              }
            }
          }
        },
        [4] = {
          [1] = {
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
            RefEntityID = 124
          },
          [2] = {
            KeyFrames = {
              [1] = {
                OpenPath = {Duration = 6, Position = 0},
                Time = 0
              }
            },
            RefEntityID = 111
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 5}
            },
            RefEntityID = 112
          }
        },
        [5] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 112,
                Position3D = {
                  -0.9,
                  7.16,
                  140.6
                },
                Time = 0.1
              }
            },
            RefEntityID = 108
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 108,
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
                  -1.8,
                  15,
                  33.2
                },
                Time = 0.1
              },
              [2] = {Active = true, Time = 0.2}
            },
            RefEntityID = 112
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 124
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 142
          }
        },
        [6] = {
          [1] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 6,
                  Ease = 3,
                  Position = 0
                },
                Time = 0
              }
            },
            RefEntityID = 108
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                Position3D = {
                  -1,
                  0,
                  76
                },
                Rotation3D = {
                  1,
                  205,
                  1
                },
                Time = 3.5
              }
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 4},
              [2] = {
                Time = 0,
                Translate3D = {
                  Duration = 6,
                  EndValue = {
                    -1.8,
                    2.5,
                    33.2
                  },
                  StartValue = {
                    -1.8,
                    15,
                    33.2
                  }
                }
              }
            },
            RefEntityID = 112
          },
          [4] = {
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
            RefEntityID = 124
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000101_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000101_2_dialog_content",
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
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.17,
                  0.93,
                  76.74
                },
                Rotation3D = {
                  3.64,
                  237.4,
                  0
                },
                Time = 1.2
              }
            },
            RefEntityID = 115
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  93.31,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -2,
                    0,
                    76
                  },
                  StartValue = {
                    -3.2,
                    0,
                    76
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.7}
            },
            RefEntityID = 116
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1.2,
                VC = {
                  Duration = 0,
                  EntityID = 115,
                  Style = 0
                }
              }
            }
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_4_dialog_content",
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
        [11] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_5_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    1,
                    295,
                    1
                  },
                  StartValue = {
                    1,
                    205,
                    1
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -2.42,
                  0.87,
                  76.98
                },
                Rotation3D = {
                  0,
                  132,
                  0
                },
                Time = 0.3
              }
            },
            RefEntityID = 118
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 118,
                  Style = 0
                }
              }
            }
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1500331_worried",
            DialogContentStr = "str_homestory_N17guide_90000101_6_dialog_content",
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
              [1] = {
                Bubble = {
                  ID = 131,
                  Offset = {
                    -0.1,
                    0.1,
                    0
                  }
                },
                FaceSeq = 5,
                PlayAnimation = "sad",
                PlayAnimatorType = "trigger",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.4}
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
              }
            },
            RefEntityID = 131
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000101_7_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "str_homestory_N17guide_90000101_8_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "str_homestory_N17guide_90000101_13_option_content",
                NextParagraphID = 3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0.2}
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 131
          }
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_9_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 119,
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
                OpenPath = {Duration = 50, Position = 0},
                Position3D = {
                  -6.37,
                  0.51,
                  79.5
                },
                Time = 0
              }
            },
            RefEntityID = 119
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.4,
                  0.7,
                  76.24
                },
                Time = 0
              }
            },
            RefEntityID = 109
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 5,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    50.63,
                    0
                  },
                  StartValue = {
                    0,
                    93.3,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimator = "idle", Time = 1}
            },
            RefEntityID = 116
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_10_dialog_content",
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
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_11_dialog_content",
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
        [4] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_12_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "sad", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 113
          },
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_14_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 119,
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
                OpenPath = {Duration = 50, Position = 0},
                Position3D = {
                  -6.37,
                  0.51,
                  79.5
                },
                Time = 0
              }
            },
            RefEntityID = 119
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.4,
                  0.7,
                  76.24
                },
                Time = 0
              }
            },
            RefEntityID = 109
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 5,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    50.63,
                    0
                  },
                  StartValue = {
                    0,
                    93.3,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimator = "idle", Time = 1}
            },
            RefEntityID = 116
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_15_dialog_content",
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
        [3] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_16_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "sad", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 113
          },
          NextParagraphID = 4
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_17_dialog_content",
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
        [2] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000101_18_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
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
                  EntityID = 118,
                  Style = 1
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 128,
                  Offset = {
                    0.1,
                    0.23,
                    -0.06
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "happy",
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    1,
                    301.3,
                    1
                  },
                  StartValue = {
                    1,
                    295,
                    1
                  }
                },
                Time = 0.3
              },
              [2] = {PlayAnimation = "stand", Time = 2.1}
            },
            RefEntityID = 113
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    107.7,
                    0
                  },
                  StartValue = {
                    0,
                    50.6,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {PlayAnimator = "idle", Time = 1.1}
            },
            RefEntityID = 116
          },
          [5] = {
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
            RefEntityID = 128
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 141
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1500991",
            DialogContentStr = "str_homestory_N17guide_90000101_19_dialog_content",
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
                FaceSeq = 6,
                PlayAnimator = "think",
                Time = 0.3
              },
              [2] = {PlayAnimator = "idle", Time = 2.1}
            },
            RefEntityID = 116
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_20_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 4,
                  EndValue = {
                    -2,
                    3,
                    52
                  },
                  StartValue = {
                    -2,
                    3,
                    49.216
                  }
                }
              }
            },
            RefEntityID = 120
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 112,
                OpenPath = {Duration = 4, Position = 0},
                Position3D = {
                  -3.5,
                  3.48,
                  50.74
                },
                Time = 0
              }
            },
            RefEntityID = 121
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                LateUpdate = true,
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 121,
                  Style = 0
                }
              },
              [2] = {
                LateUpdate = false,
                Time = 3.5,
                VC = {
                  Duration = 0,
                  EntityID = 122,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate3D = {
                  Duration = 4,
                  EndValue = {
                    -2,
                    3.2,
                    52
                  },
                  StartValue = {
                    -2,
                    3.2,
                    49.216
                  }
                }
              }
            },
            RefEntityID = 112
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 109,
                OpenPath = {Duration = 4, Position = 0},
                Position3D = {
                  -2.36,
                  1,
                  74.64
                },
                Time = 3.3
              }
            },
            RefEntityID = 122
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.4,
                  0.78,
                  76.2
                },
                Time = 3.2
              }
            },
            RefEntityID = 109
          },
          [8] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 5,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    167.2,
                    0
                  },
                  StartValue = {
                    0,
                    107.7,
                    0
                  }
                },
                Time = 4
              },
              [2] = {PlayAnimator = "idle", Time = 4.5},
              [3] = {Active = true, Time = 4.7}
            },
            RefEntityID = 116
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 127,
                  Offset = {
                    -0.5,
                    0,
                    -0.2
                  }
                },
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    1,
                    203.95,
                    1
                  },
                  StartValue = {
                    1,
                    301.3,
                    1
                  }
                },
                Time = 3.8
              },
              [2] = {PlayAnimation = "stand", Time = 4.3},
              [3] = {FaceSeq = 1, Time = 2.4}
            },
            RefEntityID = 113
          },
          [10] = {
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
            RefEntityID = 127
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 3.8}
            },
            RefEntityID = 141
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 2.5,
                  EndValue = {
                    -1.5,
                    0.35,
                    74.22
                  },
                  StartValue = {
                    -1.5,
                    0.35,
                    70.72
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 2.5}
            },
            RefEntityID = 120
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 112,
                OpenPath = {
                  Duration = 3,
                  Ease = 2,
                  Position = 0
                },
                Position3D = {
                  -2.11,
                  0.98,
                  77.25
                },
                Time = 0
              }
            },
            RefEntityID = 125
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 125,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    -1.5,
                    0.7,
                    74.91
                  },
                  StartValue = {
                    -1.5,
                    0,
                    70.72
                  }
                }
              }
            },
            RefEntityID = 112
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 127
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1500331_Shocked",
            DialogContentStr = "str_homestory_N17guide_90000101_21_dialog_content",
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
              [1] = {Time = 0}
            },
            RefEntityID = 113
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500331_Shocked",
            DialogContentStr = "str_homestory_N17guide_90000101_22_dialog_content",
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
        [8] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_23_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 115,
                  Style = 1
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.41,
                  1.1,
                  75.96
                },
                Rotation3D = {
                  15.52,
                  -176,
                  -0.13
                },
                Time = 0
              }
            },
            RefEntityID = 115
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.964,
                  0,
                  89.1
                },
                Rotation3D = {
                  -0.15,
                  -97.1,
                  1.4
                },
                Time = 0.7
              }
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.465,
                  0,
                  89.8
                },
                Rotation3D = {
                  0,
                  230.1,
                  0
                },
                Time = 0.7
              }
            },
            RefEntityID = 116
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -3,
                  0.35,
                  88.538
                },
                Rotation3D = {
                  0,
                  56.3,
                  0
                },
                Time = 0.7
              }
            },
            RefEntityID = 136
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1500331_surprise",
            DialogContentStr = "str_homestory_N17guide_90000101_24_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
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
                  EntityID = 129,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 9,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 113
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0},
              [2] = {PlayAnimator = "surprise", Time = 0.2},
              [3] = {PlayAnimator = "idle", Time = 2.2}
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.88,
                  0.35,
                  74.74
                },
                Rotation3D = {
                  0,
                  55.93,
                  0
                },
                Time = 0.6
              }
            },
            RefEntityID = 120
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 109,
                OpenPath = {Duration = 45, Position = 0},
                Position3D = {
                  -4.34,
                  0.88,
                  88.72
                },
                Time = 0
              }
            },
            RefEntityID = 129
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.964,
                  0.76,
                  89.12
                },
                Time = 0
              }
            },
            RefEntityID = 109
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1021001_shy",
            DialogContentStr = "str_homestory_N17guide_90000101_25_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 128
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 128,
                  Offset = {
                    0,
                    -1,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0.2
              },
              [2] = {PlayAnimation = "idle", Time = 2.2}
            },
            RefEntityID = 136
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 141
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_26_dialog_content",
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
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 116
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_27_dialog_content",
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
                FaceSeq = 11,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -100.3,
                    1.4
                  },
                  StartValue = {
                    -0.15,
                    -97.1,
                    1.4
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 0.5,
                  EndValue = {
                    -2.334,
                    0,
                    89.1
                  },
                  StartValue = {
                    -1.964,
                    0,
                    89.1
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 113
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_28_dialog_content",
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
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N17guide_90000101_29_dialog_content",
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
              [1] = {FaceSeq = 2, Time = 0},
              [2] = {FaceSeq = 1, Time = 0.2}
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  1.13,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 120
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1021001_angry",
            DialogContentStr = "str_homestory_N17guide_90000101_30_dialog_content",
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
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 137,
                  Offset = {
                    0,
                    -1,
                    0
                  }
                },
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 120
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.8,
                  0,
                  75.76
                },
                Rotation3D = {
                  9.71,
                  220.74,
                  1.52
                },
                Time = 0.3
              }
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.6,
                  0,
                  74.95
                },
                Rotation3D = {
                  -3.94,
                  -97.34,
                  -5.3
                },
                Time = 0.3
              }
            },
            RefEntityID = 113
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Look = 112,
                OpenPath = {Duration = 0.2, Position = 0},
                Position3D = {
                  -2.9,
                  1.16,
                  75.8
                },
                Time = 0
              }
            },
            RefEntityID = 133
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.88,
                  0.75,
                  74.74
                },
                Time = 0
              }
            },
            RefEntityID = 112
          },
          [8] = {
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
            RefEntityID = 137
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 141
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N17guide_90000101_31_dialog_content",
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
                  EntityID = 115,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.733,
                  0.6,
                  74.727
                },
                Rotation3D = {
                  -12.97,
                  -303,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 115
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 10,
                PlayAnimation = "sad",
                Time = 0.3
              },
              [2] = {
                FaceSeq = 1,
                PlayAnimation = "stand",
                Time = 2.4
              }
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 116
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_32_dialog_content",
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
        [18] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000101_33_dialog_content",
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
              [1] = {
                Bubble = {
                  ID = 134,
                  Offset = {
                    1,
                    0.245,
                    0.3
                  }
                },
                FaceSeq = 5,
                Time = 0
              },
              [2] = {Active = true, Time = 2}
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 141
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000101_34_dialog_content",
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
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 134
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_35_dialog_content",
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
                FaceSeq = 3,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    9.7,
                    192.8,
                    1.5
                  },
                  StartValue = {
                    9.7,
                    220.7,
                    1.5
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "talk", Time = 0.3},
              [3] = {PlayAnimator = "idle", Time = 2.1}
            },
            RefEntityID = 116
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N17guide_90000101_36_dialog_content",
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
              [1] = {FaceSeq = 10, Time = 0}
            },
            RefEntityID = 113
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1021001_shy",
            DialogContentStr = "str_homestory_N17guide_90000101_37_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 135,
                  Offset = {
                    0.318,
                    -1.05,
                    -0.5
                  }
                },
                PlayAnimation = "happy",
                Time = 0
              }
            },
            RefEntityID = 120
          },
          [4] = {
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
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 140
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000101_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.1
              },
              [2] = {ShowContent = 0.02, Time = 0.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.42,
                  0.95,
                  74.66
                },
                Rotation3D = {
                  4.77,
                  76.22,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 115
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 115,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                Position3D = {
                  -0.8,
                  0,
                  74.6
                },
                Rotation3D = {
                  0,
                  -79,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "walk",
                Position3D = {
                  -1.1,
                  0,
                  75.31
                },
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    237.7,
                    0
                  },
                  StartValue = {
                    0,
                    192.8,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.4}
            },
            RefEntityID = 116
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000101_39_dialog_content",
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
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 113
          }
        },
        [25] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000101_40_dialog_content",
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
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 3.5}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
