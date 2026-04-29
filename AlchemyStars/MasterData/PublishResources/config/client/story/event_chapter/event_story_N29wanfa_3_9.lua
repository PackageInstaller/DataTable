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
      FitSize = false,
      Name = "小哈提",
      Resource = "n29_g_xiaohati_spine_idle.prefab",
      Type = "Spine"
    },
    [3] = {
      EntityID = 4,
      FitSize = false,
      Name = "凯尔卜",
      Resource = "n29_g_xiaoma_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 5,
      FitSize = false,
      Name = "手套",
      Resource = "N29shoutao.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 6,
      Name = "斧子",
      Resource = "N29fuzi.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 7,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 98,
      Name = "木偶戏BGM",
      Resource = "70",
      Type = "Sound"
    },
    [8] = {
      EntityID = 99,
      FitSize = false,
      Name = "丘布弹跳",
      Resource = "10260",
      Type = "Sound"
    },
    [9] = {
      EntityID = 100,
      FitSize = false,
      Name = "衣服摩擦的声音",
      Resource = "10057",
      Type = "Sound"
    },
    [10] = {
      EntityID = 101,
      FitSize = false,
      Name = "拔刀出鞘音效",
      Resource = "10191",
      Type = "Sound"
    }
  },
  ID = 50470309,
  Name = "event_story_N29wanfa_3_9",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
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
                Scaling = {0.9, 0.9},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-450, -130},
                  StartValue = {-600, -130}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
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
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 7,
                Scaling = {0.5, 0.5},
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {600, 10},
                  StartValue = {650, -40}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {550, -40},
                  StartValue = {600, 10}
                }
              },
              [3] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {500, 10},
                  StartValue = {550, -40}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -40},
                  StartValue = {500, 10}
                }
              },
              [5] = {
                LoopAnimation = "Story_pain",
                Shake = {
                  Duration = 0.3,
                  Strength = {20, 0},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 1.2
              },
              [6] = {
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {350, -40},
                  StartValue = {450, -40}
                }
              }
            },
            RefEntityID = 4
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
                Position = {-50, 0},
                Time = 0.3
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.5,
                    EndValue = 0.5,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 100
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {350, 10},
                  StartValue = {350, -40}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {350, -40},
                  StartValue = {350, 10}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 99
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hati"
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
            RefEntityID = 3
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
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.8
              },
              [2] = {ShowContent = 0.02, Time = 2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 1.8
              },
              [2] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-350, -130},
                  StartValue = {-450, -130}
                }
              },
              [3] = {
                LoopAnimation = "Story_pain",
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-450, -130},
                  StartValue = {-350, -130}
                }
              },
              [4] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 0},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 1.2
              }
            },
            RefEntityID = 3
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
              },
              [2] = {
                Time = 1.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, 10},
                  StartValue = {350, -40}
                }
              },
              [3] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -90},
                  StartValue = {400, 0.2}
                }
              },
              [4] = {
                Shake = {
                  Duration = 0.4,
                  Strength = {20, 0},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 1.4
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-25, 50},
                  StartValue = {-50, 0}
                }
              },
              [2] = {
                Time = 1.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {-25, 50}
                }
              }
            },
            RefEntityID = 6
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 20},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 1.3
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 100
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1}
            },
            RefEntityID = 101
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {450, -40},
                  StartValue = {450, -90}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hati"
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
            RefEntityID = 3
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
            RefEntityID = 4
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
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
            RefEntityID = 3
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hati"
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
            RefEntityID = 3
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
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
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
            RefEntityID = 3
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
                LoopAnimation = "Story_laugh",
                Time = 0
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, 10},
                  StartValue = {450, -40}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -40},
                  StartValue = {450, 10}
                }
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 99
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hati"
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
            RefEntityID = 3
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
            RefEntityID = 4
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
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
            RefEntityID = 3
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
                LoopAnimation = "Story_laugh",
                Time = 0
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, 10},
                  StartValue = {450, -40}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {450, -40},
                  StartValue = {450, 10}
                }
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 99
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 4
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kaierbo"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5047_50470309_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_hati"
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
            RefEntityID = 3
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
            RefEntityID = 4
          }
        },
        [19] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-650, -130},
                  StartValue = {-450, -130}
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
            RefEntityID = 3
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {650, -40},
                  StartValue = {450, -40}
                }
              },
              [2] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 6
          }
        }
      }
    }
  },
  StartParagraph = 1
}
