local UINFormationChioceCareerTog = require("Game.Formation.UI.2DFormation.UINFormationChioceCareerTog")
local UINFormationChioceCampTog = class("UINFormationChioceCampTog", UINFormationChioceCareerTog)
local base = UINFormationChioceCareerTog

function UINFormationChioceCampTog:InitCompany(companyId, onValueChange, nodeType)
  self.ui.img_CurSelCamp:SetActive(false)
  base.InitCompany(self, companyId, onValueChange, nodeType)
end

function UINFormationChioceCampTog:SetCampCurSelActive(isActive)
  self.ui.img_CurSelCamp:SetActive(isActive)
end

return UINFormationChioceCampTog
