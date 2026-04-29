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
      Name = "海边夜间",
      Resource = "StoryBGshatanye.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "通常BGM",
      Resource = "17",
      Type = "Sound"
    },
    [5] = {
      EntityID = 5,
      FitSize = true,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "波娜瑟立绘",
      Resource = "bonase_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "暗鬼沟通",
      Resource = "StoryBGhive.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "皇后立绘",
      Resource = "huanghou_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 9,
      FitSize = false,
      Name = "电磁特效",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "黑白特效",
      Resource = "UIeff_bahamosi_02.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "入侵特效",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 12,
      FitSize = false,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 13,
      FitSize = false,
      Name = "黑幕底图",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 14,
      FitSize = false,
      Name = "写实暗鬼杂兵替代",
      Resource = "qizi_bing_spine_idle.prefab",
      Type = "Spine"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "卡莲",
      Resource = "1600061_spine_idle.prefab",
      Type = "Spine"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "暗鬼叫声",
      Resource = "10069",
      Type = "Sound"
    }
  },
  ID = 50042801,
  Name = "event_story_xiahuo2021_1_28_1",
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
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 4,
                Time = 0.5
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
                  StartValue = 1
                },
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
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bonase"
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
                LoopAnimation = "Story_disagree",
                Position = {100, -330},
                Scaling = {0.9, 0.9},
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E2_dialog_content",
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
            RefEntityID = 6
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_bonase"
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
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {100, -300},
                  StartValue = {100, -330}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {100, -330},
                  StartValue = {100, -300}
                }
              },
              [4] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {100, -300},
                  StartValue = {100, -330}
                }
              },
              [5] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.1,
                  EndValue = {100, -330},
                  StartValue = {100, -300}
                }
              }
            },
            RefEntityID = 6
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E4_dialog_content",
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
            RefEntityID = 6
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_heiying"
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 5,
                Time = 0.5
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
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 20,
                Position = {0, -600},
                Scaling = {1.4, 1.4},
                Time = 1
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.5
              }
            },
            RefEntityID = 7
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.5
              }
            },
            RefEntityID = 11
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 41,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [9] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_heiying"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E7_dialog_content",
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
                  Duration = 1,
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
                Active = false,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 20,
                Position = {0, -600},
                Scaling = {1.4, 1.4},
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 40,
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 20,
                Time = 0.5
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 30,
                Time = 0.5
              }
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 41,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0.5}
            },
            RefEntityID = 6
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_heiying"
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
                  Duration = 1,
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 20,
                Position = {0, -600},
                Scaling = {1.4, 1.4},
                Time = 1
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0.5
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.5
              }
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 41,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 6
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_heiying"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                  Duration = 1,
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
                Active = false,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 20,
                Position = {0, -600},
                Scaling = {1.4, 1.4},
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 40,
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 20,
                Time = 0.5
              }
            },
            RefEntityID = 7
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 30,
                Time = 0.5
              }
            },
            RefEntityID = 11
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 41,
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                LoopAnimation = "Story_think",
                Position = {0, -400},
                Scaling = {0.42, 0.42},
                Time = 0.5
              }
            },
            RefEntityID = 12
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E11_dialog_content",
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
                LoopAnimation = "Story_shocked",
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E12_dialog_content",
            KeyFrames = {
              [1] = {ContentBGVisible = true, Time = 0.5},
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1
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
                  Duration = 1,
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
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0.5
              }
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_E13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiteangui"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Position = {50, -250},
                Scaling = {0.9, 0.9},
                Time = 0
              }
            },
            RefEntityID = 14
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
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_184_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiteangui"
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
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 17
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_185_dialog_content",
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
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 14
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
                LoopAnimation = "Story_rebuke",
                Position = {50, -200},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5004_50042801_186_dialog_content",
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
            RefEntityID = 16
          }
        },
        [18] = {
          [1] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1.5,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                Layer = 50,
                Time = 2
              }
            },
            RefEntityID = 2
          }
        }
      }
    }
  },
  StartParagraph = 1
}
