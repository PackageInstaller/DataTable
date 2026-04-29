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
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [4] = {
      EntityID = 4,
      Name = "菲雅",
      PetID = 1601661,
      Resource = "1601661.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [5] = {
      EntityID = 5,
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [6] = {
      EntityID = 6,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [7] = {
      EntityID = 7,
      Name = "固定机位3",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 8,
      Name = "固定机位4",
      Resource = "vc_0001.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 9,
      Name = "固定机位5",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 10,
      Name = "青瞳",
      PetID = 1601481,
      Resource = "1601481.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [11] = {
      EntityID = 11,
      Name = "弗劳尔",
      PetID = 1601161,
      Resource = "1601161.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [12] = {
      EntityID = 12,
      Name = "丘布长老",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [13] = {
      EntityID = 13,
      Name = "轨道相机1001",
      Resource = "vc_1027.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [14] = {
      EntityID = 14,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [15] = {
      EntityID = 15,
      Name = "固定机位6",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      Name = "惊奇bubble",
      Resource = "eff_jy_meme_jingqi.prefab",
      Type = "Model"
    },
    [18] = {
      EntityID = 18,
      Name = "害羞bubble",
      Resource = "eff_jy_meme_haixiu.prefab",
      Type = "Model"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "惊讶",
      Resource = "1714",
      Type = "Sound"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "气泡通用",
      Resource = "1712",
      Type = "Sound"
    }
  },
  ID = 90050206,
  Name = "home_story_N24diaoyu_2_6",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050206_1_dialog_content",
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
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 7,
                Position3D = {
                  -44.4,
                  -5,
                  -106.2
                },
                Rotation3D = {
                  0,
                  -90.49,
                  0
                },
                Time = 0.4
              },
              [2] = {PlayAnimator = "sigh", Time = 0.6},
              [3] = {PlayAnimator = "idle", Time = 2.5}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -45.4,
                  -5.12,
                  -106.24
                },
                Rotation3D = {
                  0,
                  90,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -45.4,
                  -4.1,
                  -105.9
                },
                Rotation3D = {
                  0,
                  109.1,
                  0
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.4,
                VC = {
                  Duration = 0,
                  EntityID = 5,
                  Style = 0
                }
              },
              [2] = {
                Time = 0.5,
                VC = {
                  Duration = 0.5,
                  EntityID = 6,
                  Style = 1
                }
              },
              [3] = {
                Time = 2.5,
                VC = {
                  Duration = 1,
                  EntityID = 5,
                  Style = 1
                }
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -45.4,
                  -4.18,
                  -105.9
                },
                Rotation3D = {
                  0,
                  109.1,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [9] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 16, Time = 0.4}
            }
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601661_shocked",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_2_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
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
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -42.7,
                  -4.3,
                  -104.9
                },
                Rotation3D = {
                  0,
                  -120.7,
                  0
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
                Bubble = {
                  ID = 17,
                  Offset = {
                    0,
                    0.15,
                    0
                  }
                },
                FaceSeq = 4,
                PlayAnimation = "surprise",
                Time = 0.1
              },
              [2] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 16
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Bubble = {
                  ID = 17,
                  Offset = {
                    0,
                    0.15,
                    0
                  }
                },
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 0
              },
              [2] = {Active = false, Time = 1.9}
            },
            RefEntityID = 17
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1601661_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -44.5,
                  -4.2,
                  -105.8
                },
                Rotation3D = {
                  10.1,
                  -115,
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
                  Duration = 0,
                  EntityID = 8,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          },
          NextParagraphID = 0
        },
        [4] = {
          [1] = {
            Body = "base_icon_1601661_happy",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 3, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1601661_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_5_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 4,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 1.9}
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050206_6_dialog_content",
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
                  -44.49,
                  -3.9,
                  -104.16
                },
                Rotation3D = {
                  11.27,
                  191.2,
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
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601661_awkward",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 18,
                  Offset = {
                    -0.15,
                    0.15,
                    0
                  }
                },
                FaceSeq = 3,
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
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 20
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601661_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1601661_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
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
                Look = 14,
                OpenPath = {
                  Duration = 1,
                  Ease = 1,
                  Position = 0
                },
                Position3D = {
                  -121.6,
                  3.5,
                  -41.7
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -149,
                  -3.9,
                  -81.29
                },
                Time = 0.2
              }
            },
            RefEntityID = 14
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
              [1] = {
                Active = true,
                Position3D = {
                  -144,
                  -3.9,
                  -76.7
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    241.7,
                    0
                  },
                  StartValue = {
                    0,
                    241.7,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -143.3,
                  -3.9,
                  -77.2
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    194.4,
                    0
                  },
                  StartValue = {
                    0,
                    194.4,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -144,
                  -3.9,
                  -76
                },
                Rotate3D = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    285.7,
                    0
                  },
                  StartValue = {
                    0,
                    285.7,
                    0
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 12
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601661_serious",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_10_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601661_norm",
            DialogContentStr = "str_homestory_N24diaoyu_90050206_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050206_12_dialog_content",
            DialogDir = 0,
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
                  -45.4,
                  -4.1,
                  -105.9
                },
                Rotation3D = {
                  0,
                  109.1,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 15
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 15,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 6, Time = 0.2}
            },
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            KeyFrames = {
              [1] = {
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
