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
      Name = "菲雅",
      PetID = 1601661,
      Resource = "1601661.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [6] = {
      EntityID = 6,
      Name = "阿克西娅",
      PetID = 1601751,
      Resource = "1601751.prefab",
      SubType = "Pet",
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
      Name = "抖动机位-大",
      Resource = "vc_0005.prefab",
      SubType = 0,
      Type = "CameraVC"
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
      Name = "固定机位3",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
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
      Name = "丘布过场",
      Resource = "Uieff_zhuanchang.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 18,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "战斗",
      Resource = "9033",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "战斗2",
      Resource = "9000",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 90050503,
  Name = "home_story_N24diaoyu_5_3",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601661_provocation",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
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
                Look = 7,
                Position3D = {
                  -43.7,
                  -4,
                  -114.48
                },
                Time = 0.2
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -37.68,
                  -4.4,
                  -110
                },
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -38.7,
                  -4.95,
                  -110.8
                },
                Rotation3D = {
                  0,
                  175,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
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
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -40.69,
                  -4.94,
                  -110.3
                },
                Rotation3D = {
                  0,
                  114.9,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -38.1,
                  -4.95,
                  -112.4
                },
                Rotation3D = {
                  0,
                  -1.11,
                  0
                },
                Time = 0.2
              },
              [2] = {PlayAnimation = "angry", Time = 1.4},
              [3] = {PlayAnimation = "stand", Time = 3.2}
            },
            RefEntityID = 4
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 16, Time = 0.5}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050503_7_dialog_content",
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
                FaceSeq = 6,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    271.21,
                    0
                  },
                  StartValue = {
                    0,
                    175,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "happy", Time = 0.5},
              [3] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    324.1,
                    0
                  },
                  StartValue = {
                    0,
                    358.9,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {PlayAnimation = "stand", Time = 1.2}
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1601751_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -39.3,
                  -4,
                  -110.6
                },
                Rotation3D = {
                  6.1,
                  -79,
                  0.32
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
            RefEntityID = 6
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1601661_surprise",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -39.7,
                  -4,
                  -110.2
                },
                Rotation3D = {
                  9.8,
                  134.6,
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
                Bubble = {
                  ID = 12,
                  Offset = {
                    0,
                    0.1,
                    0.1
                  }
                },
                FaceSeq = 4,
                Time = 0
              }
            },
            RefEntityID = 4
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
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050503_10_dialog_content",
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
                FaceSeq = 6,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    155.5,
                    0
                  },
                  StartValue = {
                    0,
                    271.2,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "talk", Time = 0.5},
              [3] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 5
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1601661_angry",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 14,
                  Offset = {
                    -0.15,
                    0.1,
                    0.25
                  }
                },
                PlayAnimation = "angry",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    341.6,
                    0
                  },
                  StartValue = {
                    0,
                    324.1,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -39.1,
                  -4,
                  -110.9
                },
                Rotation3D = {
                  10.4,
                  145.77,
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
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601661_angry",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601661_angry",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601661_angry",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                Position3D = {
                  -38.7,
                  -4.9,
                  -111.1
                },
                Rotation3D = {
                  0,
                  160.6,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -40.17,
                  -4.9,
                  -110.3
                },
                Rotation3D = {
                  0,
                  129.7,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -38.8,
                  -4,
                  -111.32
                },
                Rotation3D = {
                  11.83,
                  145.77,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.2,
                  EntityID = 11,
                  Style = 2
                }
              }
            }
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050503_15_dialog_content",
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
                  -38.45,
                  -4.16,
                  -113.2
                },
                Rotation3D = {
                  1.7,
                  0,
                  1.17
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
                Bubble = {
                  ID = 15,
                  Offset = {
                    0,
                    0.1,
                    -0.1
                  }
                },
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 9, Time = 0}
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
            RefEntityID = 15
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601661_awkward",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
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
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1601661_awkward",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1601661_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1601661_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601661_provocation",
            DialogContentStr = "str_homestory_N24diaoyu_90050503_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "angry", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -38.8,
                  -4,
                  -111.32
                },
                Rotation3D = {
                  11.83,
                  145.77,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 9,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 11,
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
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.9
              },
              [2] = {Active = true, Time = 3.9}
            },
            RefEntityID = 2
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0.9
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.6
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 0.3
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 0.9
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Time = 0.9
              }
            },
            RefEntityID = 17
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 21
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 20
          }
        }
      }
    }
  },
  StartParagraph = 1
}
