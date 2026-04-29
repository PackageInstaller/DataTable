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
      EntityID = 125,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 126,
      Name = "轨道镜头1010",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [5] = {
      EntityID = 128,
      Name = "巴顿",
      PetID = 1500421,
      Resource = "1500421.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [6] = {
      EntityID = 129,
      Name = "固定机位1",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 130,
      Name = "小咋",
      Resource = "1030006.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [8] = {
      EntityID = 131,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 132,
      Name = "固定机位1.5",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 133,
      Name = "固定机位1.8",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 134,
      Name = "抖动机位1",
      Resource = "vc_0004.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 135,
      Name = "抖动机位2",
      Resource = "vc_0004.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 136,
      Name = "阴间特效",
      Resource = "uieff_Story_DarkSmoke.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 137,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 138,
      Name = "固定机位end start",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 139,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 140,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    }
  },
  ID = 90010404,
  Name = "home_story_N19chuanshanjia_4_4",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1500421_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_1_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 4,
                Position3D = {
                  28.6,
                  2.9,
                  11.4
                },
                Rotation3D = {
                  0,
                  114.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 128
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 126,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  34.1,
                  4.55,
                  13
                },
                Rotation3D = {
                  1,
                  65.2,
                  0
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 2,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 126
          },
          [5] = {
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
            RefEntityID = 123
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "idle",
                Position3D = {
                  29.78,
                  2.9,
                  9.3
                },
                Rotation3D = {
                  0,
                  -25.12,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 130
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1030006_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_2_dialog_content",
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
                FaceSeq = 3,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 130
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1030006_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_xiaoza"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_4_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  31.3,
                  4,
                  10.9
                },
                Rotation3D = {
                  7.7,
                  269.22,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 129
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 129,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 4,
                PlayAnimator = "move",
                Rotation3D = {
                  0,
                  98.1,
                  0
                },
                Time = 0.2,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    28.8,
                    2.9,
                    10
                  },
                  StartValue = {
                    25.1,
                    2.9,
                    11
                  }
                }
              },
              [2] = {
                PlayAnimator = "awkward",
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    62.1,
                    0
                  },
                  StartValue = {
                    0,
                    98.1,
                    0
                  }
                },
                Time = 1.7
              },
              [3] = {PlayAnimator = "idle", Time = 3.6}
            },
            RefEntityID = 125
          },
          [5] = {
            KeyFrames = {
              [1] = {
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
        [5] = {
          [1] = {
            Body = "base_icon_1500421_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1500421_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500421_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 128
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500421_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  30.26,
                  3.9,
                  10.9
                },
                Rotation3D = {
                  6,
                  288.1,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 132
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 132,
                  Style = 2
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  27.81,
                  2.9,
                  9.7
                },
                Rotation3D = {
                  0,
                  67.14,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 125
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1030006_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_9_dialog_content",
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
                Position3D = {
                  29.3,
                  4,
                  13
                },
                Rotation3D = {
                  13.6,
                  181.6,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 131
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 131,
                  Style = 0
                }
              }
            }
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1030006_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_xiaoza"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "angry", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 130
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_11_dialog_content",
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
                  EntityID = 126,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 5,
                PlayAnimator = "talk",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 125
          },
          [4] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 2,
                  Position = 0
                },
                Time = 0
              }
            },
            RefEntityID = 126
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_12_dialog_content",
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
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_13_dialog_content",
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 125
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1030006_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_14_dialog_content",
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
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    183.7,
                    0
                  },
                  StartValue = {
                    0,
                    114.2,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 128
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 139,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                FaceSeq = 4,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    278.8,
                    0
                  },
                  StartValue = {
                    0,
                    334.9,
                    0
                  }
                },
                Time = 0.1
              },
              [2] = {PlayAnimation = "idle", Time = 0.6}
            },
            RefEntityID = 130
          },
          [4] = {
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
            RefEntityID = 139
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1500421_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_16_dialog_content",
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
                Active = true,
                PlayAnimator = "think",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    46.1,
                    0
                  },
                  StartValue = {
                    0,
                    67.1,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 125
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_17_dialog_content",
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
        [18] = {
          [1] = {
            Body = "base_icon_1030006_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_18_dialog_content",
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
        [19] = {
          [1] = {
            Body = "base_icon_1500421_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_20_dialog_content",
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
                Active = true,
                FaceSeq = 1,
                PlayAnimator = "talk",
                Time = 0
              }
            },
            RefEntityID = 125
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1500421_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_21_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.4
              },
              [2] = {ShowContent = 0.1, Time = 2.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 133,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.6,
                VC = {
                  Duration = 2,
                  EntityID = 134,
                  Style = 3
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    142.41,
                    0
                  },
                  StartValue = {
                    0,
                    183.7,
                    0
                  }
                },
                Time = 0.1
              },
              [2] = {PlayAnimation = "stand", Time = 0.5},
              [3] = {FaceSeq = 4, Time = 0.7}
            },
            RefEntityID = 128
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    332,
                    0
                  },
                  StartValue = {
                    0,
                    278.8,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 130
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  29.5,
                  3.8,
                  10.3
                },
                Rotation3D = {
                  0,
                  -39.9,
                  0
                },
                Time = 0.6
              }
            },
            RefEntityID = 134
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  29.75,
                  3.8,
                  10.2
                },
                Rotation3D = {
                  2.4,
                  -39.9,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 133
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0.1,
                  StartValue = 0
                },
                Layer = 18,
                Time = 0.6
              }
            },
            RefEntityID = 136
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1030006_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_xiaoza"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 137
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.2
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0.1,
                  StartValue = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 136
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 131,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.5,
                VC = {
                  Duration = 2,
                  EntityID = 135,
                  Style = 3
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  29.5,
                  3.8,
                  11.3
                },
                Rotation3D = {
                  13.5,
                  180,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 135
          }
        },
        [23] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
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
                Time = 0.1
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.3
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.4
              },
              [5] = {Active = true, Time = 2.6}
            },
            RefEntityID = 137
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 134,
                  Style = 0
                }
              },
              [2] = {
                Time = 1.4,
                VC = {
                  Duration = 0,
                  EntityID = 135,
                  Style = 0
                }
              }
            }
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_23_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.02, Time = 1.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.1
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
            RefEntityID = 137
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  29.5,
                  3.7,
                  10.4
                },
                Rotation3D = {
                  0,
                  245.4,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 138
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 138,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.7,
                VC = {
                  Duration = 0.5,
                  EntityID = 126,
                  Style = 2
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.4}
            },
            RefEntityID = 136
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                Rotation3D = {
                  0,
                  57.5,
                  0
                },
                Time = 0.5
              },
              [2] = {PlayAnimator = "happy", Time = 1.3},
              [3] = {PlayAnimator = "idle", Time = 3.1}
            },
            RefEntityID = 125
          },
          [7] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0.5}
            },
            RefEntityID = 130
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_24_dialog_content",
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
        [26] = {
          [1] = {
            Body = "base_icon_1500421_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_25_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 128
          }
        },
        [27] = {
          [1] = {
            Body = "base_icon_1030006_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_26_dialog_content",
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
                FaceSeq = 2,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
            },
            RefEntityID = 130
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_27_dialog_content",
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
                Active = true,
                FaceSeq = 6,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 125
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_28_dialog_content",
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
        [30] = {
          [1] = {
            Body = "base_icon_1500421_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_29_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
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
            RefEntityID = 128
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 133,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  2.5,
                  -45,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 133
          }
        },
        [31] = {
          [1] = {
            Body = "base_icon_1500421_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_30_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          }
        },
        [32] = {
          [1] = {
            Body = "base_icon_1030006_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_31_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 131,
                  Style = 0
                }
              }
            }
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
            RefEntityID = 140
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 140,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.8}
            },
            RefEntityID = 130
          }
        },
        [33] = {
          [1] = {
            Body = "base_icon_1030006_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_32_dialog_content",
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
            SpeakerNameStr = "ui_story_name_xiaoza"
          }
        },
        [34] = {
          [1] = {
            Body = "base_icon_1500421_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_33_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 128
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 133,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 130
          }
        },
        [35] = {
          [1] = {
            Body = "base_icon_1500421_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_34_dialog_content",
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
            SpeakerNameStr = "ui_story_name_badun"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 128
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010404_35_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.02, Time = 1.5}
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
                  EntityID = 126,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                PlayAnimator = "sigh",
                Time = 1.2
              },
              [2] = {PlayAnimator = "idle", Time = 3.1},
              [3] = {
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    50,
                    0
                  },
                  StartValue = {
                    0,
                    20,
                    0
                  }
                },
                Time = 0.1
              }
            },
            RefEntityID = 125
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  29,
                  3.8,
                  12.9
                },
                Rotation3D = {
                  3.5,
                  30.7,
                  0
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 2,
                  Position = 0
                },
                Time = 0.1
              }
            },
            RefEntityID = 126
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    83.8,
                    0
                  },
                  StartValue = {
                    0,
                    142.4,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    31,
                    2.9,
                    11.4
                  },
                  StartValue = {
                    28.6,
                    2.9,
                    11.4
                  }
                }
              }
            },
            RefEntityID = 128
          }
        },
        [37] = {
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
              [2] = {Active = true, Time = 2.7}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
