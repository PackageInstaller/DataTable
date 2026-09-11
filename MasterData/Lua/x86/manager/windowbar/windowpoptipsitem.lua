local WindowPopTipsItem = class("WindowPopTipsItem", import("game.extend.ReduxView"))

function WindowPopTipsItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.infoHandler_ = handler(self, self.RefreshInfo)

	manager.notify:RegistListener(WINDOW_BAR_INFO, self.infoHandler_)
end

function WindowPopTipsItem:AddListeners()
	return
end

function WindowPopTipsItem:Dispose()
	WindowPopTipsItem.super.Dispose(self)
	self:StopTimer()
	manager.notify:RemoveListener(WINDOW_BAR_INFO, self.infoHandler_)

	self.infoHandler_ = nil
end

function WindowPopTipsItem:RefreshInfo(arg_4_1, arg_4_2)
	if arg_4_1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		local var_4_0 = GuildData:GetGuildInfo()

		if var_4_0.id == nil then
			return
		end

		self.textNum_.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. string.format("%s/%s", var_4_0.curWeekCoin, GuildData:GetMaxWeekCoin())
	else
		return
	end

	self:CalcOffsetX(arg_4_2)
	self:AddTimer()
end

function WindowPopTipsItem:Hide()
	SetActive(self.gameObject_, false)
end

function WindowPopTipsItem:AddTimer()
	self:StopTimer()
	SetActive(self.gameObject_, true)

	self.timer_ = Timer.New(function()
		self:StopTimer()
	end, 3, 1)

	self.timer_:Start()
end

function WindowPopTipsItem:StopTimer()
	SetActive(self.gameObject_, false)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function WindowPopTipsItem:CalcOffsetX(arg_9_1)
	self.transform_.localPosition = Vector3(arg_9_1.transform:InverseTransformPoint(self.goRight_.transform:TransformPoint(Vector3.zero)).x * -1, self.transform_.localPosition.y, 0)
end

return WindowPopTipsItem
