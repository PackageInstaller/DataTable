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
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 125,
      Name = "雷吉娜",
      PetID = 1500181,
      Resource = "1500181.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [5] = {
      EntityID = 126,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [6] = {
      EntityID = 127,
      Name = "老山",
      Resource = "1030002.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [7] = {
      EntityID = 128,
      Name = "阿吉",
      Resource = "1030004.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [8] = {
      EntityID = 129,
      Name = "小咋",
      Resource = "1030006.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [9] = {
      EntityID = 130,
      Name = "壮壮",
      Resource = "1030003.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [10] = {
      EntityID = 131,
      Name = "绿肚",
      Resource = "1030005.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [11] = {
      EntityID = 132,
      Name = "固定机位1",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 133,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 134,
      Name = "抖动机位-大",
      Resource = "vc_0005.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 135,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 136,
      Name = "抖动机位-小",
      Resource = "vc_0004.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 137,
      Name = "抖动机位-小-2",
      Resource = "vc_0004.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 138,
      Name = "抖动机位-小-1.5",
      Resource = "vc_0004.prefab",
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 139,
      Name = "抖动机位-小-2.5",
      Resource = "vc_0004.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 140,
      Name = "固定机位3",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [20] = {
      EntityID = 141,
      Name = "固定机位4",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [21] = {
      EntityID = 142,
      Name = "轨道机位1",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [22] = {
      EntityID = 143,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [23] = {
      EntityID = 144,
      Name = "固定机位5",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [24] = {
      EntityID = 145,
      Name = "固定机位6",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [25] = {
      EntityID = 146,
      Name = "轨道机位2",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [26] = {
      EntityID = 147,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [27] = {
      EntityID = 148,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [28] = {
      EntityID = 149,
      Name = "爱心bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [29] = {
      EntityID = 150,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    }
  },
  ID = 90010601,
  Name = "home_story_N19chuanshanjia_6_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1500181_ecstasy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_1_dialog_content",
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
            SpeakerNameStr = "ui_story_name_leijina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {Active = false, Time = 0.7}
            },
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 51,
                Time = 0.5
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 135
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.36,
                  6.44,
                  11.58
                },
                Rotation3D = {
                  0,
                  185,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 132
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                VC = {
                  Duration = 0,
                  EntityID = 132,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.7,
                VC = {
                  Duration = 0.5,
                  EntityID = 133,
                  Style = 2
                }
              },
              [3] = {
                Time = 1.4,
                VC = {
                  Duration = 0,
                  EntityID = 134,
                  Style = 0
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0.26,
                  6,
                  12.95
                },
                Rotation3D = {
                  -0.4,
                  186.04,
                  0
                },
                Time = 0.7
              }
            },
            RefEntityID = 133
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                PlayAnimation = "angry",
                Position3D = {
                  0.13,
                  5.38,
                  10.66
                },
                Time = 0
              },
              [2] = {
                Bubble = {
                  ID = 147,
                  Offset = {
                    0.03,
                    0.15,
                    -0.1
                  }
                },
                Time = 1.4
              }
            },
            RefEntityID = 125
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.26,
                  6,
                  12.95
                },
                Rotation3D = {
                  -0.4,
                  186.04,
                  0
                },
                Time = 1.4
              }
            },
            RefEntityID = 134
          },
          [9] = {
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
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_2_dialog_content",
            DialogDir = 0,
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
                Position3D = {
                  1.3,
                  4.2,
                  17.55
                },
                Rotation3D = {
                  13.7,
                  -49.81,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 136
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 136,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                Position3D = {
                  -0.43,
                  2.9,
                  19.85
                },
                Rotation3D = {
                  0,
                  164.7,
                  0
                },
                Time = 0
              },
              [2] = {
                Bubble = {
                  ID = 148,
                  Offset = {
                    0,
                    0.05,
                    -0.1
                  }
                },
                PlayAnimator = "sigh",
                Time = 0.8
              },
              [3] = {PlayAnimator = "idle", Time = 2.7}
            },
            RefEntityID = 124
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                Position3D = {
                  -1.5,
                  2.9,
                  19.17
                },
                Rotation3D = {
                  0,
                  -208.83,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 126
          },
          [6] = {
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
            RefEntityID = 148
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1500331_angry2",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_3_dialog_content",
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
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    78,
                    0
                  },
                  StartValue = {
                    0,
                    151.2,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 126
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    220.9,
                    0
                  },
                  StartValue = {
                    0,
                    164.7,
                    0
                  }
                },
                Time = 0.1
              },
              [2] = {PlayAnimator = "idle", Time = 0.6}
            },
            RefEntityID = 124
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_4_dialog_content",
            DialogDir = 0,
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
                PlayAnimation = "move",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    203,
                    0
                  },
                  StartValue = {
                    0,
                    78,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -5.5,
                    2.9,
                    15.85
                  },
                  StartValue = {
                    -1.5,
                    2.9,
                    19.2
                  }
                }
              }
            },
            RefEntityID = 126
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "move",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    214.7,
                    0
                  },
                  StartValue = {
                    0,
                    220.9,
                    0
                  }
                },
                Time = 0.5,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -4.1,
                    2.9,
                    16.88
                  },
                  StartValue = {
                    -0.4,
                    2.9,
                    19.9
                  }
                }
              }
            },
            RefEntityID = 124
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.6
              }
            },
            RefEntityID = 123
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 148
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_5_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              },
              [2] = {ShowContent = 0.02, Time = 1.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 5,
                PlayAnimator = "awkward",
                Position3D = {
                  -51.47,
                  0,
                  10.04
                },
                Rotation3D = {
                  0,
                  -110.6,
                  0
                },
                Time = 0.5
              },
              [2] = {PlayAnimator = "idle", Time = 2.4}
            },
            RefEntityID = 124
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 142,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 126
          },
          [5] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 123
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -54.2,
                  0.9,
                  9.78
                },
                Time = 0
              },
              [2] = {
                Look = 143,
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 142
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  32.91,
                  -7.53,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 143
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_6_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_7_dialog_content",
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
                FaceSeq = 7,
                PlayAnimator = "sigh",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 124
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1030004_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_8_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 144,
                  Style = 3
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -53.3,
                  0.9,
                  7
                },
                Rotation3D = {
                  7,
                  179,
                  -0.64
                },
                Time = 0
              }
            },
            RefEntityID = 144
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                PlayAnimation = "idle",
                Position3D = {
                  -54,
                  0,
                  4.14
                },
                Rotation3D = {
                  0,
                  84.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 127
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                PlayAnimation = "idle",
                Position3D = {
                  -52.47,
                  0,
                  4
                },
                Rotation3D = {
                  0,
                  -85.67,
                  0
                },
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 2.9},
              [3] = {
                Bubble = {
                  ID = 149,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 1.2
              }
            },
            RefEntityID = 128
          },
          [6] = {
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
            RefEntityID = 149
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1030004_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -53.23,
                  0,
                  7.27
                },
                Rotation3D = {
                  0,
                  175.6,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 124
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_10_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 145,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -53.8,
                  0.9,
                  0.96
                },
                Rotation3D = {
                  6.6,
                  12.21,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 145
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -53.2,
                    0,
                    5.73
                  },
                  StartValue = {
                    -53.2,
                    0,
                    7.27
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.5}
            },
            RefEntityID = 124
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    27.7,
                    0
                  },
                  StartValue = {
                    0,
                    84.4,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 127
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    337.1,
                    0
                  },
                  StartValue = {
                    0,
                    274.3,
                    0
                  }
                },
                Time = 0.8
              },
              [2] = {PlayAnimation = "idle", Time = 1.3}
            },
            RefEntityID = 128
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1030002_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_12_dialog_content",
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
              [1] = {PlayAnimator = "think", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 124
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1030002_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_14_dialog_content",
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
              [1] = {PlayAnimator = "awkward", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 124
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1030002_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -54.55,
                  0.9,
                  7.32
                },
                Rotation3D = {
                  7,
                  154,
                  -0.64
                },
                Time = 0
              }
            },
            RefEntityID = 140
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 140,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    316.8,
                    0
                  },
                  StartValue = {
                    0,
                    225.2,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 129
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    267.8,
                    0
                  },
                  StartValue = {
                    0,
                    200.2,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 130
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    310,
                    0
                  },
                  StartValue = {
                    0,
                    217.3,
                    0
                  }
                },
                Time = 0.3
              }
            },
            RefEntityID = 131
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1030006_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_xiaoza"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -74.7,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -51.12,
                    0,
                    5.2
                  },
                  StartValue = {
                    -49,
                    0,
                    6
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 2}
            },
            RefEntityID = 129
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -166.37,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -52.1,
                    0,
                    9
                  },
                  StartValue = {
                    -51.6,
                    0,
                    10.4
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 2}
            },
            RefEntityID = 130
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 5,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -134.5,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -51.11,
                    0,
                    7.5
                  },
                  StartValue = {
                    -50.5,
                    0,
                    8.7
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 1.5}
            },
            RefEntityID = 131
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 145,
                  Style = 0
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "surprise",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    38,
                    0
                  },
                  StartValue = {
                    0,
                    144.8,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 124
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -53.4,
                  1.5,
                  1
                },
                Rotation3D = {
                  14.99,
                  10.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 145
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1030003_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_zhuangzhuang"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    25.2,
                    0
                  },
                  StartValue = {
                    0,
                    27.7,
                    0
                  }
                },
                Time = 0.1
              }
            },
            RefEntityID = 127
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    363.6,
                    0
                  },
                  StartValue = {
                    0,
                    337.1,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimation = "idle", Time = 0.7}
            },
            RefEntityID = 128
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1030005_sad",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lvdu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 150,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 131
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
            RefEntityID = 150
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1030004_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 140,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -51,
                  1.1,
                  7.28
                },
                Rotation3D = {
                  12.8,
                  -144,
                  0.64
                },
                Time = 0
              }
            },
            RefEntityID = 140
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 124
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 128
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 127
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1030006_sad",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_xiaoza"
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1030002_sad",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 148
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 148,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                FaceSeq = 5,
                Time = 0.1
              }
            },
            RefEntityID = 127
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1030006_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_xiaoza"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 146,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 143,
                Position3D = {
                  -46,
                  2.25,
                  5.73
                },
                Rotation3D = {
                  14.99,
                  10.4,
                  0
                },
                Time = 0.1
              },
              [2] = {
                OpenPath = {
                  Duration = 10,
                  Ease = 2,
                  Position = 0
                },
                Time = 0.2
              }
            },
            RefEntityID = 146
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -53.2,
                  -0.3,
                  6.6
                },
                Time = 0
              }
            },
            RefEntityID = 143
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 129
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0.2}
            },
            RefEntityID = 131
          }
        },
        [23] = {
          [1] = {
            Body = "base_icon_1030004_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_23_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 128
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1030003_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_24_dialog_content",
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
            SpeakerNameStr = "ui_story_name_zhuangzhuang"
          }
        },
        [25] = {
          [1] = {
            Body = "base_icon_1030005_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_25_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lvdu"
          }
        },
        [26] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_26_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    22.48,
                    0
                  },
                  StartValue = {
                    0,
                    25.2,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1}
            },
            RefEntityID = 127
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    193.6,
                    0
                  },
                  StartValue = {
                    0,
                    38,
                    0
                  }
                },
                Time = 0.1
              },
              [2] = {PlayAnimator = "idle", Time = 0.6}
            },
            RefEntityID = 124
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_27_dialog_content",
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
              [1] = {PlayAnimator = "awkward", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 124
          }
        },
        [28] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_28_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 127
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010601_29_dialog_content",
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
              [1] = {PlayAnimator = "think", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 124
          }
        },
        [30] = {
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
              [2] = {Active = true, Time = 2.6}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
