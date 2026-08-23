local OutpostKnightAttrTip = class("OutpostKnightAttrTip", require("app.fairyGUI.outpost.UI_OutpostKnightAttrTip"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostKnightAttrTip",
		pkgName = "outpost",
		isFullScreen = false
	}, ...)
end)

function OutpostKnightAttrTip:ctor(arg_2_1)
	self:showAtCenter()

	self._struct = arg_2_1.struct
end

function OutpostKnightAttrTip:onLoad()
	self.m_attrComp:updateKnightAttr(self._struct)
end

return OutpostKnightAttrTip
