local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoInfoOpIcon = class("UINWarChessInfoInfoOpIcon", base)
local cs_tweening = CS.DG.Tweening
local cs_Ease = CS.DG.Tweening.Ease

function UINWarChessInfoInfoOpIcon:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoInfoOpIcon:SetWCIIOpIcon(iconAtlas, iconName)
  self.ui.img_opIcon.enabled = iconName ~= nil
  if iconName == nil then
    return
  end
  self.ui.img_opIcon.sprite = AtlasUtil.GetResldSprite(iconAtlas, iconName)
end

function UINWarChessInfoInfoOpIcon:OnShow()
  base.OnShow(self)
  self.transform.localPosition = Vector3.zero
  self.transform:DOLocalMoveY(10, 1.5):SetLoops(-1, cs_tweening.LoopType.Yoyo):SetEase(cs_Ease.InOutQuad)
end

function UINWarChessInfoInfoOpIcon:PlayWCIIIOpIconntoTween()
  self.transform.localScale = Vector3.one
  self.transform:DOScale(0, 0.3):From()
end

function UINWarChessInfoInfoOpIcon:OnHide()
  self.transform:DOKill()
  self.transform.localScale = Vector3.one
  self.transform.localPosition = Vector3.zero
end

function UINWarChessInfoInfoOpIcon:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoInfoOpIcon
