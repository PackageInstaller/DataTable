return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 123,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 124,
      Name = "轨道镜头1009",
      Resource = "vc_1009.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [4] = {
      EntityID = 125,
      Name = "主角",
      Resource = "1000011.prefab",
      SubType = "Player",
      Type = "Model"
    },
    [5] = {
      EntityID = 126,
      Name = "阿吉",
      Resource = "1030004.prefab",
      SubType = "NPC",
      Type = "Model"
    },
    [6] = {
      EntityID = 127,
      Name = "关注点",
      Resource = "LookAtPoint.prefab",
      Type = "Model"
    },
    [7] = {
      EntityID = 128,
      Name = "雷文顿",
      PetID = 1601191,
      Resource = "1601191.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [8] = {
      EntityID = 129,
      Name = "固定机位1",
      Resource = "vc_0001.prefab",
      Type = "CameraVC"
    },
    [9] = {
      EntityID = 130,
      Name = "轨道镜头1010",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [10] = {
      EntityID = 131,
      Name = "固定机位2",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [11] = {
      EntityID = 132,
      Name = "固定机位3",
      Resource = "vc_0002.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [12] = {
      EntityID = 133,
      Name = "抖动机位",
      Resource = "vc_0003.prefab",
      SubType = 0,
      Type = "CameraVC"
    },
    [13] = {
      EntityID = 134,
      Name = "省略号bubble",
      Resource = "eff_jy_meme_duihua2.prefab",
      Type = "Model"
    },
    [14] = {
      EntityID = 135,
      Name = "生气bubble",
      Resource = "eff_jy_meme_shengqi.prefab",
      Type = "Model"
    }
  },
  ID = 90010202,
  Name = "home_story_N19chuanshanjia_2_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_1_dialog_content",
            DialogDir = 0,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.8
              },
              [2] = {ShowContent = 0.02, Time = 3}
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
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 5,
                PlayAnimator = "walk",
                Rotation3D = {
                  0,
                  -88.7,
                  0
                },
                Time = 0.5,
                Translate3D = {
                  Duration = 2,
                  EndValue = {
                    45,
                    0,
                    17.82
                  },
                  StartValue = {
                    47.5,
                    0,
                    17.82
                  }
                }
              },
              [2] = {PlayAnimator = "talk", Time = 2.6},
              [3] = {PlayAnimator = "idle", Time = 4.1}
            },
            RefEntityID = 125
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Look = 127,
                OpenPath = {
                  Duration = 3,
                  Ease = 2,
                  Position = 0
                },
                Position3D = {
                  47.9,
                  1.46,
                  19.98
                },
                Time = 0
              }
            },
            RefEntityID = 124
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 124,
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
                  44.08,
                  0.7,
                  17.82
                },
                Time = 0
              }
            },
            RefEntityID = 127
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  43.5,
                  0,
                  17.82
                },
                Rotation3D = {
                  0,
                  283.6,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 128
          }
        },
        [2] = {
          [1] = {
            Body = "base_icon_1601191_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_2_dialog_content",
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
            SpeakerNameStr = "ui_story_name_leiwendun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  41.7,
                  1,
                  18.9
                },
                Rotation3D = {
                  7.3,
                  117.8,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 129
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 129,
                  Style = 0
                }
              }
            }
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_3_dialog_content",
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
              [1] = {FaceSeq = 6, Time = 0}
            },
            RefEntityID = 125
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1601191_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_4_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leiwendun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    437,
                    0
                  },
                  StartValue = {
                    0,
                    269,
                    0
                  }
                },
                Time = 0.2
              },
              [2] = {PlayAnimation = "stand", Time = 0.7}
            },
            RefEntityID = 128
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                VC = {
                  Duration = 0,
                  EntityID = 124,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  46.73,
                  1.16,
                  18.5
                },
                Time = 0
              }
            },
            RefEntityID = 124
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  44.1,
                  0.6,
                  17.7
                },
                Time = 0
              }
            },
            RefEntityID = 127
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1030004_happy",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_5_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.8
              },
              [2] = {ShowContent = 0.02, Time = 3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
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
                Time = 0.8
              }
            },
            RefEntityID = 123
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Look = 127,
                Position3D = {
                  -3.9,
                  4.3,
                  23.89
                },
                Rotation3D = {
                  0,
                  198.4,
                  0
                },
                Time = 0.7
              },
              [2] = {
                OpenPath = {
                  Duration = 3,
                  Ease = 3,
                  Position = 0
                },
                Time = 0.8
              }
            },
            RefEntityID = 130
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.7,
                VC = {
                  Duration = 0,
                  EntityID = 130,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  5.7,
                  1.8,
                  30.8
                },
                Time = 0.7
              }
            },
            RefEntityID = 127
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FaceSeq = 2,
                PlayAnimation = "idle",
                Position3D = {
                  -1.42,
                  2.8,
                  27.11
                },
                Rotation3D = {
                  0,
                  151.4,
                  0
                },
                Time = 0.7
              }
            },
            RefEntityID = 126
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.2,
                  2.8,
                  26.52
                },
                Rotation3D = {
                  0,
                  -115.4,
                  0
                },
                Time = 0.7
              }
            },
            RefEntityID = 125
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -0.22,
                  2.8,
                  25.03
                },
                Rotation3D = {
                  0,
                  -34.1,
                  0
                },
                Time = 0.7
              }
            },
            RefEntityID = 128
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1601191_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_leiwendun"
          }
        },
        [7] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_7_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.17,
                  3.82,
                  25.14
                },
                Rotation3D = {
                  15.72,
                  -2.4,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 131
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 131,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {FaceSeq = 1, Time = 0}
            },
            RefEntityID = 126
          }
        },
        [8] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          }
        },
        [9] = {
          [1] = {
            Body = "base_icon_1030004_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_9_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          }
        },
        [10] = {
          [1] = {
            Body = "base_icon_1601191_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_10_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.3
              },
              [2] = {ShowContent = 0.02, Time = 3.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_leiwendun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -1.26,
                  3.55,
                  26.3
                },
                Rotation3D = {
                  0.8,
                  142,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 132
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 132,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 134,
                  Offset = {
                    0.2,
                    0,
                    0
                  }
                },
                FaceSeq = 2,
                Time = 1
              },
              [2] = {FaceSeq = 1, Time = 3}
            },
            RefEntityID = 128
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Scaling3D = {
                  0.5,
                  0.5,
                  0.5
                },
                Time = 1
              },
              [2] = {Active = false, Time = 3}
            },
            RefEntityID = 134
          }
        },
        [11] = {
          [1] = {
            Body = "base_icon_1030004_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_11_dialog_content",
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
            SpeakerNameStr = "ui_story_name_aji"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 133,
                  Style = 0
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  -1.17,
                  3.82,
                  25.14
                },
                Rotation3D = {
                  15.7,
                  -2.4,
                  0
                },
                Shake = {
                  Duration = 0.5,
                  Offset = {
                    2,
                    2,
                    2
                  },
                  Speed = 3,
                  Strength = 2
                },
                Time = 0
              }
            },
            RefEntityID = 133
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position3D = {
                  0.1,
                  2.8,
                  26.25
                },
                Rotation3D = {
                  0,
                  -77.1,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 125
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Bubble = {
                  ID = 135,
                  Offset = {
                    0,
                    0,
                    0
                  }
                },
                FaceSeq = 3,
                PlayAnimation = "angry",
                Time = 0
              },
              [2] = {PlayAnimation = "idle", Time = 1.6}
            },
            RefEntityID = 126
          },
          [6] = {
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
            RefEntityID = 135
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_12_dialog_content",
            DialogDir = 0,
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
                Position3D = {
                  -3.2,
                  3.7,
                  27.24
                },
                Rotation3D = {
                  7.61,
                  112.7,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 132
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 132,
                  Style = 0
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                FaceSeq = 7,
                PlayAnimator = "sigh",
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 125
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_13_dialog_content",
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
        [14] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_14_dialog_content",
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
              [1] = {
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    228.3,
                    0
                  },
                  StartValue = {
                    0,
                    282.9,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 0.5}
            },
            RefEntityID = 125
          }
        },
        [15] = {
          [1] = {
            Body = "base_icon_1601191_surprise",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_15_dialog_content",
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
            SpeakerNameStr = "ui_story_name_leiwendun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                PlayAnimation = "walk",
                Rotate3D = {
                  Duration = 0.5,
                  EndValue = {
                    0,
                    367.5,
                    0
                  },
                  StartValue = {
                    0,
                    325.9,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "stand", Time = 0.5}
            },
            RefEntityID = 128
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010202_16_dialog_content",
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
                FaceSeq = 7,
                PlayAnimator = "walk",
                Rotate3D = {
                  Duration = 0.3,
                  EndValue = {
                    0,
                    285.9,
                    0
                  },
                  StartValue = {
                    0,
                    228.3,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimator = "idle", Time = 2.2},
              [3] = {PlayAnimator = "talk", Time = 0.3}
            },
            RefEntityID = 125
          }
        },
        [17] = {
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
              [2] = {Active = true, Time = 2.5}
            },
            RefEntityID = 123
          }
        }
      }
    }
  },
  StartParagraph = 1
}
