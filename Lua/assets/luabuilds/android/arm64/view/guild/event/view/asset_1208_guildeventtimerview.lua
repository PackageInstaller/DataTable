local GuildEventTimerView = class("GuildEventTimerView")

function GuildEventTimerView:Flush(arg_1_1, arg_1_2)
	self.text = arg_1_1

	self:RemoveEndEventTimer()

	local var_1_0 = arg_1_2:GetLeftTime()

	if var_1_0 < 0 then
		self.timer = Timer.New(function()
			local var_2_0 = arg_1_2:GetLeftTime()

			self:UpdateText("<size=31><color=#FF3838>" .. pg.TimeMgr.GetInstance():DescCDTime(var_2_0) .. "</color></size>")

			if var_2_0 <= 0 then
				self:OnOver()
			end

			return
		end, 1, -1)

		self.timer.func()
	else
		local var_1_1, var_1_2, var_1_3, var_1_4 = pg.TimeMgr.GetInstance():parseTimeFrom(var_1_0)

		assert(var_1_1 > 0)

		if var_1_2 <= 0 and (var_1_3 > 0 or var_1_4 > 0) then
			var_1_2 = var_1_2 + 1
		end

		local var_1_5 = string.format("%s" .. i18n("word_date") .. "%s" .. i18n("word_hour"), var_1_1, var_1_2)

		if var_1_1 < 7 then
			var_1_5 = "<size=31><color=#FF3838>" .. var_1_5 .. "</color></size>"
		end

		self:UpdateText(var_1_5)

		self.timer = Timer.New(function()
			self:Flush(arg_1_1, arg_1_2)

			return
		end, math.min(var_1_0 - 0, (var_1_3 * 60 + var_1_4 <= 0 or nil) and 3600) + 2, 1)
	end

	self.timer:Start()

	return
end

function GuildEventTimerView:UpdateText(arg_4_1)
	self.text.text = arg_4_1

	return
end

function GuildEventTimerView:RemoveEndEventTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function GuildEventTimerView:OnOver()
	self:RemoveEndEventTimer()
	pg.m02:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
		force = true
	})

	return
end

function GuildEventTimerView:Dispose()
	self:RemoveEndEventTimer()

	return
end

return GuildEventTimerView
