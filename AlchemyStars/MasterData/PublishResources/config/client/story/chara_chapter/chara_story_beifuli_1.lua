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
      Name = "贝芙丽-待替换",
      Resource = "beifuli_spine_idle.prefab",
      Type = "Spine"
    },
    [3] = {
      EntityID = 3,
      Name = "黑幕",
      Resource = "BlackPic.prefab",
      Type = "Picture"
    },
    [4] = {
      EntityID = 4,
      FitSize = true,
      Name = "巨像走廊背景",
      Resource = "StoryBGFengchuan.prefab",
      Type = "Picture"
    },
    [5] = {
      EntityID = 5,
      FitSize = false,
      Name = "日常",
      Resource = "38",
      Type = "Sound"
    },
    [6] = {
      EntityID = 6,
      FitSize = false,
      Name = "薇丝立绘",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    }
  },
  ID = 30870101,
  Name = "chara_story_beifuli_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_1_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 1.5
              },
              [2] = {ShowContent = 0.02, Time = 1.7}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
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
                Time = 0.5
              },
              [2] = {
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
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0
                },
                Brightness = 0.2,
                Layer = 11,
                Position = {0, -200},
                Scaling = {0.95, 0.95},
                Time = 0.4
              }
            },
            RefEntityID = 2
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Layer = 5,
                Time = 0
              }
            },
            RefEntityID = 4
          },
          [5] = {
            BgmTrack = true,
            KeyFrames = {
              [1] = {
                FadeTime = 1,
                StartBgm = 5,
                Time = 1
              },
              [2] = {
                FadeTime = 0.5,
                StopBgm = true,
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_2_dialog_content",
            KeyFrames = {
              [1] = {
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
            DialogContentStr = "ui_story_30870101_3_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_4_dialog_content",
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
            RefEntityID = 2
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_5_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_6_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_7_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_8_dialog_content",
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
                Affinity = 30,
                Content = "ui_story_30870101_9_option_content",
                NextParagraphID = 2,
                PetID = 1500871
              },
              [2] = {
                Affinity = 50,
                Content = "ui_story_30870101_14_option_content",
                NextParagraphID = 3,
                PetID = 1500871
              }
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
            RefEntityID = 2
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
            DialogContentStr = "ui_story_30870101_10_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_11_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_12_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_13_dialog_content",
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
            RefEntityID = 2
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
            DialogContentStr = "ui_story_30870101_15_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_16_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_17_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_18_dialog_content",
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
            RefEntityID = 2
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
            DialogContentStr = "ui_story_30870101_19_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_20_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_21_dialog_content",
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
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_22_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 2,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_23_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_24_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_25_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_26_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_27_dialog_content",
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
                Affinity = 50,
                Content = "ui_story_30870101_28_option_content",
                NextParagraphID = 5,
                PetID = 1500871
              },
              [2] = {
                Affinity = 30,
                Content = "ui_story_30870101_32_option_content",
                NextParagraphID = 6,
                PetID = 1500871
              }
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
            RefEntityID = 2
          }
        }
      }
    },
    [5] = {
      ID = 5,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_29_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
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
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_30_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_31_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          NextParagraphID = 7
        }
      }
    },
    [6] = {
      ID = 6,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_33_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_34_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_35_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          NextParagraphID = 7
        }
      }
    },
    [7] = {
      ID = 7,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_36_dialog_content",
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
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_37_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_38_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_39_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_40_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_41_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_42_dialog_content",
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {40, 40},
                  Vibrato = 20
                },
                Time = 0
              }
            }
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_43_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_44_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_45_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_46_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_47_dialog_content",
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Shake = {
                  Duration = 0.2,
                  fadeOut = false,
                  Strength = {40, 40},
                  Vibrato = 20
                },
                Time = 0
              }
            }
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_48_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_49_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            Options = {
              [1] = {
                Content = "ui_story_30870101_50_option_content",
                NextParagraphID = 8
              },
              [2] = {
                Content = "ui_story_30870101_52_option_content",
                NextParagraphID = 9
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        }
      }
    },
    [8] = {
      ID = 8,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_51_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          NextParagraphID = 10
        }
      }
    },
    [9] = {
      ID = 9,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_53_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          NextParagraphID = 10
        }
      }
    },
    [10] = {
      ID = 10,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_54_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_55_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_56_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_57_dialog_content",
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
            RefEntityID = 2
          }
        },
        [5] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_58_dialog_content",
            KeyFrames = {
              [1] = {
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
            DialogContentStr = "ui_story_30870101_59_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_60_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_61_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_62_dialog_content",
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
            RefEntityID = 2
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_63_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_64_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_65_dialog_content",
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
            RefEntityID = 2
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_66_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [14] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_67_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_68_dialog_content",
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
                Content = "ui_story_30870101_69_option_content",
                NextParagraphID = 11
              },
              [2] = {
                Content = "ui_story_30870101_71_option_content",
                NextParagraphID = 12
              }
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
            RefEntityID = 2
          }
        }
      }
    },
    [11] = {
      ID = 11,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_70_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          },
          NextParagraphID = 13
        }
      }
    },
    [12] = {
      ID = 12,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_72_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          },
          NextParagraphID = 13
        }
      }
    },
    [13] = {
      ID = 13,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_73_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [2] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_74_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [3] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_75_dialog_content",
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
            RefEntityID = 2
          }
        },
        [4] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_76_dialog_content",
            KeyFrames = {
              [1] = {
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
            DialogContentStr = "ui_story_30870101_77_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [6] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_78_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [7] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_79_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [8] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_80_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [9] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_81_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [10] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_82_dialog_content",
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
            RefEntityID = 2
          }
        },
        [11] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_83_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [12] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_84_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [13] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_85_dialog_content",
            KeyFrames = {
              [1] = {
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
            DialogContentStr = "ui_story_30870101_86_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [15] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_87_dialog_content",
            KeyFrames = {
              [1] = {
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
            DialogContentStr = "ui_story_30870101_88_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 1,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [17] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_89_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [18] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_90_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [19] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_91_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [20] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_92_dialog_content",
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.1,
                  EndValue = 1,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [21] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_93_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [22] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_94_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [23] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_95_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [24] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_96_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [25] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_97_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [26] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_98_dialog_content",
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.1,
                  EndValue = 0.8,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [27] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_99_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [28] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_100_dialog_content",
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
            RefEntityID = 2
          }
        },
        [29] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_101_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [30] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_102_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_angry",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [31] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_103_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_norm",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [32] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_104_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [33] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_105_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [34] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_106_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          },
          [2] = {
            KeyFrames = {
              [1] = {
                Active = true,
                LoopAnimation = "Story_why",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [35] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_107_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
          }
        },
        [36] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_108_dialog_content",
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.2,
                  EndValue = 1,
                  StartValue = 0.8
                },
                Time = 0
              }
            }
          }
        },
        [37] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_109_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_smile",
                Time = 0
              }
            },
            RefEntityID = 2
          }
        },
        [38] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_110_dialog_content",
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
            RefEntityID = 2
          }
        },
        [39] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_111_dialog_content",
            KeyFrames = {
              [1] = {
                ShowContent = 0.02,
                ShowSpeakerName = 0,
                Time = 0
              }
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_you"
          }
        },
        [40] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_112_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
                LoopAnimation = "Story_embarrassed",
                Time = 0
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.9,
                  StartValue = 1
                },
                Time = 0
              }
            }
          }
        },
        [41] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_113_dialog_content",
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
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.8,
                  StartValue = 0.9
                },
                Time = 0
              }
            }
          }
        },
        [42] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_114_dialog_content",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_beifuli"
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
              }
            },
            RefEntityID = 2
          },
          [3] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Scale = {
                  Duration = 0.5,
                  EndValue = 0.7,
                  StartValue = 0.8
                },
                Time = 0
              }
            }
          }
        },
        [43] = {
          [1] = {
            DialogContentStr = "ui_story_30870101_115_dialog_content",
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
            RefEntityID = 2
          }
        },
        [44] = {
          [1] = {
            KeyFrames = {
              [1] = {
                AlphaChange = {
                  Duration = 2,
                  EndValue = 1,
                  StartValue = 0
                },
                Time = 0
              },
              [2] = {Time = 3}
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
