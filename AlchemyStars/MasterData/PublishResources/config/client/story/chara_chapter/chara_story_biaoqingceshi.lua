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
      Name = "卡戎",
      Resource = "1600251_spine_idle.prefab",
      Type = "Spine"
    },
    [3] = {
      EntityID = 4,
      Name = "舰桥晚上",
      Resource = "StoryBGjuxiangjianqiao2.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 5,
      Name = "舰桥早上",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 6,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [6] = {
      EntityID = 7,
      Name = "舰桥早上1",
      Resource = "StoryBGjuxiangjianqiao.prefab",
      Type = "Picture"
    },
    [7] = {
      EntityID = 8,
      Name = "黑幕2",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [8] = {
      EntityID = 9,
      Name = "舰桥晚上1",
      Resource = "StoryBGjuxiangjianqiao2.prefab",
      Type = "Picture"
    },
    [9] = {
      EntityID = 10,
      Name = "黑幕11",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [10] = {
      EntityID = 11,
      Name = "黑幕12",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [11] = {
      EntityID = 12,
      Name = "黑幕13",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [12] = {
      EntityID = 13,
      Name = "黑幕21",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [13] = {
      EntityID = 14,
      Name = "黑幕22",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [14] = {
      EntityID = 15,
      Name = "黑幕23",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [15] = {
      EntityID = 16,
      FitSize = false,
      Name = "伊伦汀",
      Resource = "1600891_spine_idle.prefab",
      Type = "Spine"
    }
  },
  ID = 234,
  Name = "chara_story_biaoqingceshi",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "表情测试",
      Sections = {
        [1] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 0,
                  StartValue = 1
                },
                Layer = 5,
                Time = 1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, -500},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Active = true,
                Layer = 5,
                Time = 0
              }
            },
            RefEntityID = 5
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.3,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 5,
                Time = 1,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 0},
                  StartValue = {0, 500}
                }
              }
            },
            RefEntityID = 4
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 4,
                Time = 0
              }
            },
            RefEntityID = 6
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 50,
                Time = 0
              }
            },
            RefEntityID = 16
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_1_dialog_content",
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
                StartShake = {
                  Duration = 3,
                  FadeOut = false,
                  HandHeld = true,
                  RandomNess = 100,
                  Strength = {0, 10},
                  Vibrato = 10
                },
                Time = 0
              }
            }
          },
          [3] = {
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
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 10,
                Time = 0
              }
            },
            RefEntityID = 8
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_2_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 7
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
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 51,
                LoopAnimation = "Story_surprise",
                Position = {0, -580},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_3_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_4_dialog_content",
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
                Layer = 51,
                LoopAnimation = "Story_surprise",
                Position = {0, -580},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 7
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Layer = 50,
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 9
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_5_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_6_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 7
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
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                LoopAnimation = "Story_surprise",
                Position = {0, -580},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_7_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 7
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_8_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 7
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
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 9
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 51,
                LoopAnimation = "Story_surprise",
                Position = {0, -580},
                Scaling = {0.6, 0.6},
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                StopShake = {Duration = 0.1, FadeOut = true},
                Time = 0
              }
            }
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_7_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {400, 0},
                  StartValue = {0, 0}
                }
              }
            },
            RefEntityID = 9
          },
          [3] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {-400, 0}
                }
              }
            },
            RefEntityID = 7
          },
          [4] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 1,
                  fadeOut = true,
                  Strength = {80, 0},
                  Vibrato = 60
                },
                Time = 0.1
              }
            }
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_39990401_7_dialog_content",
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
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Scale = {
                  Duration = 0.1,
                  EndValue = {1.3, 1.3},
                  StartValue = {1, 1}
                },
                Time = 0
              }
            },
            RefEntityID = 7
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
                Position = {0, 0},
                Scale = {
                  Duration = 0.1,
                  EndValue = {1, 1},
                  StartValue = {0.7, 0.7}
                },
                Time = 0.1
              }
            },
            RefEntityID = 9
          }
        },
        [12] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 2,
                  fadeOut = true,
                  Strength = {99, 99},
                  Vibrato = 99
                },
                Time = 2.3
              },
              [2] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.5,
                  StartValue = 1
                },
                Shake = {
                  Duration = 2,
                  fadeOut = true,
                  Strength = {40, 40},
                  Vibrato = 40
                },
                Time = 0
              }
            }
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.1,
                  EndValue = 0,
                  StartValue = 1
                },
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [13] = {
          [1] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.5
                },
                Time = 0
              }
            }
          }
        },
        [14] = {
          [1] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {0, 800}
                }
              }
            },
            RefEntityID = 7
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
                Time = 2
              }
            },
            RefEntityID = 9
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.5,
                  fadeOut = true,
                  Strength = {80, 80},
                  Vibrato = 60
                },
                Time = 2.1
              }
            }
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_1_1_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_anger",
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
                  EndValue = 0.8,
                  StartValue = 0
                },
                Layer = 99,
                Position = {0, 1650},
                Time = 0
              }
            },
            RefEntityID = 10
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                AlphaChange = {
                  Duration = 0.2,
                  EndValue = 0.8,
                  StartValue = 0
                },
                Layer = 99,
                Position = {0, -1650},
                Time = 0
              }
            },
            RefEntityID = 13
          }
        },
        [16] = {
          [1] = {
            DialogContentStr = "ui_story_1_1_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 99,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 1850},
                  StartValue = {0, 1650}
                }
              }
            },
            RefEntityID = 10
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 99,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -1450},
                  StartValue = {0, -1650}
                }
              }
            },
            RefEntityID = 13
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_1_1_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_surprise",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 99,
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, -1850},
                  StartValue = {0, -1450}
                }
              }
            },
            RefEntityID = 13
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 99,
                Time = 0,
                Translate = {
                  Duration = 0.4,
                  EndValue = {0, 1450},
                  StartValue = {0, 1850}
                }
              }
            },
            RefEntityID = 10
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_1_1_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 99,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, -1650},
                  StartValue = {0, -1850}
                }
              }
            },
            RefEntityID = 13
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 99,
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 1650},
                  StartValue = {0, 1450}
                }
              }
            },
            RefEntityID = 10
          }
        }
      }
    },
    [2] = {
      ID = 2,
      Name = "普通摇头",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.3,
                  EndValue = {150, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 0},
                  StartValue = {150, 0}
                }
              },
              [3] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.3,
                  EndValue = {-150, 0},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.9,
                Translate = {
                  Duration = 0.3,
                  EndValue = {0, 0},
                  StartValue = {-150, 0}
                }
              }
            }
          }
        }
      }
    },
    [3] = {
      ID = 3,
      Name = "普通点头",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 150},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 150}
                }
              },
              [3] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 150},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.2,
                  EndValue = {0, 0},
                  StartValue = {0, 150}
                }
              }
            }
          }
        }
      }
    },
    [4] = {
      ID = 4,
      Name = "剧烈摇头",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_9_1_21_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 0.1,
                  EndValue = {150, 0},
                  StartValue = {0, 0}
                }
              },
              [2] = {
                Time = 0.1,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {150, 0}
                }
              },
              [3] = {
                Time = 0.2,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-150, 0},
                  StartValue = {0, 0}
                }
              },
              [4] = {
                Time = 0.3,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {-150, 0}
                }
              },
              [5] = {
                Time = 0.4,
                Translate = {
                  Duration = 0.1,
                  EndValue = {150, 0},
                  StartValue = {0, 0}
                }
              },
              [6] = {
                Time = 0.5,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {150, 0}
                }
              },
              [7] = {
                Time = 0.6,
                Translate = {
                  Duration = 0.1,
                  EndValue = {-150, 0},
                  StartValue = {0, 0}
                }
              },
              [8] = {
                Time = 0.7,
                Translate = {
                  Duration = 0.1,
                  EndValue = {0, 0},
                  StartValue = {-150, 0}
                }
              }
            }
          }
        }
      }
    }
  },
  StartParagraph = 1
}
