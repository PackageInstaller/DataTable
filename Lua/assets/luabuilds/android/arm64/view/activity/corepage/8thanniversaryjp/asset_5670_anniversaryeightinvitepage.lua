local AnniversaryEightInvitePage = class("AnniversaryEightInvitePage", import("view.activity.CorePage.CoreActivityPage"))

function AnniversaryEightInvitePage:OnInit()
	self.rtMarks = self._tf:Find("AD/image_02/progress")
	self.rtFinish = self._tf:Find("AD/image_02/award")
	self.rtBtns = self._tf:Find("AD/btn_list")

	return
end

function AnniversaryEightInvitePage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function AnniversaryEightInvitePage:OnFirstFlush()
	onButton(self, self.rtBtns:Find("go"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CITY_REBUILD_MAP)

		return
	end, SFX_PANEL)
	onButton(self, self.rtBtns:Find("get"), function()
		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 4,
			activity_id = self.ptData:GetId(),
			arg1 = self.ptData:GetCurrTarget()
		})

		return
	end, SFX_PANEL)

	return
end

function AnniversaryEightInvitePage:OnUpdateFlush()
	local var_6_0, var_6_1, var_6_2 = self.ptData:GetResProgress()
	local var_6_3 = self.ptData:GetDroptItemState(self.ptData:GetCurrLevel())

	for iter_6_0 = 1, self.rtMarks.childCount do
		setActive(self.rtMarks:GetChild(iter_6_0 - 1):Find("mark"), iter_6_0 <= var_6_0)
	end

	setActive(self.rtBtns:Find("get"), var_6_3 == ActivityPtData.STATE_CAN_GET and var_6_1 <= var_6_0)
	setActive(self.rtBtns:Find("got"), var_6_3 == ActivityPtData.STATE_GOT and var_6_1 <= var_6_0)
	setActive(self.rtBtns:Find("red"), var_6_3 == ActivityPtData.STATE_CAN_GET and var_6_1 <= var_6_0)
	setActive(self.rtBtns:Find("go"), var_6_0 < var_6_1)
	setActive(self.rtFinish, var_6_3 == ActivityPtData.STATE_GOT)

	return
end

return AnniversaryEightInvitePage
