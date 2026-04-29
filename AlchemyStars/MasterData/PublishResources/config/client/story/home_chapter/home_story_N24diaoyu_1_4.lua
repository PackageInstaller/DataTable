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
      FitSize = false,
      Name = "鱼竿",
      Resource = "yuganxiao.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = true,
      Name = "海面",
      Resource = "StoryBGhaimian.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      Name = "固定机位6",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "固定机位7",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 13,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      Name = "卡莲",
      PetID = 1600061,
      Resource = "1600061.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "固定机位8",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 16,
      Name = "固定机位9",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 17,
      Name = "固定机位10",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 18,
      Name = "固定机位11",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 19,
      Name = "固定机位12",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [20] = {
      EntityID = 20,
      Name = "固定机位13",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [21] = {
      EntityID = 21,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "诙谐",
      Resource = "37",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    }
  },
  ID = 90050104,
  Name = "home_story_N24diaoyu_1_4",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_6_dialog_content",
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
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                Position3D = {
                  -80.07,
                  -4.34,
                  -70.78
                },
                Rotation3D = {
                  0,
                  40,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [4] = {
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
                  -121.36,
                  0
                },
                Scaling3D = {
                  1.01,
                  1.01,
                  1.01
                },
                Time = 0.5
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -80.5,
                  -3.1,
                  -65.7
                },
                Rotation3D = {
                  0,
                  -190,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                VC = {
                  Duration = 0,
                  EntityID = 5,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.6,
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
                Active = true,
                Position3D = {
                  -80.5,
                  -3.3,
                  -65.7
                },
                Rotation3D = {
                  0,
                  -190,
                  0
                },
                Time = 0.6
              }
            },
            RefEntityID = 6
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 22,
                Time = 0.6
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050104_7_dialog_content",
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
                  ID = 21,
                  Offset = {
                    -0.1,
                    0.1,
                    0
                  }
                },
                FaceSeq = 6,
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
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
              },
              [2] = {Active = false, Time = 1.9}
            },
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050104_8_dialog_content",
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
        [4] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_9_dialog_content",
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
                  -79.1,
                  -3.26,
                  -68.9
                },
                Rotation3D = {
                  5,
                  -169,
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
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.1,
                VC = {
                  Duration = 1,
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
                  -79.1,
                  -3.3,
                  -68.9
                },
                Rotation3D = {
                  5,
                  -169,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 20
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050104_10_dialog_content",
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
                  -80.1,
                  -3.4,
                  -70.1
                },
                Rotation3D = {
                  0,
                  -274,
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
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1601261_refuse",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_beifeier"
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
                Active = true,
                Layer = 10,
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.2
              }
            },
            RefEntityID = 10
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601261_frown",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_12_dialog_content",
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
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050104_13_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.9,
                  -3.4,
                  -67.9
                },
                Rotation3D = {
                  0,
                  -190,
                  0
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
                  EntityID = 11,
                  Style = 0
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {FaceSeq = 5, Time = 0.2}
            },
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_14_dialog_content",
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_15_dialog_content",
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
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -79.5,
                  -3.4,
                  -69.6
                },
                Rotation3D = {
                  0,
                  -153,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050104_16_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            Options = {
              [1] = {
                Content = "str_homestory_N24diaoyu_90050104_17_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "str_homestory_N24diaoyu_90050104_18_option_content",
                NextParagraphID = 2
              },
              [3] = {
                Content = "str_homestory_N24diaoyu_90050104_19_option_content",
                NextParagraphID = 2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -80.1,
                  -3.4,
                  -70.1
                },
                Rotation3D = {
                  0,
                  -274,
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
                  Duration = 1,
                  EntityID = 8,
                  Style = 1
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
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050104_20_dialog_content",
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
                FaceSeq = 6,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050104_21_dialog_content",
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
                  -81.9,
                  -4.3,
                  -69.1
                },
                Rotation3D = {
                  0,
                  140,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1600061_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_22_dialog_content",
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
                  -76.45,
                  -3.3,
                  -65.48
                },
                Rotation3D = {
                  0,
                  -144,
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
                  Duration = 0,
                  EntityID = 15,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.1,
                VC = {
                  Duration = 1.4,
                  EntityID = 16,
                  Style = 1
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -76.66,
                  -3.3,
                  -65.33
                },
                Rotation3D = {
                  0,
                  -144,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -81.14,
                    -4.3,
                    -69.9
                  },
                  StartValue = {
                    -81.9,
                    -4.3,
                    -69.1
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 14
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_23_dialog_content",
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
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -7.04,
                    0
                  },
                  StartValue = {
                    0,
                    40,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_24_dialog_content",
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
                  -79.8,
                  -3.5,
                  -69.3
                },
                Rotation3D = {
                  0,
                  -160.2,
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
                LateUpdate = true,
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_25_dialog_content",
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
                  -79.4,
                  -3.5,
                  -68.8
                },
                Rotation3D = {
                  0,
                  -143,
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
                  Duration = 1,
                  EntityID = 18,
                  Style = 1
                }
              }
            }
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_26_dialog_content",
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
                  -78.4,
                  -3.5,
                  -68.2
                },
                Rotation3D = {
                  0,
                  -143,
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
                  Duration = 2,
                  EntityID = 19,
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
                    30,
                    0
                  },
                  StartValue = {
                    0,
                    353,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601261_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050104_27_dialog_content",
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
        [9] = {
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
