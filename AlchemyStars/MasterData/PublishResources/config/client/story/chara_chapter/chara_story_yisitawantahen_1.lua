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
      Name = "巨像酒吧背景",
      Resource = "StoryBGjuxiangjiuba.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 3,
      FitSize = false,
      Name = "伊斯塔万立绘",
      Resource = "yisitawansp_n39_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_yisitawan",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "塞留古立绘",
      Resource = "heibao_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_sailiugu",
      Type = "Spine"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "帕蒂&帕西",
      Resource = "1400731_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_padipaxi",
      Type = "Spine"
    },
    [6] = {
      EntityID = 7,
      FitSize = true,
      Name = "影镇室内",
      Resource = "StoryBGyingzhenshinei.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 8,
      FitSize = true,
      Name = "影镇室外背景",
      Resource = "StoryBGyingzhenjiedao.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 9,
      FitSize = false,
      Name = "商会背景",
      Resource = "StoryBGshanghui.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 10,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 11,
      FitSize = false,
      Name = "转场",
      Resource = "uieff_Story_blackscreen.prefab",
      Type = "Effect"
    },
    [11] = {
      EntityID = 12,
      FitSize = false,
      Name = "通用BGM",
      Resource = "17",
      Type = "Sound"
    },
    [12] = {
      EntityID = 13,
      FitSize = false,
      Name = "神秘bgm",
      Resource = "21",
      Type = "Sound"
    },
    [13] = {
      EntityID = 14,
      FitSize = false,
      Name = "欢乐BGM",
      Resource = "38",
      Type = "Sound"
    },
    [14] = {
      EntityID = 15,
      FitSize = false,
      Name = "诙谐BGM",
      Resource = "37",
      Type = "Sound"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "温馨BGM",
      Resource = "29",
      Type = "Sound"
    },
    [16] = {
      EntityID = 17,
      Name = "闪白图片",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 18,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 19,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    },
    [19] = {
      EntityID = 20,
      FitSize = false,
      Name = "贝菲尔",
      Resource = "beifeier_n7_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_beifeier",
      Type = "Spine"
    },
    [20] = {
      EntityID = 21,
      Name = "跑步音效",
      Resource = "10082",
      Type = "Sound"
    },
    [21] = {
      EntityID = 22,
      Name = "帕蒂",
      Resource = "padi_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_padi",
      Type = "Spine"
    },
    [22] = {
      EntityID = 23,
      Name = "帕西",
      Resource = "paxi_spine_idle.prefab",
      StorySpineNameStr = "ui_story_name_paxi",
      Type = "Spine"
    }
  },
  ID = 32190401,
  Name = "chara_story_yisitawantahen_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 10
          }
        },
        [2] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 2,
                Time = 0
              }
            },
            RefEntityID = 2
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
                Layer = 50,
                Time = 1
              }
            },
            RefEntityID = 10
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
                Layer = 8,
                Position = {0, -400},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 12,
                Time = 0
              }
            }
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_2_dialog_content",
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
            RefEntityID = 3
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_3_dialog_content",
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
            DialogContentStr = "ui_story_32190401_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_6_dialog_content",
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
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_11_dialog_content",
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_13_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, 300},
                  StartValue = {0, 0}
                }
              },
              [3] = {
                Time = 1.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, 0},
                  StartValue = {-100, 300}
                }
              },
              [4] = {
                Time = 2.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, 200},
                  StartValue = {100, 0}
                }
              },
              [5] = {
                Time = 2.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 200},
                  StartValue = {200, 200}
                }
              }
            }
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_15_dialog_content",
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
                Affinity = 50,
                Content = "ui_story_32190401_16_option_content",
                NextParagraphID = 2,
                PetID = 1602191
              },
              [2] = {
                Affinity = 30,
                Content = "ui_story_32190401_18_option_content",
                NextParagraphID = 3,
                PetID = 1602191
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0.7
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 200}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        }
      }
    },
    [2] = {
      ComponentID = "0",
      ID = 2,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_17_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Time = 0
              }
            },
            RefEntityID = 3
          },
          NextParagraphID = 4
        }
      }
    },
    [3] = {
      ComponentID = "0",
      ID = 3,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
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
      ComponentID = "0",
      ID = 4,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_20_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Layer = 8,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_22_dialog_content",
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
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_23_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_24_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [6] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.6
              }
            },
            RefEntityID = 17
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
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
                  StartValue = 0.8
                },
                Layer = 18,
                Time = 0.3
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 19
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 3
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_25_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
                Scaling = {1, 1},
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {600, -300},
                  StartValue = {800, -300}
                }
              }
            },
            RefEntityID = 4
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
                Scaling = {1, 1},
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-600, -150},
                  StartValue = {-800, -150}
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 8,
                Scaling = {1.05, 1.05},
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -300},
                  StartValue = {-400, -300}
                }
              }
            },
            RefEntityID = 20
          }
        },
        [8] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [9] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 20
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 1}
            },
            RefEntityID = 3
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 5
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 4
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_26_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_27_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_28_dialog_content",
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
            RefEntityID = 3
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_29_dialog_content",
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
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_30_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
          }
        },
        [15] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
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
        },
        [16] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 1
              }
            },
            RefEntityID = 7
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_31_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
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
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 8,
                LoopAnimation = "Story_think",
                Position = {0, -350},
                Scaling = {1.2, 1.2},
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 13,
                Time = 0
              }
            }
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_32_dialog_content",
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
            RefEntityID = 4
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
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
                Shake = {
                  Duration = 0.3,
                  Strength = {40, 20},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 4
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_34_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_35_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
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
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_36_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = 0.7,
                  StartValue = 0.9
                },
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 300},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_happy",
                Shake = {
                  Duration = 1,
                  Strength = {40, 30},
                  Vibrato = 40,
                  fadeOut = true
                },
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [4] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 15,
                Time = 0
              }
            }
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_37_dialog_content",
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
            RefEntityID = 4
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_38_dialog_content",
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
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_39_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
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
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0.7
                },
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 0},
                  StartValue = {0, 300}
                }
              }
            }
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_40_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = {1.3, 1.3},
                  StartValue = {1.2, 1.2}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -300},
                  StartValue = {0, -350}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -350},
                  StartValue = {0, -300}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_41_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_sailiugu"
          }
        },
        [28] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
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
        },
        [29] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
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
                Layer = 2,
                Time = 1
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 7
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_42_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padi"
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 14,
                Time = 0
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
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
                Brightness = 1,
                Layer = 8,
                Scaling = {1, 1},
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 50},
                  StartValue = {-200, 0}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 0},
                  StartValue = {-200, 50}
                }
              }
            },
            RefEntityID = 22
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 8,
                Position = {200, -150},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_paxi"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 21
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
            RefEntityID = 22
          },
          [4] = {
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
            RefEntityID = 23
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_44_dialog_content",
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
            RefEntityID = 23
          }
        },
        [33] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [34] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_45_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padi"
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
            RefEntityID = 22
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_46_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_paxi"
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
            RefEntityID = 22
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
            RefEntityID = 23
          }
        },
        [37] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.6
              }
            },
            RefEntityID = 17
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
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
                  StartValue = 0.8
                },
                Layer = 18,
                Time = 0.3
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 19
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 19,
                Time = 0.3
              }
            },
            RefEntityID = 3
          },
          [6] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.3,
                Translate = {
                  Duration = 3,
                  EndValue = {0, 0},
                  StartValue = {0, 100}
                }
              }
            }
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 23
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 22
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_47_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padi"
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
            RefEntityID = 22
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_paxi"
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
            RefEntityID = 22
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
            RefEntityID = 23
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_49_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padipaxi"
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
            RefEntityID = 23
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
            RefEntityID = 5
          }
        },
        [41] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 20,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
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
        [42] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 20,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 18
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = false,
                Layer = 8,
                Time = 1
              }
            },
            RefEntityID = 3
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 1}
            },
            RefEntityID = 22
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 1}
            },
            RefEntityID = 23
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_50_dialog_content",
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
        [44] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_51_dialog_content",
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
        [45] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.6
              }
            },
            RefEntityID = 17
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
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
                  StartValue = 0.8
                },
                Layer = 18,
                Time = 0.3
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 19
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 19,
                Time = 0.3
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 22
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 23
          }
        },
        [46] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_52_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padi"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.7,
                  StartValue = 1
                },
                Time = 0
              },
              [2] = {
                Time = 1.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-100, 300},
                  StartValue = {0, 0}
                }
              },
              [3] = {
                Time = 1.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {100, 0},
                  StartValue = {-100, 300}
                }
              },
              [4] = {
                Time = 2.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {200, 200},
                  StartValue = {100, 0}
                }
              },
              [5] = {
                Time = 2.8,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 200},
                  StartValue = {200, 200}
                }
              }
            }
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
            RefEntityID = 22
          }
        },
        [47] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_53_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_paxi"
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
            RefEntityID = 22
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
            RefEntityID = 23
          }
        },
        [48] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_54_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padi"
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
            RefEntityID = 23
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
            RefEntityID = 22
          }
        },
        [49] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_55_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_paxi"
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
            RefEntityID = 22
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
            RefEntityID = 23
          }
        },
        [50] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_56_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padipaxi"
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
            RefEntityID = 23
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
            RefEntityID = 5
          }
        },
        [51] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 20,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
          }
        },
        [52] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 20,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 18
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 3
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.7
                },
                Time = 1,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 200}
                }
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 1}
            },
            RefEntityID = 22
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = true, Time = 1}
            },
            RefEntityID = 23
          }
        },
        [53] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_57_dialog_content",
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
        [54] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_58_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padi"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 21
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
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 50},
                  StartValue = {-200, 0}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 0},
                  StartValue = {-200, 50}
                }
              },
              [3] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 50},
                  StartValue = {-200, 0}
                }
              },
              [4] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 0},
                  StartValue = {-200, 50}
                }
              }
            },
            RefEntityID = 22
          }
        },
        [55] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_paxi"
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
            RefEntityID = 22
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
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -100},
                  StartValue = {200, -150}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -150},
                  StartValue = {200, -100}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -100},
                  StartValue = {200, -150}
                }
              },
              [4] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -150},
                  StartValue = {200, -100}
                }
              }
            },
            RefEntityID = 23
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.4}
            },
            RefEntityID = 21
          }
        },
        [56] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_60_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padi"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3},
              [2] = {PlaySound = "Once", Time = 0},
              [3] = {PlaySound = "Once", Time = 0.6}
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = {0.9, 0.9},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.3,
                  EndValue = {0.8, 0.8},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Layer = 8,
                Scale = {
                  Duration = 0.3,
                  EndValue = {0.8, 0.8},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 22
          }
        },
        [57] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_61_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padipaxi"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = {1, 1},
                  StartValue = {0.9, 0.9}
                },
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = {1, 1},
                  StartValue = {0.8, 0.8}
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 50},
                  StartValue = {-200, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 0},
                  StartValue = {-200, 50}
                }
              }
            },
            RefEntityID = 22
          },
          [5] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Scale = {
                  Duration = 0.4,
                  EndValue = {1, 1},
                  StartValue = {0.8, 0.8}
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -100},
                  StartValue = {200, -150}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -150},
                  StartValue = {200, -100}
                }
              }
            },
            RefEntityID = 23
          }
        },
        [58] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_62_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_padipaxi"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0},
              [2] = {PlaySound = "Once", Time = 0.5}
            },
            RefEntityID = 21
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = {1.1, 1.1},
                  StartValue = {1, 1}
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 50},
                  StartValue = {-200, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 0},
                  StartValue = {-200, 50}
                }
              },
              [3] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = {1.2, 1.2},
                  StartValue = {1.1, 1.1}
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 50},
                  StartValue = {-200, 0}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-200, 0},
                  StartValue = {-200, 50}
                }
              }
            },
            RefEntityID = 22
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -100},
                  StartValue = {200, -150}
                }
              },
              [2] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -150},
                  StartValue = {200, -100}
                }
              },
              [3] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = {1.2, 1.2},
                  StartValue = {1.1, 1.1}
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -100},
                  StartValue = {200, -150}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.1,
                  EndValue = {200, -150},
                  StartValue = {200, -100}
                }
              }
            },
            RefEntityID = 23
          }
        },
        [59] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_63_dialog_content",
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
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
          }
        },
        [60] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
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
        },
        [61] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 18,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 8
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 1
              }
            },
            RefEntityID = 9
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 22
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 23
          }
        },
        [62] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 12,
                Time = 0
              }
            }
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
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 8,
                LoopAnimation = "Story_think",
                Position = {50, -300},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [63] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_65_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -30},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, -30}
                }
              }
            }
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
            RefEntityID = 20
          }
        },
        [64] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_66_dialog_content",
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
        [65] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_67_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
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
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [66] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_68_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [67] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_69_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [68] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_70_dialog_content",
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
                  Strength = {80, 40},
                  Vibrato = 60,
                  fadeOut = true
                },
                Time = 0
              }
            }
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
            RefEntityID = 20
          }
        },
        [69] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_71_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
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
            RefEntityID = 20
          }
        },
        [70] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [71] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_73_dialog_content",
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
                Scale = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 200},
                  StartValue = {0, 0}
                }
              }
            }
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
            RefEntityID = 20
          }
        },
        [72] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_74_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
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
            RefEntityID = 20
          }
        },
        [73] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_75_dialog_content",
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
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-200, -300},
                  StartValue = {40, -300}
                }
              },
              [2] = {
                BrightnessChange = {
                  Duration = 0.2,
                  EndValue = 0.2,
                  StartValue = 1
                },
                Time = 0.5
              }
            },
            RefEntityID = 20
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {-200, 200},
                  StartValue = {0, 200}
                }
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [74] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_76_dialog_content",
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
        [75] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_77_dialog_content",
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
        [76] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {-200, 200}
                }
              }
            }
          }
        },
        [77] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_78_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                BrightnessChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0.2
                },
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {50, -300},
                  StartValue = {-200, -300}
                }
              }
            },
            RefEntityID = 20
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [78] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_79_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [79] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_80_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_think",
                Scale = {
                  Duration = 0.3,
                  EndValue = {1.2, 1.2},
                  StartValue = {1.05, 1.05}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -250},
                  StartValue = {50, -300}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -300},
                  StartValue = {50, -250}
                }
              }
            },
            RefEntityID = 20
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          }
        },
        [80] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_81_dialog_content",
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
            RefEntityID = 20
          }
        },
        [81] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_82_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
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
                LoopAnimation = "Story_sign",
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [82] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_83_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [83] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 50,
                Time = 0.6
              }
            },
            RefEntityID = 17
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
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
                  StartValue = 0.8
                },
                Layer = 18,
                Time = 0.3
              }
            },
            RefEntityID = 18
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0.3}
            },
            RefEntityID = 19
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 19,
                Time = 0.3
              }
            },
            RefEntityID = 3
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.3}
            },
            RefEntityID = 20
          }
        },
        [84] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_84_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 2,
                StartBgm = 16,
                Time = 0
              }
            }
          }
        },
        [85] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 1000},
                Scale = {
                  Duration = 0,
                  EndValue = 0.3,
                  StartValue = 0.3
                },
                Time = 0
              }
            }
          }
        },
        [86] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 200},
                  StartValue = {0, 1000}
                }
              }
            }
          }
        },
        [87] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 800},
                  StartValue = {0, -1500}
                }
              }
            }
          }
        },
        [88] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Time = 0
              }
            }
          }
        },
        [89] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_85_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [90] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_86_dialog_content",
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
            RefEntityID = 20
          }
        },
        [91] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Layer = 20,
                PlayAnimation = "uieff_Story_blackscreen_right_in",
                Time = 0
              }
            },
            RefEntityID = 11
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.7
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 200}
                }
              }
            }
          }
        },
        [92] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 20,
                PlayAnimation = "uieff_Story_blackscreen_left_out",
                Time = 1
              }
            },
            RefEntityID = 11
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 18
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 3
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
                BrightnessChange = {
                  Duration = 0,
                  EndValue = 1,
                  StartValue = 1
                },
                Layer = 8,
                LoopAnimation = "Story_think",
                Position = {50, -300},
                Scaling = {1.05, 1.05},
                Time = 1
              }
            },
            RefEntityID = 20
          }
        },
        [93] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_87_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [94] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [95] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_89_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [96] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_90_dialog_content",
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
                Content = "ui_story_32190401_91_option_content",
                NextParagraphID = 5
              },
              [2] = {
                Content = "ui_story_32190401_93_option_content",
                NextParagraphID = 6
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        }
      }
    },
    [5] = {
      [1] = {
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
      ComponentID = "0",
      ID = 5,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_92_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_norm",
                Scale = {
                  Duration = 0.4,
                  EndValue = {1.1, 1.1},
                  StartValue = {1.05, 1.05}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -250},
                  StartValue = {50, -300}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -300},
                  StartValue = {50, -250}
                }
              }
            },
            RefEntityID = 20
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          },
          NextParagraphID = 7
        }
      }
    },
    [6] = {
      [1] = {
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
      ComponentID = "0",
      ID = 6,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_94_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                LoopAnimation = "Story_norm",
                Scale = {
                  Duration = 0.4,
                  EndValue = {1.1, 1.1},
                  StartValue = {1.05, 1.05}
                },
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -250},
                  StartValue = {50, -300}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {50, -300},
                  StartValue = {50, -250}
                }
              }
            },
            RefEntityID = 20
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 21
          },
          NextParagraphID = 7
        }
      }
    },
    [7] = {
      [1] = {
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
      ComponentID = "0",
      ID = 7,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_95_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.4,
                  EndValue = {1.05, 1.05},
                  StartValue = {1.1, 1.1}
                },
                Time = 0
              }
            },
            RefEntityID = 20
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_96_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_97_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_98_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_99_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifeier"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.6,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 2,
                  EndValue = {0, 300},
                  StartValue = {0, 0}
                }
              }
            }
          }
        },
        [6] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 9
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
                Layer = 2,
                Time = 0.5
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.5}
            },
            RefEntityID = 20
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.6
                },
                Time = 0.5,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 300}
                }
              }
            }
          }
        },
        [7] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 2,
                Time = 1
              }
            },
            RefEntityID = 10
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_100_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
                LoopAnimation = "Story_think",
                Position = {0, -400},
                Scaling = {1, 1},
                Time = 0
              }
            },
            RefEntityID = 3
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_102_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_103_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          },
          [2] = {
            KeyFrames = {
              [1] = {LoopAnimation = "Story_norm", Time = 0}
            },
            RefEntityID = 3
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_104_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_105_dialog_content",
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
            RefEntityID = 3
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_106_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
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
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_107_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_32190401_108_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yisitawan"
          }
        },
        [17] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Time = 0
              },
              [2] = {
                Active = true,
                Layer = 50,
                Time = 2.6
              }
            },
            RefEntityID = 10
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
