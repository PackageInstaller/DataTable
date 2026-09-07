local NewYearSnackPage = class("NewYearSnackPage", import("...base.BaseActivityPage"))

function NewYearSnackPage:OnInit()
	self.progressTpl = self._tf:Find("ProgressTpl")
	self.progressTplContainer = self._tf:Find("ProgressList")
	self.progressUIItemList = UIItemList.New(self.progressTplContainer, self.progressTpl)
	self.helpBtn = self._tf:Find("HelpBtn")
	self.goBtn = self._tf:Find("GoBtn")

	return
end

function NewYearSnackPage:OnDataSetting()
	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId((getProxy(MiniGameProxy):GetMiniGameData(self.activity:getConfig("config_client").linkMiniGameID):getConfig("hub_id")))

	self.needCount = var_2_0:getConfig("reward_need")
	self.leftCount = var_2_0.count
	self.playedCount = var_2_0.usedtime
	self.isGotAward = var_2_0.ultimate > 0
	self.curDay = self.leftCount + self.playedCount

	return
end

function NewYearSnackPage:OnFirstFlush()
	self.progressUIItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_4_2:Find("Unlocked")
			local var_4_1 = arg_4_2:Find("Finished")
			local var_4_2 = arg_4_2:Find("FinalFinished")

			setActive(arg_4_2:Find("Locked"), arg_4_1 > self.curDay)

			if arg_4_1 <= self.curDay then
				setActive(var_4_0, arg_4_1 > self.playedCount)
				setActive(var_4_1, arg_4_1 <= self.playedCount and arg_4_1 ~= self.needCount)
				setActive(var_4_2, arg_4_1 <= self.playedCount and arg_4_1 == self.needCount)
			else
				setActive(var_4_0, false)
				setActive(var_4_1, false)
				setActive(var_4_2, false)
			end
		end

		return
	end)
	self.progressUIItemList:align(self.needCount)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 19, {
			callback = function()
				local var_6_0 = Context.New()

				SCENE.SetSceneInfo(var_6_0, SCENE.NEWYEAR_BACKHILL)
				getProxy(ContextProxy):PushContext2Prev(var_6_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_xinnian2021__meishiyemian")
		})

		return
	end, SFX_PANEL)
	self:tryGetFinalAward()

	return
end

function NewYearSnackPage:OnUpdateFlush()
	return
end

function NewYearSnackPage:OnDestroy()
	return
end

function NewYearSnackPage:tryGetFinalAward()
	local var_10_0 = getProxy(MiniGameProxy):GetHubByHubId((getProxy(MiniGameProxy):GetMiniGameData(self.activity:getConfig("config_client").linkMiniGameID):getConfig("hub_id")))

	if var_10_0:getConfig("reward_need") <= var_10_0.usedtime and var_10_0.ultimate <= 0 then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_10_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function NewYearSnackPage.IsTip()
	local var_11_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.NEWYEAR_SNACK_PAGE_ID.act_id)

	if var_11_0 and not var_11_0:isEnd() then
		local var_11_1 = getProxy(MiniGameProxy):GetHubByHubId((getProxy(MiniGameProxy):GetMiniGameData(var_11_0:getConfig("config_client").linkMiniGameID):getConfig("hub_id")))

		if var_11_1:getConfig("reward_need") <= var_11_1.usedtime and var_11_1.ultimate <= 0 then
			return true
		elseif var_11_1.count > 0 then
			return true
		else
			return false
		end
	end

	return
end

return NewYearSnackPage
