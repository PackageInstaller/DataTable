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
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "杰诺",
      PetID = 1601671,
      Resource = "1601671.prefab",
      SubType = "Pet",
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
      Name = "轨道镜头1010-2",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
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
      Name = "轨道相机1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
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
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
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
      Name = "叹号",
      Resource = "1714",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      Name = "混乱bubble",
      Resource = "eff_jy_meme_hunluan.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 17,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 18,
      Name = "速度线",
      Resource = "uieff_Story_SpeedLine.prefab",
      Type = "Effect"
    },
    [19] = {
      EntityID = 19,
      Name = "冰淇淋机",
      Resource = "5272002.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 20,
      Name = "彩虹",
      Resource = "uieff_wutaicaihong.prefab",
      Type = "Effect"
    },
    [21] = {
      EntityID = 21,
      Name = "省略号bubble",
      Resource = "eff_jy_meme_duihua2.prefab",
      Type = "Model"
    },
    [22] = {
      EntityID = 22,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [23] = {
      EntityID = 23,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      Name = "阳光",
      Resource = "10037",
      Type = "Sound"
    }
  },
  ID = 90020304,
  Name = "home_story_N21yongchi_3_4",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020304_1_dialog_content",
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
                Active = true,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  -99.14,
                  0
                },
                Time = 0.5,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -21.9,
                    3,
                    -16.5
                  },
                  StartValue = {
                    -21,
                    3,
                    -16.5
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -23.23,
                  3,
                  -16.5
                },
                Rotation3D = {
                  0,
                  -102.25,
                  0
                },
                Time = 0
              },
              [2] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    85,
                    0
                  },
                  StartValue = {
                    0,
                    257.8,
                    0
                  }
                },
                Time = 2.2
              },
              [3] = {PlayAnimation = "stand", Time = 2.7}
            },
            RefEntityID = 4
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 7,
                Position3D = {
                  -21.5,
                  4.5,
                  -13.2
                },
                Rotation3D = {
                  0,
                  -62.7,
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
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -22.8,
                  3.5,
                  -17.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601661_upset",
            DialogContentStr = "str_homestory_N21yongchi_90020304_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020304_4_dialog_content",
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
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020304_5_dialog_content",
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
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601671_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020304_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601671_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020304_9_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.7
              },
              [2] = {ShowContent = 0.02, Time = 2.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -21.46,
                  3.9,
                  -16
                },
                Rotation3D = {
                  2,
                  -118,
                  0
                },
                Time = 0.8
              }
            },
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.8,
                VC = {
                  Duration = 0,
                  EntityID = 5,
                  Style = 0
                }
              },
              [2] = {
                Time = 1.2,
                VC = {
                  Duration = 2,
                  EntityID = 8,
                  Style = 2
                }
              }
            }
          },
          [4] = {
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
                Time = 1.2
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -21.2,
                  3.9,
                  -15.8
                },
                Rotation3D = {
                  2,
                  -118,
                  0
                },
                Time = 1.2
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0.9}
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601671_rebuke",
            DialogContentStr = "str_homestory_N21yongchi_90020304_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 13,
                  Offset = {
                    0.2,
                    0.1,
                    -0.1
                  }
                },
                FaceSeq = 4,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
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
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 15
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601671_rebuke",
            DialogContentStr = "str_homestory_N21yongchi_90020304_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1601671_rebuke",
            DialogContentStr = "str_homestory_N21yongchi_90020304_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1601671_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020304_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1601671_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020304_14_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.1,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 21,
                  Offset = {
                    0.1,
                    0.1,
                    0
                  }
                },
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.4}
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
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020304_15_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0},
              [2] = {
                Bubble = {
                  ID = 22,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                PlayAnimator = "talk",
                Time = 0.2
              },
              [3] = {PlayAnimator = "idle", Time = 2.2}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 21
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0.2
              }
            },
            RefEntityID = 22
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 23
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 22
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020304_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 17
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -31.62,
                  2.85,
                  -5.26
                },
                Rotation3D = {
                  0,
                  19.17,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 19
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -31.38,
                  3.76,
                  -4.47
                },
                Rotation3D = {
                  17.7,
                  -154.8,
                  2.45
                },
                Time = 0.4
              }
            },
            RefEntityID = 10
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 10,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.5,
                VC = {
                  Duration = 0.3,
                  EntityID = 11,
                  Style = 2
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -30.52,
                  4.41,
                  -2.63
                },
                Rotation3D = {
                  17.71,
                  -157.59,
                  2.453
                },
                Time = 0.5
              }
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 0.5,
                Layer = 18,
                Time = 0.5
              }
            },
            RefEntityID = 20
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 24
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 25
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1601671_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020304_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_jienuo"
          },
          [2] = {
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
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 17
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 20
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0.2}
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0.2}
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020304_23_dialog_content",
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
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020304_24_dialog_content",
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
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [25] = {
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
          }
        }
      }
    }
  },
  StartParagraph = 1
}
