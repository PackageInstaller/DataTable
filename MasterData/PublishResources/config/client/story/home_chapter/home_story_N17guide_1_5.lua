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
      Name = "轨道镜头1009",
      Resource = "vc_1009.prefab",
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
      EntityID = 141,
      Name = "定点镜头0001",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 142,
      Name = "定点镜头0002",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 144,
      Name = "白女士",
      PetID = 1400411,
      Resource = "1400411.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [10] = {
      EntityID = 145,
      Name = "灵感bubble",
      Resource = "eff_jy_meme_linggan.prefab",
      Type = "Model"
    },
    [11] = {
      EntityID = 146,
      Name = "轨道镜头1009-2",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 147,
      Name = "爱心bubble",
      Resource = "eff_jy_meme_aixin.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 148,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 149,
      Name = "定点镜头0003",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 150,
      Name = "轨道镜头1012",
      Resource = "vc_1012.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 151,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 152,
      Name = "轨道镜头1013",
      Resource = "vc_1013.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 153,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [19] = {
      EntityID = 154,
      Name = "宅舍",
      Resource = "5242101.prefab",
      Type = "Model"
    }
  },
  ID = 90000105,
  Name = "home_story_N17guide_1_5",
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
              },
              [2] = {
                Time = 4.8,
                VC = {
                  Duration = 0,
                  EntityID = 141,
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
            DialogContentStr = "str_homestory_N17guide_90000105_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 4.7
              },
              [2] = {ShowContent = 0.02, Time = 4.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  -8.1,
                  0
                },
                Time = 1.5,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    -20.1,
                    0,
                    65.8
                  },
                  StartValue = {
                    -20.1,
                    0,
                    63.9
                  }
                }
              },
              [2] = {PlayAnimator = "talk", Time = 4.5},
              [3] = {PlayAnimator = "idle", Time = 6.8}
            },
            RefEntityID = 116
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate3D = {
                  Duration = 7,
                  EndValue = {
                    -6.4,
                    0.4,
                    72.8
                  },
                  StartValue = {
                    -11.8,
                    0.4,
                    72.8
                  }
                }
              }
            },
            RefEntityID = 140
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -20.4,
                  0,
                  67.6
                },
                Rotation3D = {
                  0,
                  173.7,
                  0
                },
                Time = 0
              },
              [2] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.7,
                  EndValue = {
                    0,
                    205.9,
                    0
                  },
                  StartValue = {
                    0,
                    173.7,
                    0
                  }
                },
                Time = 4.2
              },
              [3] = {PlayAnimation = "stand", Time = 4.7}
            },
            RefEntityID = 113
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 140,
                OpenPath = {Duration = 7, Position = 0},
                Position3D = {
                  -22.8,
                  0.9,
                  65
                },
                Time = 0
              }
            },
            RefEntityID = 138
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -20,
                  0,
                  66.8
                },
                Rotation3D = {
                  0,
                  317.9,
                  0
                },
                Time = 0
              },
              [2] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.7,
                  EndValue = {
                    0,
                    183.19,
                    0
                  },
                  StartValue = {
                    0,
                    317.9,
                    0
                  }
                },
                Time = 4.4
              },
              [3] = {PlayAnimation = "stand", Time = 5.1}
            },
            RefEntityID = 144
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -20.86,
                  0.93,
                  67.45
                },
                Rotation3D = {
                  5,
                  143,
                  0
                },
                Time = 4.8
              }
            },
            RefEntityID = 141
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -14,
                  0,
                  68.7
                },
                Rotation3D = {
                  0,
                  -90,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 154
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_2_dialog_content",
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
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 145,
                  Offset = {
                    0.097,
                    0.031,
                    0
                  }
                },
                FaceSeq = 6,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          },
          [3] = {
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
            RefEntityID = 145
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -20.5,
                  0,
                  67.6
                },
                Rotation3D = {
                  0,
                  -177.8,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 153
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_4_dialog_content",
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
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -20.72,
                  0.92,
                  65.7
                },
                Rotation3D = {
                  5.165,
                  15,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 142
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
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "sad",
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 2.6}
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 144
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "talk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    334.06,
                    0
                  },
                  StartValue = {
                    0,
                    351.9,
                    0
                  }
                },
                Time = 0.1
              },
              [2] = {PlayAnimator = "idle", Time = 2.1}
            },
            RefEntityID = 116
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
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
              [1] = {FaceSeq = 1, Time = 0.3}
            },
            RefEntityID = 113
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_6_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_white"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 140,
                OpenPath = {Duration = 20, Position = 0},
                Position3D = {
                  -24.1,
                  1,
                  65.95
                },
                Rotation3D = {
                  180,
                  0,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 146
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  220.9,
                  0
                },
                Time = 0.2
              },
              [2] = {
                Bubble = {
                  ID = 147,
                  Offset = {
                    0.2,
                    0.14,
                    0.22
                  }
                },
                FaceSeq = 1,
                PlayAnimation = "happy",
                Time = 0.6
              },
              [3] = {PlayAnimation = "stand", Time = 3.4}
            },
            RefEntityID = 144
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -20.12,
                  0.39,
                  66.91
                },
                Time = 0.2
              }
            },
            RefEntityID = 140
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  376.2,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 116
          },
          [7] = {
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
                Time = 0.2
              }
            },
            RefEntityID = 123
          },
          [8] = {
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
          [9] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                Rotation3D = {
                  0,
                  -148.98,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 113
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 153
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_7_dialog_content",
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
        [8] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_8_dialog_content",
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
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_9_dialog_content",
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
            RefEntityID = 116
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000105_10_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
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
                  Duration = 1,
                  EntityID = 142,
                  Style = 2
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    199.5,
                    0
                  },
                  StartValue = {
                    0,
                    211,
                    0
                  }
                },
                Time = 0.6
              },
              [2] = {
                Bubble = {
                  ID = 148,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 4,
                Time = 0.2
              }
            },
            RefEntityID = 113
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -20.8,
                  1,
                  66.5
                },
                Rotation3D = {
                  7.91,
                  14.69,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 142
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
            RefEntityID = 148
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  -16.5,
                  0
                },
                Time = 1.2
              }
            },
            RefEntityID = 116
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Rotation3D = {
                  0,
                  188.06,
                  0
                },
                Time = 1.2
              }
            },
            RefEntityID = 144
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 153
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
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
                FaceSeq = 7,
                PlayAnimator = "awkward",
                Time = 0.2
              },
              [2] = {PlayAnimator = "idle", Time = 2.3}
            },
            RefEntityID = 116
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                Rotation3D = {
                  0,
                  178.6,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.8}
            },
            RefEntityID = 148
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_12_dialog_content",
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
                Active = true,
                Position3D = {
                  -21.3,
                  0.9,
                  65.1
                },
                Rotation3D = {
                  5.165,
                  36.98,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 142
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
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.9}
            },
            RefEntityID = 144
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    2.72,
                    0
                  },
                  StartValue = {
                    0,
                    -16.5,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.4}
            },
            RefEntityID = 116
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_13_dialog_content",
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
        [14] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_14_dialog_content",
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
        [15] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_15_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -21,
                  1,
                  65.7
                },
                Rotation3D = {
                  8.1,
                  20.27,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 149
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 149,
                  Style = 3
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0.4},
              [2] = {PlayAnimation = "stand", Time = 2.2}
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.7,
                  EndValue = {
                    0,
                    339.7,
                    0
                  },
                  StartValue = {
                    0,
                    188.1,
                    0
                  }
                },
                Time = 0.9
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 144
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_16_dialog_content",
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 151,
                OpenPath = {Duration = 20, Ease = 3},
                Position3D = {
                  -54.7,
                  2.2,
                  86.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 150
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 150,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  101.8,
                  11.9,
                  72.3
                },
                Time = 0
              }
            },
            RefEntityID = 151
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_17_dialog_content",
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
        [18] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 152,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
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
                Position3D = {
                  326.4,
                  -17.3,
                  41.2
                },
                Time = 0.4
              }
            },
            RefEntityID = 151
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 151,
                OpenPath = {
                  Duration = 30,
                  Ease = 2,
                  Position = 0
                },
                Position3D = {
                  -0.7,
                  4.7,
                  92.6
                },
                Rotation3D = {
                  180,
                  -58.28,
                  180
                },
                Time = 0.4
              }
            },
            RefEntityID = 152
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000105_19_dialog_content",
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
        [20] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_20_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
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
              [1] = {FaceSeq = 1, Time = 0.4}
            },
            RefEntityID = 113
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -19.94,
                  0,
                  66.6
                },
                Rotation3D = {
                  0,
                  -27.9,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 144
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -20.27,
                  0,
                  65.8
                },
                Rotation3D = {
                  0,
                  -8.7,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 116
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_21_dialog_content",
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
        [22] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_22_dialog_content",
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
                FaceSeq = 3,
                PlayAnimator = "talk",
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
                  EntityID = 141,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -21.7,
                  0.94,
                  68.05
                },
                Rotation3D = {
                  6,
                  130,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 141
          }
        },
        [23] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_23_dialog_content",
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
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.7}
            },
            RefEntityID = 144
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1500331_serious",
            DialogContentStr = "str_homestory_N17guide_90000105_24_dialog_content",
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
                FaceSeq = 11,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 113
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_25_dialog_content",
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
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 116
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_26_dialog_content",
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
        [27] = {
          [1] = {
            Body = "base_icon_1500331_worried",
            DialogContentStr = "str_homestory_N17guide_90000105_27_dialog_content",
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
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 149,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 5,
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    -21,
                    0,
                    66.9
                  },
                  StartValue = {
                    -20.5,
                    0,
                    67.6
                  }
                }
              },
              [2] = {PlayAnimation = "sad", Time = 1},
              [3] = {PlayAnimation = "stand", Time = 3.2}
            },
            RefEntityID = 113
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -22.1,
                  1,
                  64.6
                },
                Rotation3D = {
                  7.7,
                  35.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 149
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    337.2,
                    0
                  },
                  StartValue = {
                    0,
                    351.3,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {
                FaceSeq = 4,
                PlayAnimator = "idle",
                Time = 0.7
              }
            },
            RefEntityID = 116
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    268.5,
                    0
                  },
                  StartValue = {
                    0,
                    332.1,
                    0
                  }
                },
                Time = 0.3
              },
              [2] = {PlayAnimation = "stand", Time = 1.3}
            },
            RefEntityID = 144
          }
        },
        [28] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_28_dialog_content",
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
              [1] = {FaceSeq = 11, Time = 0}
            },
            RefEntityID = 113
          }
        },
        [29] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_29_dialog_content",
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
            RefEntityID = 113
          }
        },
        [30] = {
          [1] = {
            Body = "base_icon_1400411_norm",
            DialogContentStr = "str_homestory_N17guide_90000105_30_dialog_content",
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
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.7}
            },
            RefEntityID = 144
          }
        },
        [31] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000105_31_dialog_content",
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
        [32] = {
          [1] = {
            DialogContentStr = "str_homestory_N17guide_90000105_32_dialog_content",
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
            RefEntityID = 116
          }
        },
        [33] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N17guide_90000105_33_dialog_content",
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 113
          }
        },
        [34] = {
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
              [2] = {Active = true, Time = 2.9}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
