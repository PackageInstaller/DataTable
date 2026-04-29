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
      Name = "星愿事务所背景图",
      Resource = "StoryBGshiwusuo.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "演唱会的主题打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "黑场灰尘",
      Resource = "uieff_blacksmoke.prefab",
      Type = "Effect"
    },
    [6] = {
      EntityID = 6,
      Name = "黑幕-高层",
      Resource = "BlackPic.prefab",
      Root = "Top",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "歌尔蒂替代",
      Resource = "geerdi_n23_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      Name = "摄像机取景框",
      Resource = "n23_viewfinder2.prefab",
      Root = "Top",
      Type = "Sprite"
    },
    [9] = {
      Anchor = "RightUp",
      EntityID = 9,
      Name = "摄像机特效",
      Resource = "uieff_hongdian.prefab",
      Root = "Top",
      Type = "Effect"
    },
    [10] = {
      Anchor = "Up",
      EntityID = 10,
      Name = "计时器打字机",
      Resource = "StoryTextMiddle.prefab",
      Root = "Top",
      Type = "Text"
    },
    [11] = {
      EntityID = 11,
      Name = "歌尔蒂有没有打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [12] = {
      EntityID = 12,
      Name = "制作人觉得打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [13] = {
      EntityID = 13,
      Name = "歌尔蒂有什么打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [14] = {
      EntityID = 14,
      Name = "制作人有什么打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "莉莉卡",
      Resource = "lilika_n23_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 16,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Root = "Top",
      Type = "Picture"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "人群立绘",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "人群立绘2",
      Resource = "renqun_spine_idle.prefab",
      Type = "Spine"
    },
    [19] = {
      EntityID = 19,
      FitSize = true,
      Name = "P5走廊背景-2",
      Resource = "StoryBGzoulang.prefab",
      Type = "Picture"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "北境NPC",
      Resource = "beijingcunmin_n9_spine_idle.prefab",
      Type = "Spine"
    },
    [21] = {
      EntityID = 21,
      Name = "红油帮众立绘",
      Resource = "hongyoushibing_spine_idle.prefab",
      Type = "Spine"
    },
    [22] = {
      EntityID = 22,
      Name = "N25暖场BGM",
      Resource = "84",
      Type = "Sound"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "打字机音效",
      Resource = "10220",
      Type = "Sound"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "抒情音乐",
      Resource = "27",
      Type = "Sound"
    },
    [25] = {
      EntityID = 25,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [26] = {
      EntityID = 26,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      Name = "人群隐约嘈杂",
      Resource = "10238",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "群体脚步声",
      Resource = "10074",
      Type = "Sound"
    }
  },
  ID = 50370601,
  Name = "event_story_N25wanfa_6_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lilika"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
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
              [2] = {StartBgm = 22, Time = 0.5}
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
            DialogContentStr = "ui_story_5037_50370601_2_dialog_content",
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
        [3] = {
          [1] = {
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
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 15,
                Scaling = {1.2, 1.2},
                Time = 0.2
              },
              [2] = {Active = true, Time = 5.1}
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
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
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_3_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.1
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1}
            },
            RefEntityID = 23
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_4_dialog_content",
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 8,
                Position = {0, -300},
                Scaling = {0.83, 0.83},
                Time = 0.6
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullAnchor = true,
                Layer = 20,
                Time = 0.6
              }
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 9
          },
          [8] = {
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
                Layer = 17,
                R = 1,
                ShowAsTimer = true,
                Time = 0.6
              }
            },
            RefEntityID = 10
          },
          [9] = {
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
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_5_dialog_content",
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
            RefEntityID = 7
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_6_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_7_dialog_content",
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
            RefEntityID = 7
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_8_dialog_content",
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
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_9_dialog_content",
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
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_10_dialog_content",
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
            RefEntityID = 7
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_11_dialog_content",
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
            RefEntityID = 7
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_12_dialog_content",
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
                LoopAnimation = "Story_tired",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.9
              },
              [2] = {ShowContent = 0.02, Time = 1.1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0.5}
            },
            RefEntityID = 7
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_14_dialog_content",
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
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_15_dialog_content",
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
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_16_dialog_content",
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
            RefEntityID = 7
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_17_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_18_dialog_content",
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
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_19_dialog_content",
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
                LoopAnimation = "Story_sad",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_20_dialog_content",
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
        [21] = {
          [1] = {
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6},
              [2] = {Active = true, Time = 5.5}
            },
            RefEntityID = 5
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
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_21_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.5
              }
            },
            RefEntityID = 11
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.6
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 23
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0.6}
            },
            RefEntityID = 7
          },
          [9] = {
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
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_23_dialog_content",
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
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_24_dialog_content",
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_25_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_26_dialog_content",
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
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_27_dialog_content",
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
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_28_dialog_content",
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
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_29_dialog_content",
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
            RefEntityID = 7
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_30_dialog_content",
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
            RefEntityID = 7
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_31_dialog_content",
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
        [32] = {
          [1] = {
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6},
              [2] = {Active = true, Time = 5.5}
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.6
              }
            }
          },
          [7] = {
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
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_32_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.5
              }
            },
            RefEntityID = 12
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 23
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_33_dialog_content",
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Brightness = 0.2,
                LoopAnimation = "Story_surprise",
                Time = 0.6
              }
            },
            RefEntityID = 7
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
            RefEntityID = 12
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_34_dialog_content",
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
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_35_dialog_content",
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
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_36_dialog_content",
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
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_37_dialog_content",
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
                LoopAnimation = "Story_sad",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_38_dialog_content",
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
            RefEntityID = 7
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_39_dialog_content",
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
        [40] = {
          [1] = {
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6},
              [2] = {Active = true, Time = 5.5}
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.6
              }
            }
          },
          [7] = {
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
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_40_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.5
              }
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 23
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_41_dialog_content",
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {Brightness = 0.2, Time = 0.6}
            },
            RefEntityID = 7
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
            RefEntityID = 13
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_42_dialog_content",
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
            RefEntityID = 7
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_43_dialog_content",
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
              [1] = {LoopAnimation = "Story_shy", Time = 0}
            },
            RefEntityID = 7
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_44_dialog_content",
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
            RefEntityID = 7
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_45_dialog_content",
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
            RefEntityID = 7
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_46_dialog_content",
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
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_47_dialog_content",
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
              [1] = {LoopAnimation = "Story_sad", Time = 0}
            },
            RefEntityID = 7
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_48_dialog_content",
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
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_49_dialog_content",
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
            RefEntityID = 7
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_50_dialog_content",
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
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_51_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_52_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_53_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_54_dialog_content",
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
            RefEntityID = 7
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_55_dialog_content",
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
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_56_dialog_content",
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
            RefEntityID = 7
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_57_dialog_content",
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
            RefEntityID = 7
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_58_dialog_content",
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
            RefEntityID = 7
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_59_dialog_content",
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
              [1] = {LoopAnimation = "Story_sad", Time = 0.3}
            },
            RefEntityID = 7
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_60_dialog_content",
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
              [1] = {LoopAnimation = "Story_cry", Time = 0}
            },
            RefEntityID = 7
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_61_dialog_content",
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
            RefEntityID = 7
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.8
              },
              [2] = {ShowContent = 0.02, Time = 1}
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
              },
              [2] = {
                LoopAnimation = "Story_embarrass",
                Time = 0.5
              }
            },
            RefEntityID = 7
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_63_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_64_dialog_content",
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
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_65_dialog_content",
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
        [66] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_66_dialog_content",
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
        [67] = {
          [1] = {
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6},
              [2] = {Active = true, Time = 5.5}
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.6
              }
            }
          },
          [7] = {
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
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5037_50370601_67_dialog_content",
                      Time = 2
                    }
                  }
                },
                Layer = 18,
                R = 1,
                Time = 1.5
              }
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.5}
            },
            RefEntityID = 23
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_68_dialog_content",
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
                Time = 0.7
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-75, -93},
                Time = 0.6
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Brightness = 0.2,
                LoopAnimation = "Story_shy",
                Time = 0.6
              }
            },
            RefEntityID = 7
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
            RefEntityID = 14
          }
        },
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_69_dialog_content",
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
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_70_dialog_content",
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
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_71_dialog_content",
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
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_72_dialog_content",
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
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_73_dialog_content",
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
            RefEntityID = 7
          }
        },
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_74_dialog_content",
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
              },
              [2] = {LoopAnimation = "Story_sad", Time = 0.4}
            },
            RefEntityID = 7
          }
        },
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_75_dialog_content",
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
        [76] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_76_dialog_content",
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
        [77] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_77_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_78_dialog_content",
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
                Scaling = {0.71, 0.71},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -350},
                  StartValue = {-650, -350}
                }
              }
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -300},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [79] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_79_dialog_content",
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
        [80] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.1, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_geerdi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 2
              }
            },
            RefEntityID = 7
          },
          [3] = {
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
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 16
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 10
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 1.5, FadeOut = true},
                Time = 0.1
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 2
              }
            },
            RefEntityID = 15
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 25
          },
          [10] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 24,
                Time = 0
              }
            }
          }
        },
        [81] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_81_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.1, Time = 0.2}
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
            RefEntityID = 7
          }
        },
        [82] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_82_dialog_content",
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
            RefEntityID = 15
          }
        },
        [83] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_83_dialog_content",
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
        [84] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_84_dialog_content",
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
        [85] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_85_dialog_content",
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
        [86] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_86_dialog_content",
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
            RefEntityID = 7
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
            RefEntityID = 15
          }
        },
        [87] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_87_dialog_content",
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
        [88] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_88_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_norm",
                Time = 0
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -300},
                  StartValue = {-450, -350}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -350},
                  StartValue = {-450, -300}
                }
              }
            },
            RefEntityID = 15
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
            RefEntityID = 7
          }
        },
        [89] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_89_dialog_content",
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
            RefEntityID = 7
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
            RefEntityID = 15
          }
        },
        [90] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_90_dialog_content",
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
            RefEntityID = 7
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {150, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {150, 0}
                }
              }
            }
          }
        },
        [91] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_91_dialog_content",
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
            RefEntityID = 7
          }
        },
        [92] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_92_dialog_content",
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
            RefEntityID = 15
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
            RefEntityID = 7
          }
        },
        [93] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_93_dialog_content",
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
            RefEntityID = 7
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
            RefEntityID = 15
          }
        },
        [94] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_94_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.5
              },
              [2] = {ShowContent = 0.02, Time = 2.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensia"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
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
                Time = 1.8
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 6,
                Position = {-450, -200},
                Scaling = {0.6, 0.6},
                Time = 1.3
              }
            },
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 7,
                Position = {450, -200},
                Scaling = {0.6, 0.6},
                Time = 1.3
              }
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 1.3
              }
            },
            RefEntityID = 19
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.3}
            },
            RefEntityID = 15
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.3}
            },
            RefEntityID = 7
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.3}
            },
            RefEntityID = 3
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -200},
                Scaling = {0.88, 0.88},
                Time = 2.5
              }
            },
            RefEntityID = 20
          },
          [10] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 26,
                Time = 0
              }
            }
          },
          [11] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2.1}
            },
            RefEntityID = 27
          }
        },
        [96] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_96_dialog_content",
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
            RefEntityID = 20
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 20},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0
              }
            }
          }
        },
        [97] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_97_dialog_content",
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
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_laugh",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -300},
                  StartValue = {600, -300}
                }
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -200},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 20
          }
        },
        [98] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensib"
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
                Scaling = {0.45, 0.45},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -350},
                  StartValue = {-600, -350}
                }
              }
            },
            RefEntityID = 21
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
            RefEntityID = 20
          },
          [4] = {
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
            RefEntityID = 7
          }
        },
        [99] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_99_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensia"
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
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -200},
                  StartValue = {-200, -200}
                }
              }
            },
            RefEntityID = 20
          }
        },
        [100] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensia"
          }
        },
        [101] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensib"
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -350},
                  StartValue = {-600, -350}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -300},
                  StartValue = {-400, -350}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -350},
                  StartValue = {-400, -300}
                }
              }
            },
            RefEntityID = 21
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
            RefEntityID = 20
          }
        },
        [102] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensic"
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
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -150},
                  StartValue = {-450, -200}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -200},
                  StartValue = {-450, -150}
                }
              }
            },
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -150},
                  StartValue = {450, -200}
                }
              },
              [2] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -200},
                  StartValue = {450, -150}
                }
              }
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [103] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensid"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -150},
                  StartValue = {-450, -200}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -200},
                  StartValue = {-450, -150}
                }
              }
            },
            RefEntityID = 17
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -150},
                  StartValue = {450, -200}
                }
              },
              [2] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -200},
                  StartValue = {450, -150}
                }
              }
            },
            RefEntityID = 18
          }
        },
        [104] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_104_dialog_content",
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
        [105] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_105_dialog_content",
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
        [106] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_106_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensia"
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
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 1,
                Layer = 8,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -200},
                  StartValue = {-200, -200}
                }
              }
            },
            RefEntityID = 20
          }
        },
        [108] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensib"
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -350},
                  StartValue = {-600, -350}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -300},
                  StartValue = {-400, -350}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-400, -350},
                  StartValue = {-400, -300}
                }
              }
            },
            RefEntityID = 21
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
            RefEntityID = 20
          }
        },
        [109] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fensimen"
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
                  EndValue = {-600, -350},
                  StartValue = {-400, -350}
                }
              }
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -150},
                  StartValue = {-450, -200}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-450, -200},
                  StartValue = {-450, -150}
                }
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-650, -200},
                  StartValue = {-450, -200}
                }
              }
            },
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -150},
                  StartValue = {450, -200}
                }
              },
              [2] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -200},
                  StartValue = {450, -150}
                }
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {250, -200},
                  StartValue = {450, -200}
                }
              }
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 28
          }
        },
        [110] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_110_dialog_content",
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
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [111] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_111_dialog_content",
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
        [112] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_112_dialog_content",
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
        [113] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_113_dialog_content",
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
        [114] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_114_dialog_content",
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
                LoopAnimation = "Story_sad",
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -300},
                  StartValue = {400, -300}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [115] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_115_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [116] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_116_dialog_content",
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
            DialogContentStr = "ui_story_5037_50370601_117_dialog_content",
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
            RefEntityID = 7
          }
        },
        [118] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_118_dialog_content",
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
        [119] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_119_dialog_content",
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
        [120] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_120_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [121] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_121_dialog_content",
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
            RefEntityID = 7
          }
        },
        [122] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_122_dialog_content",
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
        [123] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_123_dialog_content",
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
        [124] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_124_dialog_content",
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
        [125] = {
          [1] = {
            DialogContentStr = "ui_story_5037_50370601_125_dialog_content",
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
            RefEntityID = 7
          }
        },
        [126] = {
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
