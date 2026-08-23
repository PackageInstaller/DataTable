local var_0_0 = g.core.model.User.retroData
local RetroActivityPreviewPop = class("RetroActivityPreviewPop", require("app.fairyGUI.retro.UI_RetroActivityPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "RetroActivityPreviewPop",
		pkgPath = "ui/retro/retro",
		pkgName = "retro"
	}, ...)
end)

function RetroActivityPreviewPop:ctor()
	self:showAtCenter()
	self:updatePreviewData()
	self:updatePreviewItems()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PAGE_OPEN_1)
end

function RetroActivityPreviewPop:updatePreviewData()
	self._retroCfg = var_0_0:getRetroActivityCfg()
	self._boxCfg = var_0_0:getBoxContentConfigByGroup(self._retroCfg.box_group)

	table.sort(self._boxCfg, function(arg_4_0, arg_4_1)
		if arg_4_0.quality ~= arg_4_1.quality then
			return arg_4_0.quality > arg_4_1.quality
		end

		return arg_4_0.id > arg_4_1.id
	end)

	self._boxContentMap = {}

	for iter_3_0, iter_3_1 in ipairs(self._boxCfg) do
		self._boxContentMap[iter_3_1.quality] = self._boxContentMap[iter_3_1.quality] or {}

		table.insert(self._boxContentMap[iter_3_1.quality], {
			quality = iter_3_1.quality,
			info = iter_3_1
		})
	end
end

function RetroActivityPreviewPop:updatePreviewItems()
	local var_5_0 = table.values(self._boxContentMap)

	for iter_5_0 = #var_5_0, 1, -1 do
		local var_5_1 = fgui.UIPackage:createObject("retro", "RetroActivityPreviewCell")

		var_5_1:updateCell(var_5_0[iter_5_0])
		self.m_previewList:addItem(var_5_1)
	end
end

return RetroActivityPreviewPop
