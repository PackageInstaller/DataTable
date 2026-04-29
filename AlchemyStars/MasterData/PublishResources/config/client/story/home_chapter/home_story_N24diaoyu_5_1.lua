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
      Name = "阿克西娅",
      PetID = 1601751,
      Resource = "1601751.prefab",
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
      Name = "轨道镜头10",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [6] = {
      EntityID = 6,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 7,
      Name = "轨道相机1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
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
      Name = "抖动机位-小",
      Resource = "vc_0004.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 11,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
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
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      Name = "黑线bubble",
      Resource = "eff_jy_meme_heixian.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "失落",
      Resource = "1716",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    }
  },
  ID = 90050501,
  Name = "home_story_N24diaoyu_5_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_1_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              },
              [2] = {ShowContent = 0.02, Time = 1.9}
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
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 16, Time = 0.5}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                Position3D = {
                  0,
                  3,
                  29
                },
                Time = 0
              },
              [2] = {PlayAnimator = "think", Time = 0.5},
              [3] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 6,
                Position3D = {
                  0,
                  4,
                  32
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 3,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  0,
                  3.6,
                  29
                },
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 5,
                  Style = 0
                }
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_2_dialog_content",
            DialogDir = 0,
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
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_3_dialog_content",
            DialogDir = 0,
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
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_4_dialog_content",
            DialogDir = 0,
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
        [5] = {
          [1] = {
            Body = "base_icon_1601751_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_6_dialog_content",
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
                Bubble = {
                  ID = 11,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 4,
                Time = 0
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
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_7_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3
              },
              [2] = {ShowContent = 0.02, Time = 3.2}
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  1.2,
                  3,
                  35
                },
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 6,
                OpenPath = {
                  Duration = 10,
                  Ease = 3,
                  Position = 0
                },
                Position3D = {
                  0,
                  4,
                  30
                },
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.8,
                  3.5,
                  36.49
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 7,
                  Style = 0
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {
                PlayAnimator = "walk",
                Time = 0.2,
                Translate3D = {
                  Duration = 4,
                  EndValue = {
                    0,
                    3,
                    34.9
                  },
                  StartValue = {
                    -0.8,
                    3,
                    30.2
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 4.2},
              [3] = {
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    91.9,
                    0
                  },
                  StartValue = {
                    0,
                    0,
                    0
                  }
                },
                Time = 4
              }
            },
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601751_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    -90.71,
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
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.5,
                  4,
                  34.32
                },
                Rotation3D = {
                  7.6,
                  62,
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
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601751_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_10_dialog_content",
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
                  1.9,
                  4,
                  34.37
                },
                Rotation3D = {
                  8.9,
                  -66.49,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
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
        [11] = {
          [1] = {
            Body = "base_icon_1601751_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
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
              [1] = {FaceSeq = 5, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1601751_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_12_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          }
        },
        [13] = {
          [1] = {
            Body = "base_icon_1601751_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_13_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          }
        },
        [14] = {
          [1] = {
            Body = "base_icon_1601751_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_14_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_15_dialog_content",
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
              [1] = {FaceSeq = 5, Time = 0}
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
          }
        },
        [16] = {
          [1] = {
            Body = "base_icon_1601751_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_16_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
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
            Body = "base_icon_1601751_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_17_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          }
        },
        [18] = {
          [1] = {
            Body = "base_icon_1601751_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_18_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          }
        },
        [19] = {
          [1] = {
            Body = "base_icon_1601751_sad",
            DialogContentStr = "str_homestory_N24diaoyu_90050501_19_dialog_content",
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
            SpeakerNameStr = "ui_story_name_akexiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 14,
                  Offset = {
                    -0.3,
                    0.1,
                    0.1
                  }
                },
                PlayAnimation = "sad",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 2}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scaling3D = {
                  0.4,
                  0.4,
                  0.4
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 15
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_20_dialog_content",
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
                Position3D = {
                  1.9,
                  4,
                  34.37
                },
                Rotation3D = {
                  8.9,
                  -66.49,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  1.9,
                  4,
                  34.37
                },
                Rotation3D = {
                  8.9,
                  -66.49,
                  0
                },
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                VC = {
                  Duration = 0,
                  EntityID = 10,
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
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 12,
                  Offset = {
                    0,
                    0.1,
                    0
                  }
                },
                FaceSeq = 4,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [6] = {
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
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 14
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050501_21_dialog_content",
            DialogDir = 0,
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
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          }
        },
        [22] = {
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
