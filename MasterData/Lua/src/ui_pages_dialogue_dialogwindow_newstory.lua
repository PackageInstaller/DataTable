local page = class("dialogWindow_NewStory", G_UIPageBase)

function page.bind()
  return {
    reviewButtonActive = true,
    skipButtonActive = true,
    buttonsActive = true,
    nextToggle = false,
    nextToggleActive = false,
    normalTextUI = false,
    subtitleUI = false,
    subtitleTextName = "",
    subtitleText = "",
    avatarUI = false,
    modulePlotDialog = {
      moduleName = "pages/dialogue/modulePlotDialog"
    },
    entryTipActive = false,
    moduleEntryTip = {
      moduleName = "pages/dialogue/moduleEntryTip"
    },
    dialogWriterPlayText = nil,
    dialogWriterPlayTextInterval = 0.05,
    dialogWriterCmd = 0,
    speakerText = "",
    blackTextUI = false,
    blackWriterPlayText = nil,
    blackWriterPlayTextInterval = 0.05,
    blackWriterCmd = 0,
    blackNextToggle = false,
    oldNotepadPos = C_Vector2(10, -48),
    oldNotepadTextUI = false,
    oldNotepadPlayText = "",
    oldNotepadNameText = "",
    oldNotepadNameTextActive = false,
    oldNotepadHaveNameIcon = false,
    oldNotepadNoNameIcon = false,
    oldNotepadNoNamePlaceholder = false,
    timeLineUI = false,
    timeLineSubtitleText = "",
    writedSubtitleTextUI = false,
    writedSubtitlePlayText = nil,
    writedSubtitlePlayTextInterval = 0.05,
    writedSubtitleWriterCmd = 0,
    globalMaskActive = false,
    illustrationActive = false,
    toggle_play = false,
    padKeyLocActive = false
  }
end

function page.methods()
  return {
    dragBegin = function(self, pos)
    end,
    drag = function(self, pos)
    end,
    dragEnd = function(self, pos)
    end,
    skipOnClick = function(self)
    end,
    nextDialogueClick = function(self)
    end,
    autoOn = function(self)
    end,
    autoOff = function(self)
    end,
    onLogClick = function(self)
    end,
    onHideClick = function(self)
    end,
    onDialogWriterPlayComplete = function(self)
    end,
    onBlackWriterPlayComplete = function(self)
    end,
    onSubtitleWriterPlayComplete = function(self)
    end,
    speedDropdownOn = function(self)
    end,
    speedDropdownOff = function(self)
    end
  }
end

function page:open(options)
  C_UIMgr:pushOrPopUIRTStack(true, false)
end

function page:close(options)
  L_UIManager:pushOrPopUIRTStack(false)
end

return page
