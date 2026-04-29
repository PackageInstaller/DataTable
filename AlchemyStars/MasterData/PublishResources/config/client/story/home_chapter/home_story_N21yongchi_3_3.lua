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
      Name = "黑潮1",
      PetID = 1400811,
      Resource = "1400811.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "黑潮2",
      PetID = 1400811,
      Resource = "1400811.prefab",
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
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 7,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [8] = {
      EntityID = 8,
      Name = "轨道相机1",
      Resource = "vc_1025.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "轨道相机2",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "轨道镜头3",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "轨道镜头4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "主角2",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [14] = {
      EntityID = 14,
      Name = "轨道镜头5",
      Resource = "vc_1026.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 15,
      Name = "轨道相机6",
      Resource = "vc_1099.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 16,
      Name = "轨道镜头7",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 17,
      Name = "轨道镜头8",
      Resource = "vc_0005.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 18,
      Name = "疲惫bubble",
      Resource = "eff_jy_meme_pibei.prefab",
      Type = "Model"
    },
    [19] = {
      EntityID = 19,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 20,
      Name = "轨道镜头9",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [21] = {
      EntityID = 21,
      Name = "汗水bubble",
      Resource = "eff_jy_meme_huangzhang.prefab",
      Type = "Model"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "诙谐BGM",
      Resource = "37",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "难过声",
      Resource = "1716",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "通用气泡",
      Resource = "1712",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "咀嚼声",
      Resource = "10110",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "轰",
      Resource = "10049",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "叹号",
      Resource = "1714",
      Type = "Sound"
    }
  },
  ID = 90020303,
  Name = "home_story_N21yongchi_3_3",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_1_dialog_content",
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
                Alpha = 1,
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                Position3D = {
                  44.8,
                  0,
                  -78
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    24.3,
                    0
                  },
                  StartValue = {
                    0,
                    24.3,
                    0
                  }
                },
                Time = 0.4
              },
              [2] = {
                Bubble = {
                  ID = 18,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                PlayAnimator = "sigh",
                Time = 0.5
              },
              [3] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  44.8,
                  0.8,
                  -78
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                OpenPath = {
                  Duration = 1,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  43.3,
                  1.8,
                  -75.1
                },
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                VC = {
                  Duration = 0,
                  EntityID = 8,
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
                  46.6,
                  0,
                  -76.3
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    233.7,
                    0
                  },
                  StartValue = {
                    0,
                    233.7,
                    0
                  }
                },
                Time = 0.4
              }
            },
            RefEntityID = 3
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0.5
              }
            },
            RefEntityID = 18
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 22,
                Time = 0.6
              }
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 23
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    45.48,
                    0,
                    -77.2
                  },
                  StartValue = {
                    46.4,
                    0,
                    -76.7
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  46,
                  0.6,
                  -78.5
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                Position3D = {
                  43.9,
                  1.2,
                  -75.9
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 9,
                  Style = 1
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {Time = 0},
              [2] = {
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    44.54,
                    0
                  },
                  StartValue = {
                    0,
                    24.3,
                    0
                  }
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6},
              [2] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 24
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
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
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_4_dialog_content",
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
              [1] = {PlayAnimation = "stand", Time = 0}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  43.3,
                  0.87,
                  -79.3
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                Position3D = {
                  43.7,
                  1,
                  -78.3
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
                Active = true,
                FaceSeq = 2,
                PlayAnimator = "think",
                Position3D = {
                  43.3,
                  0,
                  -79.3
                },
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    29.7,
                    0
                  },
                  StartValue = {
                    0,
                    29.7,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 12
          },
          [5] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_5_dialog_content",
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
            DialogContentStr = "str_homestory_N21yongchi_90020303_6_dialog_content",
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
                FaceTo = {Duration = 0.5, ID = 5},
                Position3D = {
                  44.7,
                  0,
                  -76.8
                },
                Rotate3D = {
                  Duration = 0.1,
                  EndValue = {
                    0,
                    190.81,
                    0
                  },
                  StartValue = {
                    0,
                    190.81,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "idle",
                Rotate3D = {
                  Duration = 0.1,
                  EndValue = {
                    0,
                    13.7,
                    0
                  },
                  StartValue = {
                    0,
                    13.7,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_7_dialog_content",
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
                Look = 7,
                Position3D = {
                  44,
                  1,
                  -78.7
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  44.9,
                  0.8,
                  -77.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [4] = {
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
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimator = "talk",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.7}
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_9_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "move",
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    61.1,
                    0
                  },
                  StartValue = {
                    0,
                    61.1,
                    0
                  }
                },
                Time = 0.2,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    20.38,
                    -0.71,
                    -88.29
                  },
                  StartValue = {
                    13.79,
                    -0.71,
                    -91.93
                  }
                }
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -45,
                  -4.48,
                  -114.6
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                OpenPath = {
                  Duration = 2,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  17.8,
                  0.1,
                  -90
                },
                Time = 0.2
              }
            },
            RefEntityID = 14
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 14,
                  Style = 0
                }
              }
            }
          },
          [7] = {
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
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.5
              }
            },
            RefEntityID = 2
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 18
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5},
              [2] = {PlaySound = "Once", Time = 0.9},
              [3] = {PlaySound = "Once", Time = 1.3},
              [4] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 24
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_10_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  46,
                  0.6,
                  -78.5
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                Position3D = {
                  43.9,
                  1.2,
                  -75.9
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
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
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          },
          [7] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "stand",
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    233.7,
                    0
                  },
                  StartValue = {
                    0,
                    233.7,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 0.1,
                  EndValue = {
                    45.48,
                    0,
                    -77.2
                  },
                  StartValue = {
                    45.48,
                    0,
                    -77.2
                  }
                }
              }
            },
            RefEntityID = 3
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    52.3,
                    0
                  },
                  StartValue = {
                    0,
                    52.3,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_11_dialog_content",
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
                Bubble = {
                  ID = 21,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 7,
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
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
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_12_dialog_content",
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
            CreateName = {NextParagraphID = 2},
            DialogContentStr = "str_homestory_N21yongchi_90020303_13_dialog_content",
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
                Active = true,
                PlayAnimation = "stand",
                Position3D = {
                  47,
                  -0.1,
                  -75.8
                },
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    220.6,
                    0
                  },
                  StartValue = {
                    0,
                    220.6,
                    0
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1400811_think",
            DialogContentStr = "str_homestory_N21yongchi_90020303_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 6,
                Position3D = {
                  45.9,
                  0.9,
                  -76.5
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  47,
                  0.8,
                  -75.8
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 16,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 21
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          }
        },
        [17] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                Position3D = {
                  43.7,
                  1,
                  -78.3
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                PlayAnimator = "think",
                Position3D = {
                  43.3,
                  0,
                  -79.3
                },
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    29.7,
                    0
                  },
                  StartValue = {
                    0,
                    29.7,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 12
          },
          [4] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_17_dialog_content",
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
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  43.3,
                  0.87,
                  -79.3
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
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
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 26
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1400811_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020303_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 26
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 17,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                Position3D = {
                  43.2,
                  0.9,
                  -74.7
                },
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  46,
                  0.6,
                  -78.5
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1400811_surprise",
            DialogContentStr = "str_homestory_N21yongchi_90020303_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 6,
                Position3D = {
                  45.9,
                  0.9,
                  -76.5
                },
                Time = 0.2
              }
            },
            RefEntityID = 16
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  47,
                  0.8,
                  -75.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 16,
                  Style = 0
                }
              }
            }
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
            RefEntityID = 2
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Bubble = {
                  ID = 19,
                  Offset = {
                    -0.4,
                    0,
                    0
                  }
                },
                FaceSeq = 4,
                PlayAnimation = "surprise",
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 2.4}
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.3,
                  0.3,
                  0.3
                },
                Time = 0.2
              }
            },
            RefEntityID = 19
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 28
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1400811_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020303_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          }
        },
        [23] = {
          [1] = {
            Body = "base_icon_1400811_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020303_23_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 19
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1400811_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020303_24_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "stand", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_25_dialog_content",
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
                Look = 7,
                Position3D = {
                  43.7,
                  1,
                  -78.3
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
                Active = true,
                FaceSeq = 7,
                PlayAnimator = "awkward",
                Position3D = {
                  43.3,
                  0,
                  -79.3
                },
                Rotate3D = {
                  Duration = 0,
                  EndValue = {
                    0,
                    29.7,
                    0
                  },
                  StartValue = {
                    0,
                    29.7,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  43.3,
                  0.87,
                  -79.3
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_26_dialog_content",
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
            RefEntityID = 12
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_27_dialog_content",
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
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_28_dialog_content",
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
        [29] = {
          [1] = {
            Body = "base_icon_1400811_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020303_29_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                Position3D = {
                  43.9,
                  1.2,
                  -75.9
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
              [1] = {
                Position3D = {
                  46,
                  0.6,
                  -78.5
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020303_30_dialog_content",
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
                PlayAnimation = "happy",
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [31] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_31_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 20,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  47,
                  0.8,
                  -75.8
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0},
              [2] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                Position3D = {
                  45.9,
                  0.9,
                  -76.5
                },
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [32] = {
          [1] = {
            Body = "base_icon_1400811_like",
            DialogContentStr = "str_homestory_N21yongchi_90020303_32_dialog_content",
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
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [33] = {
          [1] = {
            KeyFrames = {
              [1] = {PlayAnimation = "stand", Time = 0}
            },
            RefEntityID = 4
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 2
          },
          [3] = {
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
