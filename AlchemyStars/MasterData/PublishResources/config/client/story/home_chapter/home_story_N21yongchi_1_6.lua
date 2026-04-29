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
      Name = "卡莲",
      PetID = 1600061,
      Resource = "1600061.prefab",
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
      Name = "加载一个轨道相机1",
      Resource = "vc_1018.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "加载一个轨道相机2",
      Resource = "vc_1017.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 8,
      Name = "关注点2",
      Resource = "LookAtPoint2.prefab",
      Type = "Model"
    },
    [9] = {
      EntityID = 9,
      Name = "加载一个轨道相机3",
      Resource = "vc_1005.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "加载一个轨道相机5",
      Resource = "vc_1006.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "加载一个轨道相机6",
      Resource = "vc_1094.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 12,
      Name = "泳池",
      Resource = "5271001.prefab",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "加载一个轨道相机7",
      Resource = "vc_1006.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 14,
      Name = "轨道相机1008",
      Resource = "vc_1095.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "夏活BGM",
      Resource = "46",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "脚步声2",
      Resource = "10082",
      Type = "Sound"
    }
  },
  ID = 90020106,
  Name = "home_story_N21yongchi_1_6",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020106_1_dialog_content",
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 6,
                PlayAnimator = "move",
                Position3D = {
                  -6.8,
                  3,
                  19.3
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    47.9,
                    0
                  },
                  StartValue = {
                    0,
                    76,
                    0
                  }
                },
                Time = 0,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    -8.76,
                    3,
                    19.67
                  },
                  StartValue = {
                    -15,
                    3,
                    16
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 3}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Position3D = {
                  -6.3,
                  3,
                  20.7
                },
                Rotation3D = {
                  0,
                  -115,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -9,
                  3.6,
                  19.3
                },
                Time = 0
              }
            },
            RefEntityID = 5
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
              [1] = {
                Look = 5,
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  -7.1,
                  4.3,
                  21.3
                },
                Time = 0
              }
            },
            RefEntityID = 6
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
                StartBgm = 15,
                Time = 0.5
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1},
              [2] = {PlaySound = "Once", Time = 1.4},
              [3] = {PlaySound = "Once", Time = 1.8},
              [4] = {PlaySound = "Once", Time = 2.2},
              [5] = {PlaySound = "Once", Time = 2.6},
              [6] = {PlaySound = "Once", Time = 3}
            },
            RefEntityID = 16
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceTo = {Duration = 0.5, ID = 4},
                PlayAnimation = "walk",
                Time = 0,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -7.86,
                    3,
                    19.9
                  },
                  StartValue = {
                    -6.3,
                    3,
                    20.7
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 1.5}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -8.1,
                  3.6,
                  19
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
                  Duration = 1,
                  EntityID = 7,
                  Style = 1
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 8,
                Position3D = {
                  -6.7,
                  3.7,
                  21.1
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                FaceTo = {Duration = 0.5, ID = 3},
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.4},
              [2] = {PlaySound = "Once", Time = 1},
              [3] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 17
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_3_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020106_4_dialog_content",
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
            RefEntityID = 4
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {
                Look = 5,
                Position3D = {
                  -7.9,
                  3.9,
                  20.1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -8.5,
                  3.9,
                  19.67
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020106_5_dialog_content",
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
            Body = "base_icon_1600061_sigh",
            DialogContentStr = "str_homestory_N21yongchi_90020106_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 2,
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
                Position3D = {
                  -7.86,
                  3.7,
                  19.9
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
                  EntityID = 10,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Look = 8,
                Position3D = {
                  -9.6,
                  4,
                  20.3
                },
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1600061_norm",
            DialogContentStr = "str_homestory_N21yongchi_90020106_7_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 1,
                PlayAnimation = "stand",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_8_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 3,
                PlayAnimation = "happy",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2.5}
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020106_9_dialog_content",
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
                  EntityID = 9,
                  Style = 0
                }
              }
            }
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
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
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_11_dialog_content",
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
        [12] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_12_dialog_content",
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
        [13] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_13_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "stand", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020106_14_dialog_content",
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
                PlayAnimator = "think",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020106_15_dialog_content",
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
                FaceSeq = 1,
                PlayAnimator = "talk",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2}
            },
            RefEntityID = 4
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
                Look = 5,
                Position3D = {
                  -8,
                  3.9,
                  20.2
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -8.5,
                  3.9,
                  19.67
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N21yongchi_90020106_16_dialog_content",
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
            DialogContentStr = "str_homestory_N21yongchi_90020106_17_dialog_content",
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
            RefEntityID = 4
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1600061_happy",
            DialogContentStr = "str_homestory_N21yongchi_90020106_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_kalian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -7.86,
                  3.8,
                  19.9
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 8,
                Position3D = {
                  -9.3,
                  3.9,
                  17.5
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
                  Duration = 0.5,
                  EntityID = 14,
                  Style = 1
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0.1,
                Translate3D = {
                  Duration = 0.1,
                  EndValue = {
                    -8.99,
                    3,
                    19.7
                  },
                  StartValue = {
                    -8.8,
                    3,
                    19.7
                  }
                }
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 3
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
