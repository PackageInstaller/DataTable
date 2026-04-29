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
      Name = "菲莉诗",
      PetID = 1400571,
      Resource = "1400571.prefab",
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
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      Name = "抖动机位-大",
      Resource = "vc_0005.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [12] = {
      EntityID = 12,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [13] = {
      EntityID = 13,
      Name = "汗水bubble",
      Resource = "eff_jy_meme_huangzhang.prefab",
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
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "诙谐BGM",
      Resource = "37",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      Name = "鱼溜走",
      Resource = "10262",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      Name = "人从水里冒出",
      Resource = "10302",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      Name = "水打击",
      Resource = "10093",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      Name = "鱼竿",
      Resource = "hl_tool_5012001_z_story.prefab",
      Type = "Model"
    }
  },
  ID = 90050601,
  Name = "home_story_N24diaoyu_6_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_1_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
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
              [2] = {StartBgm = 16, Time = 0.5}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                OpenPath = {
                  Duration = 10,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -90.3,
                  -2.78,
                  100.31
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -91,
                  -3.39,
                  98
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 7,
                Position3D = {
                  -90.8,
                  -3.96,
                  97.9
                },
                Time = 0
              },
              [2] = {PlayAnimator = "sigh", Time = 0.7}
            },
            RefEntityID = 4
          },
          [7] = {
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
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_2_dialog_content",
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
                Bubble = {
                  ID = 14,
                  Offset = {
                    0,
                    0.2,
                    0
                  }
                },
                FaceSeq = 6,
                PlayAnimator = "happy",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
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
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 15
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_3_dialog_content",
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
            DialogContentStr = "str_homestory_N24diaoyu_90050601_4_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_5_dialog_content",
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
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_6_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.1
              },
              [2] = {ShowContent = 0.02, Time = 3.3}
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
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "fish",
                Position3D = {
                  -96.97,
                  -5.04,
                  97.9
                },
                Rotation3D = {
                  0,
                  -70.11,
                  0
                },
                Time = 0.7
              },
              [2] = {
                Bubble = {
                  ID = 11,
                  Offset = {
                    -0.1,
                    0.1,
                    0
                  }
                },
                FaceSeq = 4,
                Time = 3.1
              }
            },
            RefEntityID = 4
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
                  -98.8,
                  -4.3,
                  98.2
                },
                Time = 0.9
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -91,
                  -4.8,
                  95.9
                },
                Time = 0.9
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -98.3,
                  -4.3,
                  98.5
                },
                Rotation3D = {
                  -0.2,
                  113.1,
                  0
                },
                Time = 3.1
              }
            },
            RefEntityID = 7
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 3.1,
                VC = {
                  Duration = 0.2,
                  EntityID = 7,
                  Style = 2
                }
              }
            }
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
                Time = 3.1
              }
            },
            RefEntityID = 11
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 3.1}
            },
            RefEntityID = 12
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.8}
            },
            RefEntityID = 18
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimator = "toss_idle",
                Position3D = {
                  -96.97,
                  -5.04,
                  97.9
                },
                Rotation3D = {
                  0,
                  -70.11,
                  0
                },
                Time = 0.7
              }
            },
            RefEntityID = 21
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_7_dialog_content",
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
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_8_dialog_content",
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
                PlayAnimator = "fish_success",
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -97.8,
                  -4.15,
                  98.4
                },
                Rotation3D = {
                  2.6,
                  121.6,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.2,
                  EntityID = 8,
                  Style = 2
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          },
          [8] = {
            KeyFrames = {
              [1] = {PlayAnimator = "success", Time = 0},
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 21
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1400571_sleep",
            DialogContentStr = "str_homestory_N24diaoyu_90050601_9_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Bubble = {
                  ID = 13,
                  Offset = {
                    0.4,
                    0.1,
                    -0.1
                  }
                },
                FaceSeq = 6,
                PlayAnimation = "sad",
                Position3D = {
                  -97.6,
                  -4.85,
                  97.4
                },
                Rotation3D = {
                  0,
                  84,
                  0
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -96.87,
                  -3.8,
                  97.45
                },
                Rotation3D = {
                  8.6,
                  -90.9,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [5] = {
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
                  Duration = 0.5,
                  EntityID = 8,
                  Style = 2
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -95.77,
                  -3.8,
                  97.5
                },
                Rotation3D = {
                  8.6,
                  -90.9,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 4
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.3,
                  0.3,
                  0.3
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 17, Time = 0}
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_10_dialog_content",
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
            KeyFrames = {
              [1] = {
                Position3D = {
                  -93.82,
                  -3.29,
                  98.5
                },
                Rotation3D = {
                  4.23,
                  118.6,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Position3D = {
                  -92.6,
                  -4.2,
                  97.9
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 13
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_11_dialog_content",
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
                Position3D = {
                  -93.82,
                  -3.29,
                  98.5
                },
                Rotation3D = {
                  4.23,
                  118.6,
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
              },
              [2] = {
                Time = 0.4,
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
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_12_dialog_content",
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
        [13] = {
          [1] = {
            Body = "base_icon_1400571_cute",
            DialogContentStr = "str_homestory_N24diaoyu_90050601_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
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
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 6
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050601_14_dialog_content",
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
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1400571_cute",
            DialogContentStr = "str_homestory_N24diaoyu_90050601_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
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
              [1] = {PlayAnimation = "angry", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 6
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
