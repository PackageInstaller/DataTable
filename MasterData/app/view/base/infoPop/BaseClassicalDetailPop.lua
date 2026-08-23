local BaseClassicalDetailPop = class("BaseClassicalDetailPop", require("app.fairyGUI.infoPop.UI_BaseClassicalDetailPop"), function()
	return fgui.GComponent:create({
		resName = "BaseClassicalDetailPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	})
end)

function BaseClassicalDetailPop:ctor(arg_2_1)
	self:showAtCenter()

	self._classical = arg_2_1 and arg_2_1.classical
	self._knightCfg = arg_2_1 and arg_2_1.knightCfg

	self.m_detailComp:updateView(self._classical, self._knightCfg)
end

return BaseClassicalDetailPop
