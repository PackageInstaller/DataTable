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
      Name = "轨道镜头1009",
      Resource = "vc_1009.prefab",
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
      EntityID = 144,
      Name = "白女士",
      PetID = 1400411,
      Resource = "1400411.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [8] = {
      EntityID = 146,
      Name = "丘布商人",
      Resource = "1021003.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [9] = {
      EntityID = 147,
      Name = "爱心bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [10] = {
      EntityID = 148,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 149,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 150,
      Name = "定点镜头0003",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 151,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 152,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [15] = {
      EntityID = 153,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    }
  },
  ID = 90000107,
  Name = "home_story_N17guide_1_7",
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
            DialogContentStr = "str_homestory_N17guide_90000107_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  9.26,
                  3.2,
                  38.2
                },
                Time = 0
              }
            },
            RefEntityID = 140
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  7.42,
                  2.87,
                  38
                },
                Rotation3D = {
                  0,
                  -17.3,
                  0
                },
                Time = 0
              },
              [2] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 1.6
              },
              [3] = {PlayAnimation = "stand", Time = 3.4}
            },
            RefEntityID = 113
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 140,
                OpenPath = {
                  Duration = 20,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  5.9,
                  3.9,
                  41.06
                },
                Rotation3D = {
                  0,
                  192.9,
                  180
                },
                Time = 0
              }
            },
            RefEntityID = 138
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  8.3,
                  2.87,
                  40.02
                },
                Rotation3D = {
                  0,
                  222.38,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 144
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  8.2,
                  3.2,
                  39.12
                },
                Rotation3D = {
                  0,
                  -67.9,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 146
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1021003_happy",
            DialogContentStr = "str_homestory_N17guide_90000107_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubushangren"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 2}
            },
            RefEntityID = 146
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000107_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 144
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000107_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 147,
                  Offset = {
                    0.2,
                    0,
                    0.5
                  }
                },
                FaceSeq = 3,
                Time = 0
              }
            },
            RefEntityID = 144
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
            RefEntityID = 147
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 152
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1021003_happy",
            DialogContentStr = "str_homestory_N17guide_90000107_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubushangren"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "shy", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 2}
            },
            RefEntityID = 146
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000107_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  7.5,
                  3.8,
                  39.35
                },
                Rotation3D = {
                  5.49,
                  199,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 148
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 148,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  41.6,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    6.3,
                    2.9,
                    37.29
                  },
                  StartValue = {
                    5,
                    2.9,
                    36.27
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 2.1}
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    248,
                    0
                  },
                  StartValue = {
                    0,
                    342.7,
                    0
                  }
                },
                Time = 1.2
              },
              [2] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 113
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                Position3D = {
                  7.71,
                  2.9,
                  40
                },
                Rotation3D = {
                  0,
                  -150.8,
                  0
                },
                Time = 1
              }
            },
            RefEntityID = 144
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -126.6,
                  0
                },
                Time = 0.9
              }
            },
            RefEntityID = 146
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 147
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000107_7_dialog_content",
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
                Position3D = {
                  5.5,
                  4,
                  37.7
                },
                Rotation3D = {
                  10.5,
                  88,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 149
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 116
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000107_8_dialog_content",
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
            DialogContentStr = "str_homestory_N17guide_90000107_9_dialog_content",
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
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 113
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000107_10_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 150,
                  Style = 3
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 1
              },
              [2] = {PlayAnimation = "stand", Time = 3.5}
            },
            RefEntityID = 144
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  6.54,
                  3.72,
                  38.3
                },
                Rotation3D = {
                  2.6,
                  45,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 150
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000107_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  7.6,
                  2.9,
                  37.53
                },
                Time = 0
              }
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  7,
                  2.9,
                  36.85
                },
                Rotation3D = {
                  0,
                  41.7,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 116
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000107_12_dialog_content",
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
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  6.4,
                  4,
                  37.18
                },
                Rotation3D = {
                  10,
                  88,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 149
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 113
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000107_13_dialog_content",
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
                  EntityID = 148,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  7.39,
                  3.8,
                  38.36
                },
                Rotation3D = {
                  2,
                  -178.3,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 148
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "think",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    23.8,
                    0
                  },
                  StartValue = {
                    0,
                    41.7,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000107_14_dialog_content",
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
                FaceSeq = 7,
                PlayAnimator = "sigh",
                Time = 0
              },
              [2] = {
                PlayAnimator = "idle",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    35,
                    0
                  },
                  StartValue = {
                    0,
                    23.8,
                    0
                  }
                },
                Time = 2
              },
              [3] = {
                Bubble = {
                  ID = 151,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                Time = 0.6
              }
            },
            RefEntityID = 116
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
              [2] = {Active = false, Time = 2.2}
            },
            RefEntityID = 151
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 153
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000107_15_dialog_content",
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
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 11,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 113
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 116
          }
        },
        [16] = {
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
              [2] = {Active = true, Time = 3}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
