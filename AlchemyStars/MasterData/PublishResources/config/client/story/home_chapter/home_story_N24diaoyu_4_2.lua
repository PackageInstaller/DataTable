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
      Name = "轨道相机1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [4] = {
      EntityID = 4,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
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
      Name = "巴顿",
      PetID = 1500421,
      Resource = "1500421.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [7] = {
      EntityID = 7,
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 8,
      Name = "轨道镜头10",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "青瞳",
      PetID = 1601481,
      Resource = "1601481.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [10] = {
      EntityID = 10,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "鱼点",
      Resource = "eff_jy_fish_smallspot.prefab",
      Type = "Model"
    },
    [12] = {
      EntityID = 12,
      Name = "固定机位3",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 13,
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 14,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    }
  },
  ID = 90050402,
  Name = "home_story_N24diaoyu_4_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601481_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -66.8,
                  -0.2,
                  78.5
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 5,
                Position3D = {
                  -59.7,
                  1,
                  72.7
                },
                Time = 0.4
              },
              [2] = {
                OpenPath = {
                  Duration = 10,
                  Ease = 3,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -63,
                  0,
                  75
                },
                Rotation3D = {
                  0,
                  4.8,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 14, Time = 0.5}
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                Position3D = {
                  -63,
                  0,
                  76.4
                },
                Rotation3D = {
                  0,
                  -171.7,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 9
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_7_dialog_content",
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
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1601481_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_9_dialog_content",
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
                Active = true,
                Position3D = {
                  -62.2,
                  1,
                  76.9
                },
                Rotation3D = {
                  10,
                  216,
                  0.5
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
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601481_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -62.4,
                  1,
                  74.3
                },
                Rotation3D = {
                  8.5,
                  -23.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 9
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1601481_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601481_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
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
              [1] = {
                Look = 5,
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -62.2,
                  0.9,
                  -121.81
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -62.3,
                  -0.3,
                  -124.1
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -62.1,
                  -2.4,
                  -129.1
                },
                Scaling3D = {
                  1.5,
                  1.5,
                  1.5
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 3,
                  Style = 0
                }
              }
            }
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601481_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601481_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601481_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
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
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601481_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_17_dialog_content",
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
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_18_dialog_content",
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
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_19_dialog_content",
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
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601481_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 9
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1601481_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -63,
                    0,
                    76.07
                  },
                  StartValue = {
                    -63,
                    0,
                    76.4
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1}
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -62.7,
                  1,
                  75
                },
                Rotation3D = {
                  8.5,
                  -11.7,
                  0
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
                  Duration = 1,
                  EntityID = 12,
                  Style = 3
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -63.2,
                    0,
                    75
                  },
                  StartValue = {
                    -63,
                    0,
                    75
                  }
                }
              }
            },
            RefEntityID = 4
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1601481_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_23_dialog_content",
            DialogDir = 0,
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
                  EntityID = 7,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.1,
                VC = {
                  Duration = 0.2,
                  EntityID = 13,
                  Style = 1
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -62.8,
                  1,
                  76
                },
                Rotation3D = {
                  8.8,
                  202.2,
                  0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -63,
                  1,
                  75.45
                },
                Rotation3D = {
                  8.8,
                  202.2,
                  0.5
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1601481_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_24_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          },
          [2] = {
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
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1601481_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050402_25_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qingtong"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_26_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.6
              },
              [2] = {ShowContent = 0.02, Time = 2.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 1.5
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -62.72,
                  0.87,
                  77.6
                },
                Time = 1.5
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -63.23,
                  0.6,
                  74.5
                },
                Time = 1.3
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "walk",
                Time = 1.3,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -63.2,
                    0,
                    75
                  },
                  StartValue = {
                    -63.5,
                    0,
                    73.4
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 3.3}
            },
            RefEntityID = 4
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1.3,
                VC = {
                  Duration = 0,
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050402_27_dialog_content",
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
              [1] = {PlayAnimator = "think", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          }
        },
        [23] = {
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
