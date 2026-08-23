local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseActivityRecordPop = class("ReleaseActivityRecordPop", require("app.fairyGUI.release.UI_ReleaseActivityRecordPop"), function()
	return fgui.GComponent:create({
		resName = "ReleaseActivityRecordPop",
		pkgPath = "ui/release/release",
		pkgName = "release"
	}, ...)
end)

function ReleaseActivityRecordPop:ctor()
	self:showAtCenter()
	self.m_showList:setVirtual()
	self.m_showList:setItemRenderer(handler(self, self._onRecordItemRender))
end

function ReleaseActivityRecordPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RELEASE_PRIZELIST, self._onS2CReleasePrizeList, self)
	g.core.network.GameNetProxy:send_C2S_Release_PrizeList({})
end

function ReleaseActivityRecordPop:_onS2CReleasePrizeList()
	self._recordList = var_0_0:getReleaseRecordList()

	self.m_showList:setNumItems(#self._recordList)
	self.m_isEmptyController:setSelectedIndex(#self._recordList == 0 and 1 or 0)
end

function ReleaseActivityRecordPop:_onRecordItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateRecordCell(self._recordList[arg_5_1 + 1])
end

return ReleaseActivityRecordPop
