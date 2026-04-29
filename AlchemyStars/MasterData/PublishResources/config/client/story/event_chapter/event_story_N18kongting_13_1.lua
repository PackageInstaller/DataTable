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
      FitSize = false,
      Name = "妮娜替代",
      Resource = "nina_n18_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "空谷家园外景",
      Resource = "StoryBGjiayuanwaijing.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "丘布长老替代",
      Resource = "qiubuzhanglao_n18_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "扫描特效",
      Resource = "uieff_Story_Scan.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 7,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 8,
      Name = "红色遮罩",
      Resource = "RedPic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 9,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [10] = {
      EntityID = 10,
      Name = "空谷BGM",
      Resource = "73",
      Type = "Sound"
    },
    [11] = {
      EntityID = 11,
      Name = "拨弄草丛",
      Resource = "10265",
      Type = "Sound"
    },
    [12] = {
      EntityID = 12,
      Name = "丘布转场特效",
      Resource = "Uieff_zhuanchang.prefab",
      Type = "Effect"
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
      Name = "丘布弹弹音效",
      Resource = "10260",
      Type = "Sound"
    },
    [15] = {
      EntityID = 15,
      FitSize = false,
      Name = "神秘BGM",
      Resource = "21",
      Type = "Sound"
    },
    [16] = {
      EntityID = 16,
      Name = "扫描音效",
      Resource = "10173",
      Type = "Sound"
    },
    [17] = {
      EntityID = 17,
      Name = "机器人警报",
      Resource = "10178",
      Type = "Sound"
    },
    [18] = {
      EntityID = 18,
      FitSize = false,
      Name = "电磁1",
      Resource = "10039",
      Type = "Sound"
    },
    [19] = {
      EntityID = 19,
      FitSize = false,
      Name = "电磁2",
      Resource = "10078",
      Type = "Sound"
    }
  },
  ID = 50261301,
  Name = "event_story_N18kongting_13_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3.5
              },
              [2] = {ShowContent = 0.02, Time = 3.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
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
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
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
                LoopAnimation = "Story_surprise",
                Scaling = {1.07, 1.07},
                Time = 3.5,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -330},
                  StartValue = {-400, -330}
                }
              }
            },
            RefEntityID = 3
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0,
                  EndValue = 0.9,
                  StartValue = 0.9
                },
                Time = 0.5,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -100},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 1.5
              },
              [3] = {
                Time = 1.8,
                Translate = {
                  Duration = 1,
                  EndValue = {100, -100},
                  StartValue = {0, -100}
                }
              },
              [4] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 2.8
              },
              [5] = {
                Time = 3,
                Translate = {
                  Duration = 1,
                  EndValue = {0, -100},
                  StartValue = {100, -100}
                }
              }
            }
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {StartBgm = 10, Time = 0.5}
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.8},
              [2] = {PlaySound = "Once", Time = 3}
            },
            RefEntityID = 11
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_3_dialog_content",
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
            RefEntityID = 3
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 1,
                  EndValue = {0, 0},
                  StartValue = {0, -100}
                }
              }
            }
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_4_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_5_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_6_dialog_content",
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
        [7] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_7_dialog_content",
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
        [8] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_8_dialog_content",
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
                Content = "ui_story_5026_50261301_9_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_5026_50261301_11_option_content",
                NextParagraphID = 3
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
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
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -250},
                  StartValue = {0, -300}
                }
              },
              [2] = {
                Active = true,
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -300},
                  StartValue = {0, -250}
                }
              }
            },
            RefEntityID = 3
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_red", Time = 0}
            },
            RefEntityID = 3
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_angry2",
                Time = 0
              }
            },
            RefEntityID = 3
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_13_dialog_content",
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
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_14_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 2
              },
              [2] = {ShowContent = 0.02, Time = 2.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.4
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Position = {0, -150},
                Scaling = {0.6, 0.6},
                Time = 0.3
              }
            },
            RefEntityID = 5
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-50, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.4,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 0},
                  StartValue = {50, 0}
                }
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Time = 0.1
              }
            },
            RefEntityID = 12
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.1}
            },
            RefEntityID = 13
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_16_dialog_content",
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
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 20},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.2
              },
              [3] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 20},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.6
              }
            }
          }
        },
        [5] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
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
                LoopAnimation = "Story_norm",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -330},
                  StartValue = {600, -330}
                }
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -150},
                  StartValue = {0, -150}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [6] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                LoopAnimation = "Story_happy",
                Rotate = {
                  Duration = 0.2,
                  EndValue = -20,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {
                Rotate = {
                  Duration = 0.2,
                  EndValue = 20,
                  StartValue = -20
                },
                Time = 0.2
              },
              [3] = {
                Active = true,
                Rotate = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 20
                },
                Time = 0.4
              }
            },
            RefEntityID = 5
          },
          [3] = {
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 14
          }
        },
        [7] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_19_dialog_content",
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
            RefEntityID = 5
          }
        },
        [8] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_20_dialog_content",
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
        [9] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [10] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_22_dialog_content",
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
            RefEntityID = 5
          },
          [3] = {
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
        [11] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [12] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_24_dialog_content",
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
            RefEntityID = 5
          }
        },
        [13] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [14] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_26_dialog_content",
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
            RefEntityID = 5
          }
        },
        [15] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_27_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [17] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_29_dialog_content",
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
            RefEntityID = 5
          }
        },
        [18] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0.1
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 35,
                Time = 0
              },
              [2] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 15,
                Time = 0
              }
            }
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 16
          }
        },
        [19] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          }
        },
        [20] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_32_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Layer = 36,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.2
                },
                Time = 0.1
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Time = 0.3
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.2
                },
                Time = 0.4
              },
              [5] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0.2,
                  StartValue = 0
                },
                Time = 0.6
              },
              [6] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 0.2
                },
                Time = 0.7
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 17
          }
        },
        [21] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          }
        },
        [22] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [23] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.1}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [24] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          }
        },
        [25] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_anger",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [26] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_38_dialog_content",
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
            RefEntityID = 5
          }
        },
        [27] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
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
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [28] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
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
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                Shake = {
                  Duration = 1,
                  Strength = {40, 40},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 18
          }
        },
        [30] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_42_dialog_content",
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
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [31] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_qiubuzhanglao"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [32] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_44_dialog_content",
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
            RefEntityID = 5
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0.2
              }
            }
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {StartBgm = 10, Time = 0}
            }
          }
        },
        [33] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_45_dialog_content",
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
        [34] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_46_dialog_content",
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
        [35] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [36] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_48_dialog_content",
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
            RefEntityID = 3
          }
        },
        [37] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [38] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_50_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_red", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [39] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5026_50261301_51_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nina"
          }
        },
        [40] = {
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
              [2] = {Active = true, Time = 3}
            },
            RefEntityID = 2
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 3,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          },
          [3] = {
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
