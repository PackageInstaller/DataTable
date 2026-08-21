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
      Name = "贝菲尔",
      PetID = 1601261,
      Resource = "1601261.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
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
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
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
      Name = "固定机位3",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      Name = "固定机位6",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 13,
      Name = "固定机位7",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 14,
      Name = "固定机位8",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 15,
      Name = "固定机位9",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 16,
      Name = "固定机位10",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 17,
      Name = "固定机位11",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 18,
      Name = "固定机位3.2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 19,
      Name = "固定机位2.1",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [20] = {
      EntityID = 20,
      Name = "爱心bubble2",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [21] = {
      EntityID = 21,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [22] = {
      EntityID = 22,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "开心音效",
      Resource = "1717",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "感叹音效",
      Resource = "1714",
      Type = "Sound"
    }
  },
  ID = 90050105,
  Name = "home_story_N24diaoyu_1_5",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601261_flushed",
            DialogContentStr = "str_homestory_N24diaoyu_90050105_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.4
              },
              [2] = {ShowContent = 0.02, Time = 1.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
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
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Bubble = {
                  ID = 20,
                  Offset = {
                    0,
                    0.15,
                    0
                  }
                },
                FaceSeq = 3,
                Position3D = {
                  -80.07,
                  -4.34,
                  -70.78
                },
                Rotation3D = {
                  0,
                  49.25,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -79,
                  -4.3,
                  -70
                },
                Rotation3D = {
                  0,
                  -129,
                  0
                },
                Scaling3D = {
                  1.02,
                  1.02,
                  1.02
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -79,
                  -4.3,
                  -71
                },
                Rotation3D = {
                  0,
                  -60,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -79.6,
                  -3.604,
                  -67.64
                },
                Rotation3D = {
                  -4,
                  180,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 7
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.5,
                VC = {
                  Duration = 1,
                  EntityID = 8,
                  Style = 2
                }
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.6,
                  -3.6,
                  -67.7
                },
                Rotation3D = {
                  -4,
                  180,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0.4
              }
            },
            RefEntityID = 20
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 24
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N24diaoyu_90050105_2_dialog_content",
            DialogDir = 3,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.9,
                  -3.4,
                  -69.3
                },
                Rotation3D = {
                  0,
                  140.9,
                  0
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
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -14.9,
                    0
                  },
                  StartValue = {
                    0,
                    300,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5},
              [3] = {PlayAnimation = "happy", Time = 0.6},
              [4] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 5
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050105_3_dialog_content",
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
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -80.5,
                  -4.3,
                  -69.5
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    133.9,
                    0
                  },
                  StartValue = {
                    0,
                    133.9,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          ButtonVisible = false
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050105_4_dialog_content",
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
                Active = true,
                Position3D = {
                  -79.8,
                  -3.35,
                  -70.4
                },
                Rotation3D = {
                  0,
                  64,
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
              [1] = {
                Active = true,
                Blink = {
                  Duration = 0.3,
                  EndValue = 0.6,
                  StartValue = 1
                },
                Layer = 2,
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 6
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1500331_Shocked",
            DialogContentStr = "str_homestory_N24diaoyu_90050105_5_dialog_content",
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
                Active = true,
                Blink = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0.6
                },
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78,
                  -3.3,
                  -67.8
                },
                Rotation3D = {
                  4.2,
                  -146,
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
                  Duration = 0,
                  EntityID = 12,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 0.5,
                  EndValue = {
                    -80.2,
                    -4.3,
                    -69.7
                  },
                  StartValue = {
                    -80.5,
                    -4.3,
                    -69.5
                  }
                }
              },
              [2] = {
                Bubble = {
                  ID = 21,
                  Offset = {
                    0.1,
                    0.1,
                    0
                  }
                },
                FaceSeq = 8,
                PlayAnimation = "stand",
                Time = 0.5
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -84,
                    0
                  },
                  StartValue = {
                    0,
                    231,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.5}
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -54.4,
                    0
                  },
                  StartValue = {
                    0,
                    345.1,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 5
          },
          [8] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    15.5,
                    0
                  },
                  StartValue = {
                    0,
                    49.3,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 3
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
                Time = 0.5
              }
            },
            RefEntityID = 21
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050105_6_dialog_content",
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
              [1] = {PlayAnimator = "talk", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 6
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050105_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.4,
                  -3.4,
                  -69.3
                },
                Rotation3D = {
                  4.2,
                  -146,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 13,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    193.1,
                    0
                  },
                  StartValue = {
                    0,
                    133.9,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78.6,
                  -4.3,
                  -70.8
                },
                Rotation3D = {
                  0,
                  -109,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78.5,
                  -4.3,
                  -69.9
                },
                Rotation3D = {
                  0,
                  -143.3,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050105_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.5,
                  -3.4,
                  -69.8
                },
                Rotation3D = {
                  0,
                  -150,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 14,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                Rotate3D = {
                  Duration = 0.3,
                  EndValue = {
                    0,
                    32,
                    0
                  },
                  StartValue = {
                    0,
                    15.5,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N24diaoyu_90050105_9_dialog_content",
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
                  -79.8,
                  -3.4,
                  -71.3
                },
                Rotation3D = {
                  0,
                  66.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 15,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                Position3D = {
                  -79.5,
                  -4.3,
                  -70.1
                },
                Time = 0.3
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050105_10_dialog_content",
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
                Position3D = {
                  -79.94,
                  -3.4,
                  -71.45
                },
                Rotation3D = {
                  0,
                  45.5,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 16,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -79.05,
                    -4.3,
                    -70.45
                  },
                  StartValue = {
                    -78.5,
                    -4.3,
                    -69.9
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1}
            },
            RefEntityID = 6
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N24diaoyu_90050105_11_dialog_content",
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
                Position3D = {
                  -80,
                  -3.4,
                  -71.4
                },
                Rotation3D = {
                  0,
                  45.5,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 17,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.7,
                  -4.3,
                  -71.8
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050105_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_everyone"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -79.4,
                  1.7,
                  -63.2
                },
                Rotation3D = {
                  38,
                  180,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 18,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.1,
                VC = {
                  Duration = 3,
                  EntityID = 19,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.4,
                  2.37,
                  -62.97
                },
                Rotation3D = {
                  38,
                  180,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 19
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 22,
                  Offset = {
                    0,
                    0.15,
                    0
                  }
                },
                PlayAnimator = "happy",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 6
          },
          [6] = {
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
            RefEntityID = 22
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 24
          }
        },
        [13] = {
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
