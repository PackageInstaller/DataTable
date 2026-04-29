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
      Name = "丘布长老",
      Resource = "1021001.prefab",
      SubType = "NPC",
      Type = "Model"
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
      Name = "轨道镜头1010",
      Resource = "vc_1010.prefab",
      SubType = 1,
      Type = "CameraVC"
    },
    [6] = {
      EntityID = 128,
      Name = "巴顿",
      PetID = 1500421,
      Resource = "1500421.prefab",
      SubType = "Pet",
      Type = "Model"
    },
    [7] = {
      EntityID = 129,
      Name = "固定机位1",
      Resource = "vc_0002.prefab",
      Type = "CameraVC"
    },
    [8] = {
      EntityID = 130,
      Name = "疑问bubble",
      Resource = "eff_jy_meme_yiwen.prefab",
      Type = "Model"
    }
  },
  ID = 90010402,
  Name = "home_story_N19chuanshanjia_4_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_1_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.1
              },
              [2] = {ShowContent = 0.02, Time = 2.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                Position3D = {
                  -113.4,
                  -3.5,
                  25.1
                },
                Rotation3D = {
                  -3.6,
                  19.13,
                  0
                },
                Time = 0
              },
              [2] = {
                OpenPath = {
                  Duration = 5,
                  Ease = 2,
                  Position = 0
                },
                Time = 0.5
              }
            },
            RefEntityID = 126
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                VC = {
                  Duration = 0,
                  EntityID = 126,
                  Style = 0
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -115.3,
                  -4.85,
                  21.1
                },
                Rotation3D = {
                  0,
                  68.1,
                  0
                },
                Time = 0
              },
              [2] = {
                Bubble = {
                  ID = 130,
                  Offset = {
                    0,
                    -0.9,
                    0
                  }
                },
                Time = 2.1
              }
            },
            RefEntityID = 124
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -113.81,
                  -4.9,
                  21.5
                },
                Rotation3D = {
                  0,
                  246.6,
                  0
                },
                Time = 0
              }
            },
            RefEntityID = 125
          },
          [7] = {
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
            RefEntityID = 130
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_2_dialog_content",
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
              [1] = {PlayAnimator = "sigh", Time = 0},
              [2] = {PlayAnimator = "idle", Time = 1.9}
            },
            RefEntityID = 125
          }
        },
        [3] = {
          [1] = {
            Body = "base_icon_1021001_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_3_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0},
              [2] = {PlayAnimation = "idle", Time = 1.6}
            },
            RefEntityID = 124
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 130
          }
        },
        [4] = {
          [1] = {
            Body = "base_icon_1021001_angry",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_4_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          }
        },
        [5] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_5_dialog_content",
            DialogDir = 1,
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                PlayAnimation = "walk",
                Rotation3D = {
                  0,
                  -95.3,
                  0
                },
                Time = 0,
                Translate3D = {
                  Duration = 3,
                  EndValue = {
                    -53.3,
                    0,
                    12
                  },
                  StartValue = {
                    -49.06,
                    0,
                    12
                  }
                }
              },
              [2] = {PlayAnimation = "stand", Time = 3}
            },
            RefEntityID = 128
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position3D = {
                  -57.3,
                  1.1,
                  12.9
                },
                Rotation3D = {
                  6.9,
                  -254.33,
                  0
                },
                Time = 0.2
              }
            },
            RefEntityID = 129
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.2,
                VC = {
                  Duration = 0,
                  EntityID = 129,
                  Style = 0
                }
              }
            }
          },
          [5] = {
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
            RefEntityID = 123
          }
        },
        [6] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_6_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_7_dialog_content",
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
        [8] = {
          [1] = {
            Body = "base_icon_1021001_norm",
            DialogContentStr = "str_homestory_N19chuanshanjia_90010402_8_dialog_content",
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
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          }
        },
        [9] = {
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
