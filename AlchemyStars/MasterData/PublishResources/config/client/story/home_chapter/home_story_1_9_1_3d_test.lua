return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "HomeStoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      EntityID = 36,
      Name = "卡莲",
      Resource = "1600061.prefab",
      Type = "Model",
      SubType = "Pet",
      PetID = 1600061
    },
    [3] = {
      EntityID = 37,
      Name = "加载一个泷",
      Resource = "1500711.prefab",
      Type = "Model",
      SubType = "Pet",
      PetID = 1500711
    },
    [4] = {
      EntityID = 38,
      Name = "加载一个主角",
      Resource = "1000011.prefab",
      Type = "Model",
      SubType = "Player"
    },
    [5] = {
      EntityID = 39,
      Name = "加载一个主角",
      Resource = "1001001_StoryCube.prefab",
      Type = "Model",
      SubType = "Other"
    }
  },
  ID = 10010801,
  Name = "home_story_1_8_1",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
      Sections = {
        [1] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_1_dialog_content",
            Body = "base_icon_1500991",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 3
              },
              [2] = {ShowContent = 0.02, Time = 3.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_kalian"
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
                FadeTime = 1,
                StartBgm = 17,
                Time = 1
              }
            }
          },
          [3] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {
                  1,
                  0,
                  5
                },
                Rotate = {
                  Duration = 0,
                  StartValue = {
                    0,
                    -160,
                    0
                  },
                  EndValue = {
                    0,
                    -160,
                    0
                  }
                },
                PlayAnimation = "stand",
                Time = 0
              }
            },
            RefEntityID = 37
          },
          [4] = {
            KeyFrames = {
              [1] = {
                Active = true,
                Position = {
                  -1,
                  0,
                  5
                },
                Rotate = {
                  Duration = 0,
                  StartValue = {
                    0,
                    -200,
                    0
                  },
                  EndValue = {
                    0,
                    -200,
                    0
                  }
                },
                Time = 0
              },
              [2] = {PlayAnimation = "happy", Time = 3}
            },
            RefEntityID = 36
          },
          [5] = {
            CameraTrack = true,
            KeyFrames = {
              [1] = {
                Time = 0,
                Translate = {
                  Duration = 1.5,
                  EndValue = {
                    0,
                    1.4,
                    2.2
                  },
                  StartValue = {
                    0,
                    0,
                    0
                  }
                },
                Rotate = {
                  Duration = 1.5,
                  StartValue = {
                    0,
                    0,
                    0
                  },
                  EndValue = {
                    21,
                    0,
                    0
                  }
                }
              }
            }
          }
        },
        [2] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_2_dialog_content",
            Body = "base_icon_1500991",
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
              [1] = {PlayAnimation = "angry", Time = 0}
            },
            RefEntityID = 36
          }
        },
        [3] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_3_dialog_content",
            Body = "base_icon_1500991",
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
              [1] = {PlayAnimation = "sad", Time = 0}
            },
            RefEntityID = 36
          }
        },
        [4] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_4_dialog_content",
            Body = "base_icon_1500991",
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
              [1] = {PlayAnimation = "surprise", Time = 0}
            },
            RefEntityID = 36
          }
        },
        [5] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_5_dialog_content",
            Body = "base_icon_1401021",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_long"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "happy", Time = 0}
            },
            RefEntityID = 37
          },
          [3] = {
            KeyFrames = {
              [1] = {PlayAnimation = "stand", Time = 0}
            },
            RefEntityID = 36
          }
        },
        [6] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_6_dialog_content",
            Body = "base_icon_1401021",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_long"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "angry", Time = 0}
            },
            RefEntityID = 37
          }
        },
        [7] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_7_dialog_content",
            Body = "base_icon_1401021",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_long"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "sad", Time = 0}
            },
            RefEntityID = 37
          }
        },
        [8] = {
          [1] = {
            DialogDir = 1,
            DialogContentStr = "ui_story_1_1_8_dialog_content",
            Body = "base_icon_1401021",
            KeyFrames = {
              [1] = {
                ContentBGVisible = true,
                ShowSpeakerName = 0.2,
                Time = 0
              },
              [2] = {ShowContent = 0.02, Time = 0.2}
            },
            RefEntityID = 1,
            SpeakerNameStr = "ui_story_name_long"
          },
          [2] = {
            KeyFrames = {
              [1] = {PlayAnimation = "surprise", Time = 0}
            },
            RefEntityID = 37
          }
        }
      }
    }
  },
  StartParagraph = 1
}
