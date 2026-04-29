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
      FitSize = false,
      Name = "尼珀里斯",
      Resource = "naxilisiblack_s8_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_nipolisi",
      Type = "Spine"
    },
    [3] = {
      EntityID = 3,
      FitSize = false,
      Name = "那席里斯立绘",
      Resource = "naxilisisaiji_s8_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_naxilisi",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "刹雅",
      Resource = "xiaoboliheng_n9_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_mizhishaonv",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "镜中人（主角空裔）",
      Resource = "nanzhu_zuzhou_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_jingzhongren",
      Type = "Spine"
    },
    [6] = {
      EntityID = 6,
      FitSize = true,
      Name = "覆雪森林黎明",
      Resource = "StoryBGfuxuesenlinliming.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 7,
      FitSize = false,
      Name = "北境bgm",
      Resource = "59",
      Type = "Sound"
    },
    [8] = {
      EntityID = 8,
      FitSize = false,
      Name = "刹雅切条",
      Resource = "xiaoboliheng_n9_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [9] = {
      EntityID = 9,
      FitSize = true,
      Name = "S8花束",
      Resource = "DTs8huashu.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 10,
      FitSize = false,
      Name = "S8那席里斯切条",
      Resource = "naxilisisaiji_s8_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [11] = {
      EntityID = 11,
      FitSize = false,
      Name = "尼珀里斯切条",
      Resource = "naxilisiblack_s8_spine_idle.prefab",
      Type = "SpineSliceEdge"
    },
    [12] = {
      EntityID = 12,
      FitSize = true,
      Name = "空裔手镜",
      Resource = "DTs8kongyishoujing.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 13,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    }
  },
  ID = 50870502,
  Name = "event_story_S8naxilisi_5_2",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1
              },
              [2] = {ShowContent = 0.02, Time = 1.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
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
                Position = {0, -400},
                Scaling = {0.9, 0.9},
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 7,
                Time = 0.5
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 50,
                Time = 0
              },
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 13
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mizhishaonv"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
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
                Layer = 8,
                Position = {0, -250},
                Scaling = {0.58, 0.58},
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mizhishaonv"
          }
        },
        [5] = {
          [1] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {
                Active = true,
                Time = 1,
                Translate = {
                  Duration = 1,
                  EndValue = {3000, -250},
                  StartValue = {0, -250}
                }
              }
            },
            RefEntityID = 4
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mizhishaonv"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
                Active = true,
                Layer = 20,
                Position = {400, 0},
                Scaling = {0.6, 0.6},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {0, -250},
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
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
                Position = {0, -400},
                Scaling = {0.85, 0.85},
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 8
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
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
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Position = {0, -400},
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Scaling = {0.35, 0.35},
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Position = {400, 0},
                Scaling = {0.9, 0.9},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {50, -400},
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
                Active = true,
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
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 9
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Position = {400, 0},
                Scaling = {0.9, 0.9},
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                SpineOffset = {50, -400},
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
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
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 11
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_16_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_nipolisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Time = 0
              },
              [2] = {
                Time = 2,
                Translate = {
                  Duration = 0.6,
                  EndValue = {3000, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 2
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0}
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Scroll = {
                  Duration = 0.2,
                  StartFromCover = true,
                  Toward = "HorizontalSpread"
                },
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
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
            RefEntityID = 3
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jingzhongren"
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
                  EndValue = 0,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -400},
                Scaling = {1.15, 1.15},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 3
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
            RefEntityID = 3
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jingzhongren"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0
                },
                Layer = 8,
                LoopAnimation = "Story_heiying",
                Position = {0, -400},
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
            RefEntityID = 3
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_28_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_naxilisi"
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5087_50870502_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_jingzhongren"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = false,
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
                Active = true,
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 0
                },
                Layer = 8,
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [31] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Time = 2.5}
            },
            RefEntityID = 13
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
