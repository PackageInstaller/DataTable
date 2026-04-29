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
      Name = "菲雅",
      PetID = 1601661,
      Resource = "1601661.prefab",
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
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "闪白",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "闪白2",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "丘布转场",
      Resource = "Uieff_zhuanchang.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 15,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "诙谐BGM",
      Resource = "37",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "战斗",
      Resource = "9033",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "战斗2",
      Resource = "9000",
      Type = "Sound"
    }
  },
  ID = 90050205,
  Name = "home_story_N24diaoyu_2_5",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050205_1_dialog_content",
            DialogDir = 0,
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
              [2] = {
                FadeTime = 2,
                StartBgm = 16,
                Time = 0.5
              }
            }
          },
          [4] = {
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
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  260.1,
                  0
                },
                Time = 0.4,
                Translate3D = {
                  Duration = 1.5,
                  EndValue = {
                    -44.4,
                    -5,
                    -106.2
                  },
                  StartValue = {
                    -43.58,
                    -5,
                    -106.05
                  }
                }
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -42.7,
                  -4.3,
                  -104.9
                },
                Rotation3D = {
                  0,
                  -129,
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
                  Duration = 2,
                  EntityID = 6,
                  Style = 1
                }
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -42.9,
                  -4.3,
                  -104.7
                },
                Rotation3D = {
                  0,
                  -129,
                  0
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601661_shocked",
            DialogContentStr = "str_homestory_N24diaoyu_90050205_2_dialog_content",
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
            RefEntityID = 7
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1601661_shocked",
            DialogContentStr = "str_homestory_N24diaoyu_90050205_3_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050205_4_dialog_content",
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
                  -45.4,
                  -4.1,
                  -105.9
                },
                Rotation3D = {
                  0,
                  109.1,
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
              [1] = {
                FaceSeq = 7,
                PlayAnimator = "surprise",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050205_5_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
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
                  Duration = 0.2,
                  EntityID = 9,
                  Style = 1
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -45.1,
                  -4.1,
                  -106
                },
                Rotation3D = {
                  0,
                  109.1,
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
                Active = true,
                Blink = {
                  Duration = 0.2,
                  EndValue = 0.6,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {FaceSeq = 2, Time = 0.2}
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050205_6_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.6
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
                  EntityID = 6,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -42.9,
                  -4.3,
                  -104.7
                },
                Rotation3D = {
                  0,
                  -129,
                  0
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
                PlayAnimator = "talk",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.8}
            },
            RefEntityID = 4
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1601661_think",
            DialogContentStr = "str_homestory_N24diaoyu_90050205_7_dialog_content",
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
                FaceSeq = 2,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {
                FaceSeq = 1,
                PlayAnimation = "stand",
                Time = 1.8
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1601661_shocked",
            DialogContentStr = "str_homestory_N24diaoyu_90050205_8_dialog_content",
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
            RefEntityID = 7
          },
          [3] = {
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
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 4, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "str_homestory_N24diaoyu_90050205_9_dialog_content",
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
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601661_shocked",
            DialogContentStr = "str_homestory_N24diaoyu_90050205_10_dialog_content",
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
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1601661_think",
            DialogContentStr = "str_homestory_N24diaoyu_90050205_11_dialog_content",
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
              [1] = {FaceSeq = 2, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            Body = "base_icon_1601661_provocation",
            DialogContentStr = "str_homestory_N24diaoyu_90050205_12_dialog_content",
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
                Brightness = 0.7,
                Time = 0.5
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1
              },
              [4] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 53,
                Time = 1.6
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 70,
                Time = 1.8
              },
              [2] = {Active = true, Time = 4}
            },
            RefEntityID = 15
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 1.9
              }
            },
            RefEntityID = 13
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 1.9
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 17
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 18
          }
        }
      }
    }
  },
  StartParagraph = 1
}
