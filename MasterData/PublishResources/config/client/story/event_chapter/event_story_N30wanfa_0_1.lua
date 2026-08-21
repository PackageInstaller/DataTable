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
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [3] = {
      EntityID = 3,
      FitSize = true,
      Name = "影镇街道",
      Resource = "StoryBGyingzhenjiedao.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "莺歌",
      Resource = "yingge_n24_spine_idle.prefab",
      Type = "Spine"
    },
    [5] = {
      EntityID = 9,
      FitSize = false,
      Name = "昭",
      Resource = "zhao_n24_spine_idle.prefab",
      Type = "Spine"
    },
    [6] = {
      EntityID = 10,
      FitSize = false,
      Name = "阿纳托利",
      Resource = "anatuoli_n17_spine_idle.prefab",
      Type = "Spine"
    },
    [7] = {
      EntityID = 13,
      FitSize = false,
      Name = "风船BGM",
      Resource = "26",
      Type = "Sound"
    },
    [8] = {
      EntityID = 14,
      Name = "阿克西娅",
      Resource = "akexiya_n24_spine_idle.prefab",
      Type = "Spine"
    },
    [9] = {
      EntityID = 15,
      Name = "列奥",
      Resource = "lieao_n24_spine_idle.prefab",
      Type = "Spine"
    },
    [10] = {
      EntityID = 16,
      Name = "贡露立绘",
      Resource = "gonglu_spine_idle.prefab",
      Type = "Spine"
    },
    [11] = {
      EntityID = 17,
      Name = "闪回蒙版",
      Resource = "UIEff_Huiyi.prefab",
      Type = "Effect"
    },
    [12] = {
      EntityID = 18,
      Name = "通讯连接音效",
      Resource = "10078",
      Type = "Sound"
    },
    [13] = {
      EntityID = 19,
      FitSize = false,
      Name = "数据传输",
      Resource = "10255",
      Type = "Sound"
    },
    [14] = {
      EntityID = 20,
      Name = "电磁干扰",
      Resource = "UIEff_ganrao.prefab",
      Type = "Effect"
    },
    [15] = {
      EntityID = 21,
      Name = "入侵效果",
      Resource = "UIEff_ruqin.prefab",
      Type = "Effect"
    },
    [16] = {
      EntityID = 22,
      Name = "白底",
      Resource = "WhitePic.prefab",
      Type = "Picture"
    },
    [17] = {
      EntityID = 23,
      FitSize = false,
      Name = "眨眼",
      Resource = "uieff_Story_Blink.prefab",
      Type = "Effect"
    },
    [18] = {
      EntityID = 24,
      Name = "通讯器两声杂音",
      Resource = "10175",
      Type = "Sound"
    },
    [19] = {
      EntityID = 25,
      FitSize = false,
      Name = "闹铃",
      Resource = "10065",
      Type = "Sound"
    },
    [20] = {
      EntityID = 26,
      FitSize = true,
      Name = "实验室背景",
      Resource = "StoryBGqiguangshiyan.prefab",
      Type = "Picture"
    },
    [21] = {
      EntityID = 27,
      Name = "闪回音效",
      Resource = "10019",
      Type = "Sound"
    }
  },
  ID = 50500001,
  Name = "event_story_N30wanfa_0_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 1
              }
            },
            RefEntityID = 1
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
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1.5,
                StartBgm = 13,
                Time = 0.5
              },
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          },
          [4] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1.1}
            },
            RefEntityID = 18
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 35,
                Time = 0
              }
            },
            RefEntityID = 22
          },
          [6] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 37,
                Time = 1
              },
              [2] = {Active = false, Time = 1.6}
            },
            RefEntityID = 20
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 36,
                Time = 1
              }
            },
            RefEntityID = 21
          },
          [8] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Blink = {
                  Duration = 0,
                  EndValue = 0.7,
                  StartValue = 0.7
                },
                Layer = 45,
                Time = 0
              }
            },
            RefEntityID = 23
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 1},
              [2] = {StopSound = true, Time = 1.3}
            },
            RefEntityID = 25
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_2_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 19
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                Time = 0
              }
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 1,
                  EndValue = 0.8,
                  StartValue = 0.2
                },
                Time = 0
              },
              [2] = {
                Active = true,
                AlphaChange = {
                  Duration = 1,
                  EndValue = 0,
                  StartValue = 0.8
                },
                Time = 1.5
              }
            },
            RefEntityID = 22
          },
          [3] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                BrightnessChange = {
                  Duration = 1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 2,
                Time = 1.4
              }
            },
            RefEntityID = 3
          }
        },
        [4] = {
          [1] = {
            ButtonVisible = true,
            DialogContentStr = "ui_story_5050_50500001_4_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
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
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 20
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 21
          },
          [5] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_zhao"
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
                Position = {400, -520},
                Scaling = {1.65, 1.65},
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
                Layer = 9,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-400, -400},
                  StartValue = {0, -400}
                }
              }
            },
            RefEntityID = 4
          },
          [4] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 20
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0},
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 21
          },
          [6] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_6_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_anatuoli"
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
                  EndValue = {0, -520},
                  StartValue = {400, -520}
                }
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Time = 0,
                Translate = {
                  Duration = 0.5,
                  EndValue = {-550, -400},
                  StartValue = {-400, -400}
                }
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
                Position = {550, -480},
                Scaling = {1.05, 1.05},
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = true, Time = 0},
              [2] = {Active = false, Time = 0.5}
            },
            RefEntityID = 20
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0},
              [2] = {Active = false, Time = 0.3}
            },
            RefEntityID = 21
          },
          [7] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 24
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_7_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_anatuoli"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_8_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0.4
              },
              [2] = {ShowContent = 0.02, Time = 0.6}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_akexiya"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Alpha = 1,
                Brightness = 1,
                Layer = 8,
                Position = {550, -280},
                Scaling = {0.78, 0.78},
                Time = 0.2
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
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 7,
                Position = {0, -400},
                Time = 0.2
              }
            },
            RefEntityID = 4
          },
          [5] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 9
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2}
            },
            RefEntityID = 10
          },
          [7] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Brightness = 0.2,
                Layer = 7,
                Position = {-550, -500},
                Scaling = {1.05, 1.05},
                Time = 0.2
              }
            },
            RefEntityID = 15
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_9_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieao"
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
            RefEntityID = 14
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
            RefEntityID = 15
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_lieao"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_11_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
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
            RefEntityID = 4
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
            RefEntityID = 15
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_5050_50500001_12_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_yingge"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 49,
                Time = 0.2
              },
              [2] = {Active = false, Time = 1.8}
            },
            RefEntityID = 17
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
                Brightness = 1,
                Layer = 8,
                LoopAnimation = "Story_think",
                Position = {0, -400},
                Time = 0.2
              },
              [2] = {Active = false, Time = 1.8}
            },
            RefEntityID = 16
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
              },
              [3] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 1.6
              },
              [4] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 1.9
              }
            },
            RefEntityID = 2
          },
          [5] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 2,
                Time = 0.2
              },
              [2] = {Active = false, Time = 1.8}
            },
            RefEntityID = 26
          },
          [6] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2},
              [2] = {Active = true, Time = 1.8}
            },
            RefEntityID = 15
          },
          [7] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2},
              [2] = {Active = true, Time = 1.8}
            },
            RefEntityID = 14
          },
          [8] = {
            KeyFrames = {
              [1] = {Active = false, Time = 0.2},
              [2] = {Active = true, Time = 1.8}
            },
            RefEntityID = 4
          },
          [9] = {
            KeyFrames = {
              [1] = {PlaySound = "Once", Time = 0}
            },
            RefEntityID = 27
          }
        },
        [13] = {
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
    }
  },
  StartParagraph = 1
}
