local Z28SkinPage = class("Z28SkinPage", import(".NewYearSnackPage"))

function Z28SkinPage:OnDataSetting()
	local var_1_0 = getProxy(MiniGameProxy):GetHubByHubId((self.activity:getConfig("config_id")))

	self.needCount = var_1_0:getConfig("reward_need")
	self.leftCount = var_1_0.count
	self.playedCount = var_1_0.usedtime
	self.isGotAward = var_1_0.ultimate > 0
	self.curDay = self.leftCount + self.playedCount

	return
end

function Z28SkinPage:OnFirstFlush()
	self.progressUIItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_3_1 = arg_3_1 + 1

			local var_3_0 = arg_3_2:Find("Unlocked")
			local var_3_1 = arg_3_2:Find("Finished")
			local var_3_2 = arg_3_2:Find("FinalFinished")

			setActive(arg_3_2:Find("Locked"), arg_3_1 > self.curDay)

			if arg_3_1 <= self.curDay then
				setActive(var_3_0, arg_3_1 > self.playedCount)
				setActive(var_3_1, arg_3_1 <= self.playedCount and arg_3_1 ~= self.needCount)
				setActive(var_3_2, arg_3_1 <= self.playedCount and arg_3_1 == self.needCount)
			else
				setActive(var_3_0, false)
				setActive(var_3_1, false)
				setActive(var_3_2, false)
			end
		end

		return
	end)

	local var_2_0 = 36

	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_2_0, {
			callback = function()
				local var_5_0 = Context.New()

				SCENE.SetSceneInfo(var_5_0, SCENE.NEWYEAR_BACKHILL_2022)
				getProxy(ContextProxy):PushContext2Prev(var_5_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_xinnian2022_z28")
		})

		return
	end, SFX_PANEL)

	return
end

function Z28SkinPage:OnUpdateFlush()
	self.progressUIItemList:align(self.needCount)
	self:tryGetFinalAward()

	return
end

function Z28SkinPage:OnDestroy()
	return
end

function Z28SkinPage:tryGetFinalAward()
	local var_9_0 = getProxy(MiniGameProxy):GetHubByHubId((self.activity:getConfig("config_id")))

	if var_9_0:getConfig("reward_need") <= var_9_0.usedtime and var_9_0.ultimate <= 0 then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_9_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return Z28SkinPage
