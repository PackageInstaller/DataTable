local SpireBossDetailPop = class("SpireBossDetailPop", require("app.fairyGUI.spire.UI_SpireBossDetailPop"), function()
	return fgui.GComponent:create({
		pkgName = "spire",
		resName = "SpireBossDetailPop"
	}, ...)
end)

function SpireBossDetailPop:ctor(arg_2_1)
	self.m_picComp:setTitle(arg_2_1:getCfg().name)
	self.m_picComp:getChild("icon"):updateKnight({
		baseId = arg_2_1:getShowSpineId()
	})
	self:_initView()
	self.m_detailPannel:updatePanel(arg_2_1)
	self:showAtCenter()
end

function SpireBossDetailPop:_initView()
	self.m_cancelBtn:addClickListener(handler(self, self._onCancelBtnClicked))
end

function SpireBossDetailPop:_onCancelBtnClicked()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SpireBossDetailPop
