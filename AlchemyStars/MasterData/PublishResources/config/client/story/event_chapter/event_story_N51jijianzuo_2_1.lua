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
      EntityID = 3,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 4,
      FitSize = true,
      Name = "巨像舰桥背景",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 5,
      FitSize = false,
      Name = "defaultBGM",
      Resource = "17",
      Type = "Sound"
    },
    [5] = {
      EntityID = 6,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [6] = {
      EntityID = 7,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 8,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 9,
      FitSize = false,
      Name = "第五日打字机",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [9] = {
      EntityID = 10,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [10] = {
      EntityID = 11,
      FitSize = false,
      Name = "新BGM",
      Resource = "510",
      Type = "Sound"
    },
    [11] = {
      EntityID = 12,
      FitSize = true,
      Name = "白夜要塞街道",
      Resource = "StoryBGbaiyeyaosai.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 13,
      Name = "祭剑座-待替换",
      Resource = "jijianzuo_n8_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [13] = {
      EntityID = 14,
      FitSize = false,
      Name = "罗马士兵",
      Resource = "luomashibing_S5_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [14] = {
      EntityID = 15,
      FitSize = false,
      Name = "斩击特效",
      Resource = "uieff_spine_lirendaji.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 16,
      Name = "暗鬼呼吸",
      Resource = "10013",
      Type = "Sound"
    },
    [16] = {
      EntityID = 17,
      Name = "消散特效-消失",
      Resource = "uieff_spine_mendelssohn_dissolve.prefab",
      Type = "Effect"
    },
    [17] = {
      EntityID = 18,
      FitSize = false,
      Name = "斩击",
      Resource = "10072",
      Type = "Sound"
    },
    [18] = {
      EntityID = 19,
      FitSize = false,
      Name = "阿伽门农替代",
      Resource = "ajiamennong_n51_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [19] = {
      EntityID = 20,
      FitSize = false,
      Name = "速度线特效",
      Resource = "uieff_Story_SpeedLine.prefab",
      Type = "Effect"
    }
  },
  ID = 50880201,
  Name = "event_story_N51jijianzuo_2_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
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
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StopBgm = true, Time = 0},
              [2] = {
                FadeTime = 1,
                StartBgm = 5,
                Time = 0.5
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
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_2_dialog_content",
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
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "ui_story_5088_50880201_4_option_content",
                NextParagraphID = 2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        }
      }
    },
    [2] = {
      ComponentID = "0",
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 6
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
                Time = 0.3
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.5
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 1.5
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
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50880201_5_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 25,
                R = 1,
                Time = 2.3
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 10
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0.3
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 11,
                Time = 1.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.7
              },
              [2] = {ShowContent = 0.02, Time = 2.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 1
              }
            },
            RefEntityID = 12
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {-200, -300},
                Scaling = {1.3, 1.3},
                Time = 2.3
              }
            },
            RefEntityID = 13
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shibing1"
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
                Position = {-50, -250},
                Scaling = {0.9, 0.9},
                Time = 0.3
              },
              [2] = {
                Shake = {
                  Duration = 1,
                  Strength = {40, 0},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0.7
              }
            },
            RefEntityID = 14
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
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 18,
                Time = 0.7
              }
            },
            RefEntityID = 15
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 2}
            },
            RefEntityID = 16
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 18
          }
        },
        [4] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 17
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 14
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0,
                Layer = 20,
                Position = {400, 0},
                Scaling = {0.95, 0.95},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {50, -400},
                Time = 0
              }
            },
            RefEntityID = 19
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
            RefEntityID = 13
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
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
            RefEntityID = 19
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0.2
              }
            },
            RefEntityID = 13
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
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
                Shake = {
                  Duration = 1,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                EffectFullScreen = true,
                Layer = 18,
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50880201_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
          }
        },
        [14] = {
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
              [2] = {Time = 2.5}
            },
            RefEntityID = 3
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
