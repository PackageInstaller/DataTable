local DownloadPro = class("DownloadPro", require("app.fairyGUI.infoPop.UI_DownloadPro"))

function DownloadPro:ctor()
	self._totalWidth = self:getSize().width
end

function DownloadPro:updatePro(arg_2_1)
	local var_2_0 = self.m_proImg:getSize()

	var_2_0.width = self._totalWidth * (arg_2_1.finish / arg_2_1.total)

	self.m_proImg:setSize(var_2_0)
	self:setTitle(g.core.lang:get(500135, {
		cur = g.core.utils.Number.toMemoryShortSize(arg_2_1.finish),
		max = g.core.utils.Number.toMemoryShortSize(arg_2_1.total)
	}))
end

return DownloadPro
