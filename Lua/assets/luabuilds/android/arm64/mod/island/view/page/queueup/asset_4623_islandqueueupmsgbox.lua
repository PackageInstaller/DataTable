local IslandQueueUpMsgBox = class("IslandQueueUpMsgBox", import("view.base.BaseSubView"))

function IslandQueueUpMsgBox:getUIName()
	return "IslandQueueUpUI"
end

function IslandQueueUpMsgBox:OnLoaded()
	self.contentTxt = self._tf:Find("frame/Text"):GetComponent(typeof(Text))
	self.cancelBtn = self._tf:Find("frame/cancel")

	setText(self._tf:Find("frame/title"), i18n("island_msg_info"))
	setText(self._tf:Find("frame/cancel/Text"), i18n("island_cancel_queue"))

	return
end

function IslandQueueUpMsgBox:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Destroy()

		return
	end, SFX_PANEL)

	return
end

function IslandQueueUpMsgBox:Show(arg_5_1, arg_5_2)
	self:Flush(arg_5_2)
	self:AddTimer(arg_5_1)

	return
end

function IslandQueueUpMsgBox:Flush(arg_6_1)
	self.contentTxt.text = i18n("island_queue_display", arg_6_1)

	return
end

function IslandQueueUpMsgBox:AddTimer(arg_7_1)
	self.timer = Timer.New(function()
		self:Send(arg_7_1)

		return
	end, IslandConst.QUEUE_UP_REFRESH_TIME, -1)

	self.timer:Start()

	return
end

function IslandQueueUpMsgBox:Send(arg_9_1)
	pg.ConnectionMgr.GetInstance():Send(21208, {
		island_id = arg_9_1
	}, 21203, function(arg_10_0)
		if arg_10_0.result == 0 then
			self:Destroy()
			pg.m02:sendNotification(GAME.ISLAND_GET_DATA, {
				id = arg_10_0.island_id,
				list = arg_10_0.player_list
			})
		elseif arg_10_0.result == 6 then
			self:Flush(arg_10_0.pos)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_10_0.result] .. arg_10_0.result)
		end

		return
	end)

	return
end

function IslandQueueUpMsgBox:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandQueueUpMsgBox:OnDestroy()
	self:RemoveTimer()
	self:Reset()

	return
end

return IslandQueueUpMsgBox
