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
      Name = "红油扳手营地",
      Resource = "StoryBGrediesel.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "伊芙赛季皮肤",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "Spine"
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
      Name = "吞罗碎片",
      Resource = "deniyeer.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "残缺绘本",
      Resource = "huibencanque1.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "伊芙赛季皮切条",
      Resource = "yifupifu_guofun2_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [9] = {
      EntityID = 9,
      Name = "黑幕2",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "通用",
      Resource = "17",
      Type = "Sound"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "翻书",
      Resource = "10146",
      Type = "Sound"
    }
  },
  ID = 50559901,
  Name = "event_story_CN2xinshengzhilu_99_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
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
              [2] = {
                FadeTime = 2,
                StartBgm = 10,
                Time = 0.5
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.4
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                LoopAnimation = "Story_think",
                Position = {0, -270},
                Scaling = {0.85, 0.85},
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_2_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
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
                Layer = 10,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.2,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 21,
                Position = {250, 200},
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.8, 0.8},
                  StartValue = {0.85, 0.85}
                },
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 11
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_3_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                LoopAnimation = "Story_think",
                Position = {-500, 0},
                Scaling = {0.85, 0.85},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -270},
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_5_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559901_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.8
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yifu"
          },
          [2] = {
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
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {-150, -280},
                Scaling = {1.2, 1.2},
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-120, -150},
                  StartValue = {-120, -100}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position = {200, 120},
                Scale = {
                  Duration = 0.5,
                  EndValue = {1.03, 1.03},
                  StartValue = {1, 1}
                },
                Scaling = {1, 1},
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, 120},
                  StartValue = {180, 120}
                }
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0.6}
            },
            RefEntityID = 8
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_7_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559901_8_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559901_9_dialog_content",
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
            RefEntityID = 8
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_10_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559901_11_dialog_content",
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
            DialogContentStr = "ui_story_5055_50559901_12_dialog_content",
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
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_13_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 25,
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
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 20,
                Position = {0, 0},
                Scaling = {1, 1},
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 21,
                Position = {250, 200},
                Scaling = {0.8, 0.8},
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_angry",
                Time = 0.2
              }
            },
            RefEntityID = 8
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_14_dialog_content",
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
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_15_dialog_content",
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
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_16_dialog_content",
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
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5055_50559901_17_dialog_content",
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
            RefEntityID = 8
          }
        },
        [18] = {
          [1] = {
            KeyFrames = {
              [1] = {
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
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
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
