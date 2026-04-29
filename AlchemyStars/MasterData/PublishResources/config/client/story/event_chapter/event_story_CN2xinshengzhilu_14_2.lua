return {
  ComponentID = "0",
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "StoryDialog.prefab",
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
      FitSize = true,
      Name = "赤眼谷-火山爆发",
      Resource = "StoryBGchiyanguhuoshan.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "伊芙赛季皮肤",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "伊芙隔离仓CG",
      Resource = "CGYifugelicang.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "黑烟火星特效",
      Resource = "uieff_heiyanhuoxing.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      FitSize = true,
      Name = "启光地下城背景图-沦陷",
      Resource = "StoryBGenlightment2.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "德尼耶尔",
      Resource = "tunluoshiyan_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "热浪特效",
      Resource = "uieff_relang.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "后处理",
      Resource = "UIDistortion.asset",
      Type = "PostProcessing"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "flash1",
      Resource = "10018",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "黑烟火星",
      Resource = "uieff_heiyanhuoxing.prefab",
      Type = "Effect"
    }
  },
  ID = 50551402,
  Name = "event_story_CN2xinshengzhilu_14_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.02, Time = 1.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
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
              [2] = {StartBgm = 12, Time = 0.5}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_sad",
                Scaling = {0.85, 0.85},
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -270},
                  StartValue = {-300, -270}
                }
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 0.2,
                Layer = 4,
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 0},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 40,
                Time = 0.2
              }
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
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 41,
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
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
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 11,
                LoopAnimation = "Story_stare",
                Position = {0, -200},
                Scaling = {1, 1},
                Time = 0.2
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 10,
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 18,
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 6
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.3
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_angry",
                Time = 0.3
              }
            },
            RefEntityID = 4
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50551402_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          }
        },
        [16] = {
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
              [2] = {Active = true, Time = 2.8}
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
