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
      Name = "轨道镜头1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [4] = {
      EntityID = 125,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [5] = {
      EntityID = 126,
      Name = "阿吉",
      Resource = "1030004.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [6] = {
      EntityID = 127,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 128,
      Name = "雷文顿",
      PetID = 1601191,
      Resource = "1601191.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [8] = {
      EntityID = 129,
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 130,
      Name = "轨道镜头1010",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 131,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 132,
      Name = "固定机位3",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 133,
      Name = "抖动机位",
      Resource = "vc_0003.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 134,
      Name = "烈雀",
      PetID = 1400481,
      Resource = "1400481.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [14] = {
      EntityID = 135,
      Name = "固定机位3.1",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 136,
      Name = "固定机位3.2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 137,
      Name = "固定机位3.3",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 138,
      Name = "固定机位2.1",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 139,
      Name = "固定机位2.2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 140,
      Name = "固定机位3.4",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [20] = {
      EntityID = 141,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    },
    [21] = {
      EntityID = 142,
      Name = "高兴bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [22] = {
      EntityID = 143,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    }
  },
  ID = 90010204,
  Name = "home_story_N19chuanshanjia_2_4",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1030004_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.8
              },
              [2] = {ShowContent = 0.02, Time = 3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aji"
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
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 127,
                Position3D = {
                  -3.9,
                  4.3,
                  23.89
                },
                Rotation3D = {
                  0,
                  198.4,
                  0
                },
                Time = 0.4
              },
              [2] = {
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 130
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 130,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  5.7,
                  1.8,
                  30.8
                },
                Time = 0.4
              }
            },
            RefEntityID = 127
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "idle",
                Position3D = {
                  -1.42,
                  2.8,
                  27.11
                },
                Rotation3D = {
                  0,
                  151.4,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 126
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                Position3D = {
                  0.2,
                  2.8,
                  26.52
                },
                Rotation3D = {
                  0,
                  -115.4,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 125
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -0.2,
                  2.8,
                  25
                },
                Rotation3D = {
                  0,
                  -34,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 134
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1400481_disgust",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.3,
                  3.55,
                  26.1
                },
                Rotation3D = {
                  2.62,
                  134.3,
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
                  Duration = 0,
                  EntityID = 132,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 134
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.17,
                  3.82,
                  25.14
                },
                Rotation3D = {
                  15.72,
                  -2.4,
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
        [4] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_4_dialog_content",
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
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1400481_nervous",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
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
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1030004_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 130,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 125
          },
          [4] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0
              }
            },
            RefEntityID = 130
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 141,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "angry",
                Time = 0.2
              },
              [2] = {PlayAnimation = "idle", Time = 1.7}
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
            RefEntityID = 141
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_7_dialog_content",
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
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 125
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
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
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 141
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 126
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1400481_nervous",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_9_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.1, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0.2,
                  EntityID = 135,
                  Style = 1
                }
              },
              [2] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 132,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.2,
                  3.55,
                  25.9
                },
                Rotation3D = {
                  2.62,
                  134.3,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 135
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
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
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1400481_nervous",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_10X1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.1, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0.2,
                  EntityID = 136,
                  Style = 1
                }
              },
              [2] = {
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
                Position3D = {
                  -1.1,
                  3.55,
                  25.8
                },
                Rotation3D = {
                  2.62,
                  134.3,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 136
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_10X2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
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
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1400481_nervous",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_10X3_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.1, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0.2,
                  EntityID = 137,
                  Style = 1
                }
              },
              [2] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 136,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1,
                  3.5,
                  25.7
                },
                Rotation3D = {
                  -2.21,
                  134.3,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 137
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
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
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1400481_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_11_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.8
              },
              [2] = {ShowContent = 0.02, Time = 3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 2,
                  EntityID = 140,
                  Style = 1
                }
              },
              [2] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 137,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.9,
                  3.5,
                  25.6
                },
                Rotation3D = {
                  -5,
                  134.3,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 140
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 3}
            },
            RefEntityID = 134
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1400481_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_lieque"
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
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.9,
                  3.5,
                  25.6
                },
                Rotation3D = {
                  -5,
                  134.3,
                  0
                },
                Shake = {
                  Duration = 0.5,
                  Offset = {
                    1,
                    1,
                    1
                  },
                  Speed = 2,
                  Strength = 1
                },
                Time = 0
              }
            },
            RefEntityID = 133
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 134
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_14_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 130,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Rotation3D = {
                  0,
                  -149.34,
                  0
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 125
          },
          [4] = {
            KeyFrames = {
              [1] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0
              }
            },
            RefEntityID = 130
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1400481_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_15_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.02,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
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
            RefEntityID = 142
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 142,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 134
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1030004_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_16_dialog_content",
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
                Bubble = {
                  ID = 143,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                FaceSeq = 2,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.9}
            },
            RefEntityID = 126
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
            RefEntityID = 143
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1400481_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_17_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.02,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_18_dialog_content",
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
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 125
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1030004_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_19_dialog_content",
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
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 1.9}
            },
            RefEntityID = 126
          }
        },
        [23] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
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
                Time = 1.7
              }
            },
            RefEntityID = 123
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Look = 127,
                Position3D = {
                  -3.45,
                  0.9,
                  79.84
                },
                Time = 1.6
              },
              [2] = {
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Time = 1.7
              }
            },
            RefEntityID = 124
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1.6,
                VC = {
                  Duration = 0,
                  EntityID = 124,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Time = 1.6,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    -3.1,
                    0,
                    78.5
                  },
                  StartValue = {
                    -3.1,
                    0,
                    76.77
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 4.7}
            },
            RefEntityID = 128
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  9.3,
                  -4.39,
                  30.8
                },
                Time = 1.6
              }
            },
            RefEntityID = 127
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1601191_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_20_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              },
              [2] = {ShowContent = 0.02, Time = 1.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leiwendun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 1.5
              },
              [2] = {FaceSeq = 2, Time = 0.3},
              [3] = {PlayAnimation = "stand", Time = 3.4}
            },
            RefEntityID = 128
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -3.45,
                  0.9,
                  79.84
                },
                Rotation3D = {
                  5.85,
                  163.9,
                  0
                },
                Shake = {
                  Duration = 0.2,
                  Offset = {
                    1,
                    1,
                    1
                  },
                  Speed = 1,
                  Strength = 1
                },
                Time = 1.5
              }
            },
            RefEntityID = 133
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 1.5,
                VC = {
                  Duration = 0.2,
                  EntityID = 133,
                  Style = 1
                }
              }
            }
          }
        },
        [25] = {
          [1] = {
            Body = "base_icon_1601191_smile",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010204_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_leiwendun"
          }
        },
        [26] = {
          [1] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    33.8,
                    0
                  },
                  StartValue = {
                    0,
                    0,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -0.8,
                    0,
                    79.35
                  },
                  StartValue = {
                    -3.1,
                    0,
                    78.5
                  }
                }
              }
            },
            RefEntityID = 128
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.5
              },
              [2] = {Active = true, Time = 3.2}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
