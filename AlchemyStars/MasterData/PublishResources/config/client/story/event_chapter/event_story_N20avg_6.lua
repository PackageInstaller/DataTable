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
      Name = "宅邸内",
      Resource = "StoryBGandesenzhaidi.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "赞恩",
      Resource = "guyongbing_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = true,
      Name = "书馆房间",
      Resource = "StoryBGshuguanfangjian.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "书馆走廊",
      Resource = "StoryBGshuguanzoulang.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "卡莲sp",
      Resource = "kalianyuhun_n20_spine_idle.prefab",
      Type = "Spine"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "菲雅",
      Resource = "feiya_n19_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      Effect = "",
      EntityID = 9,
      Name = "薇丝",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "凯罗",
      Resource = "kailuo_n19_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 12,
      FitSize = false,
      Name = "风船BGM",
      Resource = "27",
      Type = "Sound"
    },
    [12] = {
      EntityID = 13,
      Name = "好感增加心心动效",
      Resource = "uieff_N20_Favorability_heart.prefab",
      Type = "Effect"
    },
    [13] = {
      EntityID = 14,
      Name = "好感提升提示",
      Resource = "uieff_N20_Favorability_up.prefab",
      Type = "Effect"
    }
  },
  ID = 50290006,
  Name = "event_story_N20avg_6",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 8,
                Position = {0, -300},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 12,
                Time = 0.5
              }
            }
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_2_dialog_content",
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
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_3_dialog_content",
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
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_4_dialog_content",
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
                Content = "ui_story_5029_50290006_5_option_content",
                NextParagraphID = 2
              },
              [2] = {
                Content = "ui_story_5029_50290006_26_option_content",
                NextParagraphID = 7
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
          },
          NextParagraphID = 2
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "选项A",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_6_dialog_content",
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
          NextParagraphID = 23
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "选项A-选项1",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_9_dialog_content",
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
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_10_dialog_content",
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
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_11_dialog_content",
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
        [5] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_12_dialog_content",
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
          NextParagraphID = 23
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "选项A-选项2",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_15_dialog_content",
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
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_16_dialog_content",
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
          NextParagraphID = 22
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_12_dialog_content",
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
          NextParagraphID = 23
        }
      }
    },
    [5] = {
      ID = 5,
      Name = "选项A-选项3",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_20_dialog_content",
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
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_21_dialog_content",
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
              [1] = {
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 4
          },
          NextParagraphID = 22
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_12_dialog_content",
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
          NextParagraphID = 23
        }
      }
    },
    [6] = {
      ID = 6,
      Name = "选项A-选项4",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zanen"
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
                LoopAnimation = "Story_laugh",
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5029_50290006_25_dialog_content",
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
            RefEntityID = 4
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 30},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 30}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 30},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 30}
                }
              }
            }
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_27_dialog_content",
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
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {45, -200},
                Scaling = {0.6, 0.6},
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {480, -330},
                Scaling = {0.85, 0.85},
                Time = 0.5
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {-400, -400},
                Scaling = {0.42, 0.42},
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 4
          },
          NextParagraphID = 8
        }
      }
    },
    [7] = {
      ID = 7,
      Name = "选项B",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 1,
                Time = 3
              }
            },
            RefEntityID = 5
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 6
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
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 2.8
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 3.1
              }
            },
            RefEntityID = 2
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              },
              [3] = {
                Time = 1.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              },
              [5] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 3,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [6] = {
                Time = 3.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              },
              [7] = {
                Time = 4,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 50},
                  StartValue = {0, 0}
                }
              },
              [8] = {
                Time = 4.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {0, 50}
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 4
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_27_dialog_content",
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
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {45, -200},
                Scaling = {0.6, 0.6},
                Time = 0.5
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {480, -330},
                Scaling = {0.85, 0.85},
                Time = 0.5
              }
            },
            RefEntityID = 7
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {-400, -400},
                Scaling = {0.42, 0.42},
                Time = 0.5
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 1,
                Time = 0.5
              }
            },
            RefEntityID = 3
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0.5
              }
            }
          },
          NextParagraphID = 8
        }
      }
    },
    [8] = {
      ID = 8,
      Name = "选项结束",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_29_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_sigh",
                Time = 0
              }
            },
            RefEntityID = 7
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
            RefEntityID = 8
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_30_dialog_content",
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
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_worried",
                Time = 0
              }
            },
            RefEntityID = 9
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
            RefEntityID = 7
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_31_dialog_content",
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
          }
        },
        [5] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_32_dialog_content",
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
            DialogContentStr = "ui_story_5029_50290006_33_dialog_content",
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
          NextParagraphID = 22
        }
      }
    },
    [9] = {
      ID = 9,
      Name = "找卡莲",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {0, -330},
                Time = 0.2
              }
            },
            RefEntityID = 7
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
                Time = 0
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
            RefEntityID = 2
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0,
                  EndValue = 0.9,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_37_dialog_content",
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
                Content = "ui_story_5029_50290006_38_option_content",
                NextParagraphID = 10,
                StoryManual = {
                  ManualSetting = {
                    InfluenceValue = {
                      0,
                      1,
                      0,
                      0
                    },
                    NextNodeId = 7
                  }
                }
              },
              [2] = {
                Content = "ui_story_5029_50290006_41_option_content",
                NextParagraphID = 11
              },
              [3] = {
                Content = "ui_story_5029_50290006_46_option_content",
                NextParagraphID = 12,
                StoryManual = {
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    Influence = "str_avg_n20_manual_Influence_004_1",
                    NextNodeId = 10
                  }
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
            RefEntityID = 7
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
          }
        }
      }
    },
    [10] = {
      ID = 10,
      Name = "找卡莲-选项1",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian",
            StorySection = {
              SectionSetting = {
                BE = "",
                BECondition = "",
                ValueChange = {
                  0,
                  4,
                  0,
                  0
                }
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-50, 0},
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                Position = {200, 0},
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_40_dialog_content",
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
        [3] = {
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
              [2] = {Active = true, Time = 2.8}
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
    [11] = {
      ID = 11,
      Name = "找卡莲-选项2",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_42_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 7
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_43_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, -330},
                  StartValue = {0, -330}
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
            RefEntityID = 7
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_44_dialog_content",
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
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_45_dialog_content",
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
          NextParagraphID = 22
        }
      }
    },
    [12] = {
      ID = 12,
      Name = "找卡莲-选项3",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_47_dialog_content",
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
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_serious",
                Time = 0
              }
            },
            RefEntityID = 7
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_48_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, -330},
                  StartValue = {0, -330}
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
            RefEntityID = 7
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_49_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_50_dialog_content",
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
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 2.8}
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
    [13] = {
      ID = 13,
      Name = "找薇丝",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
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
                Time = 0
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
            RefEntityID = 2
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0,
                  EndValue = 0.9,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
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
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {0, -400},
                Time = 0.2
              }
            },
            RefEntityID = 9
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_53_dialog_content",
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
                Content = "ui_story_5029_50290006_54_option_content",
                NextParagraphID = 14,
                StoryManual = {
                  ManualSetting = {
                    InfluenceValue = {
                      0,
                      0,
                      1,
                      0
                    },
                    NextNodeId = 8
                  }
                }
              },
              [2] = {
                Content = "ui_story_5029_50290006_57_option_content",
                NextParagraphID = 15
              },
              [3] = {
                Content = "ui_story_5029_50290006_61_option_content",
                NextParagraphID = 16,
                StoryManual = {
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    Influence = "str_avg_n20_manual_Influence_004_1",
                    NextNodeId = 10
                  }
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice"
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
                Time = 0
              }
            }
          },
          [3] = {
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
            RefEntityID = 9
          }
        }
      }
    },
    [14] = {
      ID = 14,
      Name = "找薇丝-选项1",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_vice",
            StorySection = {
              SectionSetting = {
                BE = "",
                BECondition = "",
                ValueChange = {
                  0,
                  0,
                  4,
                  0
                }
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_tsukkomi",
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-100, 0},
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                Position = {150, 0},
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_56_dialog_content",
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
                LoopAnimation = "Story_worried",
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [3] = {
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
              [2] = {Active = true, Time = 2.8}
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
    [15] = {
      ID = 15,
      Name = "找薇丝-选项2",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_58_dialog_content",
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
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 9
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_59_dialog_content",
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Layer = 8,
                Time = 0.5,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -400},
                  StartValue = {0, -400}
                }
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.8
              },
              [3] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -350},
                  StartValue = {0, -400}
                }
              },
              [4] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, -400},
                  StartValue = {0, -350}
                }
              }
            },
            RefEntityID = 9
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_44_dialog_content",
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
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 0},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          },
          NextParagraphID = 22
        }
      }
    },
    [16] = {
      ID = 16,
      Name = "找薇丝-选项3",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_62_dialog_content",
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
                Active = true,
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 9
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_63_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {200, -400},
                  StartValue = {0, -400}
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
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_64_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_65_dialog_content",
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
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 2.8}
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
    [17] = {
      ID = 17,
      Name = "找菲雅",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 7
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
                Time = 0
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
            RefEntityID = 2
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0,
                  EndValue = 0.9,
                  StartValue = 0.9
                },
                Time = 0.2
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Position = {-300, -200},
                Time = 0.2
              }
            },
            RefEntityID = 8
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 0.2,
                Layer = 8,
                Position = {300, 0},
                Scaling = {0.4, 0.4},
                Time = 0.2
              }
            },
            RefEntityID = 10
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_68_dialog_content",
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
                Content = "ui_story_5029_50290006_54_option_content",
                NextParagraphID = 18,
                StoryManual = {
                  ManualSetting = {
                    InfluenceValue = {
                      0,
                      0,
                      0,
                      1
                    },
                    NextNodeId = 9
                  }
                }
              },
              [2] = {
                Content = "ui_story_5029_50290006_57_option_content",
                NextParagraphID = 19
              },
              [3] = {
                Content = "ui_story_5029_50290006_61_option_content",
                NextParagraphID = 20,
                StoryManual = {
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    Influence = "str_avg_n20_manual_Influence_004_1",
                    NextNodeId = 10
                  }
                }
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
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
                LoopAnimation = "Story_shocked",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        }
      }
    },
    [18] = {
      ID = 18,
      Name = "找菲雅-选项1",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya",
            StorySection = {
              SectionSetting = {
                BE = "",
                BECondition = "",
                ValueChange = {
                  0,
                  0,
                  0,
                  4
                }
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 18,
                Position = {-400, -100},
                Time = 0
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 19,
                Position = {-200, 0},
                Time = 0
              }
            },
            RefEntityID = 14
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          }
        },
        [3] = {
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
              [2] = {Active = true, Time = 2.8}
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
    [19] = {
      ID = 19,
      Name = "找菲雅-选项2",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_73_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_shocked",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_75_dialog_content",
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
            RefEntityID = 8
          },
          NextParagraphID = 22
        }
      }
    },
    [20] = {
      ID = 20,
      Name = "找菲雅-选项3",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_feiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_78_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-600, -200},
                  StartValue = {-300, -200}
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
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0.1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 0},
                  StartValue = {300, 0}
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
            RefEntityID = 10
          }
        },
        [3] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_79_dialog_content",
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
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_80_dialog_content",
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
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Active = true, Time = 2.8}
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
    [21] = {
      ID = 21,
      Name = "独自搜寻",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_82_dialog_content",
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
        [2] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_83_dialog_content",
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
    [22] = {
      ID = 22,
      Name = "找不同角色车站",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290006_34_dialog_content",
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
                Content = "ui_story_5029_50290006_35_option_content",
                NextParagraphID = 9,
                StoryManual = {
                  Influence = "ui_story_name_unknown",
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    UnlockCondition = "1231,1063,09,1,3,1",
                    UnlockConditionDesc = "str_avg_n20_manual_unlock_001_1"
                  }
                }
              },
              [2] = {
                Content = "ui_story_5029_50290006_51_option_content",
                NextParagraphID = 13,
                StoryManual = {
                  Influence = "ui_story_name_unknown",
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    UnlockCondition = "1231,1063,09,2,3,1",
                    UnlockConditionDesc = "str_avg_n20_manual_unlock_002_1"
                  }
                }
              },
              [3] = {
                Content = "ui_story_5029_50290006_66_option_content",
                NextParagraphID = 17,
                StoryManual = {
                  Influence = "ui_story_name_unknown",
                  InfluenceValue = {
                    0,
                    0,
                    0,
                    0
                  },
                  ManualSetting = {
                    UnlockCondition = "1231,1063,09,3,3,1",
                    UnlockConditionDesc = "str_avg_n20_manual_unlock_003_1"
                  }
                }
              },
              [4] = {
                Content = "ui_story_5029_50290006_81_option_content",
                NextParagraphID = 21,
                StoryManual = {
                  ManualSetting = {
                    Influence = "str_avg_n20_manual_Influence_004_1",
                    NextNodeId = 10
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
    [23] = {
      ComponentID = "0",
      ID = 23,
      Name = "选项A小循环车站",
      Sections = {
        [1] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5029_50290007_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0.2
              },
              [2] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "ui_story_5029_50290006_7_option_content",
                NextParagraphID = 3
              },
              [2] = {
                Content = "ui_story_5029_50290006_13_option_content",
                NextParagraphID = 4
              },
              [3] = {
                Content = "ui_story_5029_50290006_18_option_content",
                NextParagraphID = 5
              },
              [4] = {
                Content = "ui_story_5029_50290006_23_option_content",
                NextParagraphID = 6
              }
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
            RefEntityID = 4
          }
        }
      }
    }
  },
  StartParagraph = 1
}
