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
      Name = "轨道镜头1001",
      Resource = "vc_1002.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [4] = {
      EntityID = 4,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "卡莲",
      PetID = 1600061,
      Resource = "1600061.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [6] = {
      EntityID = 6,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [7] = {
      EntityID = 7,
      Name = "轨道镜头1002",
      Resource = "vc_1098.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 8,
      Name = "空奔奔",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [9] = {
      EntityID = 9,
      Name = "空奔奔2",
      Resource = "1021002.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [10] = {
      EntityID = 10,
      Name = "定点镜头0001",
      Resource = "vc_101.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "轨道镜头1007",
      Resource = "vc_1014.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "轨道相机1001",
      Resource = "vc_1015.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 13,
      Name = "轨道镜头10",
      Resource = "vc_1016.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 14,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "关注点1",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 16,
      Name = "琪尔",
      PetID = 1501651,
      Resource = "1501651.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [17] = {
      EntityID = 17,
      Name = "轨道镜头1097",
      Resource = "vc_1017.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 18,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [19] = {
      EntityID = 19,
      Name = "思考bubble",
      Resource = "eff_jy_meme_duihua2.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "开心音效",
      Resource = "1717",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "摩擦声",
      Resource = "10057",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "后宅BGM",
      Resource = "46",
      Type = "Sound"
    }
  },
  ID = 90020101,
  Name = "home_story_N21yongchi_1_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
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
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 3,
                  Style = 0
                }
              },
              [2] = {LateUpdate = true, Time = 2.5}
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                Position3D = {
                  -56.4,
                  -6,
                  -120.3
                },
                Rotation3D = {
                  0,
                  -13.64,
                  -3.5
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -93.6,
                  21.7,
                  -129
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_1_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                StartBgm = 23,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020101_2_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.4,
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
                Time = 0.5
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
                  2.8,
                  21.6
                },
                Rotation3D = {
                  0,
                  -82.36,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -8.23,
                  3.82,
                  9.9
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                OpenPath = {
                  Duration = 4,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  3.74,
                  3.96,
                  26.38
                },
                Rotation3D = {
                  0,
                  121.72,
                  -123.3
                },
                Time = 0.4
              }
            },
            RefEntityID = 7
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
                Active = true,
                Position3D = {
                  -1.16,
                  2.79,
                  21.19
                },
                Rotation3D = {
                  0,
                  52.06,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Rotation3D = {
                  0,
                  74,
                  0
                },
                Time = 0.4,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    3,
                    2.7,
                    26.2
                  },
                  StartValue = {
                    -0.31,
                    2.7,
                    26.2
                  }
                }
              }
            },
            RefEntityID = 8
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Rotation3D = {
                  1,
                  90,
                  1
                },
                Time = 0.5,
                Translate3D = {
                  Duration = 3.5,
                  EndValue = {
                    3.12,
                    2.7,
                    26.62
                  },
                  StartValue = {
                    -1.41,
                    2.7,
                    26.62
                  }
                }
              }
            },
            RefEntityID = 9
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020101_3_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.4
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.305,
                  3.5,
                  18.85
                },
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 10,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.7,
                  4,
                  24.78
                },
                Rotation3D = {
                  -16,
                  115.9,
                  25.4
                },
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
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
            RefEntityID = 9
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0,
                  2.8,
                  21.4
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_4_dialog_content",
            DialogDir = 0,
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
                Bubble = {
                  ID = 18,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 6,
                PlayAnimator = "talk",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 6
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
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_5_dialog_content",
            DialogDir = 0,
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
                Position3D = {
                  -3.81,
                  3.3,
                  18.61
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
                Look = 4,
                OpenPath = {
                  Duration = 1.5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 11,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 18
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_6_dialog_content",
            DialogDir = 0,
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
        [7] = {
          [1] = {
            Body = "base_icon_1600061_sigh",
            DialogContentStr = "str_homestory_N21yongchi_90020101_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 12,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    8.3,
                    0
                  },
                  StartValue = {
                    0,
                    277.6,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Look = 14, Time = 0}
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -7.7,
                  2.79,
                  21.6
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0.1}
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2},
              [2] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020101_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    2.8,
                    22.8
                  },
                  StartValue = {
                    0,
                    2.8,
                    21.4
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                LateUpdate = true,
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 12,
                  Style = 0
                }
              },
              [2] = {LateUpdate = false, Time = 1.5}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -7.7,
                    2.79,
                    24.64
                  },
                  StartValue = {
                    -7.7,
                    2.79,
                    21.6
                  }
                }
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                OpenPath = {
                  Duration = 1.5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.5},
              [3] = {PlaySound = "Once", Time = 1},
              [4] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 21
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020101_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 13,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.2,
                  2.8,
                  21.2
                },
                Rotation3D = {
                  0,
                  18.39,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {Look = 15, Time = 0.2}
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                Rotation3D = {
                  0,
                  -3.9,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.48,
                  3.34,
                  21.08
                },
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [7] = {
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
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_10_dialog_content",
            DialogDir = 0,
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
                FaceSeq = 6,
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    19.1,
                    0
                  },
                  StartValue = {
                    0,
                    18.39,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_11_dialog_content",
            DialogDir = 0,
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
                FaceSeq = 1,
                PlayAnimator = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -1.06,
                    2.8,
                    22.8
                  },
                  StartValue = {
                    -1.2,
                    2.8,
                    21.2
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.5}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 1.5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.5},
              [3] = {PlaySound = "Once", Time = 1},
              [4] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 21
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1600061_swear",
            DialogContentStr = "str_homestory_N21yongchi_90020101_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -73,
                    0
                  },
                  StartValue = {
                    0,
                    -3.9,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    69.7,
                    0
                  },
                  StartValue = {
                    0,
                    19.1,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimator = "idle", Time = 0.8}
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2},
              [2] = {PlaySound = "Once", Time = 0.5},
              [3] = {PlaySound = "Once", Time = 0.4},
              [4] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 21
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_13_dialog_content",
            DialogDir = 0,
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
                FaceSeq = 7,
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 6
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_14_dialog_content",
            DialogDir = 0,
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 6
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_15_dialog_content",
            DialogDir = 0,
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
              [1] = {PlayAnimator = "talk", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 6
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1600061_sigh",
            DialogContentStr = "str_homestory_N21yongchi_90020101_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 19,
                  Offset = {
                    0,
                    0,
                    0.5
                  }
                },
                FaceSeq = 2,
                Time = 0
              }
            },
            RefEntityID = 5
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
              }
            },
            RefEntityID = 19
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1600061_sigh",
            DialogContentStr = "str_homestory_N21yongchi_90020101_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "sad", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 5
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020101_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.2}
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 19
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_19_dialog_content",
            DialogDir = 0,
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
              [1] = {PlayAnimator = "think", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {PlayAnimation = "stand", Time = 0}
            },
            RefEntityID = 5
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020101_20_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
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
                Time = 0
              },
              [2] = {
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
                Position3D = {
                  -27.93,
                  3.13,
                  -8.95
                },
                Time = 0.5
              }
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -27.93,
                  3.13,
                  -8.95
                },
                Time = 0.5
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 4,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 17
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                VC = {
                  Duration = 0,
                  EntityID = 17,
                  Style = 0
                }
              }
            }
          }
        },
        [21] = {
          [1] = {
            KeyFrames = {
              [1] = {
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
