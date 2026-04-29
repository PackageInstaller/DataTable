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
      EntityID = 126,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [4] = {
      EntityID = 130,
      Name = "主角2",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [5] = {
      EntityID = 131,
      Name = "薇丝2",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [6] = {
      EntityID = 134,
      Name = "老山",
      Resource = "1030002.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [7] = {
      EntityID = 135,
      Name = "轨道镜头1010",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 144,
      Name = "恐尔贡",
      PetID = 1200501,
      Resource = "1200501.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [9] = {
      EntityID = 145,
      Name = "固定机位1",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 146,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [11] = {
      EntityID = 147,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 148,
      Name = "抖动机位",
      Resource = "vc_0003.prefab",
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 149,
      Name = "轨道镜头1010-2",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 150,
      Name = "老山2",
      Resource = "1030002.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [15] = {
      EntityID = 151,
      Name = "恐尔贡2",
      PetID = 1200501,
      Resource = "1200501.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [16] = {
      EntityID = 152,
      Name = "固定机位3",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 153,
      Name = "固定机位4",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 154,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [19] = {
      EntityID = 155,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 156,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    }
  },
  ID = 90010104,
  Name = "home_story_N19chuanshanjia_1_4",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_1_dialog_content",
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
                PlayAnimation = "idle",
                Rotation3D = {
                  0,
                  -3.67,
                  0
                },
                Time = 0.2,
                Translate3D = {
                  Duration = 0,
                  EndValue = {
                    71.6,
                    0,
                    -62.4
                  },
                  StartValue = {
                    71,
                    0,
                    -63
                  }
                }
              }
            },
            RefEntityID = 134
          },
          [3] = {
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
                Time = 0.5
              }
            },
            RefEntityID = 123
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 126,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  75,
                  1,
                  -61.2
                },
                Time = 0.5
              }
            },
            RefEntityID = 135
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                VC = {
                  Duration = 0,
                  EntityID = 135,
                  Style = 0
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  179.6,
                  0
                },
                Time = 0.5,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    71.5,
                    0,
                    -60.2
                  },
                  StartValue = {
                    72,
                    0,
                    -59.5
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.5}
            },
            RefEntityID = 130
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                Position3D = {
                  71,
                  0,
                  -61.2
                },
                Rotation3D = {
                  0,
                  112.6,
                  0
                },
                Time = 0.5
              },
              [2] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    66.3,
                    0
                  },
                  StartValue = {
                    0,
                    112.6,
                    0
                  }
                },
                Time = 1.6
              },
              [3] = {PlayAnimation = "stand", Time = 2.1}
            },
            RefEntityID = 131
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -14,
                  -12.3,
                  -74.24
                },
                Time = 0.5
              }
            },
            RefEntityID = 126
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_2_dialog_content",
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
                FaceSeq = 10,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 131
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  72.78,
                  0,
                  -54.6
                },
                Rotation3D = {
                  0,
                  200.9,
                  0
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
                Position3D = {
                  71.2,
                  0,
                  -56.7
                },
                Rotation3D = {
                  0,
                  175.3,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 146
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_3_dialog_content",
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
                  EntityID = 145,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  71.53,
                  0.9,
                  -58.9
                },
                Rotation3D = {
                  3.19,
                  8.12,
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
                Active = true,
                FaceSeq = 3,
                PlayAnimation = "move",
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    72.4,
                    0,
                    -56.39
                  },
                  StartValue = {
                    72.8,
                    0,
                    -54.6
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 144
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "talk",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 146
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_4_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kongergong"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "atk", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 1.8}
            },
            RefEntityID = 144
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  71.53,
                  0.9,
                  -58.02
                },
                Rotation3D = {
                  -3.09,
                  31.98,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 147
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 147,
                  Style = 3
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 130
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 131
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 9,
                Position3D = {
                  71,
                  0,
                  -61.4
                },
                Time = 0.4
              }
            },
            RefEntityID = 131
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1030002_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  72.3,
                  1.2,
                  -60.5
                },
                Rotation3D = {
                  20.2,
                  210.4,
                  0
                },
                Shake = {
                  Duration = 0.5,
                  Offset = {
                    1.5,
                    1.5,
                    1.5
                  },
                  Speed = 3,
                  Strength = 1
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
                FaceSeq = 4,
                PlayAnimation = "surprise",
                Rotation3D = {
                  0,
                  17.71,
                  0
                },
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 134
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 7,
                Position3D = {
                  71.1,
                  0,
                  -60.2
                },
                Rotation3D = {
                  0,
                  107.6,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 146
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  71.56,
                  0,
                  -59.5
                },
                Rotation3D = {
                  0,
                  176,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 144
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_6_dialog_content",
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
                  EntityID = 135,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 126,
                OpenPath = {
                  Duration = 6,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  75.9,
                  1,
                  -59.9
                },
                Time = 0
              }
            },
            RefEntityID = 135
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  70.6,
                  0.5,
                  -61.07
                },
                Time = 0
              }
            },
            RefEntityID = 126
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 10,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 131
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 154,
                  Offset = {
                    0.2,
                    0,
                    -0.2
                  }
                },
                FaceSeq = 4,
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
            RefEntityID = 154
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1030002_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    -1.4,
                    0
                  },
                  StartValue = {
                    0,
                    17.7,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    72.4,
                    0,
                    -61.7
                  },
                  StartValue = {
                    71.6,
                    0,
                    -62.4
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 1}
            },
            RefEntityID = 134
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1030002_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  75.8,
                  0,
                  -57.7
                },
                Rotation3D = {
                  0,
                  162.92,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 151
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 134
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 147,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  77.1,
                  0.9,
                  -59.1
                },
                Rotation3D = {
                  -2.55,
                  321.09,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 147
          },
          [4] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 150
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 155,
                  Offset = {
                    0.2,
                    0,
                    -0.2
                  }
                },
                FaceSeq = 3,
                Time = 0
              }
            },
            RefEntityID = 151
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
            RefEntityID = 155
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                Rotation3D = {
                  0,
                  -214.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 144
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -20.3,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    72.4,
                    0,
                    -61.7
                  },
                  StartValue = {
                    71.6,
                    0,
                    -62.4
                  }
                }
              }
            },
            RefEntityID = 134
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 131
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1030002_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  72,
                  1.7,
                  -58.5
                },
                Rotation3D = {
                  26.9,
                  183.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 152
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 152,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 134
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_17_dialog_content",
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 134
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1030002_sad",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_21_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 135,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 126,
                OpenPath = {
                  Duration = 6,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  75.9,
                  1,
                  -59.9
                },
                Time = 0.2
              }
            },
            RefEntityID = 135
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  70.6,
                  0.5,
                  -61.07
                },
                Time = 0.2
              }
            },
            RefEntityID = 126
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 11,
                Time = 0.2
              }
            },
            RefEntityID = 131
          },
          [6] = {
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
            RefEntityID = 123
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_22_dialog_content",
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
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 146
          }
        },
        [23] = {
          [1] = {
            Body = "base_icon_1030002_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_23_dialog_content",
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 134
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_24_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kongergong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    177,
                    0
                  },
                  StartValue = {
                    0,
                    -3.67,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 4,
                  EndValue = {
                    70,
                    0,
                    -67.5
                  },
                  StartValue = {
                    72.4,
                    0,
                    -61.7
                  }
                }
              }
            },
            RefEntityID = 134
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "move",
                Time = 1.5,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    71.8,
                    0,
                    -62.7
                  },
                  StartValue = {
                    71.56,
                    0,
                    -59.5
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 2.5},
              [3] = {FaceSeq = 1, Time = 1.2}
            },
            RefEntityID = 144
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  75.2,
                  0.9,
                  -62.1
                },
                Rotation3D = {
                  4.2,
                  -81.6,
                  0
                },
                Time = 1.5
              }
            },
            RefEntityID = 153
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1.5,
                VC = {
                  Duration = 1.5,
                  EntityID = 153,
                  Style = 3
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    138.4,
                    0
                  },
                  StartValue = {
                    0,
                    107.6,
                    0
                  }
                },
                Time = 1.7
              },
              [2] = {PlayAnimator = "idle", Time = 2.2}
            },
            RefEntityID = 146
          },
          [7] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 9,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    133.12,
                    0
                  },
                  StartValue = {
                    0,
                    66.3,
                    0
                  }
                },
                Time = 1.8
              },
              [2] = {PlayAnimation = "stand", Time = 2.3}
            },
            RefEntityID = 131
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_25_dialog_content",
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
                FaceSeq = 7,
                PlayAnimator = "talk",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 146
          }
        },
        [26] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_26_dialog_content",
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
                FaceSeq = 10,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 131
          }
        },
        [27] = {
          [1] = {
            Body = "base_icon_1200501_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010104_27_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kongergong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "sit",
                Time = 0
              },
              [2] = {
                Bubble = {
                  ID = 156,
                  Offset = {
                    0,
                    -0.1,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 144
          }
        },
        [28] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
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
