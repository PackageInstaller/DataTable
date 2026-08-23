local DownloadingListPop = class("DownloadingListPop", require("app.fairyGUI.infoPop.UI_DownloadingListPop"), function()
	return fgui.GComponent:create({
		resName = "DownloadingListPop",
		isFullScreen = true,
		pkgName = "infoPop"
	})
end)

function DownloadingListPop:ctor()
	self._groupList = nil

	self.m_downloadList:setVirtual(self)
	self.m_downloadList:setItemRenderer(handler(self, self._onRenderDownloadList))
	self.m_finishAwardsList:setVirtual(self)
	self.m_finishAwardsList:setItemRenderer(handler(self, self._onRenderFinishAwardList))
end

function DownloadingListPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, handler(self, self._downloadProcess), self)
	self:_updatePop()
end

function DownloadingListPop:_downloadProcess()
	self:_updateDownloadList()

	self._totalAwardsList = {}
	self._totalAwardsList = g.core.common.Drops:getGoodsArray(g.core.config.parameter_info.get(24032).parameter)

	self.m_finishAwardsList:setNumItems(#self._totalAwardsList)

	if g.core.model.User.splitDownloadData:isAllReceived() then
		self.m_isGetAllRwdController:setSelectedIndex(1)
	else
		self.m_isGetAllRwdController:setSelectedIndex(0)
	end
end

function DownloadingListPop:_updatePop()
	self:_updateDownloadList(true)

	self._totalAwardsList = {}

	for iter_5_0 = 1, g.core.config.split_download_reward_info.getLength() do
		local var_5_0 = g.core.config.split_download_reward_info.indexOf(iter_5_0)

		self._totalAwardsList[iter_5_0] = {
			type = var_5_0.reward_type,
			value = var_5_0.reward_value,
			size = var_5_0.reward_size
		}
	end

	self.m_finishAwardsList:setNumItems(#self._totalAwardsList)

	if g.core.model.User.splitDownloadData:isAllReceived() then
		self.m_isGetAllRwdController:setSelectedIndex(1)
	else
		self.m_isGetAllRwdController:setSelectedIndex(0)
	end
end

function DownloadingListPop:_updateDownloadList(arg_6_1)
	self._groupList = g.core.common.PackageRes:getResMainGroupList()

	self.m_downloadList:setNumItems(#self._groupList)

	if arg_6_1 then
		self.m_downloadList:transitionShowCells("enter_right", 0.03)
	end
end

function DownloadingListPop:_onRenderDownloadList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._groupList[arg_7_1 + 1])
end

function DownloadingListPop:_onRenderFinishAwardList(arg_8_1, arg_8_2)
	arg_8_2:updateIcon(self._totalAwardsList[arg_8_1 + 1])
end

function DownloadingListPop:onCancelCallback()
	self.m_backTransition:play(handler(self, self.closeDownloadListPop))
end

function DownloadingListPop:closeDownloadListPop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return DownloadingListPop
