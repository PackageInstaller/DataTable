local page = class("slateCutsceneUI", G_UIPageBase)
local tag = "page:slateCutsceneUI"

function page:bind()
  return {showSkipButton = false}
end

function page:methods()
  return {
    skipClick = function(self)
    end
  }
end

function page:preOpen(options)
  self.bind.showSkipButton = options.showSkipButton
  self.storyId = options.storyId
end

return page
