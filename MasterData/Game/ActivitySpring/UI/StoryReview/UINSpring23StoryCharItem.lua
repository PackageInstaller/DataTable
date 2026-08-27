local base = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryBaseItem")
local UINSpring23StoryCharItem = class("UINSpring23StoryCharItem", base)

function UINSpring23StoryCharItem:__InitUI()
  base.__InitUI(self)
  self.ui.tex_Stage.text = LanguageUtil.GetLocaleText(self._interactInfoCfg.index)
end

return UINSpring23StoryCharItem
