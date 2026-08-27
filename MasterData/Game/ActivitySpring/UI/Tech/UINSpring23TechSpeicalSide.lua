local base = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechSpeicalSide")
local UINSpring23TechSpeicalSide = class("UINSpring23TechSpeicalSide", base)

function UINSpring23TechSpeicalSide:RefreshTechSpeicalSideInfoNode()
  base.RefreshTechSpeicalSideInfoNode(self)
  if self._curTechData == nil then
    return
  end
  local isUnlockAndLvUp = self._curTechData:GetCurLevel() > 0
  self.ui.tex_lvup:SetIndex(isUnlockAndLvUp and 1 or 0)
end

return UINSpring23TechSpeicalSide
