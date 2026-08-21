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
      FitSize = true,
      Name = "巨像控制台背景图",
      Resource = "StoryBGfengchuankongzhitai.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 4,
      Name = "童谣座-待替换",
      Resource = "1701091_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_xinxiya",
      Type = "Spine"
    },
    [4] = {
      EntityID = 5,
      FitSize = false,
      Name = "蜜特拉代替-12-2",
      Resource = "mitela_n51_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_mitela",
      Type = "Spine"
    },
    [5] = {
      EntityID = 6,
      FitSize = false,
      Name = "车尔尼老年",
      Resource = "cheernilaonian_n51_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_cheerni",
      Type = "Spine"
    },
    [6] = {
      EntityID = 7,
      FitSize = false,
      Name = "路德维希",
      Resource = "kongyinv2_S5_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_ludeweixi",
      Type = "Spine"
    },
    [7] = {
      EntityID = 8,
      FitSize = true,
      Name = "风船房间-宕机",
      Resource = "StoryBGjuxiangroom2.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 9,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 10,
      FitSize = false,
      Name = "空谷家园外景",
      Resource = "StoryBGjiayuanwaijing.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 12,
      FitSize = false,
      Name = "临空者意识模块",
      Resource = "yishimokuai_n17_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_vice",
      Type = "Spine"
    },
    [11] = {
      EntityID = 14,
      FitSize = false,
      Name = "一叠手稿",
      Resource = "DTyidieshougao.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 16,
      Name = "打字机-升入天际",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [13] = {
      EntityID = 17,
      Name = "打字机-伴随那风",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [14] = {
      EntityID = 18,
      Name = "打字机-一座乐器",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [15] = {
      EntityID = 19,
      Name = "打字机-摇篮曲",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [16] = {
      EntityID = 20,
      Name = "打字机-温徳岚之日",
      Resource = "StoryTextMiddle.prefab",
      Type = "Text"
    },
    [17] = {
      EntityID = 23,
      FitSize = false,
      Name = "缅怀BGM",
      Resource = "29",
      Type = "Sound"
    },
    [18] = {
      EntityID = 24,
      FitSize = false,
      Name = "空谷bgm",
      Resource = "54",
      Type = "Sound"
    }
  },
  ID = 50881202,
  Name = "event_story_N51jijianzuo_12_2",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
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
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -500},
                Scaling = {0.95, 0.95},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = false,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -450},
                Scaling = {0.85, 0.85},
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StopBgm = true,
                Time = 0
              },
              [2] = {
                FadeTime = 2,
                StartBgm = 23,
                Time = 0.1
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinxiya"
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
                Scaling = {1.35, 1.35},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, -250},
                  StartValue = {900, -250}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-500, -450},
                  StartValue = {0, -450}
                }
              }
            },
            RefEntityID = 5
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_xinxiya"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
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
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 4
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Position = {0, -500},
                Scaling = {0.5, 0.5},
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.5
              },
              [2] = {ShowContent = 0.02, Time = 0.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ludeweixi"
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
                Time = 0.2,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, -400},
                  StartValue = {1000, -400}
                }
              }
            },
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -500},
                  StartValue = {0, -500}
                }
              }
            },
            RefEntityID = 6
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_6_dialog_content",
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
            RefEntityID = 7
          },
          [3] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 6
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_7_dialog_content",
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
            DialogContentStr = "ui_story_5088_50881202_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
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
                Scaling = {0.5, 0.5},
                Time = 0
              }
            },
            RefEntityID = 6
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ludeweixi"
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
              }
            },
            RefEntityID = 7
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
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
            RefEntityID = 7
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
              }
            },
            RefEntityID = 6
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_13_dialog_content",
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
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
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
            RefEntityID = 6
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_16_dialog_content",
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
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ludeweixi"
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
            RefEntityID = 7
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_18_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ludeweixi"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ludeweixi"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_ludeweixi"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_cheerni"
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
            RefEntityID = 7
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
              }
            },
            RefEntityID = 6
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
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
            RefEntityID = 6
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
                Position = {0, -450},
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 7
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_23_dialog_content",
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
            RefEntityID = 5
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
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
            RefEntityID = 5
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_27_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-600, -450},
                  StartValue = {0, -450}
                }
              }
            },
            RefEntityID = 5
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
                Scaling = {0.8, 0.8},
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {400, 0},
                  StartValue = {900, 0}
                }
              }
            },
            RefEntityID = 12
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_28_dialog_content",
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
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_29_dialog_content",
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
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_30_dialog_content",
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
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
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
            RefEntityID = 5
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
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_32_dialog_content",
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
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 12
          },
          [6] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 24,
                Time = 0
              }
            }
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
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
                  StartValue = 0.2
                },
                Layer = 8,
                Position = {0, -450},
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_34_dialog_content",
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
            RefEntityID = 5
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
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
            RefEntityID = 5
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 8,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_37_dialog_content",
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
            RefEntityID = 5
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_38_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
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
            RefEntityID = 5
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_39_dialog_content",
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
            RefEntityID = 5
          }
        },
        [40] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 2
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_40_dialog_content",
                      Time = 3
                    }
                  }
                },
                Layer = 18,
                OutLine = true,
                R = 1,
                Time = 0
              }
            },
            RefEntityID = 16
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
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [41] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_41_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                OutLine = true,
                R = 1,
                Time = 1.6
              }
            },
            RefEntityID = 17
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.5}
            },
            RefEntityID = 16
          }
        },
        [42] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_42_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                OutLine = true,
                R = 1,
                Time = 1.6
              }
            },
            RefEntityID = 18
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.5}
            },
            RefEntityID = 17
          }
        },
        [43] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_1_1_1_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_43_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                OutLine = true,
                R = 1,
                Time = 1.6
              }
            },
            RefEntityID = 19
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.5}
            },
            RefEntityID = 18
          }
        },
        [44] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                B = 1,
                G = 1,
                Languages = {
                  es = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  idn = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  jp = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  kr = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  pt = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  th = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  tw = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  us = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  },
                  zh = {
                    FontSize = 40,
                    Position = {0, 0},
                    TypeText = {
                      TextID = "ui_story_5088_50881202_44_dialog_content",
                      Time = 1
                    }
                  }
                },
                Layer = 18,
                OutLine = true,
                R = 1,
                Time = 1.6
              }
            },
            RefEntityID = 20
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.5}
            },
            RefEntityID = 19
          }
        },
        [45] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.5
              }
            },
            RefEntityID = 9
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1.5}
            },
            RefEntityID = 20
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_mitela"
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
                  StartValue = 0.2
                },
                Layer = 8,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 5
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_46_dialog_content",
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
            RefEntityID = 5
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_47_dialog_content",
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
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_48_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.8
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
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 5
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_49_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [51] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_50_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [52] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_51_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_52_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_53_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_5088_50881202_54_dialog_content",
            KeyFrames = {
              [1] = {ShowContent = 0.02, Time = 0}
            },
            RefEntityID = 1
          }
        },
        [56] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {Time = 1.5}
            },
            RefEntityID = 9
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
