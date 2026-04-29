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
      Name = "海蒂",
      Resource = "1601201.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [6] = {
      EntityID = 6,
      Name = "定点相机1",
      Resource = "vc_101.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "定点相机2",
      Resource = "vc_101.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 8,
      Name = "轨道相机1",
      Resource = "vc_1028.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "关注点1",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [10] = {
      EntityID = 10,
      Name = "丘布长老",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [11] = {
      EntityID = 11,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [12] = {
      EntityID = 12,
      Name = "轨道相机2",
      Resource = "vc_1024.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 13,
      Name = "轨道镜头3",
      Resource = "vc_1025.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 14,
      Name = "定点相机3",
      Resource = "vc_101.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 15,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "震惊气泡音效",
      Resource = "1714",
      Type = "Sound"
    }
  },
  ID = 90040202,
  Name = "home_story_N23paixi_2_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1601201_surprise",
            DialogContentStr = "str_homestory_N23paixi_90040202_1_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 1,
                PlayAnimation = "walk",
                Position3D = {
                  -92.9,
                  -5.1,
                  -55.5
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    -32,
                    0
                  },
                  StartValue = {
                    0,
                    -125,
                    0
                  }
                },
                Time = 0.3
              },
              [2] = {PlayAnimation = "stand", Time = 1.8}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  150,
                  0
                },
                Time = 0.3,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -93.3,
                    -5.2,
                    -54.8
                  },
                  StartValue = {
                    -93.5,
                    -5.2,
                    -53.8
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -109,
                  -5.1,
                  -63.96
                },
                Time = 0.3
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 5,
                Position3D = {
                  -90.7,
                  -4.6,
                  -53.8
                },
                Time = 0.3
              }
            },
            RefEntityID = 6
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -108.7,
                  -6.7,
                  -63.7
                },
                Time = 0.3
              }
            },
            RefEntityID = 10
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
                StartBgm = 16,
                Time = 0.5
              }
            }
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8},
              [2] = {PlaySound = "Once", Time = 1.4}
            },
            RefEntityID = 17
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601201_smile",
            DialogContentStr = "str_homestory_N23paixi_90040202_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_3_dialog_content",
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
                PlayAnimator = "happy",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_4_dialog_content",
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
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601201_think",
            DialogContentStr = "str_homestory_N23paixi_90040202_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                Position3D = {
                  -91.9,
                  -4.2,
                  -54.6
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
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.2}
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_6_dialog_content",
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
              [1] = {PlayAnimator = "talk", Time = 0}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_7_dialog_content",
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
        [8] = {
          [1] = {
            Body = "base_icon_1601201_smile",
            DialogContentStr = "str_homestory_N23paixi_90040202_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                OpenPath = {
                  Duration = 5,
                  Ease = 2,
                  Position = 0
                },
                Position3D = {
                  -90.9,
                  -3.8,
                  -51.8
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
                  Duration = 0,
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -109,
                  -5.1,
                  -63.96
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    -100,
                    0
                  },
                  StartValue = {
                    0,
                    -32,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1}
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601201_smile",
            DialogContentStr = "str_homestory_N23paixi_90040202_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601201_think",
            DialogContentStr = "str_homestory_N23paixi_90040202_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
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
                Layer = 50,
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
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -108.7,
                  -6.7,
                  -63.7
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 11,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -105.8,
                  -3.6,
                  -64.3
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 12,
                  Style = 0
                }
              }
            }
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601201_smile",
            DialogContentStr = "str_homestory_N23paixi_90040202_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1601201_serious",
            DialogContentStr = "str_homestory_N23paixi_90040202_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1601201_serious",
            DialogContentStr = "str_homestory_N23paixi_90040202_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_14_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
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
                Time = 0.3
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -90,
                  -5.2,
                  -54.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -98,
                  -3,
                  -54.3
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [5] = {
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
          },
          [6] = {
            KeyFrames = {
              [1] = {PlayAnimator = "talk", Time = 0.2}
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -93,
                  -5.1,
                  -55.6
                },
                Time = 0.1
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601201_anger",
            DialogContentStr = "str_homestory_N23paixi_90040202_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 1,
                  EndValue = {
                    0,
                    -45,
                    0
                  },
                  StartValue = {
                    0,
                    -100,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1}
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_16_dialog_content",
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
              [1] = {PlayAnimator = "awkward", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_17_dialog_content",
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
            DialogContentStr = "str_homestory_N23paixi_90040202_18_dialog_content",
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
              [1] = {PlayAnimator = "think", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1601201_worried",
            DialogContentStr = "str_homestory_N23paixi_90040202_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 15,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 5,
                PlayAnimation = "surprise",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 3
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
              },
              [2] = {Active = false, Time = 1.5}
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_20_dialog_content",
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
              [1] = {PlayAnimator = "idle", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1601201_think",
            DialogContentStr = "str_homestory_N23paixi_90040202_21_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -86,
                  -5.1,
                  -60.39
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 9,
                Position3D = {
                  -94.2,
                  -4.1,
                  -54.5
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1601201_serious",
            DialogContentStr = "str_homestory_N23paixi_90040202_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            Body = "base_icon_1601201_smile",
            DialogContentStr = "str_homestory_N23paixi_90040202_23_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          }
        },
        [24] = {
          [1] = {
            Body = "base_icon_1601201_smile",
            DialogContentStr = "str_homestory_N23paixi_90040202_24_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          }
        },
        [25] = {
          [1] = {
            Body = "base_icon_1601201_think",
            DialogContentStr = "str_homestory_N23paixi_90040202_25_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {
                FaceSeq = 1,
                PlayAnimation = "stand",
                Time = 2.5
              }
            },
            RefEntityID = 3
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_26_dialog_content",
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
              [1] = {PlayAnimator = "happy", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [27] = {
          [1] = {
            Body = "base_icon_1601201_happy",
            DialogContentStr = "str_homestory_N23paixi_90040202_27_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -93.8,
                  -4.1,
                  -55
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            Body = "base_icon_1601201_smile",
            DialogContentStr = "str_homestory_N23paixi_90040202_28_dialog_content",
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
            SpeakerNameStr = "ui_story_name_haidi"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "str_homestory_N23paixi_90040202_29_dialog_content",
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
        [30] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 2
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
