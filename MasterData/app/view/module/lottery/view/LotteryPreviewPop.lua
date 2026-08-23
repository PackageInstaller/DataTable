local LotteryPreviewPop = class("LotteryPreviewPop", require("app.fairyGUI.lottery.UI_LotteryPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "LotteryPreviewPop",
		pkgPath = "ui/lottery/lottery",
		pkgName = "lottery"
	})
end)

function LotteryPreviewPop:ctor(arg_2_1)
	self._dataList = arg_2_1

	self:_init()
end

function LotteryPreviewPop:_init()
	self:getView():center(true)
	self.m_previewList:setVirtual()
	self.m_previewList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_previewList:doFairyBatching(false)
	self.m_previewList:setNumItems(#self._dataList)
end

function LotteryPreviewPop:_onItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateComp(self._dataList[arg_4_1 + 1])
end

function LotteryPreviewPop:onLoad()
	return
end

return LotteryPreviewPop
