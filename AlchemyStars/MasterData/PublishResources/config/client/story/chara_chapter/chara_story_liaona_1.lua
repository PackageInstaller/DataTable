return {
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
      Name = "莉奥娜立绘",
      Resource = "1500701_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "酒吧背景",
      Resource = "StoryBGjuxiangjiuba.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = true,
      Name = "主角房间背景",
      Resource = "StoryBGjuxiangroom2.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "萤盏立绘",
      Resource = "yingzhan_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "打字机 咕噜1",
      Resource = "StoryText.prefab",
      Type = "Text"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "打字机 咕噜2",
      Resource = "StoryText.prefab",
      Type = "Text"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "打字机 咕噜3",
      Resource = "StoryText.prefab",
      Type = "Text"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "小龙居里立绘切条",
      Resource = "bailong_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [12] = {
      EntityID = 12,
      Name = "对话Slice阴影-小龙居里",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = true,
      Name = "娱乐室替代背景",
      Resource = "StoryBGjuxiangyuleshi.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "桑冬替代立绘",
      Resource = "1500701_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "火打击特效",
      Resource = "uieff_spine_huodaji.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 16,
      Name = "红色遮罩",
      Resource = "RedPic.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "桑冬切条替代",
      Resource = "1500701_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [18] = {
      EntityID = 18,
      Name = "对话Slice阴影-桑冬",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "萤盏切条",
      Resource = "yingzhan_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [20] = {
      EntityID = 20,
      Name = "对话Slice阴影-萤盏",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "莉奥娜切条",
      Resource = "1500701_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [22] = {
      EntityID = 22,
      Name = "对话Slice阴影-莉奥娜",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [23] = {
      EntityID = 23,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
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
      Name = "诙谐BGM",
      Resource = "37",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "爆炸音效",
      Resource = "10049",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "敌人低吼",
      Resource = "10013",
      Type = "Sound"
    }
  },
  ID = 30700401,
  Name = "chara_story_liaona_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_1_dialog_content",
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
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 6,
                LoopAnimation = "Story_queen_confused",
                Position = {0, -300},
                Scaling = {1.2, 1.2},
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 24, Time = 1},
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
            DialogContentStr = "ui_story_30700401_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_3_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_5_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_6_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_8_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_confused",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_10_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_11_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                Active = true,
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Brightness = 0.5,
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.2
              }
            },
            RefEntityID = 7
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
                Layer = 21,
                Scale = {
                  Duration = 1,
                  EndValue = {0.5, 0.5},
                  StartValue = {0.4, 0.4}
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 27
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_12_dialog_content",
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
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 1,
                  EndValue = {50, 0},
                  StartValue = {-50, 0}
                }
              },
              [3] = {
                Active = true,
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  jp = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  es = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 24,
                R = 1,
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
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  jp = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  es = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 25,
                R = 1,
                Time = 0.4
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.9
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  jp = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  es = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {-250, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 26,
                R = 1,
                Time = 0.9
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.4
              }
            },
            RefEntityID = 10
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_13_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                Active = true,
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
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 5
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_15_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_17_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Position = {500, 0},
                Scaling = {0.8, 0.8},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -100},
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 9,
                Position = {500, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_confused",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0,
                TypeTimeList = {
                  0.02,
                  0.02,
                  0
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_confused",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X27_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
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
                Active = true,
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_28_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            Options = {
              [1] = {
                Affinity = 50,
                Content = "ui_story_30700401_30_option_content",
                NextParagraphID = 2,
                PetID = 1500701
              },
              [2] = {
                Affinity = 30,
                Content = "ui_story_30700401_34_option_content",
                NextParagraphID = 3,
                PetID = 1500701
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_confused",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_32_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_37_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          NextParagraphID = 4
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_42_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_43_dialog_content",
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
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_confused",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_47_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_51_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.1
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Scale = {
                  Duration = 2,
                  EndValue = {1.05, 1.05},
                  StartValue = {1, 1}
                },
                Time = 1
              }
            },
            RefEntityID = 13
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 1
              }
            }
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 1,
                StartBgm = 25,
                Time = 2.2
              }
            }
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_56_dialog_content",
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
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_57_dialog_content",
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
                Active = true,
                Layer = 5,
                Scale = {
                  Duration = 1,
                  EndValue = {1.1, 1.1},
                  StartValue = {1.05, 1.05}
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                LoopAnimation = "Story_dragon",
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sangdong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {1.1, 1.1}
                },
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                LoopAnimation = "Story_dragon_angry",
                Position = {250, -500},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1.2, 1.2},
                  StartValue = {0.8, 0.8}
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 28
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_59_dialog_content",
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
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 18,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.2
              }
            },
            RefEntityID = 16
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.1
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 26
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sangdong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {250, -450},
                  StartValue = {250, -500}
                }
              },
              [2] = {
                Active = true,
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {250, -500},
                  StartValue = {250, -450}
                }
              },
              [3] = {
                Active = true,
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {250, -450},
                  StartValue = {250, -500}
                }
              },
              [4] = {
                Active = true,
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {250, -500},
                  StartValue = {250, -450}
                }
              }
            },
            RefEntityID = 14
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_61_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
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
                Time = 0
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
                Scale = {
                  Duration = 0.5,
                  EndValue = {1.15, 1.15},
                  StartValue = {1.1, 1.1}
                },
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -280},
                  StartValue = {0, -300}
                }
              },
              [2] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {1.2, 1.2},
                  StartValue = {1.15, 1.15}
                },
                Time = 1.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -300},
                  StartValue = {0, -280}
                }
              }
            },
            RefEntityID = 3
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_63_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_65_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                LoopAnimation = "Story_dragon",
                SpineOffset = {0, -100},
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_serious",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, -300},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_dragon",
                Position = {400, 0},
                Scaling = {1.1, 1.1},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {250, -500},
                Time = 0
              }
            },
            RefEntityID = 17
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
                Layer = 19,
                Position = {400, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 18
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_68_dialog_content",
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0.2
              }
            },
            RefEntityID = 17
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0.2
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -300},
                  StartValue = {-200, -300}
                }
              }
            },
            RefEntityID = 3
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_72_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_74_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_75_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_serious",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_76_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
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
                Active = true,
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Brightness = 0.5,
                Layer = 10,
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.2
              }
            },
            RefEntityID = 7
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
                Layer = 21,
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  jp = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  es = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {200, 0},
                    TypeText = {
                      TextID = "ui_story_30700401_128_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 24,
                R = 1,
                Time = 0.3
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                B = 1,
                G = 1,
                Languages = {
                  jp = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  es = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {-200, -200},
                    TypeText = {
                      TextID = "ui_story_30700401_129_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 25,
                R = 1,
                Time = 1
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.5
              }
            },
            RefEntityID = 9
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                B = 1,
                G = 1,
                Languages = {
                  jp = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  es = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {-300, 100},
                    TypeText = {
                      TextID = "ui_story_30700401_130_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 26,
                R = 1,
                Time = 1.6
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2.2
              }
            },
            RefEntityID = 10
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0
                },
                Layer = 20,
                Position = {250, -450},
                Scale = {
                  Duration = 2,
                  EndValue = {1.2, 1.2},
                  StartValue = {0.8, 0.8}
                },
                Time = 2.4
              }
            },
            RefEntityID = 14
          },
          [10] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 27
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            Options = {
              [1] = {
                Affinity = 50,
                Content = "ui_story_30700401_78_option_content",
                NextParagraphID = 5,
                PetID = 1500701
              },
              [2] = {
                Affinity = 30,
                Content = "ui_story_30700401_84_option_content",
                NextParagraphID = 6,
                PetID = 1500701
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
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
                Active = true,
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 10,
                Time = 0.2
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 49,
                Time = 0.2
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 21,
                Time = 0.2
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0
                },
                Layer = 20,
                Position = {400, -700},
                Scale = {
                  Duration = 2,
                  EndValue = {1.2, 1.2},
                  StartValue = {1, 1}
                },
                Time = 0.2
              }
            },
            RefEntityID = 14
          }
        }
      }
    },
    [5] = {
      ID = 5,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_79_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X82_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_83_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0
              }
            },
            RefEntityID = 2
          },
          NextParagraphID = 7
        }
      }
    },
    [6] = {
      ID = 6,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_88_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          NextParagraphID = 7
        }
      }
    },
    [7] = {
      ID = 7,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_91_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_confused",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_95_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {10, 0},
                  Vibrato = 10
                },
                Time = 1
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_98_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 10
                },
                Time = 0
              }
            }
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_99_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 20
                },
                Time = 0
              }
            }
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Position = {-400, 0},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -200},
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                Position = {-400, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 22
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_101_dialog_content",
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
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = false,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 20
                },
                Time = 0
              }
            }
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sangdong"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 25,
                Scaling = {0.5, 0.5},
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {600, -150},
                  StartValue = {800, -150}
                }
              }
            },
            RefEntityID = 14
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_103_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 20
                },
                Time = 0
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sangdong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Scale = {
                  Duration = 1,
                  EndValue = {0.55, 0.55},
                  StartValue = {0.5, 0.5}
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {400, -150},
                  StartValue = {600, -150}
                }
              }
            },
            RefEntityID = 14
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_105_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = true,
                  Strength = {20, 0},
                  Vibrato = 20
                },
                Time = 0
              }
            }
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Scale = {
                  Duration = 1,
                  EndValue = {0.6, 0.6},
                  StartValue = {0.55, 0.55}
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {200, -150},
                  StartValue = {400, -150}
                }
              },
              [2] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 14
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_X107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Scale = {
                  Duration = 1,
                  EndValue = {1, 1},
                  StartValue = {0.6, 0.6}
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {200, -400},
                  StartValue = {200, -150}
                }
              },
              [2] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 1
              }
            }
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sangdong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_dragon_happy",
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 40
                },
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_109_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_110_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sangdong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_dragon_angry",
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_111_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sangdong"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_dragon_sad",
                Scale = {
                  Duration = 2,
                  EndValue = {0.7, 0.7},
                  StartValue = {1, 1}
                },
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {200, -150},
                  StartValue = {200, -400}
                }
              }
            },
            RefEntityID = 14
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_112_dialog_content",
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
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -150},
                  StartValue = {200, -150}
                }
              }
            },
            RefEntityID = 14
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 1
              }
            }
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_113_dialog_content",
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
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_114_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0.2,
                Time = 1
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.1
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 2.5
              }
            },
            RefEntityID = 2
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 30,
                Time = 1
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 48,
                Time = 1
              }
            },
            RefEntityID = 7
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
                Layer = 25,
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_115_dialog_content",
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 53,
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
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
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_116_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 21,
                Scale = {
                  Duration = 1,
                  EndValue = {0.3, 0.3},
                  StartValue = {0.25, 0.25}
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_117_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.35, 0.35},
                  StartValue = {0.3, 0.3}
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_118_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StartBgm = 24,
                Time = 0
              }
            }
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_119_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_120_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_121_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_122_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_123_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_124_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 0.8
                },
                Time = 0
              }
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_125_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_liaona"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                LoopAnimation = "Story_queen_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_126_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_30700401_127_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.95,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [39] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.95
                },
                Time = 0
              }
            }
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
                Time = 0
              },
              [2] = {Active = true, Time = 2}
            },
            RefEntityID = 2
          },
          [3] = {
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
