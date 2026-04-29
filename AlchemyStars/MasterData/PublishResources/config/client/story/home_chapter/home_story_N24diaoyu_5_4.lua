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
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [12] = {
      EntityID = 12,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "汗水bubble",
      Resource = "eff_jy_meme_huangzhang.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 14,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    },
    [15] = {
      EntityID = 15,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 16,
      Name = "爱心bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 17,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [18] = {
      EntityID = 18,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    },
    [19] = {
      EntityID = 19,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    }
  },
  ID = 90050504,
  Name = "home_story_N24diaoyu_5_4",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050504_1_dialog_content",
            DialogDir = 0,
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
                Look = 7,
                Position3D = {
                  -34,
                  -4.2,
                  -110
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
                  -4.41,
                  -111.2
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
                  151.3,
                  0
                },
                Time = 0.2
              },
              [2] = {
                Bubble = {
                  ID = 13,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                PlayAnimator = "surprise",
                Time = 1
              },
              [3] = {PlayAnimator = "idle", Time = 3}
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
                  115.69,
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
                FaceSeq = 5,
                Position3D = {
                  -38.1,
                  -4.95,
                  -112.4
                },
                Rotation3D = {
                  0,
                  -18,
                  0
                },
                Time = 0.2
              },
              [2] = {
                Bubble = {
                  ID = 12,
                  Offset = {
                    0.2,
                    0.1,
                    0
                  }
                },
                PlayAnimation = "surprise",
                Time = 0.7
              },
              [3] = {PlayAnimation = "stand", Time = 2.5}
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
              [2] = {StartBgm = 11, Time = 0.5}
            }
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
                Time = 0.7
              }
            },
            RefEntityID = 12
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 1
              }
            },
            RefEntityID = 13
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 19
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050504_2_dialog_content",
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
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050504_3_dialog_content",
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
              [1] = {PlayAnimator = "think", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1601661_cry_surprise",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_4_dialog_content",
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
                  -38.4,
                  -4.02,
                  -110.2
                },
                Rotation3D = {
                  9.26,
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
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 15,
                  Offset = {
                    -0.07,
                    0.1,
                    0.2
                  }
                },
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
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
            RefEntityID = 15
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 14
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601661_cry_surprise",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_5_dialog_content",
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
        [6] = {
          [1] = {
            Body = "base_icon_1601661_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_6_dialog_content",
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
                Position3D = {
                  -39.1,
                  -3.98,
                  -111.09
                },
                Rotation3D = {
                  6.38,
                  -63.79,
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
              [1] = {FaceSeq = 9, Time = 0}
            },
            RefEntityID = 6
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601751_smile",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_7_dialog_content",
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
                Bubble = {
                  ID = 16,
                  Offset = {
                    0,
                    0.1,
                    -0.25
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -101.7,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.4,
                  0.4,
                  0.4
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050504_8_dialog_content",
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
                  -39.6,
                  -4,
                  -111.1
                },
                Rotation3D = {
                  4.3,
                  71.6,
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
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050504_9_dialog_content",
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
                FaceSeq = 1,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601661_surprise",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 17,
                  Offset = {
                    0,
                    0.1,
                    0.1
                  }
                },
                FaceSeq = 4,
                Position3D = {
                  -38.4,
                  -4.9,
                  -112.1
                },
                Rotation3D = {
                  0,
                  -26.28,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 8,
                  Style = 2
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -39.53,
                  -4,
                  -110.2
                },
                Rotation3D = {
                  9.5,
                  141.54,
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
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    168.5,
                    0
                  },
                  StartValue = {
                    0,
                    258.3,
                    0
                  }
                },
                Time = 0.4
              },
              [2] = {PlayAnimator = "idle", Time = 0.9}
            },
            RefEntityID = 5
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
            RefEntityID = 17
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601661_surprise",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_11_dialog_content",
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
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050504_12_dialog_content",
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
                  EntityID = 9,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -38.9,
                  -4.13,
                  -113
                },
                Rotation3D = {
                  3.21,
                  12.5,
                  0.76
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1601661_surprise",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_13_dialog_content",
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
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 9, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1601661_angry",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_14_dialog_content",
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
                Bubble = {
                  ID = 18,
                  Offset = {
                    -0.25,
                    0.1,
                    0.4
                  }
                },
                FaceSeq = 4,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.4,
                  0.4,
                  0.4
                },
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601661_angry",
            DialogContentStr = "str_homestory_N24diaoyu_90050504_15_dialog_content",
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
                  -39,
                  -4,
                  -111
                },
                Rotation3D = {
                  10.03,
                  151.8,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.2,
                  EntityID = 10,
                  Style = 2
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
