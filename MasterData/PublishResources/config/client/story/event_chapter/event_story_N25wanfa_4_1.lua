return {
  ComponentID = "0",
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "UIN25IdolStoryDialog.prefab",
      Type = "IdolDialog"
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
      Name = "走廊",
      Resource = "StoryBGzoulang.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "工作人员A",
      Resource = "shexiang_n23_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      Name = "工作人员B",
      Resource = "juzurenyuana_n23_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "人群立绘",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "人群立绘2",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "歌尔蒂",
      Resource = "geerdi_n23_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "莉莉卡",
      Resource = "lilika_n23_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      FitSize = true,
      Name = "星愿事务所背景图",
      Resource = "StoryBGshiwusuo.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "黑场灰尘",
      Resource = "uieff_blacksmoke.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      Name = "考核演唱会打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [14] = {
      EntityID = 14,
      Name = "摄像机取景框",
      Resource = "n23_viewfinder2.prefab",
      Root = "Top",
      Type = "Sprite"
    },
    [15] = {
      EntityID = 15,
      Name = "黑幕-高层",
      Resource = "BlackPic.prefab",
      Root = "Top",
      Type = "Picture"
    },
    [16] = {
      Anchor = "RightUp",
      EntityID = 16,
      Name = "摄影机特效",
      Resource = "uieff_hongdian.prefab",
      Root = "Top",
      Type = "Effect"
    },
    [17] = {
      EntityID = 17,
      Name = "准备演唱会打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [18] = {
      EntityID = 18,
      Name = "制作人觉得打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [19] = {
      EntityID = 19,
      Name = "这次准备了打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [20] = {
      EntityID = 20,
      Name = "听说制作人打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [21] = {
      EntityID = 21,
      Name = "对这场演唱会打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "人群edge",
      Resource = "renqun_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [23] = {
      Anchor = "Up",
      EntityID = 23,
      Name = "计时器打字机",
      Resource = "StoryTextMiddle.prefab",
      Root = "Top",
      Type = "Text"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "人群嘈杂声",
      Resource = "10156",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "打字机音效",
      Resource = "10220",
      Type = "Sound"
    }
  },
  ID = 50370401,
  Name = "event_story_N25wanfa_4_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuana"
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
              [2] = {StartBgm = 24, Time = 0.5}
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
                Scaling = {0.95, 0.95},
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -400},
                  StartValue = {-150, -400}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_2_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuanb"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {250, -400},
                  StartValue = {50, -400}
                }
              }
            },
            RefEntityID = 4
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
                Scaling = {0.53, 0.53},
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -230},
                  StartValue = {-200, -230}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_4_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuanmen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -230},
                  StartValue = {0, -230}
                }
              }
            },
            RefEntityID = 5
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
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.6, 0.6},
                  StartValue = {0.55, 0.55}
                },
                Time = 0.4
              }
            },
            RefEntityID = 6
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuanmen"
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
            RefEntityID = 6
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
                Position = {450, -200},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.6, 0.6},
                  StartValue = {0.55, 0.55}
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuanmen"
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
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -150},
                  StartValue = {-450, -200}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -200},
                  StartValue = {-450, -150}
                }
              },
              [4] = {
                Time = 0.9,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -150},
                  StartValue = {-450, -200}
                }
              },
              [5] = {
                Time = 1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -200},
                  StartValue = {-450, -150}
                }
              }
            },
            RefEntityID = 6
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
                Position = {450, -200},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.6, 0.6},
                  StartValue = {0.55, 0.55}
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -150},
                  StartValue = {450, -200}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {450, -200},
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.6, 0.6},
                  StartValue = {0.55, 0.55}
                },
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -200},
                  StartValue = {450, -150}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -150},
                  StartValue = {450, -200}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -200},
                  StartValue = {450, -150}
                }
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_8_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 6
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
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_9_dialog_content",
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
            RefEntityID = 6
          },
          [4] = {
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
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
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
                Position = {0, -300},
                Scaling = {0.83, 0.83},
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_12_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_14_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_16_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
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
                LoopAnimation = "Story_angry",
                Position = {-450, -350},
                Scaling = {0.71, 0.71},
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -300},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 8
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_norm",
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
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
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
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
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_angry",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -300},
                  StartValue = {-450, -350}
                }
              },
              [2] = {
                LoopAnimation = "Story_angry",
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -350},
                  StartValue = {-450, -300}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
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
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
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
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_surprise",
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -300},
                  StartValue = {-450, -350}
                }
              },
              [2] = {
                LoopAnimation = "Story_angry",
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -350},
                  StartValue = {-450, -300}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 9
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_34_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.8}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.8
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.8},
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_cheerful",
                Position = {-50, -350},
                Time = 1.7
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.8}
            },
            RefEntityID = 8
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
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
                Time = 0
              }
            }
          }
        },
        [39] = {
          [1] = {
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
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Scaling = {1.2, 1.2},
                Time = 0.1
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_39_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.8
              },
              [2] = {Active = true, Time = 4.8}
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.8}
            },
            RefEntityID = 26
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullAnchor = true,
                Layer = 20,
                Time = 0.7
              }
            },
            RefEntityID = 14
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 9
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scaling = 0.8,
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 1
                },
                Time = 0.6
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_norm",
                Position = {0, -300},
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 16
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, -90},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                R = 1,
                ShowAsTimer = true,
                Time = 0.6
              }
            },
            RefEntityID = 23
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_44_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_45_dialog_content",
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
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [48] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Scaling = {1.2, 1.2},
                Time = 0.7
              }
            },
            RefEntityID = 11
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_48_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.7
              },
              [2] = {Active = true, Time = 5.7}
            },
            RefEntityID = 17
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.5
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 23
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 26
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullAnchor = true,
                Layer = 20,
                Time = 0.6
              }
            },
            RefEntityID = 14
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_laugh",
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 16
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 17
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 1
                },
                Time = 0.6
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 23
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 8
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [54] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Scaling = {1.2, 1.2},
                Time = 0.7
              }
            },
            RefEntityID = 11
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 16
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.5
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_54_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.7
              },
              [2] = {Active = true, Time = 5.7}
            },
            RefEntityID = 18
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 23
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 26
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullAnchor = true,
                Layer = 20,
                Time = 0.6
              }
            },
            RefEntityID = 14
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 8,
                LoopAnimation = "Story_norm",
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 16
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 17
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 1
                },
                Time = 0.6
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 18
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 23
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_56_dialog_content",
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
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_57_dialog_content",
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
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_58_dialog_content",
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
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_63_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_64_dialog_content",
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
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_65_dialog_content",
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
        [66] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Scaling = {1.2, 1.2},
                Time = 0.7
              }
            },
            RefEntityID = 11
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 16
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.5
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_66_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.7
              },
              [2] = {Active = true, Time = 5.7}
            },
            RefEntityID = 19
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 23
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 26
          }
        },
        [67] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullAnchor = true,
                Layer = 20,
                Time = 0.6
              }
            },
            RefEntityID = 14
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_laugh",
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 16
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 1
                },
                Time = 0.6
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 19
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 23
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_69_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_75_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [76] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_76_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [77] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_77_dialog_content",
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
        [78] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_78_dialog_content",
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
        [79] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [80] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [81] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [82] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [83] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [84] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [85] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_85_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [86] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_86_dialog_content",
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
        [87] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_87_dialog_content",
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
        [88] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Scaling = {1.2, 1.2},
                Time = 0.7
              }
            },
            RefEntityID = 11
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 16
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.5
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 28,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 28,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 28,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_88_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.7
              },
              [2] = {Active = true, Time = 5.7}
            },
            RefEntityID = 20
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 23
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 26
          }
        },
        [89] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullAnchor = true,
                Layer = 20,
                Time = 0.6
              }
            },
            RefEntityID = 14
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_surprise",
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 16
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 17
          },
          [8] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 1
                },
                Time = 0.6
              }
            }
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 20
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 23
          }
        },
        [90] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [91] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_91_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [92] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [93] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [94] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [95] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_95_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [96] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_96_dialog_content",
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
        [97] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_97_dialog_content",
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
        [98] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_98_dialog_content",
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
        [99] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_99_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_shy",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [100] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [101] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [102] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_102_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [103] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Scaling = {1.2, 1.2},
                Time = 0.7
              }
            },
            RefEntityID = 11
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.7}
            },
            RefEntityID = 16
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.5
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370401_103_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.7
              },
              [2] = {Active = true, Time = 5.7}
            },
            RefEntityID = 21
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 23
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 26
          }
        },
        [104] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullAnchor = true,
                Layer = 20,
                Time = 0.6
              }
            },
            RefEntityID = 14
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 15
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_norm",
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 16
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 1
                },
                Time = 0.6
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 21
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 23
          }
        },
        [105] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_105_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [106] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_106_dialog_content",
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
        [107] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [108] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_108_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [109] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [110] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi&PlayerName"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.75,
                  StartValue = 0.8
                },
                Time = 0
              }
            }
          }
        },
        [111] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuanmen"
          },
          [2] = {
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
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Position = {-450, 0},
                Scaling = {0.6, 0.6},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -200},
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.75
                },
                Time = 0
              }
            }
          }
        },
        [112] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuanmen"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              },
              [2] = {
                Position = {450, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0.2
              }
            },
            RefEntityID = 22
          }
        },
        [113] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_113_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_gongzuorenyuanmen"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          }
        },
        [114] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_114_dialog_content",
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 22
          }
        },
        [115] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_115_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [116] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_116_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [117] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370401_117_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          }
        },
        [118] = {
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
