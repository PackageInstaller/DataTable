local BlackFridayWithManualSignPage = class("BlackFridayWithManualSignPage", import(".BlackFridayPage"))

function BlackFridayWithManualSignPage:OnInit()
	BlackFridayWithManualSignPage.super.OnInit(self)

	self.signList = UIItemList.New(self._tf:Find("AD/singlist"), self._tf:Find("AD/singlist/Award"))
	self.signBtn = self._tf:Find("AD/signBtn")

	setText(self.signBtn:Find("Text"), i18n("SkinMagazinePage2_tip"))

	return
end

function BlackFridayWithManualSignPage:GetPageLink()
	return {
		self.activity:getConfig("config_client")[2]
	}
end

function BlackFridayWithManualSignPage:OnFirstFlush()
	BlackFridayWithManualSignPage.super.OnFirstFlush(self)

	self.signInActId = self.activity:getConfig("config_client")[2]

	return
end

function BlackFridayWithManualSignPage:FlushSignBtn()
	local var_4_0 = getProxy(ActivityProxy):getActivityById(self.signInActId)
	local var_4_1 = not var_4_0 or var_4_0:isEnd()

	onButton(self, self.signBtn, function()
		self:Sign(var_4_0)

		return
	end, SFX_PANEL)
	setActive(self.signBtn, not var_4_1 and var_4_0:AnyAwardCanGet())

	return
end

function BlackFridayWithManualSignPage:FlushSignActivity()
	local var_6_0 = getProxy(ActivityProxy):getActivityById(self.signInActId)

	if not var_6_0 or var_6_0:isEnd() then
		self:FlushEmptyList()
	else
		self:FlushSignList(var_6_0)
	end

	return
end

function BlackFridayWithManualSignPage:FlushEmptyList()
	self.signList:align(0)

	return
end

function BlackFridayWithManualSignPage:FlushSignList(arg_8_1)
	local var_8_0 = arg_8_1:GetDropList()
	local var_8_1 = arg_8_1:GetCanGetAwardIndexList()
	local var_8_2 = {}
	local var_8_3 = arg_8_1:getConfig("config_client")
	local var_8_4 = type(var_8_3) == "table" and var_8_3 or {}

	self.signList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = arg_8_1:GetAwardState(arg_9_1 + 1)

			self:UpdateSignAward(arg_8_1, var_9_0, var_8_0[arg_9_1 + 1], arg_9_2)

			if var_9_0 == ManualSignActivity.STATE_GOT then
				table.insert(var_8_2, var_8_4[arg_9_1 + 1])
			end
		end

		return
	end)
	self.signList:align(#var_8_0)
	self:TryPlayStory(var_8_2)

	return
end

function BlackFridayWithManualSignPage:TryPlayStory(arg_10_1)
	if #arg_10_1 <= 0 then
		return
	end

	local var_10_0 = _.select(arg_10_1, function(arg_11_0)
		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_11_0)
	end)

	if #var_10_0 > 0 then
		pg.NewStoryMgr.GetInstance():SeriesPlay(var_10_0)
	end

	return
end

function BlackFridayWithManualSignPage:UpdateSignAward(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	updateDrop(arg_12_4, arg_12_3)
	setActive(arg_12_4:Find("got"), arg_12_2 == ManualSignActivity.STATE_GOT)
	setActive(arg_12_4:Find("get"), arg_12_2 == ManualSignActivity.STATE_CAN_GET)
	onButton(self, arg_12_4, function()
		if arg_12_2 == ManualSignActivity.STATE_CAN_GET then
			self:Sign(arg_12_1)
		end

		return
	end, SFX_PANEL)

	return
end

function BlackFridayWithManualSignPage:Sign(arg_14_1)
	pg.m02:sendNotification(GAME.ACT_MANUAL_SIGN, {
		activity_id = arg_14_1.id,
		cmd = ManualSignActivity.OP_GET_AWARD
	})

	return
end

function BlackFridayWithManualSignPage:OnUpdateFlush()
	BlackFridayWithManualSignPage.super.OnUpdateFlush(self)
	self:FlushSignActivity()
	self:FlushSignBtn()

	return
end

return BlackFridayWithManualSignPage
