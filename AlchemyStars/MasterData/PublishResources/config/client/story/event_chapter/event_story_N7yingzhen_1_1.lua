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
      FitSize = true,
      Name = "舰桥背景图",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "萤盏立绘1",
      Resource = "yingzhan_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "普通信封替代",
      Resource = "Tongyongxinfeng.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "阿褐slice",
      Resource = "1400351_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "阿褐",
      Resource = "1400351_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      Name = "对话Slice阴影",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "速度线特效",
      Resource = "uieff_Story_SpeedLine.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "通用信纸1",
      Resource = "tongyongxinzhi.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "伊斯塔万立绘",
      Resource = "yixienaqi_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "通用信纸",
      Resource = "tongyongxinzhi.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 15,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 16,
      FitSize = true,
      Name = "空谷墓地背景",
      Resource = "StoryBGkongyimudi.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 17,
      FitSize = false,
      Name = "反色特效",
      Resource = "uieff_Story_AntiDeColor.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "打字机1",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "打字机2",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [20] = {
      EntityID = 20,
      FitSize = false,
      Name = "伊斯塔万",
      Resource = "yixienaqi_spine_idle.prefab",
      Type = "Spine"
    },
    [21] = {
      EntityID = 21,
      FitSize = false,
      Name = "影镇背景",
      Resource = "StoryBGyingzhenjiedao.prefab",
      Type = "Picture"
    },
    [22] = {
      EntityID = 22,
      FitSize = false,
      Name = "纳努塞尔切条",
      Resource = "nanusaier_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [23] = {
      EntityID = 23,
      FitSize = false,
      Name = "商会背景",
      Resource = "StoryBGshanghui.prefab",
      Type = "Picture"
    },
    [24] = {
      EntityID = 24,
      FitSize = false,
      Name = "拍卖会背景",
      Resource = "StoryBGpaimaihui.prefab",
      Type = "Picture"
    },
    [25] = {
      EntityID = 25,
      FitSize = true,
      Name = "影镇室内",
      Resource = "StoryBGyingzhenshinei.prefab",
      Type = "Picture"
    },
    [26] = {
      EntityID = 26,
      Name = "风船BGM",
      Resource = "26",
      Type = "Sound"
    },
    [27] = {
      EntityID = 27,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [28] = {
      EntityID = 28,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [29] = {
      EntityID = 29,
      FitSize = false,
      Name = "撕纸音效",
      Resource = "10129",
      Type = "Sound"
    },
    [30] = {
      EntityID = 30,
      FitSize = false,
      Name = "衣服摩擦的声音",
      Resource = "10057",
      Type = "Sound"
    }
  },
  ID = 50100101,
  Name = "event_story_N7yingzhen_1_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_1_dialog_content",
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
                Layer = 2,
                Scale = {
                  Duration = 2,
                  EndValue = {1.05, 1.05},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 16
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 26, Time = 0.6}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_2_dialog_content",
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
            DialogContentStr = "ui_story_5010_50100101_3_dialog_content",
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
                Layer = 18,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 1,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "_Decolor"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.3
              },
              [2] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.5
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
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 17
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_5_dialog_content",
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
            DialogContentStr = "ui_story_5010_50100101_6_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -50},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {10, 0},
                  Vibrato = 10,
                  fadeOut = true
                },
                Time = 0.7
              }
            }
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 27, Time = 1}
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 29
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 30
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_7_dialog_content",
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
                  Strength = {10, 0},
                  Vibrato = 10,
                  fadeOut = true
                },
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {10, 0},
                  Vibrato = 10,
                  fadeOut = true
                },
                Time = 0.3
              }
            }
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingzhan"
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
                Scaling = {0.5, 0.5},
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {-1000, 0},
                  StartValue = {1000, 0}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 28
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
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
                Scaling = {0.33, 0.33},
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {700, -200},
                  StartValue = {700, -250}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {700, -250},
                  StartValue = {700, -200}
                }
              },
              [3] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {700, -200},
                  StartValue = {700, -250}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {700, -250},
                  StartValue = {700, -200}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_10_dialog_content",
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
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -250},
                  StartValue = {700, -250}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -230},
                  StartValue = {0, -200}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -150},
                  StartValue = {0, -230}
                }
              },
              [4] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -250},
                  StartValue = {0, -150}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_14_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, -50}
                }
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_15_dialog_content",
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
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_21_dialog_content",
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
        [22] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
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
                Time = 0.6
              }
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Scaling = {0.45, 0.45},
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                Time = 0.5
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {-400, 140},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_22_dialog_content",
                      Time = 0.5
                    }
                  }
                },
                Layer = 22,
                OutLine = false,
                Time = 0.9
              }
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 0.5
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 1.5
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 0.5
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 0.5
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 0.5
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 10},
                    TypeText = {
                      TextID = "ui_story_5010_50100101_24_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 24,
                OutLine = false,
                Time = 2
              },
              [2] = {
                Active = true,
                OutLine = false,
                Time = 4.5
              }
            },
            RefEntityID = 19
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.7
              },
              [2] = {ShowContent = 0.02, Time = 1.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
                Time = 0
              },
              [2] = {
                Active = true,
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
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 19
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 13
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.5
              }
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
                  StartValue = 1
                },
                Layer = 25,
                Position = {0, -300},
                Scaling = {0.6, 0.6},
                Time = 0.5
              }
            },
            RefEntityID = 20
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.5
              }
            },
            RefEntityID = 21
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
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
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {500, 0},
                Scaling = {0.3, 0.3},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -200},
                Time = 0
              }
            },
            RefEntityID = 6
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
                Layer = 39,
                Position = {500, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
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
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {500, 0},
                Scaling = {0.3, 0.3},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -200},
                Time = 0
              }
            },
            RefEntityID = 6
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
                Layer = 39,
                Position = {500, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = {0, 1},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 20
          },
          [5] = {
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
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
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
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 20
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 15
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_34_dialog_content",
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
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
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
                  EndValue = 0.95,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_36_dialog_content",
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
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
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
                  StartValue = 0.95
                },
                Time = 0
              }
            }
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_38_dialog_content",
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
                Shake = {
                  Duration = 0.5,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
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
                Scaling = {0.33, 0.33},
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              },
              [3] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_42_dialog_content",
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
                Layer = 8,
                Scaling = {0.33, 0.33},
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
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
                Scaling = {0.33, 0.33},
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_45_dialog_content",
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
                Layer = 8,
                Scaling = {0.33, 0.33},
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              },
              [3] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [45] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.75,
                  StartValue = 0.75
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Position = {-300, -300},
                Time = 0.2
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 7,
                Position = {450, 0},
                Scaling = {1.05, 1.05},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {30, -400},
                Time = 1
              }
            },
            RefEntityID = 22
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
                Layer = 6,
                Position = {450, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Time = 1
              }
            },
            RefEntityID = 8
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nanusaier"
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.6
              },
              [2] = {ShowContent = 0.02, Time = 0.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 22
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Position = {0, -250},
                Time = 0.2
              }
            },
            RefEntityID = 7
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_54_dialog_content",
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
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              },
              [3] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 7
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_aho"
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_58_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -200},
                  StartValue = {0, -250}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -230},
                  StartValue = {0, -200}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -100},
                  StartValue = {0, -230}
                }
              },
              [4] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -170},
                  StartValue = {0, -100}
                }
              },
              [5] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-800, -170},
                  StartValue = {0, -170}
                }
              },
              [6] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.8
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1},
              [2] = {PlaySound = "Once", Time = 0.7}
            },
            RefEntityID = 28
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_59_dialog_content",
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
            DialogContentStr = "ui_story_5010_50100101_60_dialog_content",
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
                  EndValue = {-400, 0},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 3
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
                Layer = 7,
                Time = 0.1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {400, 0}
                }
              },
              [2] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, 0},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 23
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                Time = 0.7,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {400, 0}
                }
              }
            },
            RefEntityID = 24
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_61_dialog_content",
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
                Layer = 10,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, 0},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 24
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
                Layer = 15,
                Time = 0.1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {400, 0}
                }
              }
            },
            RefEntityID = 25
          }
        },
        [60] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_62_dialog_content",
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 15,
                Position = {400, 0},
                Time = 0.1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {400, 0}
                }
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 15,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, 0},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 25
          }
        },
        [61] = {
          [1] = {
            DialogContentStr = "ui_story_5010_50100101_63_dialog_content",
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
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [62] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
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
