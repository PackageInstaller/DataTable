local UINAthItemSimpleAttr = class("UINAthItemSimpleAttr", UIBaseNode)
local base = UIBaseNode
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")

function UINAthItemSimpleAttr:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthItemSimpleAttr:InitAthItemSimpleAttr(quality)
  self.ui.simpleAtt.color = AthEnum.AthQualityColor[quality]
end

function UINAthItemSimpleAttr:OnDelete()
  base.OnDelete(self)
end

return UINAthItemSimpleAttr
