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
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
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
      Name = "多孚",
      PetID = 1300521,
      Resource = "1300521.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [6] = {
      EntityID = 6,
      Name = "轨道镜头1010",
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
      Name = "抖动机位1",
      Resource = "vc_0004.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "轨道相机1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "灵感bubble",
      Resource = "eff_jy_meme_linggan.prefab",
      Type = "Model"
    },
    [12] = {
      EntityID = 12,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 14,
      Name = "混乱bubble",
      Resource = "eff_jy_meme_hunluan.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      Name = "问号",
      Resource = "1713",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      Name = "开心",
      Resource = "1717",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    }
  },
  ID = 90020402,
  Name = "home_story_N21yongchi_4_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.4
              },
              [2] = {ShowContent = 0.02, Time = 2.6}
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
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                Position3D = {
                  -112.6,
                  -4.9,
                  -10.8
                },
                Rotation3D = {
                  0,
                  0,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 3,
                PlayAnimator = "move",
                Rotation3D = {
                  0,
                  -19.52,
                  0
                },
                Time = 0.4,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    -111.8,
                    -4.8,
                    -11.9
                  },
                  StartValue = {
                    -111.1,
                    -4.75,
                    -14
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 2.4}
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                Position3D = {
                  -111.8,
                  -4,
                  -7.7
                },
                Rotation3D = {
                  17,
                  -171.55,
                  0
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 2,
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
                  -112.76,
                  -4.5,
                  -13.7
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 12,
                  Offset = {
                    0,
                    0,
                    0.2
                  }
                },
                FaceSeq = 1,
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0.2,
                  EntityID = 9,
                  Style = 2
                }
              },
              [2] = {
                Time = 0.5,
                VC = {
                  Duration = 0.2,
                  EntityID = 3,
                  Style = 2
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 7,
                Position3D = {
                  -112,
                  -4,
                  -9
                },
                Rotation3D = {
                  17,
                  -171.55,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 7,
                Position3D = {
                  -112,
                  -4,
                  -9
                },
                Rotation3D = {
                  17,
                  -171.55,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.45,
                  0.45,
                  0.45
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 15
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    146,
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
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -111.9,
                  -3.8,
                  -13
                },
                Rotation3D = {
                  10.6,
                  -10.7,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
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
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 13,
                  Offset = {
                    0,
                    0.1,
                    -0.2
                  }
                },
                FaceSeq = 1,
                Time = 0
              }
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
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_5_dialog_content",
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
                  EntityID = 3,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlayAnimator = "talk", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Look = -1,
                Position3D = {
                  -112.24,
                  -4,
                  -9.51
                },
                Rotation3D = {
                  15.83,
                  -180.2,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
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
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_8_dialog_content",
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
                  EntityID = 3,
                  Style = 0
                }
              }
            }
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 14,
                  Offset = {
                    0,
                    0.1,
                    -0.2
                  }
                },
                FaceSeq = 4,
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -112.8,
                  -4.5,
                  -11.7
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.45,
                  0.45,
                  0.45
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_11_dialog_content",
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
                Active = true,
                Look = 7,
                OpenPath = {
                  Duration = 10,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -109.09,
                  -4,
                  -9.71
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
              [1] = {PlayAnimator = "awkward", Time = 0.2},
              [2] = {PlayAnimator = "idle", Time = 2.2},
              [3] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 14
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_12_dialog_content",
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
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_17_dialog_content",
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
                  EntityID = 3,
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
            RefEntityID = 4
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_18_dialog_content",
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
                  ID = 11,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 4,
                Time = 0.6
              }
            },
            RefEntityID = 4
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
                Time = 0.6
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 17
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020402_19_dialog_content",
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
                PlayAnimator = "happy",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          }
        },
        [20] = {
          [1] = {
            Body = "base_icon_1300521_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020402_20_dialog_content",
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
            SpeakerNameStr = "ui_story_name_duofu"
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
        [21] = {
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
