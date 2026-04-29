return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 123,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 124,
      Name = "轨道镜头1099",
      Resource = "vc_1099.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [4] = {
      EntityID = 125,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [5] = {
      EntityID = 126,
      Name = "薇丝",
      PetID = "1500331",
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [6] = {
      EntityID = 127,
      Name = "轨道镜头1098",
      Resource = "vc_1098.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 128,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [8] = {
      EntityID = 129,
      Name = "轨道镜头1097",
      Resource = "vc_1097.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 130,
      Name = "轨道相机1096",
      Resource = "vc_1096.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 131,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 132,
      Name = "轨道镜头1095",
      Resource = "vc_1095.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 133,
      Name = "空奔奔",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [13] = {
      EntityID = 134,
      Name = "轨道镜头1094",
      Resource = "vc_1094.prefab",
      SubType = 1,
      Type = "CameraVC"
    }
  },
  ID = 90000999,
  Name = "home_story_N17guide_1_10",
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
                  EntityID = 124,
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
              },
              [3] = {Active = true, Time = 5.1}
            },
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 125,
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -133,
                  6,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 124
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -138,
                  0,
                  -45
                },
                Time = 0.2
              },
              [2] = {Time = 0.3}
            },
            RefEntityID = 125
          }
        },
        [2] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                Position3D = {
                  -67,
                  -0.2,
                  -48
                },
                Rotation3D = {
                  1,
                  -60,
                  1
                },
                Time = 0
              }
            },
            RefEntityID = 126
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -69,
                  -0.5,
                  -52
                },
                Time = 0.2
              },
              [2] = {Time = 0.3},
              [3] = {Active = true, Time = 2.5}
            },
            RefEntityID = 125
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 123
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -68.3,
                  0.65,
                  -45.3
                },
                Rotation3D = {
                  0,
                  -21,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 127
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 127,
                  Style = 0
                }
              }
            }
          }
        },
        [3] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  -180,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -67.5,
                    -0.2,
                    -47.6
                  },
                  StartValue = {
                    -67.5,
                    -0.2,
                    -46
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 128
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_1_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_2_dialog_content",
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
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_3_dialog_content",
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
                Active = true,
                Position3D = {
                  -67.4,
                  0.58,
                  -45.9
                },
                Time = 0
              },
              [2] = {Time = 0.1}
            },
            RefEntityID = 125
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 125,
                OpenPath = {
                  Duration = 1.5,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -65.5,
                  0.77,
                  -49.9
                },
                Time = 0
              }
            },
            RefEntityID = 129
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Time = 0.1,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -67,
                    -0.2,
                    -48.6
                  },
                  StartValue = {
                    -67,
                    -0.2,
                    -48
                  }
                }
              }
            },
            RefEntityID = 126
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "talk",
                Time = 0
              }
            },
            RefEntityID = 128
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_4_dialog_content",
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
              }
            },
            RefEntityID = 128
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 130,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 4,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -65.5,
                  0.8,
                  -49.9
                },
                Time = 0.1
              }
            },
            RefEntityID = 130
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 131
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_6_dialog_content",
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
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_7_dialog_content",
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
            DialogContentStr = "str_homestory_N17guide_99999999_8_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 131
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 8,
                PlayAnimation = "surprise",
                Rotation3D = {
                  0,
                  -26.84,
                  0
                },
                Time = 0.1
              },
              [2] = {
                FaceSeq = 9,
                PlayAnimation = "stand",
                Time = 2
              }
            },
            RefEntityID = 126
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -66.49,
                  0.61,
                  -47.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 125
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 125,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -69.1,
                  0.6,
                  -50
                },
                Time = 0.2
              }
            },
            RefEntityID = 132
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 132,
                  Style = 0
                }
              }
            }
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_9_dialog_content",
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
                FaceSeq = 6,
                PlayAnimator = "talk",
                Time = 0
              }
            },
            RefEntityID = 128
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_10_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 128
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 10,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 126
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_11_dialog_content",
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
                PlayAnimator = "surprise",
                Time = 0
              }
            },
            RefEntityID = 128
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_99999999_12_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 131
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -118.3,
                  -5.7,
                  -49.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 133
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -118.6,
                  -6,
                  -50
                },
                Time = 0.2
              }
            },
            RefEntityID = 125
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 125,
                Position3D = {
                  -118.2,
                  -4.6,
                  -50.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 134
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 134,
                  Style = 0
                }
              }
            }
          }
        },
        [16] = {
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
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
