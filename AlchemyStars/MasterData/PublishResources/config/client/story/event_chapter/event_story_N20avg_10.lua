return {
  ComponentID = "106310709",
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "UIN20AVGStoryDialog.prefab",
      Type = "AVGDialog"
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
      Name = "书馆走廊",
      Resource = "StoryBGshuguanzoulang.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "图书馆房间",
      Resource = "StoryBGshuguanfangjian.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "红油食谱正面",
      Resource = "hongyoushipuzheng.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "书-佣兵笔记",
      Resource = "yongbingbiji.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = true,
      Name = "安德森宅邸内景背景图",
      Resource = "StoryBGandesenzhaidi.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      Name = "赞恩",
      Resource = "guyongbing_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      Name = "菲雅",
      Resource = "feiya_n19_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 14,
      Name = "海螺单图",
      Resource = "Hailuo.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 15,
      FitSize = true,
      Name = "假日咖啡馆背景",
      Resource = "StoryJiari.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "杯子",
      Resource = "kafeibei.prefab",
      Type = "Picture"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "白夜城徽章替代",
      Resource = "Qishituanhuizhang.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 18,
      Name = "脚步声",
      Resource = "10083",
      Type = "Sound"
    },
    [18] = {
      EntityID = 19,
      FitSize = false,
      Name = "茶杯碰撞",
      Resource = "10167",
      Type = "Sound"
    },
    [19] = {
      EntityID = 20,
      FitSize = false,
      Name = "风船BGM",
      Resource = "27",
      Type = "Sound"
    },
    [20] = {
      EntityID = 22,
      FitSize = false,
      Name = "撕纸音效",
      Resource = "10160",
      Type = "Sound"
    }
  },
  ID = 50290010,
  Name = "event_story_N20avg_10",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
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
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 20,
                Time = 0.5
              }
            }
          },
          NextParagraphID = 19
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "去书房",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            Options = {
              [1] = {
                Content = "ui_story_5029_50290010_5_option_content",
                NextParagraphID = 3
              },
              [2] = {
                Content = "ui_story_5029_50290010_9_option_content",
                NextParagraphID = 4,
                StoryManual = {
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    InfluenceValue = {
                      -1,
                      0,
                      0,
                      0
                    }
                  }
                }
              },
              [3] = {
                Content = "ui_story_5029_50290010_15_option_content",
                NextParagraphID = 5
              },
              [4] = {
                Content = "ui_story_5029_50290010_18_option_content",
                NextParagraphID = 16,
                StoryManual = {
                  ManualSetting = {
                    ShowCondition = "1232,1063,09,98|1232,1063,09,99|1232,1063,09,100"
                  }
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 4
          },
          [3] = {
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.3
              }
            },
            RefEntityID = 2
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1.6,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.3,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              },
              [3] = {
                Time = 1.1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1},
              [2] = {PlaySound = "Once", Time = 1.9}
            },
            RefEntityID = 18
          }
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "去书房-第一排书架",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
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
                Layer = 10,
                Position = {0, 50},
                Scaling = {0.5, 0.5},
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_7_dialog_content",
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
            DialogContentStr = "ui_story_5029_50290010_8_dialog_content",
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
                Layer = 10,
                Position = {0, 50},
                Scaling = {0.5, 0.5},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          NextParagraphID = 2
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "去书房-书桌",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
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
                Layer = 10,
                Position = {0, 50},
                Scaling = {0.5, 0.5},
                Time = 0.4
              }
            },
            RefEntityID = 6
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.1
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 6
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 20},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0.1
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {StopSound = true, Time = 0.4}
            },
            RefEntityID = 22
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you",
            StorySection = {
              SectionSetting = {
                ValueChange = {
                  -2,
                  0,
                  0,
                  0
                }
              }
            }
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you",
            StorySection = {
              SectionSetting = {
                BE = "104",
                BECondition = "1230,1063,09,5,1"
              }
            }
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_14_dialog_content",
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
          NextParagraphID = 2
        }
      }
    },
    [5] = {
      ID = 5,
      Name = "去书房-矮柜",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
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
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_17_dialog_content",
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
          NextParagraphID = 2
        }
      }
    },
    [6] = {
      ID = 6,
      Name = "去大厅",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_21_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
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
                  Duration = 1.6,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.3,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              },
              [3] = {
                Time = 1.1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1},
              [2] = {PlaySound = "Once", Time = 1.9}
            },
            RefEntityID = 18
          },
          NextParagraphID = 17
        }
      }
    },
    [7] = {
      ID = 7,
      Name = "去大厅-花盆",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_24_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_25_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              }
            }
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen",
            StorySection = {
              SectionSetting = {
                ValueChange = {
                  -2,
                  0,
                  0,
                  0
                }
              }
            }
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
                LoopAnimation = "Story_surprise",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -300},
                  StartValue = {300, -300}
                }
              }
            },
            RefEntityID = 9
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you",
            StorySection = {
              SectionSetting = {
                BE = "105",
                BECondition = "1230,1063,09,5,1"
              }
            }
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 90,
                  Strength = {10, 10},
                  Vibrato = 2
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Layer = 18,
                Time = 0
              },
              [2] = {Active = true, Time = 2}
            },
            RefEntityID = 10
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
            RefEntityID = 9
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
            RefEntityID = 9
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_29_dialog_content",
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
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Layer = 18,
                Time = 0
              },
              [2] = {Active = true, Time = 2}
            },
            RefEntityID = 10
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 2, FadeOut = true},
                Time = 0
              }
            }
          },
          NextParagraphID = 17
        }
      }
    },
    [8] = {
      ID = 8,
      Name = "去大厅-沙发",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 4.2
              },
              [2] = {ShowContent = 0.02, Time = 4.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -50},
                  StartValue = {0, 0}
                }
              },
              [3] = {
                Time = 4.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -50}
                }
              }
            }
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
                Scaling = {0.6, 0.6},
                Time = 2.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-300, -200},
                  StartValue = {300, -200}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3.5
              }
            },
            RefEntityID = 12
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
                LoopAnimation = "Story_serious",
                Scaling = {0.42, 0.42},
                Time = 1.2,
                Translate = {
                  Duration = 1,
                  EndValue = {300, -400},
                  StartValue = {-300, -400}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 2
              }
            },
            RefEntityID = 11
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
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
                  Strength = {0, 20},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.5,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_33_dialog_content",
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
            DialogContentStr = "ui_story_5029_50290010_34_dialog_content",
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
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          NextParagraphID = 17
        }
      }
    },
    [9] = {
      ID = 9,
      Name = "去大厅-装饰物",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
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
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
                Layer = 10,
                Scaling = {0.5, 0.5},
                Time = 0.4
              }
            },
            RefEntityID = 14
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_37_dialog_content",
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
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
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
            RefEntityID = 14
          },
          NextParagraphID = 17
        }
      }
    },
    [10] = {
      ID = 10,
      Name = "去咖啡厅",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -300},
                  StartValue = {200, -300}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
                  Duration = 0.5,
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
                  Duration = 1.6,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.3,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              },
              [3] = {
                Time = 1.1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 25},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 0},
                  StartValue = {0, 25}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.3
              }
            },
            RefEntityID = 15
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
                Time = 2
              },
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 9
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1},
              [2] = {PlaySound = "Once", Time = 1.9}
            },
            RefEntityID = 18
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 9
          }
        },
        [4] = {
          [1] = {
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
                  Duration = 0.5,
                  EndValue = {200, -300},
                  StartValue = {0, -300}
                }
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
            RefEntityID = 9
          },
          NextParagraphID = 18
        }
      }
    },
    [11] = {
      ID = 11,
      Name = "去咖啡厅-咖啡杯",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
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
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
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
                Layer = 10,
                Scaling = {0.5, 0.5},
                Time = 0.4
              }
            },
            RefEntityID = 16
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_47_dialog_content",
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
            DialogContentStr = "ui_story_5029_50290010_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.1
              }
            },
            RefEntityID = 1
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
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 0.5
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_49_dialog_content",
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
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_50_dialog_content",
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 10,
                Scaling = {0.5, 0.5},
                Time = 0
              }
            },
            RefEntityID = 17
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_51_dialog_content",
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
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
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
            RefEntityID = 17
          },
          NextParagraphID = 18
        }
      }
    },
    [12] = {
      ID = 12,
      Name = "去咖啡厅-地板",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_53_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you",
            StorySection = {
              SectionSetting = {
                ValueChange = {
                  -2,
                  0,
                  0,
                  0
                }
              }
            }
          },
          [2] = {
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
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you",
            StorySection = {
              SectionSetting = {
                BE = "106",
                BECondition = "1230,1063,09,5,1"
              }
            }
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
                LoopAnimation = "Story_surprise",
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -300},
                  StartValue = {200, -300}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_57_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_59_dialog_content",
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
            RefEntityID = 9
          },
          NextParagraphID = 18
        },
        [8] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, -300},
                  StartValue = {0, -300}
                }
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
          }
        }
      }
    },
    [13] = {
      ID = 13,
      Name = "去咖啡厅-墙壁",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_61_dialog_content",
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.85,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_62_dialog_content",
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
                  EndValue = 0.9,
                  StartValue = 0.85
                },
                Time = 0
              }
            }
          },
          NextParagraphID = 18
        }
      }
    },
    [14] = {
      ID = 14,
      Name = "换个房间接着逛",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.7
              },
              [2] = {ShowContent = 0.02, Time = 0.9}
            },
            Options = {
              [1] = {
                Content = "ui_story_5029_50290010_3_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_5029_50290010_20_option_content",
                NextParagraphID = 6
              },
              [3] = {
                Content = "ui_story_5029_50290010_40_option_content",
                NextParagraphID = 10
              },
              [4] = {
                Content = "ui_story_5029_50290010_65_option_content",
                NextParagraphID = 15
              }
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.2
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                StopShake = {Duration = 0, FadeOut = false},
                Time = 0.2
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 5
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.2}
            },
            RefEntityID = 3
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 4
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 10
          },
          [10] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 15
          },
          [11] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 17
          },
          [12] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 14
          },
          [13] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          }
        }
      }
    },
    [15] = {
      ID = 15,
      Name = "不想逛了",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_66_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-25, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.3,
                  EndValue = {25, 0},
                  StartValue = {-25, 0}
                }
              },
              [3] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {25, 0}
                }
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_67_dialog_content",
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
            DialogContentStr = "ui_story_5029_50290010_68_dialog_content",
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
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 2.9}
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
    },
    [16] = {
      ComponentID = "0",
      ID = 16,
      Name = "好像都逛完了",
      Sections = {
        [1] = {
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
                Time = 0.8
              }
            },
            RefEntityID = 2
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 15
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.6}
            },
            RefEntityID = 3
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0.8
              }
            }
          },
          [7] = {
            DialogContentStr = "ui_story_5029_50290010_64_dialog_content",
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
          NextParagraphID = 19
        }
      }
    },
    [17] = {
      ComponentID = "0",
      ID = 17,
      Name = "去大厅车站小节",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_22_dialog_content",
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
                Content = "ui_story_5029_50290010_23_option_content",
                NextParagraphID = 7,
                StoryManual = {
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    InfluenceValue = {
                      -1,
                      0,
                      0,
                      0
                    }
                  }
                }
              },
              [2] = {
                Content = "ui_story_5029_50290010_30_option_content",
                NextParagraphID = 8
              },
              [3] = {
                Content = "ui_story_5029_50290010_35_option_content",
                NextParagraphID = 9
              },
              [4] = {
                Content = "ui_story_5029_50290010_38_option_content",
                NextParagraphID = 16,
                StoryManual = {
                  ManualSetting = {
                    ShowCondition = "1232,1063,09,106|1232,1063,09,107|1232,1063,09,108"
                  }
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        }
      }
    },
    [18] = {
      ComponentID = "0",
      ID = 18,
      Name = "去咖啡厅车站小节",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_44_dialog_content",
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
                Content = "ui_story_5029_50290010_45_option_content",
                NextParagraphID = 11
              },
              [2] = {
                Content = "ui_story_5029_50290010_52_option_content",
                NextParagraphID = 12,
                StoryManual = {
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    InfluenceValue = {
                      -1,
                      0,
                      0,
                      0
                    }
                  }
                }
              },
              [3] = {
                Content = "ui_story_5029_50290010_60_option_content",
                NextParagraphID = 13
              },
              [4] = {
                Content = "ui_story_5029_50290010_63_option_content",
                NextParagraphID = 16,
                StoryManual = {
                  ManualSetting = {
                    ShowCondition = "1232,1063,09,110|1232,1063,09,111|1232,1063,09,112"
                  }
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        }
      }
    },
    [19] = {
      ComponentID = "0",
      ID = 19,
      Name = "要去哪个房间看看呢",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290010_2_dialog_content",
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
                Content = "ui_story_5029_50290010_3_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_5029_50290010_20_option_content",
                NextParagraphID = 6
              },
              [3] = {
                Content = "ui_story_5029_50290010_40_option_content",
                NextParagraphID = 10
              },
              [4] = {
                Content = "ui_story_5029_50290010_65_option_content",
                NextParagraphID = 15,
                StoryManual = {
                  ManualSetting = {
                    ShowCondition = "1232,1063,09,114|1232,1063,09,115|1232,1063,09,116"
                  }
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        }
      }
    }
  },
  StartParagraph = 1
}
