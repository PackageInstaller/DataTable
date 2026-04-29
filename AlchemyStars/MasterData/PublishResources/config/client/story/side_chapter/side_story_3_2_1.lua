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
      Name = "白夜下城背景",
      Resource = "StoryBGyingzhenjiedao.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      Name = "涉替代",
      Resource = "she_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      Name = "烈雀立绘",
      Resource = "1400481_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      Name = "知更替代",
      Resource = "1500781_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      Name = "神秘人替代",
      Resource = "heitipro_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      Effect = "",
      EntityID = 8,
      Name = "烈雀切条",
      Resource = "1400481_spine_idle.prefab",
      Type = "SpineSlice"
    },
    [9] = {
      EntityID = 9,
      Name = "对话Slice阴影-斯叶特",
      Resource = "StorySliceEdge.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 11,
      Name = "日蚀 立绘",
      Resource = "rishixiaobing_spine_idle.prefab",
      Type = "Spine"
    },
    [12] = {
      EntityID = 12,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [13] = {
      EntityID = 13,
      Name = "暗鬼叫声",
      Resource = "10013",
      Type = "Sound"
    },
    [14] = {
      EntityID = 14,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "flash3",
      Resource = "10020",
      Type = "Sound"
    }
  },
  ID = 20030201,
  Name = "side_story_3_2_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.4
              },
              [2] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1.6
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_Sheol"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              },
              [2] = {
                Active = true,
                Layer = 99,
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
                  StartValue = 0.8
                },
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.5,
                  StartValue = 0.5
                },
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 53,
                LoopAnimation = "Story_serious",
                Position = {0, -600},
                Scaling = {1.1, 1.1},
                Time = 0.4
              }
            },
            RefEntityID = 4
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 12, Time = 1},
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 98,
                Time = 0.3
              }
            },
            RefEntityID = 14
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_Sheol"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {
                ContentBGVisible = true,
                ShowContent = 0.04,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
                Layer = 99,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 0,
                Time = 0.3
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 14
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Layer = 50,
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
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 54,
                LoopAnimation = "Story_anger",
                Position = {-400, -300},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StartShake = {
                  Duration = 5,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 45,
                  Strength = {20, 20},
                  Vibrato = 3
                },
                Time = 0
              }
            }
          },
          [5] = {
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
            RefEntityID = 2
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_robine"
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
                Layer = 55,
                Position = {0, -220},
                Scaling = {0.9, 0.9},
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.7,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7,
                Translate = {
                  Duration = 0.7,
                  EndValue = {1500, -220},
                  StartValue = {0, -220}
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
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 54,
                Time = 1,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-1200, -300},
                  StartValue = {-400, -300}
                }
              }
            },
            RefEntityID = 5
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0.5, FadeOut = true},
                Time = 1.3
              }
            }
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2.5
              },
              [2] = {ShowContent = 0.02, Time = 2.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 60,
                Scaling = {0.9, 0.9},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-2000, -200},
                  StartValue = {2000, -200}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 60,
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {2000, -200},
                  StartValue = {-1500, -200}
                }
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 70,
                Position = {0, -200},
                Time = 2
              },
              [4] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 60,
                Time = 2.5
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 80,
                LoopAnimation = "Story_surprise",
                Position = {-300, 0},
                Scaling = {1.5, 1.5},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -600},
                Time = 2.5
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 70,
                Position = {-300, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = {1, 1},
                  StartValue = {0, 1}
                },
                Scaling = {1, 1},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 2.5
              }
            },
            RefEntityID = 9
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
          },
          [2] = {
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
                  EndValue = 0.5,
                  StartValue = 0.2
                },
                Layer = 60,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 60,
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {2000, -200},
                  StartValue = {0, -200}
                }
              }
            },
            RefEntityID = 7
          },
          [3] = {
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
            RefEntityID = 8
          },
          [4] = {
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
            RefEntityID = 9
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
                Layer = 70,
                Time = 0.1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-300, -300},
                  StartValue = {-2000, -300}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 60,
                Time = 1.4,
                Translate = {
                  Duration = 0.4,
                  EndValue = {2000, -300},
                  StartValue = {-300, -300}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
                Layer = 57,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 57,
                Time = 0.3
              }
            },
            RefEntityID = 10
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
                Layer = 60,
                Position = {-300, -300},
                Time = 0.7
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 15
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_robine"
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
                Layer = 70,
                Time = 0.3,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-300, -220},
                  StartValue = {-300, -220}
                }
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.4,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, -300},
                  StartValue = {-300, -300}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.2
              },
              [2] = {ShowContent = 0.02, Time = 0.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_enemy"
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
                Layer = 53,
                Time = 0
              },
              [2] = {
                Active = true,
                Layer = 70,
                Time = 0.3,
                Translate = {
                  Duration = 0.4,
                  EndValue = {-500, -220},
                  StartValue = {-300, -220}
                }
              }
            },
            RefEntityID = 6
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 71,
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, -300},
                  StartValue = {200, -300}
                }
              }
            },
            RefEntityID = 5
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
                Layer = 81,
                Position = {500, -200},
                Scaling = {0.35, 0.35},
                Time = 0.2
              }
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.2}
            },
            RefEntityID = 13
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_2003_2_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieque"
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
                Layer = 81,
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.4
                },
                Time = 0
              }
            },
            RefEntityID = 5
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
                Layer = 99,
                Time = 0.4
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
