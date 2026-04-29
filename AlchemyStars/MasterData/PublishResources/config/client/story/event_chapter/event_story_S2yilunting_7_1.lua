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
      Name = "审判院外背景图",
      Resource = "StoryBGshenpanyuanwai.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "伊伦汀赛季皮肤",
      Resource = "yiluntingpifu_S2_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = true,
      Name = "小审判庭背景图",
      Resource = "StoryBGxiaoshenpanting.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      Name = "金身伊伦汀立绘",
      Resource = "jinyilunting_S2_spine_idle.prefab",
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
      Name = "普律玛替代立绘",
      Resource = "pulvma_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      Name = "伊伦汀赛季皮edge",
      Resource = "yiluntingpifu_S2_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [11] = {
      EntityID = 11,
      Name = "金色卫兵",
      Resource = "jinweibing_S2_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      Name = "白夜城BGM",
      Resource = "28",
      Type = "Sound"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "大脚步声1",
      Resource = "10058",
      Type = "Sound"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    }
  },
  ID = 50630701,
  Name = "event_story_S2yilunting_7_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 50,
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
            RefEntityID = 2
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 12, Time = 0.5},
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
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
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                LoopAnimation = "Story_sad",
                Scaling = {0.97, 0.97},
                Time = 0.5,
                Translate = {
                  Duration = 0.7,
                  EndValue = {0, -380},
                  StartValue = {-200, -380}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shenpanzhangdaren"
          },
          [2] = {
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
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 11,
                LoopAnimation = "Story_angry",
                Position = {-30, -320},
                Scaling = {1.25, 1.25},
                Time = 0.1
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Time = 0.1
              }
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Scaling = 0.9, Time = 0.1}
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          },
          [2] = {
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
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 18,
                Time = 0.1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 10,
                Time = 0.1
              }
            },
            RefEntityID = 5
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {Scaling = 1, Time = 0.1}
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 13
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.1, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_heiyinvren"
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
                Layer = 8,
                LoopAnimation = "Story_mock",
                Scaling = {1.05, 1.05},
                Time = 0.4,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -300},
                  StartValue = {-200, -300}
                }
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 1,
                  EndValue = 0.5,
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
            DialogContentStr = "ui_story_5063_50630701_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.3
              },
              [2] = {ShowContent = 0.02, Time = 0.5}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
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
                  EndValue = {200, -300},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                LoopAnimation = "Story_surprise",
                Scaling = {0.97, 0.97},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -380},
                Time = 0.2
              }
            },
            RefEntityID = 10
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_surprise",
                Shake = {
                  Duration = 0.2,
                  Strength = {20, 0},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jinseweibing"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {0, 10},
                  Vibrato = 20,
                  fadeOut = false
                },
                Time = 1.7
              }
            }
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
              [1] = {
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                LoopAnimation = "Story_serious",
                Time = 0.2
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.8,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-450, -380},
                  StartValue = {0, -380}
                }
              }
            },
            RefEntityID = 4
          },
          [5] = {
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
            RefEntityID = 10
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
                Time = 0.7,
                Translate = {
                  Duration = 0.5,
                  EndValue = {500, -350},
                  StartValue = {550, -400}
                }
              },
              [2] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {450, -400},
                  StartValue = {500, -350}
                }
              }
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.7}
            },
            RefEntityID = 14
          },
          [8] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 15, Time = 1.2}
            }
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
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
            RefEntityID = 11
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5063_50630701_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yilunting"
          }
        },
        [16] = {
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
