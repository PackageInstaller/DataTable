local base = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechLv")
local UINSpring23TechLv = class("UINSpring23TechLv", base)

function UINSpring23TechLv:OnInit()
  base.OnInit(self)
  self._canLvBtnColor = self.ui.img_Clear.color
  self._canLvTexColor = self.ui.tex_level.text.color
end

function UINSpring23TechLv:RefreshChristmas22TechLv()
  self.ui.ani_techInfoNode:Stop()
  self.ui.ani_techInfoNode:Play()
  base.RefreshChristmas22TechLv(self)
  if self._techData:IsLeveUpResEnough() then
    self.ui.img_Clear.color = self._canLvBtnColor
    self.ui.tex_level.text.color = self._canLvTexColor
    self.ui.obj_image:SetActive(true)
  else
    self.ui.img_Clear.color = self.ui.color_cannotLvBtn
    self.ui.tex_level.text.color = self.ui.color_cannotLvText
    self.ui.obj_image:SetActive(false)
  end
end

function UINSpring23TechLv:__RefreshDes()
  if self._techData:IsMaxLvel() or self._techData:GetCurLevel() == 0 then
    base.__RefreshDes(self)
    return
  end
  local level = self._techData:GetCurLevel()
  local desCur = self._techData:GetTechDescription(level, self._desType)
  local desNext = self._techData:GetTechDescription(level + 1, self._desType)
  self.ui.tex_Des.text = ConfigData:GetTipContent(9108, desCur, desNext)
end

return UINSpring23TechLv
