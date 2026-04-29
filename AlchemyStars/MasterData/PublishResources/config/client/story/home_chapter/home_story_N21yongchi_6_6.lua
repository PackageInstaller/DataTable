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
      Name = "轨道镜头10",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [4] = {
      EntityID = 4,
      Name = "卡莲",
      PetID = 1600061,
      Resource = "1600061.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
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
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [8] = {
      EntityID = 8,
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
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
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 14,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "爱心bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 16,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      Name = "问号",
      Resource = "1713",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      Name = "欢呼",
      Resource = "10293",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      Name = "诙谐BGM",
      Resource = "37",
      Type = "Sound"
    }
  },
  ID = 90020606,
  Name = "home_story_N21yongchi_6_6",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.4
              },
              [2] = {ShowContent = 0.02, Time = 1.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Look = 7,
                Position3D = {
                  -0.98,
                  5,
                  27.2
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 3,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.66,
                  2.8,
                  19.23
                },
                Rotation3D = {
                  0,
                  -27.5,
                  0
                },
                Time = 0
              },
              [2] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    403.1,
                    0
                  },
                  StartValue = {
                    0,
                    332.5,
                    0
                  }
                },
                Time = 1.9
              },
              [3] = {PlayAnimation = "stand", Time = 2.4}
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -2.13,
                  2.8,
                  21.04
                },
                Rotation3D = {
                  0,
                  147.1,
                  0
                },
                Time = 0
              },
              [2] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    103.3,
                    0
                  },
                  StartValue = {
                    0,
                    147.1,
                    0
                  }
                },
                Time = 1.8
              },
              [3] = {PlayAnimation = "stand", Time = 2.8}
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 7,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  -132.1,
                  0
                },
                Time = 0.4,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    0.8,
                    2.8,
                    21.03
                  },
                  StartValue = {
                    1.2,
                    2.8,
                    21.5
                  }
                }
              },
              [2] = {
                Bubble = {
                  ID = 12,
                  Offset = {
                    -0.15,
                    0.1,
                    0.5
                  }
                },
                PlayAnimator = "sigh",
                Time = 1.4
              }
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.66,
                  3.1,
                  19.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [9] = {
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
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 16
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1600061_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020606_2_dialog_content",
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
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020606_3_dialog_content",
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
              [1] = {PlayAnimation = "sad", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.4}
            },
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_4_dialog_content",
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
                  -0.7,
                  3.9,
                  20.5
                },
                Rotation3D = {
                  8.2,
                  73,
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
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_5_dialog_content",
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
            RefEntityID = 6
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1600061_sigh",
            DialogContentStr = "str_homestory_N21yongchi_90020606_6_dialog_content",
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
                Position3D = {
                  0.94,
                  3.87,
                  22.14
                },
                Rotation3D = {
                  6.86,
                  -157,
                  -1.2
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_7_dialog_content",
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
                  EntityID = 8,
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
            RefEntityID = 6
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_8_dialog_content",
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
        [9] = {
          [1] = {
            Body = "base_icon_1600061_swear",
            DialogContentStr = "str_homestory_N21yongchi_90020606_9_dialog_content",
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
                Position3D = {
                  0.94,
                  3.87,
                  22.14
                },
                Rotation3D = {
                  6.86,
                  -157,
                  -1.2
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020606_10_dialog_content",
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
            KeyFrames = {
              [1] = {
                Position3D = {
                  1.88,
                  3.93,
                  20.38
                },
                Rotation3D = {
                  9.125,
                  -105.4,
                  1.048
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
                  Duration = 1,
                  EntityID = 10,
                  Style = 3
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    74.6,
                    0
                  },
                  StartValue = {
                    0,
                    103.3,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -1,
                    2.8,
                    20.1
                  },
                  StartValue = {
                    -2.13,
                    2.8,
                    21.04
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.4}
            },
            RefEntityID = 5
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020606_11_dialog_content",
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
        [12] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N21yongchi_90020606_12_dialog_content",
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
                Active = true,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 14,
                  Offset = {
                    0,
                    0.1,
                    0.05
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_13_dialog_content",
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
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2},
              [3] = {
                Bubble = {
                  ID = 13,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.4,
                  3.85,
                  19.72
                },
                Rotation3D = {
                  6.05,
                  41.7,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [5] = {
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
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020606_14_dialog_content",
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
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 14
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020606_15_dialog_content",
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
              [1] = {PlayAnimation = "sad", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.2}
            },
            RefEntityID = 5
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_16_dialog_content",
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
                  EntityID = 8,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.2,
                VC = {
                  Duration = 0.2,
                  EntityID = 11,
                  Style = 1
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2.1},
              [3] = {PlayAnimator = "happy", Time = 0.2}
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  3.85,
                  20.1
                },
                Rotation3D = {
                  6,
                  41,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 20
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 21, Time = 0}
            }
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_17_dialog_content",
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
        [18] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020606_18_dialog_content",
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
            DialogContentStr = "str_homestory_N21yongchi_90020606_19_dialog_content",
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
            RefEntityID = 6
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020606_20_dialog_content",
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
                  Duration = 0,
                  EntityID = 3,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.8}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 10,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  2.6,
                  4,
                  20.15
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -2.5,
                  3.1,
                  19.9
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020606_21_dialog_content",
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
          }
        },
        [22] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 3.6}
            },
            RefEntityID = 2
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0.5
              }
            }
          }
        }
      }
    }
  },
  StartParagraph = 1
}
