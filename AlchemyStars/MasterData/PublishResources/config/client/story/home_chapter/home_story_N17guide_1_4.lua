return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 113,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [3] = {
      EntityID = 116,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 123,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 138,
      Name = "轨道镜头1003",
      Resource = "vc_1003.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [6] = {
      EntityID = 140,
      Name = "关注点1",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 141,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 142,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 143,
      Name = "轨道镜头1011",
      Resource = "vc_1011.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 144,
      Name = "宅舍",
      Resource = "5242101.prefab",
      Type = "Model"
    }
  },
  ID = 90000104,
  Name = "home_story_N17guide_1_4",
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
                  EntityID = 138,
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
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 123
          },
          [3] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000104_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.5
              },
              [2] = {ShowContent = 0.02, Time = 2.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -2.4,
                  5.3,
                  10.44
                },
                Rotation3D = {
                  0,
                  -25.65,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 140,
                OpenPath = {
                  Duration = 30,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -21.6,
                  3.2,
                  57.6
                },
                Rotation3D = {
                  -7.2,
                  38.02,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 138
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -20.24,
                  2.07,
                  72.8
                },
                Time = 0
              }
            },
            RefEntityID = 140
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -19,
                  0,
                  72
                },
                Rotation3D = {
                  0,
                  0,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 144
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000104_2_dialog_content",
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
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000104_3_dialog_content",
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
            DialogContentStr = "str_homestory_N17guide_90000104_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.1,
                  6.1,
                  12.07
                },
                Rotation3D = {
                  3.27,
                  -167.69,
                  0
                },
                Time = 0.3
              }
            },
            RefEntityID = 141
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 141,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "think",
                Time = 0.3
              },
              [2] = {PlayAnimator = "idle", Time = 2.3}
            },
            RefEntityID = 116
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000104_5_dialog_content",
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
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    421,
                    0
                  },
                  StartValue = {
                    0,
                    334.4,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1}
            },
            RefEntityID = 116
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000104_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0},
              [2] = {
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Time = 0.5
              },
              [3] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 116
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.17,
                  6,
                  13.91
                },
                Rotation3D = {
                  3.5,
                  -152,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 142
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 142,
                  Style = 3
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -12.5,
                  0,
                  67.8
                },
                Rotation3D = {
                  0,
                  119.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 113
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000104_7_dialog_content",
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
            KeyFrames = {
              [1] = {
                Active = true,
                OpenPath = {
                  Duration = 1,
                  Ease = 2,
                  Position = 0
                },
                Time = 0.2
              },
              [2] = {
                Active = true,
                Look = 140,
                Position3D = {
                  -7.79,
                  1.5,
                  63.6
                },
                Rotation3D = {
                  0,
                  350,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 143
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 143,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -21.3,
                  -1.1,
                  72.8
                },
                Time = 0
              }
            },
            RefEntityID = 140
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0.7
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 113
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000104_8_dialog_content",
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
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000104_9_dialog_content",
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
                Rotation3D = {
                  0,
                  -19.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 116
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000104_10_dialog_content",
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
                  EntityID = 141,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 141
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [11] = {
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
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
