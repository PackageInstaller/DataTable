local KnightSoulBagCell = class("KnightSoulBagCell", require("app.fairyGUI.knightSoul.UI_KnightSoulBagCell"))

function KnightSoulBagCell:ctor()
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
end

function KnightSoulBagCell:updateBagCell(arg_2_1)
	self.m_iconComp:updateIcon(arg_2_1)
end

return KnightSoulBagCell
