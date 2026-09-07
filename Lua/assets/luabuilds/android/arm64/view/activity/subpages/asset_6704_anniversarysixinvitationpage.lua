local AnniversarySixInvitationPage = class("AnniversarySixInvitationPage", import("...base.BaseActivityPage"))

function AnniversarySixInvitationPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function AnniversarySixInvitationPage:OnFirstFlush()
	self.rtMarks = self._tf:Find("AD/progress")
	self.rtFinish = self._tf:Find("AD/award")

	local var_2_0 = self._tf:Find("AD/btn_list")

	onButton(self, var_2_0:Find("go"), function()
		local var_3_0 = underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_4_0)
			return arg_4_0:getConfig("config_id") == 3
		end)

		if not var_3_0 or var_3_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		local var_3_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

		if var_3_1 and not var_3_1:isEnd() then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
				wraps = SixthAnniversaryIslandScene.SHOP
			})
		else
			self:emit(ActivityMediator.OPEN_LAYER, Context.New({
				mediator = SixthAnniversaryIslandShopMediator,
				viewComponent = SixthAnniversaryIslandShopLayer
			}))
		end

		return
	end, SFX_PANEL)
	onButton(self, var_2_0:Find("get"), function()
		local var_5_0, var_5_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_5_1
		})

		return
	end, SFX_PANEL)

	return
end

function AnniversarySixInvitationPage:OnUpdateFlush()
	local var_6_0, var_6_1 = self.ptData:GetResProgress()
	local var_6_2 = self.ptData:CanGetAward()
	local var_6_3 = self.ptData:CanGetNextAward()
	local var_6_4 = self._tf:Find("AD/btn_list")

	setActive(var_6_4:Find("get"), var_6_2)
	setActive(var_6_4:Find("got"), not var_6_3)
	setActive(var_6_4:Find("go"), not var_6_2 and var_6_3)

	var_6_0 = var_6_3 and math.min(var_6_0, var_6_1) or var_6_1 + 1

	for iter_6_0 = 1, self.rtMarks.childCount do
		local var_6_5 = self.rtMarks:GetChild(iter_6_0 - 1)

		setActive(var_6_5:Find("mark"), iter_6_0 < var_6_0)
		setActive(var_6_5:Find("icon"), iter_6_0 == var_6_0)
	end

	setGray(self.rtFinish:Find("Image"), not var_6_3)
	setActive(self.rtFinish:Find("got"), not var_6_3)

	return
end

return AnniversarySixInvitationPage
