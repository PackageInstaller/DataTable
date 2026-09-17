local page = class("pageDialoguePreview", G_UIPageBase)
local tag = "page:pageDialoguePreview"

function page.methods()
  return {
    onClick = function(self)
      if self.inputCode then
        L_DialogueManager:loadConfig(self.inputCode, function()
          printf(tag, "播放完毕")
          local options = {
            coverdTime = 1,
            fadeOut = true,
            isCompleteClose = true
          }
          L_UI:open("pageMask", options)
        end)
      end
    end,
    onInput = function(self, input)
      self.inputCode = input
    end,
    onClose = function(self)
      L_UI:close("pageDialoguePreview")
    end
  }
end

return page
