local var_0_0 = {
	4,
	3,
	2
}
local ActivityReturnPreviewPop = class("ActivityReturnPreviewPop", require("app.fairyGUI.activityReturn.UI_ActivityReturnPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityReturnPreviewPop",
		pkgPath = "ui/activityReturn/activityReturn",
		pkgName = "activityReturn"
	}, ...)
end)

function ActivityReturnPreviewPop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()

	self._previewData = arg_2_1
	self._gameInfo = arg_2_2

	self:updatePreviewItems()
end

function ActivityReturnPreviewPop:updatePreviewItems()
	local var_3_0 = {
		self._gameInfo.cfg.ssr_rate,
		self._gameInfo.cfg.sr_rate,
		self._gameInfo.cfg.r_rate
	}

	for iter_3_0, iter_3_1 in ipairs(self._previewData.previewMap) do
		local var_3_1 = fgui.UIPackage:createObject("activityReturn", "ActivityReturnPreviewCell")

		var_3_1:updateItem(iter_3_1, var_0_0[iter_3_0], (tonumber((string.format("%0.2f", var_3_0[iter_3_0] / (self._gameInfo.cfg.ssr_rate + self._gameInfo.cfg.sr_rate + self._gameInfo.cfg.r_rate) * 100)))))
		self.m_previewList:addItem(var_3_1)
	end
end

return ActivityReturnPreviewPop
