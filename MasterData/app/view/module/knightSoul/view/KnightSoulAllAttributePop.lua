local KnightSoulAllAttributePop = class("KnightSoulAllAttributePop", require("app.fairyGUI.knightSoul.UI_KnightSoulAllAttributePop"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulAllAttributePop",
		pkgPath = "ui/knightSoul/knightSoul",
		pkgName = "knightSoul"
	}, ...)
end)

function KnightSoulAllAttributePop:ctor()
	self:showAtCenter()
	self.m_attributeComp:updateAttribute()
end

return KnightSoulAllAttributePop
