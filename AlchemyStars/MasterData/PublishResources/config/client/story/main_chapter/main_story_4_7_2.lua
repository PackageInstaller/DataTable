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
      Effect = "",
      EntityID = 14,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 68,
      Name = "卡莲立绘",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 72,
      FitSize = true,
      Name = "下城背景图",
      Resource = "StoryBGxiacheng.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 73,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 74,
      Name = "暗鬼姐姐",
      Resource = "anguijiejie_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 78,
      Name = "暗鬼妹妹",
      Resource = "anguimeimei_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 80,
      FitSize = true,
      Name = "下城背景图2",
      Resource = "StoryBGxiacheng.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 81,
      Name = "紧张BGM",
      Resource = "18",
      Type = "Sound"
    },
    [11] = {
      EntityID = 82,
      Name = "激光音效",
      Resource = "10071",
      Type = "Sound"
    }
  },
  ID = 10040702,
  Name = "main_story_4_7_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "第七关战后第一段",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_44_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.2
              },
              [2] = {ShowContent = 0.02, Time = 1.4}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sjet"
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
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.6,
                  StartValue = 0.6
                },
                Layer = 1,
                Position = {0, 50},
                Time = 0
              }
            },
            RefEntityID = 72
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 9,
                Position = {-400, -220},
                Scaling = {-0.5, 0.5},
                Time = 0
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {40, 0},
                  Vibrato = 60
                },
                Time = 1.2
              }
            },
            RefEntityID = 74
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 0.2,
                  StartValue = 0.2
                },
                Layer = 8,
                Position = {300, -270},
                Scaling = {-0.37, 0.37},
                Time = 0
              }
            },
            RefEntityID = 78
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 81, Time = 0.7}
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sjet"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.04,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sjet"
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_47_dialog_content",
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
            RefEntityID = 74
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shire"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 10,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, -270},
                  StartValue = {300, -270}
                }
              }
            },
            RefEntityID = 78
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, 0},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sjet"
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
            RefEntityID = 78
          },
          [3] = {
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
            RefEntityID = 74
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sjet"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, 50},
                  StartValue = {-100, 0}
                }
              }
            }
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.04,
                Time = 3.5
              }
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Shake = {
                  Duration = 3.5,
                  fadeOut = true,
                  Strength = {60, 60},
                  Vibrato = 80
                },
                Time = 0.5
              },
              [2] = {
                Position = {0, 0},
                Time = 0.3
              }
            }
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
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0.2
              },
              [3] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              },
              [4] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 73
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 4,
                  EndValue = 0,
                  StartValue = 1
                },
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 3,
                Scale = {
                  Duration = 3,
                  EndValue = {1, 1},
                  StartValue = {1.15, 1.15}
                },
                Time = 0.5
              }
            },
            RefEntityID = 80
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 78
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 74
          },
          [7] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 3,
                  EndValue = 1,
                  StartValue = 0.6
                },
                Time = 0.5
              }
            },
            RefEntityID = 72
          },
          [8] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 82
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_53_dialog_content",
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_anger",
                Scaling = {0.42, 0.42},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-400, -400},
                  StartValue = {-450, -400}
                }
              }
            },
            RefEntityID = 14
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
                Layer = 9,
                LoopAnimation = "Story_rebuke",
                Scaling = {0.6, 0.6},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {350, -200},
                  StartValue = {450, -200}
                }
              }
            },
            RefEntityID = 68
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
            RefEntityID = 14
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_4_7_56_dialog_content",
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
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 14
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
            RefEntityID = 68
          }
        },
        [13] = {
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
