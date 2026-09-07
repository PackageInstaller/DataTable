local BlackFridayWithSignInPage = class("BlackFridayWithSignInPage", import(".BlackFridayPage"))

function BlackFridayWithSignInPage:OnInit()
	BlackFridayWithSignInPage.super.OnInit(self)

	self.signInUIlist = UIItemList.New(self._tf:Find("AD/signIn"), self._tf:Find("AD/signIn/award"))
	self.toggles = {
		self._tf:Find("AD/toggles/skin"),
		self._tf:Find("AD/toggles/sign")
	}
	self.lockSignBtn = self._tf:Find("AD/toggles/sign/lock")

	return
end

function BlackFridayWithSignInPage:OnFirstFlush()
	BlackFridayWithSignInPage.super.OnFirstFlush(self)
	onButton(self, self.lockSignBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end, SFX_PANEL)

	self.signInActId = self.activity:getConfig("config_client")[2]

	self:FlushSignInInfo()

	if self.contextData.showByNextAct then
		self.contextData.showByNextAct = nil

		triggerToggle(self.toggles[2], true)
	end

	return
end

function BlackFridayWithSignInPage:GetSignInAct()
	return (getProxy(ActivityProxy):getActivityById(self.signInActId))
end

function BlackFridayWithSignInPage:ClientSignInActIsEnd()
	local var_5_0 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_template[self.signInActId].time[3])
	local var_5_1 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_template[self.signInActId].time[2])
	local var_5_2 = pg.TimeMgr.GetInstance():GetServerTime()

	return var_5_0 < var_5_2 or var_5_2 < var_5_1
end

function BlackFridayWithSignInPage:FlushSignInInfo()
	local var_6_0 = self:GetSignInAct()
	local var_6_1 = pg.activity_template[self.signInActId]
	local var_6_2 = not (var_6_0 and not var_6_0:isEnd()) and self:ClientSignInActIsEnd()

	if var_6_2 then
		triggerToggle(self.toggles[1], true)
		setToggleEnabled(self.toggles[2], false)
	end

	setActive(self.lockSignBtn, var_6_2)

	local var_6_3 = pg.activity_7_day_sign[var_6_1.config_id].front_drops

	self.signInUIlist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = {
				type = var_6_3[arg_7_1 + 1][1],
				id = var_6_3[arg_7_1 + 1][2],
				count = var_6_3[arg_7_1 + 1][3]
			}

			updateDrop(arg_7_2, var_7_0)
			onButton(self, arg_7_2, function()
				self:emit(BaseUI.ON_DROP, var_7_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.signInUIlist:align(#pg.activity_7_day_sign[var_6_1.config_id].front_drops)

	return
end

function BlackFridayWithSignInPage:FlushSignAwardsState()
	local var_9_0 = self:GetSignInAct()
	local var_9_1 = var_9_0 and not var_9_0:isEnd()

	if var_9_1 then
		local var_9_2 = var_9_0.data1 or 0
	end

	local var_9_3 = self:ClientSignInActIsEnd()

	self.signInUIlist:each(function(arg_10_0, arg_10_1)
		if not var_9_3 and not var_9_1 then
			setActive(arg_10_1:Find("got"), true)
		else
			setActive(arg_10_1:Find("got"), arg_10_0 + 1 <= var_9_2)
		end

		return
	end)

	return
end

function BlackFridayWithSignInPage:OnUpdateFlush()
	BlackFridayWithSignInPage.super.OnUpdateFlush(self)
	self:FlushSignAwardsState()

	return
end

return BlackFridayWithSignInPage
