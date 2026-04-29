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
      Name = "莉莉卡",
      PetID = 1601721,
      Resource = "1601721.prefab",
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
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 8,
      Name = "固定机位5",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "固定机位7",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "诙谐",
      Resource = "37",
      Type = "Sound"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    }
  },
  ID = 90050201,
  Name = "home_story_N24diaoyu_2_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_1_dialog_content",
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
                  1.9,
                  -1.4,
                  -97.5
                },
                Rotation3D = {
                  0,
                  -113,
                  0
                },
                Time = 0.4
              },
              [2] = {
                Bubble = {
                  ID = 10,
                  Offset = {
                    0,
                    0.15,
                    0
                  }
                },
                FaceSeq = 6,
                PlayAnimator = "happy",
                Time = 1.5
              },
              [3] = {PlayAnimator = "idle", Time = 3.7}
            },
            RefEntityID = 3
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
                  -16,
                  -3.3,
                  -114
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0.3,
                  -0.6,
                  -97.9
                },
                Rotation3D = {
                  -5.61,
                  -284,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 5,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.5,
                VC = {
                  Duration = 2,
                  EntityID = 6,
                  Style = 1
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.3,
                  -0.6,
                  -97.9
                },
                Rotation3D = {
                  -1.4,
                  -284,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 1.5
              }
            },
            RefEntityID = 10
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 11
          },
          [10] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 12,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_2_dialog_content",
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
                Position3D = {
                  0.917,
                  -0.5,
                  -97.74
                },
                Rotation3D = {
                  0,
                  -284,
                  0
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
                  Duration = 0.2,
                  EntityID = 7,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0.2}
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_3_dialog_content",
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
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_4_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_5_dialog_content",
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
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_6_dialog_content",
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_7_dialog_content",
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
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_8_dialog_content",
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
                  2.84,
                  -0.46,
                  -95.35
                },
                Rotation3D = {
                  0,
                  -148.5,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
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
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050201_9_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                Active = true,
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
                  -14,
                  -2.2,
                  -111.7
                },
                Rotation3D = {
                  1.88,
                  -137.9,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 9,
                  Style = 0
                }
              }
            }
          }
        },
        [10] = {
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
              [2] = {Active = true, Time = 2.6}
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
