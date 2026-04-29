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
      Name = "舰桥",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [4] = {
      Effect = "",
      EntityID = 4,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "白纸单图",
      Resource = "tongyongxinzhi.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "日常BGM",
      Resource = "38",
      Type = "Sound"
    },
    [7] = {
      EntityID = 7,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      Name = "临空者立绘",
      Resource = "bahamosi_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "落锤",
      Resource = "10061",
      Type = "Sound"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "限时委托书",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "近日",
      Resource = "StoryText.prefab",
      Type = "Text"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "请立刻",
      Resource = "StoryText.prefab",
      Type = "Text"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "委托人：匿名",
      Resource = "StoryText.prefab",
      Type = "Text"
    },
    [16] = {
      EntityID = 16,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 50010101,
  Name = "event_story_yifu_1_1_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1
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
              [2] = {StartBgm = 6, Time = 1}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_2_dialog_content",
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
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
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
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  Strength = {0, 60},
                  Vibrato = 80,
                  fadeOut = true
                },
                Time = 1.3
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1}
            },
            RefEntityID = 11
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_3_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_4_dialog_content",
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
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_norm",
                Scale = {
                  Duration = 1,
                  EndValue = {0.42, 0.42},
                  StartValue = {0.37, 0.37}
                },
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -350},
                  StartValue = {0, -400}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -400},
                  StartValue = {0, -350}
                }
              },
              [3] = {
                Time = 0.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -400},
                  StartValue = {0, -350}
                }
              },
              [4] = {
                Active = true,
                Time = 0.5,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -350},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_6_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_8_dialog_content",
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
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -350},
                  StartValue = {0, -400}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -400},
                  StartValue = {0, -350}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -400},
                  StartValue = {0, -350}
                }
              },
              [4] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -350},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_10_dialog_content",
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
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [13] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 1,
                Layer = 10,
                Scaling = {0.45, 0.45},
                Time = 0.3
              },
              [2] = {Active = true, Time = 1}
            },
            RefEntityID = 5
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.5,
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
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 4
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
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 9,
                Time = 0.2
              }
            },
            RefEntityID = 10
          }
        },
        [14] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 0,
                G = 0,
                Languages = {
                  es = {
                    FontSize = 45,
                    Position = {0, 209},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 45,
                    Position = {0, 209},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  jp = {
                    FontSize = 45,
                    Position = {0, 205},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 204},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 45,
                    Position = {0, 209},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 45,
                    Position = {0, 209},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 204},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 45,
                    Position = {0, 209},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 204},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_14_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 49,
                OutLine = false,
                R = 0,
                Time = 0.5
              },
              [2] = {
                Active = true,
                OutLine = false,
                Time = 3.5
              }
            },
            RefEntityID = 12
          }
        },
        [15] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 0,
                G = 0,
                Languages = {
                  es = {
                    FontSize = 38,
                    Position = {-625, 42},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 38,
                    Position = {-625, 42},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 45,
                    Position = {-575, 57},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 37,
                    Position = {-575, 42},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 38,
                    Position = {-625, 42},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 45,
                    Position = {-550, 57},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {-500, 52},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 38,
                    Position = {-625, 42},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {-500, 52},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_15_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                OutLine = false,
                R = 0,
                Time = 0
              },
              [2] = {
                Active = true,
                OutLine = false,
                Time = 3
              }
            },
            RefEntityID = 13
          }
        },
        [16] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 0,
                G = 0,
                Languages = {
                  es = {
                    FontSize = 38,
                    Position = {-625, -75},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 38,
                    Position = {-625, -75},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 45,
                    Position = {-575, -71},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 37,
                    Position = {-575, -11},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 38,
                    Position = {-625, -75},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 45,
                    Position = {-550, -71},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {-500, -11},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 38,
                    Position = {-625, -75},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {-500, -11},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_Z1_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                OutLine = false,
                R = 0,
                Time = 0
              },
              [2] = {
                Active = true,
                OutLine = false,
                Time = 3
              }
            },
            RefEntityID = 14
          }
        },
        [17] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 0,
                G = 0,
                Languages = {
                  es = {
                    FontSize = 35,
                    Position = {342, -141},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 35,
                    Position = {342, -141},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {342, -136},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 37,
                    Position = {342, -141},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 35,
                    Position = {342, -141},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {342, -136},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {342, -136},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 35,
                    Position = {342, -141},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {342, -136},
                    TypeText = {
                      TextID = "ui_story_5001_50010101_16_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                OutLine = false,
                R = 0,
                Time = 0
              },
              [2] = {
                Active = true,
                OutLine = false,
                Time = 2.5
              }
            },
            RefEntityID = 15
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                FullScreen = false,
                Time = 0.3
              }
            },
            RefEntityID = 5
          },
          [3] = {
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 12
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 14
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 15
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
          [9] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 9,
                Time = 0.3
              }
            },
            RefEntityID = 10
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 4
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_19_dialog_content",
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
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
            RefEntityID = 4
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_21_dialog_content",
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
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {80, 0},
                  Vibrato = 80,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_22_dialog_content",
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
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_23_dialog_content",
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
                Content = "ui_story_5001_50010101_24_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_5001_50010101_27_option_content",
                NextParagraphID = 3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
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
            DialogContentStr = "ui_story_5001_50010101_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_26_dialog_content",
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
            DialogContentStr = "ui_story_5001_50010101_30_dialog_content",
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
            DialogContentStr = "ui_story_5001_50010101_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bachmoth"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.1
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
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 15,
                Position = {0, 50},
                Scaling = {0.45, 0.45},
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 11,
                Time = 0.1
              }
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Brightness = 0.2, Time = 0}
            },
            RefEntityID = 4
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
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_30_dialog_content",
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
            DialogContentStr = "ui_story_5001_50010101_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_shocked",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_33_dialog_content",
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_36_dialog_content",
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
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                LoopAnimation = "Story_worried",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_norm",
                Scale = {
                  Duration = 0.2,
                  EndValue = {0.44, 0.44},
                  StartValue = {0.42, 0.42}
                },
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_43_dialog_content",
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
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.04, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Scale = {
                  Duration = 0.5,
                  EndValue = {0.5, 0.5},
                  StartValue = {0.44, 0.44}
                },
                Time = 0.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -450},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5001_50010101_45_dialog_content",
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
        [15] = {
          [1] = {
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
