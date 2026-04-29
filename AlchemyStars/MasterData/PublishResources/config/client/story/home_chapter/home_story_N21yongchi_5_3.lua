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
      Name = "杰诺",
      PetID = 1601671,
      Resource = "1601671.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [6] = {
      EntityID = 6,
      Name = "轨道镜头1010-2",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [8] = {
      EntityID = 8,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "轨道相机1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "固定机位3",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 14,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    },
    [15] = {
      EntityID = 15,
      Name = "问号",
      Resource = "1713",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      Name = "混乱bubble",
      Resource = "eff_jy_meme_hunluan.prefab",
      Type = "Model"
    }
  },
  ID = 90020503,
  Name = "home_story_N21yongchi_5_3",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601661_upset",
            DialogContentStr = "str_homestory_N21yongchi_90020503_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              },
              [2] = {ShowContent = 0.02, Time = 1.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
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
                  -22,
                  3,
                  -15.6
                },
                Rotation3D = {
                  0,
                  -122.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -23.23,
                  3,
                  -16.5
                },
                Rotation3D = {
                  0,
                  53.7,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
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
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 7,
                Position3D = {
                  -21.5,
                  3.85,
                  -14.6
                },
                Rotation3D = {
                  0,
                  -62.6,
                  0
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 1.5,
                  Ease = 2,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -23.2,
                  3.7,
                  -17.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601671_sleep",
            DialogContentStr = "str_homestory_N21yongchi_90020503_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 12,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 2,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.6}
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
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 14
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_3_dialog_content",
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
                Position3D = {
                  -24.14,
                  4.15,
                  -16.5
                },
                Rotation3D = {
                  13.3,
                  76.28,
                  0
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
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 5,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1601671_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020503_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601671_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020503_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1601671_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020503_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_7_dialog_content",
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
                  EntityID = 5,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "happy",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601671_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020503_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601671_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020503_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601671_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020503_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 2,
                  EntityID = 8,
                  Style = 2
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -21.72,
                  3.85,
                  -14.6
                },
                Rotation3D = {
                  1.3,
                  -151.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.45,
                  0.45,
                  0.45
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 16,
                  Offset = {
                    0.2,
                    0.1,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_11_dialog_content",
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
                  EntityID = 5,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 16
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_12_dialog_content",
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
                Position3D = {
                  -21.9,
                  3.5,
                  -17.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020503_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 9,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                OpenPath = {
                  Duration = 10,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -24.3,
                  4.3,
                  -13.18
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_14_dialog_content",
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
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020503_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020503_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_17_dialog_content",
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
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020503_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -22.4,
                  4.05,
                  -15.5
                },
                Rotation3D = {
                  4.46,
                  -143.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
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
                  EntityID = 5,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.2,
                VC = {
                  Duration = 0.2,
                  EntityID = 11,
                  Style = 2
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2.2},
              [3] = {
                Bubble = {
                  ID = 13,
                  Offset = {
                    -0.2,
                    0,
                    0.1
                  }
                },
                PlayAnimator = "surprise",
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -23.3,
                  4.1,
                  -16.2
                },
                Rotation3D = {
                  12,
                  67.3,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.4,
                  0.4,
                  0.4
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 15
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_20_dialog_content",
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
            Body = "base_icon_1601671_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020503_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1601671_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020503_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [23] = {
          [1] = {
            Body = "base_icon_1601671_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020503_23_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1601671_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020503_24_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 4
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_26_dialog_content",
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
                  EntityID = 5,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [26] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020503_27_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [27] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020503_28_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020503_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
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
                  EntityID = 9,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 3}
            },
            RefEntityID = 2
          }
        }
      }
    }
  },
  StartParagraph = 1
}
