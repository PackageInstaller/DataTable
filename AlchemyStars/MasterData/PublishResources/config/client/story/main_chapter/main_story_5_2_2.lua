return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "StoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 3,
      Name = "黑幕-底图用",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 4,
      FitSize = true,
      Name = "废都背景替代",
      Resource = "StoryBGfeidu.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 5,
      Name = "吞罗立绘",
      Resource = "tunluo_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 6,
      Name = "舒默尔立绘",
      Resource = "shumoer_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 7,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 8,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [8] = {
      EntityID = 9,
      Name = "脚步声",
      Resource = "10082",
      Type = "Sound"
    },
    [9] = {
      EntityID = 10,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [10] = {
      EntityID = 11,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 12,
      Name = "崩塌音效",
      Resource = "10024",
      Type = "Sound"
    }
  },
  ID = 10050202,
  Name = "main_story_5_2_2",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.6
              },
              [2] = {ShowContent = 0.02, Time = 1.8}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mystery"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
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
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 60,
                LoopAnimation = "Story_hood_idle",
                Position = {0, -450},
                Scaling = {0.6, 0.6},
                Time = 1.5
              }
            },
            RefEntityID = 5
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 8, Time = 1},
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 80,
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 85,
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
            RefEntityID = 7
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_86_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.1
              },
              [2] = {ShowContent = 0.02, Time = 1.3}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 40,
                Position = {50, 50},
                Scaling = {1.15, 1.15},
                Time = 0.5
              }
            },
            RefEntityID = 4
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
                Time = 0.5
              }
            },
            RefEntityID = 3
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
                Layer = 60,
                Position = {-100, -540},
                Scaling = {0.6, 0.6},
                Time = 0.5
              }
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 99,
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
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 5
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 10
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 11
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-50, -510},
                  StartValue = {-100, -540}
                }
              },
              [2] = {
                Active = true,
                Time = 0.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -540},
                  StartValue = {-50, -510}
                }
              },
              [3] = {
                Active = true,
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {50, -510},
                  StartValue = {0, -540}
                }
              },
              [4] = {
                Active = true,
                Time = 0.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {100, -540},
                  StartValue = {50, -510}
                }
              },
              [5] = {
                Active = true,
                LoopAnimation = "Story_sullen",
                Time = 1.3
              }
            },
            RefEntityID = 6
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {200, 0},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3},
              [2] = {PlaySound = "Once", Time = 0.9}
            },
            RefEntityID = 9
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
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
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_90_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.5
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 1
              },
              [2] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 80},
                  Vibrato = 60
                },
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 12
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_91_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5_2_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_shumoer"
          }
        },
        [9] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 99,
                Time = 0
              },
              [2] = {Active = true, Time = 2}
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
