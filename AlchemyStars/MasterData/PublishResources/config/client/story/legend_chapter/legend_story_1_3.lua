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
      Name = "戒卫座-待替换",
      Resource = "1701071_spine_idle.prefab",
      Type = "Spine"
    },
    [3] = {
      EntityID = 3,
      Name = "童谣座-待替换",
      Resource = "1701091_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      Name = "镇魂座-待替换",
      Resource = "1701101_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      Name = "焚霜座-待替换",
      Resource = "1701081_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 8,
      FitSize = true,
      Name = "北境背景",
      Resource = "StoryBGbingdong.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 9,
      Name = "红色遮罩",
      Resource = "RedPic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 10,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 11,
      Name = "祭剑座替代",
      Resource = "jijianzuo_n8_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 12,
      FitSize = false,
      Name = "童谣座切条",
      Resource = "1701091_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [12] = {
      EntityID = 13,
      Name = "对话Slice阴影-童谣座",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 14,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 15,
      FitSize = false,
      Name = "打字机1",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "打字机2",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "打字机3",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [17] = {
      EntityID = 18,
      FitSize = true,
      Name = "黑白特效",
      Resource = "UIeff_bahamosi_02.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 19,
      FitSize = false,
      Name = "黑烟火星特效",
      Resource = "uieff_heiyanhuoxing.prefab",
      Type = "Effect"
    },
    [19] = {
      EntityID = 20,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [20] = {
      EntityID = 21,
      FitSize = false,
      Name = "攻击音效",
      Resource = "10068",
      Type = "Sound"
    },
    [21] = {
      EntityID = 22,
      FitSize = false,
      Name = "神秘BGM2",
      Resource = "36",
      Type = "Sound"
    }
  },
  ID = 60000003,
  Name = "legend_story_1_3",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Time = 0
              },
              [2] = {Active = true, Time = 1.5}
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0
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
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 1,
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 1,
                StartBgm = 20,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiewei"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.3,
                  StartValue = 0
                },
                Layer = 30,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.3
                },
                Time = 0.1
              }
            },
            RefEntityID = 9
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
                Brightness = 1,
                Layer = 20,
                LoopAnimation = "Story_angry",
                Position = {0, -100},
                Scaling = {1.4, 1.4},
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
                  Duration = 0.1,
                  Strength = {20, 20},
                  Vibrato = 10,
                  fadeOut = false
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongyao"
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
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_norm",
                Position = {-600, 0},
                Scaling = {1.4, 1.4},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {-550, -250},
                Time = 0
              }
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                Position = {-600, 0},
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
            RefEntityID = 13
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiewei"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 30,
                Time = 0.2
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.3
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 20,
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.1,
                  Strength = {20, 20},
                  Vibrato = 10,
                  fadeOut = false
                },
                Time = 0.2
              }
            }
          },
          [5] = {
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
            RefEntityID = 12
          },
          [6] = {
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
            RefEntityID = 13
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 21
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zhenhun"
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -100},
                  StartValue = {0, -100}
                }
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
                Brightness = 1,
                Layer = 20,
                LoopAnimation = "Story_surprise",
                Position = {500, 0},
                Scaling = {1.6, 1.6},
                Time = 0.3
              }
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jiewei"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 20,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
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
            RefEntityID = 4
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zhenhun"
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
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 20,
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_fenshuang"
          },
          [2] = {
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
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 8,
                Time = 1
              }
            },
            RefEntityID = 3
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
                Brightness = 1,
                Layer = 20,
                LoopAnimation = "Story_think",
                Position = {-300, -150},
                Scaling = {1.25, 1.25},
                Time = 1
              }
            },
            RefEntityID = 5
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_tongyao"
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
                  StartValue = 0.2
                },
                Layer = 21,
                Position = {-500, -250},
                Scaling = {1.35, 1.35},
                Time = 1
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
                  EndValue = 0,
                  StartValue = 0
                },
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 8,
                Time = 1
              }
            },
            RefEntityID = 5
          },
          [4] = {
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
            RefEntityID = 14
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [10] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.5
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.6
              }
            },
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 1.5
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Time = 1.5
              }
            },
            RefEntityID = 19
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 1.5
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Languages = {
                  es = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  idn = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  jp = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  kr = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  pt = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  th = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  tw = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  us = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  },
                  zh = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_9_dialog_content",
                      Time = 0.1
                    }
                  }
                },
                Layer = 26,
                Time = 1.5
              },
              [2] = {Active = true, Time = 4.5}
            },
            RefEntityID = 15
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 29,
                Time = 1.5
              }
            },
            RefEntityID = 18
          },
          [7] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StartBgm = 22,
                Time = 1.5
              }
            }
          }
        },
        [11] = {
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
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.9}
            },
            RefEntityID = 15
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Languages = {
                  es = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  idn = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  jp = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  kr = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  pt = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  th = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  tw = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  us = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  },
                  zh = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_10_dialog_content",
                      Time = 0.1
                    }
                  }
                },
                Layer = 27,
                Time = 0.9
              },
              [2] = {Active = true, Time = 4}
            },
            RefEntityID = 16
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_60000003_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jijian"
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
                Layer = 28,
                Position = {-200, -300},
                Scaling = {1.3, 1.3},
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [3] = {
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
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.1
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.9}
            },
            RefEntityID = 16
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 0.9
              }
            },
            RefEntityID = 14
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.9}
            },
            RefEntityID = 19
          }
        },
        [13] = {
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
            RefEntityID = 6
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 25,
                Time = 1
              }
            },
            RefEntityID = 19
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 1
              }
            },
            RefEntityID = 14
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0
                },
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Languages = {
                  es = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  idn = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  jp = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  kr = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  pt = {
                    FontSize = 35,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  th = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  tw = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  us = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  },
                  zh = {
                    FontSize = 50,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_60000003_12_dialog_content",
                      Time = 0.1
                    }
                  }
                },
                Layer = 29,
                Time = 1
              },
              [2] = {Time = 4}
            },
            RefEntityID = 17
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
              [2] = {Active = true, Time = 2}
            },
            RefEntityID = 6
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
