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
      Name = "黎明学院背景图",
      Resource = "StoryBGlimingxueyuan.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "羽毛笔",
      Resource = "yumaobi.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      Name = "伊伦汀赛季皮肤",
      Resource = "yiluntingpifu_S2_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      Name = "伊伦汀赛季皮edge",
      Resource = "yiluntingpifu_S2_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "人群立绘1",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "人群立绘2",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "反色特效",
      Resource = "uieff_Story_AntiDeColor.prefab",
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
      Name = "白夜城BGM",
      Resource = "28",
      Type = "Sound"
    },
    [13] = {
      EntityID = 13,
      Name = "拨弄草丛",
      Resource = "10265",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 50630303,
  Name = "event_story_S2yilunting_3_3",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.2
              }
            },
            RefEntityID = 1
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
              [1] = {StartBgm = 12, Time = 0.5},
              [2] = {
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
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.2
              }
            },
            RefEntityID = 1
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
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_think",
                Position = {-450, 0},
                Scaling = {0.97, 0.97},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -380},
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, 0},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongxueA"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {-450, -200},
                Scaling = {0.7, 0.7},
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 4
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0,
                    EndValue = 1,
                    StartValue = 1,
                    Var = "_Decolor"
                  }
                },
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 14
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongxueB"
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
                Layer = 8,
                Position = {450, -200},
                Scaling = {0.7, 0.7},
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongxueB"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongxueA"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongxueA"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongxueB"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongxueA"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -150},
                  StartValue = {-450, -200}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -200},
                  StartValue = {-450, -150}
                }
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 19,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0,
                    EndValue = 1,
                    StartValue = 1,
                    Var = "_Decolor"
                  }
                },
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Position = {0, -380},
                Scaling = {0.97, 0.97},
                Time = 0.1
              }
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 8
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 14
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630303_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [15] = {
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
