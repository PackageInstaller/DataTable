local DownloadingListCell = class("DownloadingListCell", require("app.fairyGUI.infoPop.UI_DownloadingListCell"))

function DownloadingListCell:ctor()
	self.m_effLoading:addEffectSpine({
		anim = "play_2",
		name = "eff_ui_infoPop_downloading",
		isLoop = true
	})
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)

	self._group = nil
end

function DownloadingListCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, handler(self, self._downloadProcess), self)
end

function DownloadingListCell:updateCell(arg_3_1)
	if arg_3_1 then
		self._group = arg_3_1
	else
		arg_3_1 = self._group
	end

	local var_3_0 = arg_3_1:getCfg()

	self.m_nameTxt:setText(var_3_0.name)
	self.m_award:updateIcon({
		type = var_3_0.reward_type,
		value = var_3_0.reward_value,
		size = var_3_0.reward_size
	})
	self.m_pro:updatePro(arg_3_1:getGroupSizeInfo())

	if arg_3_1:isPause() then
		self.m_stateController:setSelectedIndex(0)
	elseif arg_3_1:isFinishAll() then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	if g.core.model.User.splitDownloadData:isReceivedAwardById(var_3_0.id) then
		self.m_isReceivedController:setSelectedIndex(1)
	else
		self.m_isReceivedController:setSelectedIndex(0)
	end
end

function DownloadingListCell:_downloadProcess()
	self:updateCell()
end

function DownloadingListCell:playShow()
	self:setVisible(true)
end

function DownloadingListCell:playHide()
	self:setVisible(false)
end

return DownloadingListCell
