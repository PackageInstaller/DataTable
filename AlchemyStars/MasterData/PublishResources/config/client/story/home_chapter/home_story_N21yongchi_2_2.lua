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
      EntityID = 4,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 5,
      Name = "虹霞",
      PetID = 1501681,
      Resource = "1501681.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [5] = {
      EntityID = 6,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [6] = {
      EntityID = 7,
      Name = "轨道相机1001",
      Resource = "vc_1020.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 8,
      Name = "加载一个轨道相机2",
      Resource = "vc_1019.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 9,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [9] = {
      EntityID = 10,
      Name = "加载一个轨道相机3",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 11,
      Name = "加载一个轨道相机4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 12,
      Name = "加载一个轨道相机6",
      Resource = "vc_1021.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 13,
      Name = "轨道镜头1005",
      Resource = "vc_1002.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 14,
      Name = "轨道镜头1007",
      Resource = "vc_1022.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 15,
      Name = "加载一个轨道相机8",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 16,
      Name = "杰诺",
      PetID = 1601671,
      Resource = "1601671.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [16] = {
      EntityID = 17,
      Name = "祈愿",
      Resource = "5354003.prefab",
      Type = "Model"
    },
    [17] = {
      EntityID = 18,
      Name = "轨道镜头9",
      Resource = "vc_1023.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [18] = {
      EntityID = 19,
      Name = "加载一个轨道相机10",
      Resource = "vc_1024.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [19] = {
      EntityID = 20,
      Name = "难过bubble",
      Resource = "eff_jy_meme_beiai.prefab",
      Type = "Model"
    },
    [20] = {
      EntityID = 21,
      FitSize = false,
      Name = "夏活BGM",
      Resource = "46",
      Type = "Sound"
    },
    [21] = {
      EntityID = 22,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [22] = {
      EntityID = 23,
      FitSize = false,
      Name = "失落气泡",
      Resource = "1716",
      Type = "Sound"
    }
  },
  ID = 90020202,
  Name = "home_story_N21yongchi_2_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1501681_wink",
            DialogContentStr = "str_homestory_N21yongchi_90020202_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.3
              },
              [2] = {ShowContent = 0.02, Time = 2.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hongxia"
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
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceTo = {Duration = 0.5, ID = 5},
                PlayAnimator = "move",
                Position3D = {
                  -41.2,
                  -4.8,
                  -118.7
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    163.9,
                    0
                  },
                  StartValue = {
                    0,
                    163.9,
                    0
                  }
                },
                Time = 0.5,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -41.2,
                    -4.8,
                    -118.5
                  },
                  StartValue = {
                    -41.2,
                    -4.8,
                    -116.73
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -40.8,
                  -4.8,
                  -119.7
                },
                Rotation3D = {
                  0,
                  -98.8,
                  0
                },
                Time = 0.5
              },
              [2] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 1.9
              },
              [3] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    0,
                    0
                  },
                  StartValue = {
                    0,
                    -98.8,
                    0
                  }
                },
                Time = 1.4
              },
              [4] = {PlayAnimation = "stand", Time = 3.7}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -41,
                  -3.92,
                  -119.4
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 6,
                OpenPath = {
                  Duration = 2,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -39.4,
                  -4.1,
                  -47.4
                },
                Time = 0.5
              }
            },
            RefEntityID = 7
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 21,
                Time = 0.6
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.8},
              [2] = {PlaySound = "Once", Time = 1.2},
              [3] = {PlaySound = "Once", Time = 1.6},
              [4] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 22
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -40.9,
                  -4,
                  -119.8
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                Position3D = {
                  -40.5,
                  -4.1,
                  -48.3
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "stand",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_3_dialog_content",
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
                Look = 6,
                Position3D = {
                  -40.1,
                  -3.9,
                  -119.4
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
                Position3D = {
                  -148.3,
                  -5.1,
                  -48.2
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -41.2,
                  -4.8,
                  -119.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_4_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 1.5,
                  EntityID = 11,
                  Style = 1
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -148.3,
                  -5.1,
                  -110.6
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                Position3D = {
                  -38.4,
                  -4,
                  -119.3
                },
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 20,
                  Offset = {
                    0.1,
                    0.18,
                    0
                  }
                },
                FaceSeq = 5,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
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
            RefEntityID = 20
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 23
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_7_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hongxia"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                Position3D = {
                  -40.9,
                  -4.1,
                  -48.7
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
                  -41.3,
                  -4,
                  -119.8
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "stand",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 20
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceTo = {Duration = 0.1, ID = 5},
                PlayAnimator = "idle",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_9_dialog_content",
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
                  EntityID = 13,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -60,
                  -5.8,
                  -82.6
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                Position3D = {
                  68.65,
                  -3.9,
                  -119.6
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -41.4,
                  -4.8,
                  -119.8
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                PlayAnimator = "awkward",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_10_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 12,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -40.2,
                  -4.1,
                  -118
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Brightness = 6,
                Position3D = {
                  -180,
                  4.8,
                  -89.3
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_11_dialog_content",
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
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_12_dialog_content",
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
                FaceSeq = 6,
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1501681_smile",
            DialogContentStr = "str_homestory_N21yongchi_90020202_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -53.9,
                  -6,
                  -147.6
                },
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                OpenPath = {
                  Duration = 0.1,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -41.9,
                  -3.9,
                  -116.1
                },
                Time = 0.2
              }
            },
            RefEntityID = 14
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
              [1] = {FaceSeq = 2, Time = 0.2}
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Time = 0.2,
                Translate3D = {
                  Duration = 0.1,
                  EndValue = {
                    -41.8,
                    -4.8,
                    -118.5
                  },
                  StartValue = {
                    -41.2,
                    -4.8,
                    -118.5
                  }
                }
              }
            },
            RefEntityID = 4
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
              }
            },
            RefEntityID = 2
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_15_dialog_content",
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
            RefEntityID = 4
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_16_dialog_content",
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
        [17] = {
          [1] = {
            Body = "base_icon_1501681_sad",
            DialogContentStr = "str_homestory_N21yongchi_90020202_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                Position3D = {
                  -41,
                  -4,
                  -48.9
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
                  -41.4,
                  -3.9,
                  -119.8
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 5,
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 5
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1501681_serious",
            DialogContentStr = "str_homestory_N21yongchi_90020202_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -41.25,
                  -4.8,
                  -118.8
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_19_dialog_content",
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
                  EntityID = 15,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                Position3D = {
                  -39.7,
                  -3.7,
                  -119.5
                },
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -180,
                  -30,
                  -110
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {PlayAnimation = "stand", Time = 0}
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [21] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_21_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.5
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0.7,
                  3,
                  46.2
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    195.3,
                    0
                  },
                  StartValue = {
                    0,
                    195.3,
                    0
                  }
                },
                Time = 0.3
              }
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Position3D = {
                  -0.2,
                  2.9,
                  42
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    57.9,
                    0
                  },
                  StartValue = {
                    0,
                    57.9,
                    0
                  }
                },
                Time = 0.3
              }
            },
            RefEntityID = 17
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0.7,
                  3.5,
                  46.2
                },
                Time = 0.3
              }
            },
            RefEntityID = 6
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 18,
                  Style = 0
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Look = 6,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  3,
                  6.4,
                  46.6
                },
                Time = 0.3
              }
            },
            RefEntityID = 18
          }
        },
        [22] = {
          [1] = {
            Body = "base_icon_1501681_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020202_22_dialog_content",
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
            SpeakerNameStr = "ui_story_name_hongxia"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 19,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -1.2,
                  4,
                  43.4
                },
                Time = 0
              }
            },
            RefEntityID = 19
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.7,
                  4,
                  46.2
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_23_dialog_content",
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
        [24] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020202_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.6
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                VC = {
                  Duration = 0,
                  EntityID = 15,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 9,
                Position3D = {
                  -39.7,
                  -3.7,
                  -119.5
                },
                Time = 0.3
              }
            },
            RefEntityID = 15
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -180,
                  -30,
                  -110
                },
                Time = 0.3
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {PlayAnimator = "happy", Time = 0.7},
              [2] = {PlayAnimator = "idle", Time = 2.7}
            },
            RefEntityID = 4
          }
        },
        [25] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
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
