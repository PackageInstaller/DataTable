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
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
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
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [7] = {
      EntityID = 7,
      Name = "卡莲",
      PetID = 1600061,
      Resource = "1600061.prefab",
      SubType = "Pet",
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
      Name = "固定机位5",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
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
      Name = "固定机位12",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 19,
      Name = "固定机位13",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [20] = {
      EntityID = 20,
      Name = "固定机位14",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [21] = {
      EntityID = 21,
      Name = "固定机位15",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [22] = {
      EntityID = 22,
      Name = "固定机位16",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [23] = {
      EntityID = 23,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [24] = {
      EntityID = 24,
      Name = "灵感bubble",
      Resource = "eff_jy_meme_linggan.prefab",
      Type = "Model"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "灵感",
      Resource = "1715",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "溪水",
      Resource = "10195",
      Type = "Sound"
    }
  },
  ID = 90050103,
  Name = "home_story_N24diaoyu_1_3",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_1_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
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
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 25,
                Time = 0.5
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -80.07,
                  -4.34,
                  -70.78
                },
                Rotation3D = {
                  0,
                  0,
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
                FaceSeq = 6,
                Position3D = {
                  -77.1,
                  -4.3,
                  -69.3
                },
                Rotation3D = {
                  0,
                  -121,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -78,
                  -3.4,
                  -69.6
                },
                Rotation3D = {
                  0,
                  77,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 5,
                  Style = 0
                }
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -76,
                  -4.3,
                  -69.6
                },
                Rotation3D = {
                  0,
                  -94,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -73.3,
                  -4.3,
                  -69.1
                },
                Rotation3D = {
                  1,
                  -110.5,
                  1
                },
                Time = 0.4
              }
            },
            RefEntityID = 7
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_2_dialog_content",
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
                Active = true,
                Position3D = {
                  -77.8,
                  -3.2,
                  -64.2
                },
                Rotation3D = {
                  0,
                  180,
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
              },
              [2] = {
                Time = 0.1,
                VC = {
                  Duration = 2,
                  EntityID = 9,
                  Style = 1
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
                    69,
                    0
                  },
                  StartValue = {
                    0,
                    0,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5},
              [3] = {
                PlayAnimation = "walk",
                Time = 0.9,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -79.53,
                    -4.34,
                    -70.79
                  },
                  StartValue = {
                    -80.07,
                    -4.34,
                    -70.78
                  }
                }
              },
              [4] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -77.8,
                  -3.4,
                  -64.2
                },
                Rotation3D = {
                  0,
                  180,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -75.24,
                    -4.3,
                    -70.35
                  },
                  StartValue = {
                    -73.3,
                    -4.3,
                    -69.1
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 7
          },
          [7] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.6}
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {PlayAnimator = "think", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 1.6}
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_3_dialog_content",
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
                  -78.8,
                  -3.4,
                  -69.7
                },
                Rotation3D = {
                  0,
                  -150,
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_4_dialog_content",
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
                  -81.4,
                  -3.6,
                  -70
                },
                Rotation3D = {
                  0,
                  90,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 0.5,
                  EndValue = {
                    -77.53,
                    -4.3,
                    -69.84
                  },
                  StartValue = {
                    -76,
                    -4.3,
                    -69.6
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    1,
                    -96.3,
                    1
                  },
                  StartValue = {
                    1,
                    249.5,
                    1
                  }
                },
                Time = 0
              },
              [2] = {Time = 0.5}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_5_dialog_content",
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
                Position3D = {
                  -78.7,
                  -3.4,
                  -69.9
                },
                Rotation3D = {
                  0,
                  90,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 12,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                Time = 0.5
              }
            },
            RefEntityID = 6
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1601261_flushed",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_6_dialog_content",
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
                  -78.8,
                  -3.4,
                  -69.7
                },
                Rotation3D = {
                  0,
                  -150,
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
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_7_dialog_content",
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
                  -77.7,
                  -3.4,
                  -68.3
                },
                Rotation3D = {
                  0,
                  -194,
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
              },
              [2] = {
                Time = 0.1,
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
                Position3D = {
                  -77.6,
                  -3.4,
                  -68.3
                },
                Rotation3D = {
                  0,
                  -194,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 14
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    1,
                    -65.4,
                    1
                  },
                  StartValue = {
                    1,
                    263.7,
                    1
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_8_dialog_content",
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
                FaceSeq = 9,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    12.7,
                    0
                  },
                  StartValue = {
                    0,
                    266,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_9_dialog_content",
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
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -93.3,
                    0
                  },
                  StartValue = {
                    0,
                    12.7,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -78.1,
                  -3.5,
                  -67.6
                },
                Rotation3D = {
                  0,
                  -183,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 15,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_10_dialog_content",
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
                FaceSeq = 8,
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -78.71,
                    -4.3,
                    -70.5
                  },
                  StartValue = {
                    -79.53,
                    -4.34,
                    -70.79
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78.3,
                  -3.5,
                  -67.3
                },
                Rotation3D = {
                  0,
                  -190,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [4] = {
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
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Position3D = {
                  -76.6,
                  -4.3,
                  -70.7
                },
                Rotation3D = {
                  0,
                  -83,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.7,
                  EndValue = {
                    -76.6,
                    -4.3,
                    -70.7
                  },
                  StartValue = {
                    -75,
                    -4.3,
                    -69.1
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 6
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_11_dialog_content",
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
                  -79,
                  -3.5,
                  -69.8
                },
                Rotation3D = {
                  0,
                  91,
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
                  Duration = 0,
                  EntityID = 17,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_12_dialog_content",
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 6
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1600061_sigh",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_13_dialog_content",
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
                  ID = 23,
                  Offset = {
                    0,
                    0.15,
                    0
                  }
                },
                FaceSeq = 5,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.6}
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 6
          },
          [4] = {
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
            RefEntityID = 23
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 26
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1601261_frown",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_14_dialog_content",
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
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78.3,
                  -3.5,
                  -67.3
                },
                Rotation3D = {
                  0,
                  -190,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_15_dialog_content",
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
                PlayAnimator = "happy",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 4
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1601261_sighs",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_16_dialog_content",
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_17_dialog_content",
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
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 4
          },
          ButtonVisible = false
        },
        [18] = {
          [1] = {
            Body = "base_icon_1601261_frown",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_18_dialog_content",
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_19_dialog_content",
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
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78.3,
                  -3.5,
                  -67.3
                },
                Rotation3D = {
                  0,
                  -195,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.2,
                  EntityID = 18,
                  Style = 1
                }
              }
            }
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_20_dialog_content",
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
                  -77.92,
                  -3.4,
                  -69.5
                },
                Rotation3D = {
                  0,
                  -143.3,
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
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1600061_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_21_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -78.2,
                  -3.4,
                  -70
                },
                Rotation3D = {
                  0,
                  113.94,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 19
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 19,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.1,
                VC = {
                  Duration = 0.5,
                  EntityID = 20,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -77.8,
                  -3.4,
                  -70.2
                },
                Rotation3D = {
                  0,
                  113.94,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 20
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1601261_refuse",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_22_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 16,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78.3,
                  -3.5,
                  -67.3
                },
                Rotation3D = {
                  0,
                  -190,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_23_dialog_content",
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
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_24_dialog_content",
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
                  -77.92,
                  -3.4,
                  -69.5
                },
                Rotation3D = {
                  0,
                  -143.3,
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
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_25_dialog_content",
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
          }
        },
        [26] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_26_dialog_content",
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
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_27_dialog_content",
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
                  -78.2,
                  -3.5,
                  -67.9
                },
                Rotation3D = {
                  0,
                  -195,
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
                  Duration = 0,
                  EntityID = 16,
                  Style = 0
                }
              }
            }
          }
        },
        [28] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_28_dialog_content",
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
                Active = true,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              }
            },
            RefEntityID = 24
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Bubble = {
                  ID = 24,
                  Offset = {
                    0,
                    0.15,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [29] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050103_29_dialog_content",
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 24
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050103_30_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -182,
                    0
                  },
                  StartValue = {
                    0,
                    239,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.5}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    16.6,
                    0
                  },
                  StartValue = {
                    0,
                    266.7,
                    0
                  }
                },
                Time = 0.8
              },
              [2] = {PlayAnimation = "stand", Time = 1.3}
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -27.3,
                    0
                  },
                  StartValue = {
                    0,
                    277,
                    0
                  }
                },
                Time = 0.8
              },
              [2] = {PlayAnimation = "stand", Time = 1.3}
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -78.2,
                  -3.5,
                  -67.9
                },
                Rotation3D = {
                  0,
                  -200,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 22,
                  Style = 1
                }
              }
            }
          }
        },
        [31] = {
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
