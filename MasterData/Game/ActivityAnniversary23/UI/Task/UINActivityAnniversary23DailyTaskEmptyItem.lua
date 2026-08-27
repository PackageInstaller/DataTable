local base = require("Game.CommonUI.Activity.UINActivityCommonDailyTaskEmptyItem")
local UINActivityAnniversary23DailyTaskEmptyItem = class("UINActivityAnniversary23DailyTaskEmptyItem", base)

function UINActivityAnniversary23DailyTaskEmptyItem:InitDailyTaskEmptyItem(str)
  self.ui.tex_Timer.text = str
end

function UINActivityAnniversary23DailyTaskEmptyItem:SetTaskNextShowTex(str)
  self.ui.tex_Timer.text = str
end

return UINActivityAnniversary23DailyTaskEmptyItem
