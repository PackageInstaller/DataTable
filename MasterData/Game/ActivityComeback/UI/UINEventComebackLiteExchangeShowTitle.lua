local UINEventComebackExchangeShowTitle = require("Game.ActivityComeback.UI.UINEventComebackExchangeShowTitle")
local UINEventComebackLiteExchangeShowTitle = class("UINEventComebackLiteExchangeShowTitle", UINEventComebackExchangeShowTitle)
local base = UINEventComebackExchangeShowTitle

function UINEventComebackLiteExchangeShowTitle:InitExchangeShowTitle(texIndex)
  self.ui.tex_GroupTitle:SetIndex(texIndex)
  self.ui.title.color = self.ui.color_tileBg[texIndex + 1]
end

function UINEventComebackLiteExchangeShowTitle:SetNextPoolTip(poolName)
end

return UINEventComebackLiteExchangeShowTitle
