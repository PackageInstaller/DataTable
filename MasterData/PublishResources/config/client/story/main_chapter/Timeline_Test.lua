return {
  Entities = {
    [1] = {
      EntityID = 1,
      Name = "有角色名背景的对话框背景",
      Resource = "StoryDialog.prefab",
      Type = "Dialog"
    },
    [2] = {
      Effect = "EMI",
      EntityID = 2,
      Name = "薇丝",
      Resource = "vice_spine_idle.prefab",
      Type = "Spine"
    },
    [3] = {
      EntityID = 3,
      Name = "兔子立绘",
      Resource = "1300221_spine_idle.prefab",
      Type = "Spine"
    },
    [4] = {
      EntityID = 4,
      FitSize = false,
      Name = "weisi",
      Resource = "weisi_spine_idle.prefab",
      Type = "Spine"
    }
  },
  ID = 831143,
  Name = "Timeline_Test",
  Paragraphs = {
    [1] = {
      ID = 1,
      Name = "Default name",
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
              [2] = {ShowContent = 0.2, Time = 0.2}
            },
            RefEntityID = 1
          },
          [2] = {
            KeyFrames = {
              [1] = {Time = 0}
            },
            RefEntityID = 4
          }
        }
      }
    }
  },
  StartParagraph = 1
}
