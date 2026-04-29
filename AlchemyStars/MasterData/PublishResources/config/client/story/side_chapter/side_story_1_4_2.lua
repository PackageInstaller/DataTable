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
      EntityID = 6,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 41,
      Name = "涡轮立绘",
      Resource = "heichao_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 43,
      Name = "米迦勒立绘",
      Resource = "1600271_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 44,
      FitSize = true,
      Name = "高庭背景图",
      Resource = "StoryBGgaoting.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 45,
      Name = "约拿立绘",
      Resource = "1600601_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 46,
      Name = "拉斐尔立绘",
      Resource = "1600281_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 47,
      Name = "约拿Slice",
      Resource = "1600601_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [10] = {
      EntityID = 48,
      Name = "对话Slice阴影",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 49,
      Name = "跳崖CG",
      Resource = "JumpCG.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 50,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [13] = {
      EntityID = 51,
      Name = "离开 音效",
      Resource = "10076",
      Type = "Sound"
    },
    [14] = {
      EntityID = 52,
      Name = "下落音效",
      Resource = "10019",
      Type = "Sound"
    },
    [15] = {
      EntityID = 53,
      Name = "下落2音效",
      Resource = "10017",
      Type = "Sound"
    },
    [16] = {
      EntityID = 54,
      Name = "风声音效",
      Resource = "10042",
      Type = "Sound"
    }
  },
  ID = 20010402,
  Name = "side_story_1_4_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "第二关战前第一段",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {ShowContent = 0.02, Time = 1.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.5
              },
              [2] = {
                Active = true,
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 44
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_happy",
                Position = {400, -150},
                Scaling = {0.65, 0.65},
                Time = 1.3
              }
            },
            RefEntityID = 45
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 50, Time = 0.8},
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_36_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
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
                Layer = 9,
                LoopAnimation = "Story_helpless",
                Position = {-500, -300},
                Scaling = {0.7, 0.7},
                Time = 0
              }
            },
            RefEntityID = 41
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 45
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_38_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_surprise",
                Time = 1
              }
            },
            RefEntityID = 41
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_39_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.04, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 41
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 45
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 11,
                LoopAnimation = "Story_surprise",
                Position = {-300, -200},
                Scaling = {0.45, 0.45},
                Time = 1
              }
            },
            RefEntityID = 46
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                Position = {300, -100},
                Scaling = {0.9, 0.9},
                Time = 1
              }
            },
            RefEntityID = 43
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mijiale"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.6,
                  StartValue = 1
                },
                Layer = 9,
                Time = 0
              }
            },
            RefEntityID = 46
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lafeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.6
                },
                Layer = 11,
                Time = 0
              }
            },
            RefEntityID = 46
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.6,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 43
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_sigh",
                Position = {0, 0},
                Scaling = {0.6, 0.6},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {70, -200},
                Time = 0
              }
            },
            RefEntityID = 47
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
                Layer = 19,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 48
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.6,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 46
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_43_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 1.3},
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
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
                Layer = 50,
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 48
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 47
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 46
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 43
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 9,
                Time = 0.6
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 1.1
              }
            },
            RefEntityID = 45
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0.6
              }
            },
            RefEntityID = 41
          },
          [9] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scaling = 1,
                Time = 0.6
              }
            }
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 10,
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 41
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 45
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_45_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 41
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 45
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_47_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_48_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_49_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.04,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
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
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.04, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                FullScreen = true,
                Layer = 40,
                Time = 0
              }
            },
            RefEntityID = 49
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.3
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 51,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 3,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.4
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 51
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_51_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_52_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yuena"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 54
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_55_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_wolun"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_2001_4_56_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.04, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 51,
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [23] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 55,
                Time = 0
              },
              [2] = {Layer = 54, Time = 2}
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
