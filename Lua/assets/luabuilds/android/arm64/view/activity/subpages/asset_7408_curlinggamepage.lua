local CurlingGamePage = class("CurlingGamePage", import("...base.BaseActivityPage"))

function CurlingGamePage:OnInit()
	self.progressTpl = self._tf:Find("ProgressTpl")
	self.progressTplContainer = self._tf:Find("ProgressList")
	self.progressUIItemList = UIItemList.New(self.progressTplContainer, self.progressTpl)
	self.goBtn = self._tf:Find("GoBtn")

	return
end

function CurlingGamePage:OnDataSetting()
	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId((self.activity:getConfig("config_id")))

	self.needCount = var_2_0:getConfig("reward_need")
	self.leftCount = var_2_0.count
	self.playedCount = var_2_0.usedtime
	self.isGotAward = var_2_0.ultimate > 0
	self.curDay = self.leftCount + self.playedCount

	return
end

function CurlingGamePage:OnFirstFlush()
	self.progressUIItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_4_2:Find("Unlocked")
			local var_4_1 = arg_4_2:Find("Finished")

			setActive(arg_4_2:Find("Current"), arg_4_1 == self.playedCount)

			if arg_4_1 <= self.curDay then
				setActive(var_4_0, arg_4_1 > self.playedCount)
				setActive(var_4_1, arg_4_1 <= self.playedCount and arg_4_1 ~= self.needCount)
			else
				setActive(var_4_0, false)
				setActive(var_4_1, false)
			end
		end

		return
	end)
	self.progressUIItemList:align(self.needCount)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 33)

		return
	end, SFX_PANEL)
	self:tryGetFinalAward()

	return
end

function CurlingGamePage:OnUpdateFlush()
	return
end

function CurlingGamePage:OnDestroy()
	return
end

function CurlingGamePage:tryGetFinalAward()
	local var_8_0 = getProxy(MiniGameProxy):GetHubByHubId((self.activity:getConfig("config_id")))

	if var_8_0:getConfig("reward_need") <= var_8_0.usedtime and var_8_0.ultimate <= 0 then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_8_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return CurlingGamePage
