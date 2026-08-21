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
      Name = "菲莉诗",
      PetID = 1400571,
      Resource = "1400571.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "薇薇安",
      PetID = 1400441,
      Resource = "1400441.prefab",
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
      Name = "轨道镜头10",
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
      Name = "抖动机位1",
      Resource = "vc_0005.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 13,
      Name = "卡莲",
      PetID = 1600061,
      Resource = "1600061.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [14] = {
      EntityID = 14,
      Name = "省略号bubble",
      Resource = "eff_jy_meme_duihua2.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 16,
      Name = "慌张bubble",
      Resource = "eff_jy_meme_huangzhang.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 17,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
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
      Name = "黑线bubble",
      Resource = "eff_jy_meme_heixian.prefab",
      Type = "Model"
    },
    [21] = {
      EntityID = 21,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    }
  },
  ID = 90020405,
  Name = "home_story_N21yongchi_4_5",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1400571_sleep",
            DialogContentStr = "str_homestory_N21yongchi_90020405_1_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
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
                FaceSeq = 2,
                Position3D = {
                  24.78,
                  2.875,
                  18.7
                },
                Time = 0
              },
              [2] = {
                Bubble = {
                  ID = 14,
                  Offset = {
                    0,
                    0.1,
                    0.2
                  }
                },
                Time = 1.2
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  24.7,
                  4,
                  21.39
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [6] = {
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
          [7] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 7
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 1.2
              }
            },
            RefEntityID = 14
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.2}
            },
            RefEntityID = 19
          },
          [10] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 23, Time = 0.5}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020405_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  28.2,
                  4.2,
                  21.8
                },
                Rotation3D = {
                  10.1,
                  -120.6,
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
                  Duration = 1.5,
                  EntityID = 8,
                  Style = 3
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
                  129,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    23.7,
                    2.85,
                    20.1
                  },
                  StartValue = {
                    20.8,
                    2.85,
                    22
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 14
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020405_3_dialog_content",
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
              [1] = {FaceSeq = 7, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1400571_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020405_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  23.8,
                  3.9,
                  21
                },
                Rotation3D = {
                  10,
                  -195,
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
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -40.8,
                    0
                  },
                  StartValue = {
                    0,
                    0,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020405_5_dialog_content",
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
                  25.8,
                  3.9,
                  18.6
                },
                Rotation3D = {
                  9.4,
                  -60.6,
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
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020405_6_dialog_content",
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
              [1] = {PlayAnimator = "talk", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1400571_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020405_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
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
                  23.94,
                  3.828,
                  20.153
                },
                Rotation3D = {
                  6.8,
                  151,
                  -0.146
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1400441_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020405_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_weiweian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  23.94,
                  3.828,
                  20.153
                },
                Rotation3D = {
                  6.8,
                  151,
                  -0.146
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 11,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 9,
                  Style = 0
                }
              }
            }
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1400571_shock",
            DialogContentStr = "str_homestory_N21yongchi_90020405_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  22.8,
                  3.9,
                  19
                },
                Rotation3D = {
                  9.5,
                  89.87,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1,
                  EntityID = 12,
                  Style = 3
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 4,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -126.5,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    26.3,
                    2.85,
                    19.7
                  },
                  StartValue = {
                    27.2,
                    2.85,
                    20.5
                  }
                }
              },
              [2] = {
                PlayAnimation = "stand",
                Rotate3D = {
                  Duration = 0.2,
                  EndValue = {
                    0,
                    -140,
                    0
                  },
                  StartValue = {
                    0,
                    -126,
                    0
                  }
                },
                Time = 2
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    408.03,
                    0
                  },
                  StartValue = {
                    0,
                    319.2,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5},
              [3] = {
                Bubble = {
                  ID = 16,
                  Offset = {
                    -0.2,
                    0.1,
                    0.15
                  }
                },
                PlayAnimation = "surprise",
                Time = 1.5
              },
              [4] = {PlayAnimation = "stand", Time = 3.3}
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Scaling3D = {
                  0.4,
                  0.4,
                  0.4
                },
                Time = 1.5
              }
            },
            RefEntityID = 16
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 19
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1400571_shock",
            DialogContentStr = "str_homestory_N21yongchi_90020405_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1400571_shock",
            DialogContentStr = "str_homestory_N21yongchi_90020405_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 16
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1400441_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020405_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_weiweian"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  23.7,
                  3.9,
                  18.8
                },
                Rotation3D = {
                  10.1,
                  78.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 18,
                  Offset = {
                    -0.2,
                    0.1,
                    -0.05
                  }
                },
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 4
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
            RefEntityID = 18
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1400441_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020405_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1400571_surprise",
            DialogContentStr = "str_homestory_N21yongchi_90020405_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  26.3,
                  3.9,
                  21.2
                },
                Rotation3D = {
                  10.6,
                  200.67,
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 18
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1400571_surprise",
            DialogContentStr = "str_homestory_N21yongchi_90020405_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1400441_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020405_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_weiweian"
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
          }
        },
        [17] = {
          [1] = {
            Body = "base_icon_1400441_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020405_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_weiweian"
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1400571_cute",
            DialogContentStr = "str_homestory_N21yongchi_90020405_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  26.3,
                  3.9,
                  21.2
                },
                Rotation3D = {
                  10.6,
                  200.67,
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
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1400571_cute",
            DialogContentStr = "str_homestory_N21yongchi_90020405_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 20,
                  Offset = {
                    0.3,
                    0.1,
                    0.1
                  }
                },
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scaling3D = {
                  0.45,
                  0.45,
                  0.45
                },
                Time = 0
              }
            },
            RefEntityID = 20
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1400571_cute",
            DialogContentStr = "str_homestory_N21yongchi_90020405_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feilishi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  24.4,
                  3.5,
                  18.8
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 20
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1600061_surprise",
            DialogContentStr = "str_homestory_N21yongchi_90020405_21_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.5
              },
              [2] = {ShowContent = 0.02, Time = 3.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
              },
              [2] = {
                Time = 0.4,
                VC = {
                  Duration = 3,
                  EntityID = 9,
                  Style = 3
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  26.14,
                  3.87,
                  17.42
                },
                Rotation3D = {
                  7,
                  -18.46,
                  -0.72
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  25.77,
                  3.83,
                  18.54
                },
                Rotation3D = {
                  8.7,
                  -63.6,
                  0.95
                },
                Time = 0.4
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    37.9,
                    0
                  },
                  StartValue = {
                    0,
                    48,
                    0
                  }
                },
                Time = 0.2,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    27.3,
                    2.9,
                    22
                  },
                  StartValue = {
                    24.8,
                    2.9,
                    18.7
                  }
                }
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    403.05,
                    0
                  },
                  StartValue = {
                    0,
                    220,
                    0
                  }
                },
                Time = 0
              },
              [2] = {
                Time = 0.4,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    27.9,
                    2.8,
                    22.7
                  },
                  StartValue = {
                    26.3,
                    2.8,
                    19.7
                  }
                }
              }
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    97.4,
                    0
                  },
                  StartValue = {
                    0,
                    129,
                    0
                  }
                },
                Time = 0.7
              },
              [2] = {PlayAnimator = "idle", Time = 1.6},
              [3] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 5
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  83.5,
                  0
                },
                Time = 1.6,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    22.9,
                    2.85,
                    19.4
                  },
                  StartValue = {
                    21,
                    2.85,
                    19
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 3.5}
            },
            RefEntityID = 13
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1600061_surprise",
            DialogContentStr = "str_homestory_N21yongchi_90020405_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020405_23_dialog_content",
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
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020405_24_dialog_content",
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
        [25] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020405_25_dialog_content",
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
                Bubble = {
                  ID = 17,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                PlayAnimator = "happy",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 5
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
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [26] = {
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
                Time = 0.5
              }
            }
          }
        }
      }
    }
  },
  StartParagraph = 1
}
