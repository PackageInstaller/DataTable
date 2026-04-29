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
      EntityID = 3,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 4,
      FitSize = false,
      Name = "北境荒原夜",
      Resource = "StoryBGbeijingshiwaiye.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 5,
      FitSize = true,
      Name = "阴云天空",
      Resource = "StoryBGyinyun.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 6,
      FitSize = false,
      Name = "暴风雪",
      Resource = "uieff_Story_SnowStorm.prefab",
      Type = "Effect"
    },
    [6] = {
      EntityID = 7,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [7] = {
      EntityID = 8,
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [8] = {
      EntityID = 9,
      FitSize = false,
      Name = "模糊特效",
      Resource = "uieff_Story_Blur.prefab",
      Type = "Effect"
    },
    [9] = {
      EntityID = 10,
      FitSize = false,
      Name = "北境CG1",
      Resource = "cg_beijingbingyuan_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 11,
      FitSize = false,
      Name = "北境CG2",
      Resource = "cg_beijingbingyuan_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 12,
      FitSize = false,
      Name = "live光特效",
      Resource = "uieff_wutaicaihong.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 13,
      FitSize = false,
      Name = "黑暗野外",
      Resource = "bg_anguichao_spine_idle.prefab",
      Type = "Spine"
    },
    [13] = {
      EntityID = 14,
      FitSize = false,
      Name = "白夜城CG",
      Resource = "CGbaiyedating.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 15,
      FitSize = false,
      Name = "风",
      Resource = "10085",
      Type = "Sound"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "n35bgm",
      Resource = "504",
      Type = "Sound"
    },
    [16] = {
      EntityID = 17,
      FitSize = false,
      Name = "踩雪脚步声",
      Resource = "10165",
      Type = "Sound"
    },
    [17] = {
      EntityID = 19,
      FitSize = false,
      Name = "极昼散射CG",
      Resource = "DamokelisiCG2.prefab",
      Type = "Picture"
    },
    [18] = {
      EntityID = 20,
      FitSize = false,
      Name = "赤眼谷",
      Resource = "StoryBGchiyangu.prefab",
      Type = "Picture"
    },
    [19] = {
      EntityID = 21,
      FitSize = false,
      Name = "赤眼谷CG",
      Resource = "StoryBGchiyangu.prefab",
      Type = "Picture"
    },
    [20] = {
      EntityID = 22,
      FitSize = false,
      Name = "极光CG",
      Resource = "CGkaichangjiguang.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 23,
      FitSize = false,
      Name = "意识空间",
      Resource = "StoryBGyigeyishikongjian.prefab",
      Type = "Picture"
    },
    [22] = {
      EntityID = 25,
      FitSize = false,
      Name = "下雪",
      Resource = "uieff_cg_snow.prefab",
      Type = "Effect"
    },
    [23] = {
      EntityID = 26,
      Name = "N35 1_1视频",
      Resource = "N35_1_1_JPVideo",
      Type = "Usme"
    }
  },
  ID = 50610101,
  Name = "event_story_N35bingfengzhixi_1_1",
  Paragraphs = {
    [1] = {
      ComponentID = "0",
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.4
              },
              [2] = {ShowContent = 0.02, Time = 1.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 3
          },
          [3] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = true, Time = 4}
            },
            RefEntityID = 3
          }
        },
        [3] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.1
              }
            },
            RefEntityID = 3
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0
              },
              [2] = {Active = true, Time = 2}
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 3,
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
                  HandHeld = false,
                  RandomNess = 90,
                  Strength = {1, 1},
                  Vibrato = 2
                },
                Time = 0
              }
            }
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 40,
                Position = {600, 800},
                Scaling = {2, 2},
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 1,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Layer = 55,
                Time = 0
              }
            },
            RefEntityID = 8
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 15
          },
          [8] = {
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
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 2.1
              },
              [2] = {ShowSpeakerName = 0.2, Time = 1.9}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.9
              }
            },
            RefEntityID = 5
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2.5,
                  EndValue = {1.15, 1.15},
                  StartValue = {1.1, 1.1}
                },
                Time = 1.1,
                Translate = {
                  Duration = 1.5,
                  EndValue = {0, 10},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.7
                },
                Layer = 55,
                Time = 0
              },
              [2] = {
                Blink = {
                  Duration = 1,
                  EndValue = 0.7,
                  StartValue = 0
                },
                Time = 1.1
              }
            },
            RefEntityID = 8
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 45,
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.5,
                    EndValue = 1,
                    StartValue = 0,
                    Var = "AlphaValue"
                  }
                },
                Time = 0
              },
              [2] = {
                RawImageMatAnim = {
                  [1] = {
                    Duration = 0.5,
                    EndValue = 0,
                    StartValue = 1,
                    Var = "AlphaValue"
                  }
                },
                Time = 1
              }
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.6},
              [2] = {PlaySound = "Once", Time = 2.2},
              [3] = {PlaySound = "Once", Time = 2.8}
            },
            RefEntityID = 17
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 1
              },
              [2] = {
                Time = 1.1,
                Translate = {
                  Duration = 0.5,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              },
              [3] = {
                Time = 1.6,
                Translate = {
                  Duration = 0.6,
                  EndValue = {0, 0},
                  StartValue = {0, 20}
                }
              },
              [4] = {
                Time = 2.2,
                Translate = {
                  Duration = 0.6,
                  EndValue = {0, 20},
                  StartValue = {0, 0}
                }
              },
              [5] = {
                Time = 2.8,
                Translate = {
                  Duration = 0.6,
                  EndValue = {0, 0},
                  StartValue = {0, 20}
                }
              }
            }
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 1.2
              },
              [2] = {ShowSpeakerName = 0.2, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
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
              [2] = {
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.1
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Scaling = {1.5, 1.5},
                Time = 1
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 6
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                FullScreen = true,
                Layer = 30,
                LoopAnimation = "beijing",
                Scaling = {0.6, 0.6},
                Time = 1,
                Translate = {
                  Duration = 2,
                  EndValue = {0, -20},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 1}
            },
            RefEntityID = 8
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0, FadeOut = false},
                Time = 1
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 33,
                Time = 1
              }
            },
            RefEntityID = 25
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.5
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.6
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Position = {0, 650},
                Scaling = {1.6, 1.6},
                Time = 0.5
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 30,
                LoopAnimation = "nvwang",
                Scaling = {1, 1},
                Time = 1.1,
                Translate = {
                  Duration = 1.5,
                  EndValue = {-370, 0},
                  StartValue = {-360, 0}
                }
              }
            },
            RefEntityID = 11
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0.2
              },
              [2] = {ShowSpeakerName = 0.2, Time = 0}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 3,
                  EndValue = {0, 200},
                  StartValue = {0, 0}
                }
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 1.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 36,
                Time = 0
              }
            },
            RefEntityID = 12
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.06,
                ShowSpeakerName = 0,
                Time = 1.2
              },
              [2] = {ShowSpeakerName = 0.2, Time = 1}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0.7
              }
            },
            RefEntityID = 3
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 12
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 11
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 10
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 35,
                Position = {200, 0},
                Scaling = {1.2, 1.2},
                Time = 3
              }
            },
            RefEntityID = 13
          },
          [7] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Position = {0, 0},
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 1
                },
                Time = 0.6
              }
            }
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 36,
                Scaling = {0.6, 0.6},
                Time = 4.5
              }
            },
            RefEntityID = 14
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 37,
                Time = 6.3
              }
            },
            RefEntityID = 19
          },
          [10] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.5,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 45,
                Time = 8
              }
            },
            RefEntityID = 21
          },
          [11] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 34,
                Time = 0.6
              }
            },
            RefEntityID = 22
          },
          [12] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.6}
            },
            RefEntityID = 25
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
                Layer = 46,
                Time = 0
              }
            },
            RefEntityID = 23
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
          },
          [2] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 22
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 21
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 20
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 19
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 14
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0}
            },
            RefEntityID = 13
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 20,
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [9] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 30,
                Time = 0
              }
            },
            RefEntityID = 8
          },
          NextParagraphID = 2
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_5061_50610101_14_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_unknown"
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
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                Time = 0.3
              }
            },
            RefEntityID = 26
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
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 52,
                Time = 0
              },
              [2] = {
                Active = true,
                Layer = 50,
                Time = 79
              },
              [3] = {
                Alpha = 1,
                Layer = 50,
                Time = 1.4
              }
            },
            RefEntityID = 3
          }
        }
      }
    }
  },
  SkipBlockIDs = {2},
  StartParagraph = 1
}
