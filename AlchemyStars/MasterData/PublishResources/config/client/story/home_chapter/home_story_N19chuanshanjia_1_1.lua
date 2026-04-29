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
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 125,
      Name = "轨道镜头1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [5] = {
      EntityID = 126,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [6] = {
      EntityID = 127,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [7] = {
      EntityID = 128,
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 129,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 130,
      Name = "主角2",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [10] = {
      EntityID = 131,
      Name = "薇丝2",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [11] = {
      EntityID = 132,
      Name = "震动机位3",
      Resource = "vc_0003.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 133,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 134,
      Name = "老山",
      Resource = "1030002.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [14] = {
      EntityID = 135,
      Name = "轨道镜头1010",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 136,
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 137,
      Name = "固定机位5",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 138,
      Name = "固定机位6",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 139,
      Name = "固定机位7",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 140,
      Name = "固定机位8",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [20] = {
      EntityID = 141,
      Name = "固定机位9",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [21] = {
      EntityID = 142,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [22] = {
      EntityID = 143,
      Name = "固定机位10",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [23] = {
      EntityID = 144,
      Name = "恐尔贡",
      PetID = 1200501,
      Resource = "1200501.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [24] = {
      EntityID = 145,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [25] = {
      EntityID = 146,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    },
    [26] = {
      EntityID = 147,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    }
  },
  ID = 90010101,
  Name = "home_story_N19chuanshanjia_1_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_1_dialog_content",
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
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  44.8,
                  0.25,
                  -88.2
                },
                Rotation3D = {
                  0,
                  16.9,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 124
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 126,
                Position3D = {
                  49.07,
                  2.1,
                  -95.8
                },
                Rotation3D = {
                  0,
                  304.7,
                  0
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 10,
                  Ease = 2,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 125
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 125,
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
                  15.2,
                  -7.97,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 126
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  45.77,
                  0.28,
                  -87.93
                },
                Rotation3D = {
                  0,
                  -57.9,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 127
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_2_dialog_content",
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
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  46.4,
                  1.2,
                  -86.6
                },
                Rotation3D = {
                  5.87,
                  221.1,
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
                  EntityID = 128,
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
                    63.1,
                    0
                  },
                  StartValue = {
                    0,
                    16.9,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {
                FaceSeq = 5,
                PlayAnimation = "stand",
                Time = 0.7
              }
            },
            RefEntityID = 124
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    250.9,
                    0
                  },
                  StartValue = {
                    0,
                    302.1,
                    0
                  }
                },
                Time = 0.3
              },
              [2] = {PlayAnimator = "idle", Time = 0.8}
            },
            RefEntityID = 127
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_4_dialog_content",
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
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 127
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_5_dialog_content",
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
            RefEntityID = 124
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_6_dialog_content",
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
                Position3D = {
                  53.6,
                  1,
                  -80.1
                },
                Rotation3D = {
                  3.83,
                  110.05,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 129
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
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
                FaceSeq = 2,
                PlayAnimator = "awkward",
                Position3D = {
                  55.7,
                  0.18,
                  -80.6
                },
                Rotation3D = {
                  0,
                  -91.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 130
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  54.7,
                  0.18,
                  -81
                },
                Rotation3D = {
                  0,
                  94.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 131
          }
        },
        [7] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 132,
                  Style = 0
                }
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  53.6,
                  1,
                  -80.1
                },
                Rotation3D = {
                  3.83,
                  110.05,
                  0
                },
                Shake = {
                  Duration = 0.2,
                  Offset = {
                    1,
                    1,
                    1
                  },
                  Speed = 3,
                  Strength = 1
                },
                Time = 0
              }
            },
            RefEntityID = 132
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              },
              [3] = {Active = false, Time = 0.6}
            },
            RefEntityID = 133
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_7_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
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
                  Duration = 1,
                  EntityID = 136,
                  Style = 3
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -186.15,
                    0
                  },
                  StartValue = {
                    0,
                    -91.4,
                    0
                  }
                },
                Time = 0.4
              },
              [2] = {
                Bubble = {
                  ID = 145,
                  Offset = {
                    -0.1,
                    0,
                    0.5
                  }
                },
                PlayAnimator = "idle",
                Time = 0.9
              }
            },
            RefEntityID = 130
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -204.4,
                    0
                  },
                  StartValue = {
                    0,
                    94.2,
                    0
                  }
                },
                Time = 0.5,
                Translate3D = {
                  Duration = 0.5,
                  EndValue = {
                    54.5,
                    0.05,
                    -80.5
                  },
                  StartValue = {
                    54.7,
                    0.2,
                    -81
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1}
            },
            RefEntityID = 131
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  54.6,
                  1.4,
                  -83
                },
                Rotation3D = {
                  16.65,
                  12.3,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 136
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
            RefEntityID = 145
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1500331_shocked",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_8_dialog_content",
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
              [1] = {FaceSeq = 8, Time = 0}
            },
            RefEntityID = 131
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.9
              },
              [2] = {ShowContent = 0.02, Time = 3.1}
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 123
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 137,
                  Style = 0
                }
              },
              [2] = {
                Time = 1.4,
                VC = {
                  Duration = 1,
                  EntityID = 138,
                  Style = 3
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  50.6,
                  2.21,
                  -93.15
                },
                Rotation3D = {
                  -9.32,
                  190.8,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 137
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 127
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 124
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -25.81,
                  0
                },
                Time = 0.2,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    46.9,
                    3.45,
                    -106.48
                  },
                  StartValue = {
                    47.8,
                    3.5,
                    -106.48
                  }
                }
              },
              [2] = {
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    8.78,
                    0
                  },
                  StartValue = {
                    0,
                    -25.81,
                    0
                  }
                },
                Time = 0.7
              },
              [3] = {PlayAnimation = "idle", Time = 1.2}
            },
            RefEntityID = 134
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  47.2,
                  3.7,
                  -103
                },
                Rotation3D = {
                  -2.8,
                  187.2,
                  0
                },
                Time = 1.4
              }
            },
            RefEntityID = 138
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_10_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.1
              },
              [2] = {ShowContent = 0.02, Time = 3.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_linjiashou"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Time = 0.2,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    47.3,
                    3.25,
                    -104.7
                  },
                  StartValue = {
                    46.9,
                    3.45,
                    -106.5
                  }
                }
              },
              [2] = {
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  12.96,
                  0
                },
                Time = 1.4,
                Translate3D = {
                  Duration = 1.5,
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
              },
              [3] = {PlayAnimation = "idle", Time = 2.9}
            },
            RefEntityID = 134
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.7
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.4
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
                  75.07,
                  1,
                  -60.9
                },
                Time = 1.4
              }
            },
            RefEntityID = 135
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1.4,
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
                Position3D = {
                  71.5,
                  0,
                  -60.1
                },
                Rotation3D = {
                  0,
                  179.6,
                  0
                },
                Time = 1.4
              }
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
                Time = 1.4
              }
            },
            RefEntityID = 131
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -3,
                  -10.51,
                  -79.33
                },
                Time = 1.2
              }
            },
            RefEntityID = 126
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_linjiashou"
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_linjiashou"
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1500331_shocked",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_13_dialog_content",
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
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_14_dialog_content",
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
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    59.3,
                    0
                  },
                  StartValue = {
                    0,
                    112.6,
                    0
                  }
                },
                Time = 0.4
              },
              [2] = {PlayAnimation = "stand", Time = 0.9}
            },
            RefEntityID = 131
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    209.2,
                    0
                  },
                  StartValue = {
                    0,
                    179.6,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.5}
            },
            RefEntityID = 130
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1500331_shocked",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_15_dialog_content",
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
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_16_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.1, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  72.8,
                  1,
                  -60.4
                },
                Rotation3D = {
                  8.7,
                  -105.77,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 139
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1.5,
                  EntityID = 139,
                  Style = 3
                }
              }
            }
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1500331_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_17_dialog_content",
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
                FaceSeq = 9,
                PlayAnimation = "surprise",
                Time = 0
              }
            },
            RefEntityID = 131
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_linjiashou"
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
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    118.7,
                    0
                  },
                  StartValue = {
                    0,
                    59.3,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 0.7}
            },
            RefEntityID = 131
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    175,
                    0
                  },
                  StartValue = {
                    0,
                    209.2,
                    0
                  }
                },
                Time = 0.3
              },
              [2] = {PlayAnimator = "idle", Time = 0.8}
            },
            RefEntityID = 130
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1030002_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_linjiashou"
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1500331_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_20_dialog_content",
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
              [1] = {PlayAnimation = "surprise", Time = 0}
            },
            RefEntityID = 131
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1030002_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_21_dialog_content",
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
                FaceSeq = 3,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.7},
              [3] = {
                Bubble = {
                  ID = 146,
                  Offset = {
                    0,
                    0.1,
                    -0.1
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 134
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
            RefEntityID = 146
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_22_dialog_content",
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
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 130
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_23_dialog_content",
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
          }
        },
        [25] = {
          [1] = {
            Body = "base_icon_1030002_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_24_dialog_content",
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
            SpeakerNameStr = "ui_story_name_laoshan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  72.31,
                  0.9,
                  -60.71
                },
                Rotation3D = {
                  11.63,
                  -154.6,
                  0
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
                Time = 0.1,
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
                FaceSeq = 4,
                PlayAnimation = "surprise",
                Time = 0.3
              },
              [2] = {PlayAnimation = "idle", Time = 2.3}
            },
            RefEntityID = 134
          }
        },
        [26] = {
          [1] = {
            Body = "base_icon_1030002_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_25_dialog_content",
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
                Position3D = {
                  70.7,
                  0,
                  -60.7
                },
                Rotation3D = {
                  0,
                  131.3,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 131
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -198.02,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 130
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_26_dialog_content",
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
                  72.4,
                  0.9,
                  -61.5
                },
                Rotation3D = {
                  4.5,
                  310,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 141
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 141,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlayAnimator = "awkward", Time = 0.2},
              [2] = {PlayAnimator = "idle", Time = 2.1}
            },
            RefEntityID = 130
          }
        },
        [28] = {
          [1] = {
            Body = "base_icon_1030002_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_27_dialog_content",
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
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_28_dialog_content",
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
                  EntityID = 141,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "talk",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    223.7,
                    0
                  },
                  StartValue = {
                    0,
                    162,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 130
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    82.8,
                    0
                  },
                  StartValue = {
                    0,
                    131.3,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {PlayAnimation = "stand", Time = 1.2}
            },
            RefEntityID = 131
          }
        },
        [30] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_29_dialog_content",
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
                FaceSeq = 8,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 131
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_30_dialog_content",
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 130
          }
        },
        [32] = {
          [1] = {
            Body = "base_icon_1500331_shocked",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_31_dialog_content",
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
              [1] = {FaceSeq = 9, Time = 0}
            },
            RefEntityID = 131
          }
        },
        [33] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_32_dialog_content",
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
              [1] = {FaceSeq = 10, Time = 0}
            },
            RefEntityID = 131
          }
        },
        [34] = {
          [1] = {
            Body = "base_icon_1030002_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_33_dialog_content",
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
                  70.8,
                  0,
                  -60.9
                },
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    118.7,
                    0
                  },
                  StartValue = {
                    0,
                    59.3,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 131
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    175,
                    0
                  },
                  StartValue = {
                    0,
                    209.2,
                    0
                  }
                },
                Time = 0.3
              }
            },
            RefEntityID = 130
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "angry",
                Time = 0.2
              },
              [2] = {PlayAnimation = "idle", Time = 1.9}
            },
            RefEntityID = 134
          }
        },
        [35] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_34_dialog_content",
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
          }
        },
        [36] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_35_dialog_content",
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
        [37] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_36_dialog_content",
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 131
          }
        },
        [38] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_37_dialog_content",
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 131
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_38_dialog_content",
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
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 130
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 142
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
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 133
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  111.6,
                  0.9,
                  -4.4
                },
                Rotation3D = {
                  0.5,
                  -228.35,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 143
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 143,
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
                  113.95,
                  0,
                  -6.2
                },
                Rotation3D = {
                  0,
                  -82.24,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 144
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 142
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
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 133
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 135,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Position3D = {
                  113.95,
                  0,
                  -6.2
                },
                Rotation3D = {
                  0,
                  -82.24,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 144
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "talk",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    153.5,
                    0
                  },
                  StartValue = {
                    0,
                    175,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 130
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_41_dialog_content",
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
                  72.4,
                  0.9,
                  -61.5
                },
                Rotation3D = {
                  4.5,
                  310,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 141
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 141,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 7, Time = 0.2}
            },
            RefEntityID = 130
          }
        },
        [43] = {
          [1] = {
            Body = "base_icon_1500331_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010101_42_dialog_content",
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
              [1] = {FaceSeq = 10, Time = 0}
            },
            RefEntityID = 131
          }
        },
        [44] = {
          [1] = {
            KeyFrames = {
              [1] = {
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
