return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 113,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [3] = {
      EntityID = 116,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 123,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 138,
      Name = "轨道镜头1013",
      Resource = "vc_1013.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [6] = {
      EntityID = 140,
      Name = "关注点1",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 144,
      Name = "白女士",
      PetID = 1400411,
      Resource = "1400411.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [8] = {
      EntityID = 146,
      Name = "丘布商人",
      Resource = "1021003.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [9] = {
      EntityID = 147,
      Name = "爱心bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [10] = {
      EntityID = 148,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 149,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 150,
      Name = "定点镜头0003",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 152,
      Name = "丘布长老",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [14] = {
      EntityID = 153,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 154,
      Name = "剧情中心点",
      Resource = "HomeStoryRoot.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 155,
      Name = "爱心bubble2",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 156,
      Name = "轨道镜头1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 157,
      Name = "兴奋bubble2",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [19] = {
      EntityID = 158,
      Name = "彩带特效",
      Resource = "uieff_Story_caidai.prefab",
      Type = "Effect"
    },
    [20] = {
      EntityID = 159,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 160,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [22] = {
      EntityID = 161,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [23] = {
      EntityID = 163,
      Name = "掌声",
      Resource = "10239",
      Type = "Sound"
    },
    [24] = {
      EntityID = 164,
      Name = "烟花",
      Resource = "10096",
      Type = "Sound"
    }
  },
  ID = 90000109,
  Name = "home_story_N17guide_1_9",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 138,
                  Style = 0
                }
              }
            }
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
                Time = 0.3
              }
            },
            RefEntityID = 123
          },
          [3] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000109_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  1.9,
                  5.8,
                  12.73
                },
                Time = 0
              }
            },
            RefEntityID = 140
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                Position3D = {
                  1.91,
                  5.18,
                  12.73
                },
                Rotation3D = {
                  0,
                  -26.32,
                  0
                },
                Time = 0.3
              },
              [2] = {
                Bubble = {
                  ID = 153,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 1.6
              },
              [3] = {PlayAnimation = "stand", Time = 3.4}
            },
            RefEntityID = 113
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 140,
                OpenPath = {
                  Duration = 30,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -1.5,
                  6.54,
                  16.88
                },
                Rotation3D = {
                  0,
                  82.88,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 138
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -67.1,
                  0
                },
                Time = 0.3,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    3,
                    5.2,
                    13.12
                  },
                  StartValue = {
                    4.14,
                    5.2,
                    12.7
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 2.4}
            },
            RefEntityID = 144
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -65.07,
                  0
                },
                Time = 0.3,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    3.8,
                    5.4,
                    13.71
                  },
                  StartValue = {
                    5.1,
                    5.4,
                    13.24
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 1.4}
            },
            RefEntityID = 146
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -6,
                  0,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 154
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  85.1,
                  0
                },
                Time = 0.3,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -0.46,
                    5.4,
                    13.2
                  },
                  StartValue = {
                    -1.07,
                    5.4,
                    13.2
                  }
                }
              },
              [2] = {PlayAnimation = "idle", Time = 2.4}
            },
            RefEntityID = 152
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                Position3D = {
                  0.73,
                  5.18,
                  12.73
                },
                Rotation3D = {
                  0,
                  50,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 116
          },
          [12] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.6}
            },
            RefEntityID = 160
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000109_2_dialog_content",
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
        [3] = {
          [1] = {
            Body = "base_icon_1021001_shy",
            DialogContentStr = "str_homestory_N17guide_90000109_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubumen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 147,
                  Offset = {
                    0,
                    -0.7,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 2.2}
            },
            RefEntityID = 146
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 155,
                  Offset = {
                    0,
                    -0.7,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0.2
              },
              [2] = {PlayAnimation = "idle", Time = 2.2}
            },
            RefEntityID = 152
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
            RefEntityID = 147
          },
          [5] = {
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
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 161
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 144
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000109_8_dialog_content",
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
                  2.52,
                  6.14,
                  13.57
                },
                Rotation3D = {
                  6.5,
                  236,
                  0
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
                PlayAnimator = "talk",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    70.7,
                    0
                  },
                  StartValue = {
                    0,
                    50,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -95,
                  0
                },
                Time = 1
              }
            },
            RefEntityID = 144
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -104,
                  0
                },
                Time = 1
              }
            },
            RefEntityID = 146
          },
          [7] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    281.42,
                    0
                  },
                  StartValue = {
                    0,
                    333.7,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 0.6}
            },
            RefEntityID = 113
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_9_dialog_content",
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
              [1] = {PlayAnimation = "sad", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 113
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.17,
                  6.25,
                  13.36
                },
                Rotation3D = {
                  9.4,
                  116.8,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 149
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000109_10_dialog_content",
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 113
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1500331_worried",
            DialogContentStr = "str_homestory_N17guide_90000109_11_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "str_homestory_N17guide_90000109_12_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "str_homestory_N17guide_90000109_15_option_content",
                NextParagraphID = 3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 113
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
            DialogContentStr = "str_homestory_N17guide_90000109_13_dialog_content",
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
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
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
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_14_dialog_content",
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
                FaceSeq = 3,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 113
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.1,
                  5.4,
                  13.2
                },
                Time = 0
              }
            },
            RefEntityID = 152
          },
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000109_16_dialog_content",
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
                  EntityID = 148,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_17_dialog_content",
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
                FaceSeq = 3,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 113
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_18_dialog_content",
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
              [1] = {
                Position3D = {
                  -0.1,
                  5.4,
                  13.2
                },
                Time = 0
              }
            },
            RefEntityID = 152
          },
          NextParagraphID = 4
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000109_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 156,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "happy",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    340,
                    0
                  },
                  StartValue = {
                    0,
                    281.4,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 113
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 140,
                OpenPath = {
                  Duration = 10,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  0.3,
                  6.5,
                  15.8
                },
                Rotation3D = {
                  0,
                  63,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 156
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 116
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1021001_shy",
            DialogContentStr = "str_homestory_N17guide_90000109_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubumen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 147,
                  Offset = {
                    0,
                    0.2,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 2.2}
            },
            RefEntityID = 146
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 155,
                  Offset = {
                    0,
                    0.2,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0.1
              },
              [2] = {PlayAnimation = "idle", Time = 2.3}
            },
            RefEntityID = 152
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 116
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 144
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  1.57,
                  6.15,
                  13.47
                },
                Rotation3D = {
                  6,
                  94.8,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 149
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_23_dialog_content",
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
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 144
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  64.3,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 116
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000109_24_dialog_content",
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
                  EntityID = 148,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlayAnimator = "think", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  1.77,
                  6.25,
                  13.3
                },
                Rotation3D = {
                  10,
                  -112,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 148
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_25_dialog_content",
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
                Active = true,
                Position3D = {
                  1.6,
                  6,
                  13.9
                },
                Rotation3D = {
                  0,
                  -190.5,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 150
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.5,
                  EntityID = 150,
                  Style = 3
                }
              }
            }
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000109_26_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.04,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  1.55,
                  5.9,
                  14.2
                },
                Rotation3D = {
                  -4.5,
                  -192.5,
                  0
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
                  Duration = 2,
                  EntityID = 148,
                  Style = 3
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    3.46,
                    28.1,
                    0
                  },
                  StartValue = {
                    0,
                    64.3,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    1.3,
                    5.2,
                    12.6
                  },
                  StartValue = {
                    0.7,
                    5.2,
                    12.7
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.1}
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    292,
                    0
                  },
                  StartValue = {
                    0,
                    265,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    2.4,
                    5.2,
                    12.9
                  },
                  StartValue = {
                    3,
                    5.2,
                    13.1
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.6}
            },
            RefEntityID = 144
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -80.42,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    3.1,
                    5.4,
                    13.04
                  },
                  StartValue = {
                    3.2,
                    5.4,
                    13.2
                  }
                }
              }
            },
            RefEntityID = 146
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  46.6,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0.62,
                    5.4,
                    12.42
                  },
                  StartValue = {
                    -0.1,
                    5.4,
                    13.2
                  }
                }
              }
            },
            RefEntityID = 152
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000109_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_everyone"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.99,
                  6,
                  15.58
                },
                Rotation3D = {
                  3,
                  162,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 149
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0.5,
                  EntityID = 149,
                  Style = 3
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 147,
                  Offset = {
                    0,
                    0.2,
                    0
                  }
                },
                PlayAnimation = "happy",
                Time = 0.6
              },
              [2] = {PlayAnimation = "stand", Time = 2.4}
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 153,
                  Offset = {
                    0,
                    0.2,
                    0
                  }
                },
                PlayAnimator = "happy",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    3,
                    -1.5,
                    0
                  },
                  StartValue = {
                    0,
                    4.5,
                    0
                  }
                },
                Time = 0.6
              },
              [2] = {
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    4.49,
                    0
                  },
                  StartValue = {
                    3.5,
                    28.1,
                    0
                  }
                },
                Time = 0.2
              },
              [3] = {PlayAnimator = "idle", Time = 2.6}
            },
            RefEntityID = 116
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 157,
                  Offset = {
                    0.1,
                    0.2,
                    0
                  }
                },
                PlayAnimation = "happy",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    309.16,
                    0
                  },
                  StartValue = {
                    0,
                    292,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {
                Time = 0.2,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    2.5,
                    5.2,
                    12.9
                  },
                  StartValue = {
                    2.4,
                    5.2,
                    12.9
                  }
                }
              },
              [3] = {PlayAnimation = "stand", Time = 3}
            },
            RefEntityID = 144
          },
          [7] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0.7},
              [2] = {
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    306.8,
                    0
                  },
                  StartValue = {
                    0,
                    279.6,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 146
          },
          [8] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0.8},
              [2] = {
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    19.18,
                    0
                  },
                  StartValue = {
                    0,
                    46.6,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 152
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0},
              [2] = {Active = false, Time = 3}
            },
            RefEntityID = 155
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0},
              [2] = {Active = false, Time = 3.1}
            },
            RefEntityID = 147
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              },
              [2] = {Active = false, Time = 3}
            },
            RefEntityID = 157
          },
          [12] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              },
              [2] = {Active = false, Time = 3.1}
            },
            RefEntityID = 153
          },
          [13] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0.6
              }
            },
            RefEntityID = 158
          },
          [14] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.5
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.6
              }
            },
            RefEntityID = 159
          },
          [15] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 161
          },
          [16] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 163
          },
          [17] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 164
          }
        },
        [10] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 55,
                Time = 0.3
              },
              [2] = {Active = true, Time = 3.3}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
