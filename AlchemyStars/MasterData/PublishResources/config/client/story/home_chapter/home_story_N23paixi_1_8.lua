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
      Name = "摄影机",
      Resource = "5273011.prefab",
      Type = "Model"
    },
    [3] = {
      EntityID = 3,
      Name = "背景板",
      Resource = "5273010.prefab",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "薇丝",
      PetID = 1500331,
      Resource = "1500331.prefab",
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
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "主角2",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [8] = {
      EntityID = 8,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [9] = {
      EntityID = 9,
      Name = "定点镜头1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "轨道相机1",
      Resource = "vc_1024.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "关注点1",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [12] = {
      EntityID = 12,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "轨道镜头2",
      Resource = "vc_1025.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 14,
      Name = "定点相机2",
      Resource = "vc_101.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 15,
      Name = "关注点3",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 16,
      Name = "定点镜头3",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [17] = {
      EntityID = 17,
      Name = "轨道镜头1094",
      Resource = "vc_1023.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 18,
      Name = "兴奋bubble",
      Resource = "eff_jy_meme_xingfen.prefab",
      Type = "Model"
    },
    [19] = {
      EntityID = 19,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "脚步",
      Resource = "10083",
      Type = "Sound"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    }
  },
  ID = 90040108,
  Name = "home_story_N23paixi_1_8",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
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
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  19.77,
                  2,
                  24.61
                },
                Rotation3D = {
                  0,
                  124,
                  0
                },
                Time = 0.3
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  20.4,
                  1.9,
                  23.9
                },
                Rotation3D = {
                  0,
                  -31,
                  1
                },
                Time = 0.3
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                Position3D = {
                  17.4,
                  2,
                  25.4
                },
                Rotation3D = {
                  0,
                  91,
                  0
                },
                Time = 0.3
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  18,
                  2.9,
                  25.5
                },
                Time = 0.3
              }
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 8,
                Position3D = {
                  18.2,
                  2.9,
                  25.55
                },
                Time = 0.3
              }
            },
            RefEntityID = 9
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 9,
                  Style = 0
                }
              }
            }
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.2,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 20,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N23paixi_90040108_2_dialog_content",
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
                Look = 11,
                Position3D = {
                  21.2,
                  3.3,
                  23.8
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  18.9,
                  2,
                  23
                },
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    19,
                    2,
                    23
                  },
                  StartValue = {
                    18.9,
                    2,
                    23
                  }
                }
              }
            },
            RefEntityID = 11
          },
          [4] = {
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
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 6,
                PlayAnimator = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    19.77,
                    2,
                    24.61
                  },
                  StartValue = {
                    19.45,
                    2,
                    24.82
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.5}
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 18,
                  Offset = {
                    -0.1,
                    0.1,
                    0
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
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
                Time = 0
              }
            },
            RefEntityID = 18
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5},
              [2] = {PlaySound = "Once", Time = 1},
              [3] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 21
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 22
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N23paixi_90040108_3_dialog_content",
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
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 18
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_4_dialog_content",
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
              }
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_5_dialog_content",
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
                Position3D = {
                  -2.7,
                  0,
                  88.8
                },
                Rotation3D = {
                  0,
                  -50,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  0,
                  86
                },
                Rotation3D = {
                  0,
                  -50,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_6_dialog_content",
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
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1500331_Shocked",
            DialogContentStr = "str_homestory_N23paixi_90040108_7_dialog_content",
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
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1500331_worried",
            DialogContentStr = "str_homestory_N23paixi_90040108_8_dialog_content",
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
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_9_dialog_content",
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
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_10_dialog_content",
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
                FaceSeq = 1,
                PlayAnimator = "talk",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N23paixi_90040108_11_dialog_content",
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
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1500331_norm",
            DialogContentStr = "str_homestory_N23paixi_90040108_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimator = "idle", Time = 0.2}
            },
            RefEntityID = 5
          },
          [3] = {
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
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  25,
                  5,
                  85
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 12,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -14.9,
                  2.4,
                  93.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 13,
                  Style = 0
                }
              }
            }
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_13_dialog_content",
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
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_14_dialog_content",
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
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_15_dialog_content",
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
        [16] = {
          [1] = {
            Body = "base_icon_1500331_tsukkomi",
            DialogContentStr = "str_homestory_N23paixi_90040108_16_dialog_content",
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  20.4,
                  2.8,
                  23.9
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [4] = {
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
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 11,
                Position3D = {
                  19.84,
                  2.8,
                  24.69
                },
                Time = 0.2
              }
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  20.44,
                  1.9,
                  23.92
                },
                Time = 0.2
              }
            },
            RefEntityID = 4
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040108_17_dialog_content",
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
                FaceSeq = 2,
                PlayAnimator = "talk",
                Position3D = {
                  19.82,
                  2,
                  24.69
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  18.9,
                  2,
                  23
                },
                Time = 0,
                Translate3D = {
                  Duration = 1,
                  EndValue = {
                    18.9,
                    2.2,
                    23
                  },
                  StartValue = {
                    19,
                    2.2,
                    23
                  }
                }
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 15,
                Position3D = {
                  21.4,
                  3,
                  25.8
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [5] = {
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
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1500331_angry2",
            DialogContentStr = "str_homestory_N23paixi_90040108_18_dialog_content",
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
                FaceSeq = 4,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 5
          }
        },
        [19] = {
          [1] = {
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
            RefEntityID = 6
          },
          [2] = {
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
