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
      FitSize = false,
      Name = "残缺绘本",
      Resource = "huibencanque1.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "红油扳手营地背景",
      Resource = "StoryBGrediesel.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "空花盆",
      Resource = "kongpen.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "伊芙切条",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [8] = {
      EntityID = 8,
      Name = "黑幕2",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "to通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "翻书",
      Resource = "10146",
      Type = "Sound"
    }
  },
  ID = 50559902,
  Name = "event_story_CN2xinshengzhilu_99_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559902_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.3
              }
            },
            RefEntityID = 1
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
              [2] = {
                FadeTime = 2,
                StartBgm = 9,
                Time = 0.5
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 17,
                Time = 0.4
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 18,
                Position = {250, -210},
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.78, 0.78},
                  StartValue = {0.85, 0.85}
                },
                Time = 1.3
              }
            },
            RefEntityID = 6
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.3}
            },
            RefEntityID = 10
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559902_2_dialog_content",
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
                Active = true,
                Layer = 40,
                Position = {-500, 0},
                Scaling = {0.85, 0.85},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -270},
                Time = 0.8
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 25,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Position = {0, 200},
                Scaling = {1.2, 1.2},
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Position = {250, -20},
                Scaling = {1.1, 1.1},
                Time = 0.5,
                Translate = {
                  Duration = 1,
                  EndValue = {250, -20},
                  StartValue = {250, 0}
                }
              }
            },
            RefEntityID = 6
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559902_3_dialog_content",
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559902_4_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559902_5_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559902_6_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559902_7_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559902_8_dialog_content",
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
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559902_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
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
                Time = 0.3
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 17,
                Position = {0, 0},
                Scaling = {1, 1},
                Time = 0.2
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 18,
                Position = {250, -210},
                Scale = {
                  Duration = 0,
                  EndValue = {0.78, 0.78},
                  StartValue = {0.85, 0.85}
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559902_10_dialog_content",
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
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 1.5}
            },
            RefEntityID = 2
          }
        }
      }
    }
  },
  StartParagraph = 1
}
