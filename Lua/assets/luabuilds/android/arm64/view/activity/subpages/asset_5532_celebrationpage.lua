local CelebrationPage = class("CelebrationPage", import("...base.BaseActivityPage"))

function CelebrationPage:OnInit()
	self.rtMarks = self._tf:Find("AD/progress")
	self.rtFinish = self._tf:Find("AD/award")
	self.rtBtns = self._tf:Find("AD/btn_list")

	return
end

function CelebrationPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function CelebrationPage:OnFirstFlush()
	onButton(self, self.rtBtns:Find("go"), function()
		self:emit(ActivityMediator.OPEN_LAYER, (Context.New({
			mediator = HolidayVillaShopMediator,
			viewComponent = HolidayVillaShopLayer
		})))

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

function CelebrationPage:OnUpdateFlush()
	local var_6_0 = self.ptData:GetCurrTarget()
	local var_6_1 = self.ptData:GetLevel()

	for iter_6_0 = 1, self.rtMarks.childCount do
		local var_6_2 = self.rtMarks:GetChild(iter_6_0 - 1)

		setActive(var_6_2:Find("icon"), iter_6_0 <= var_6_0)
		setActive(var_6_2:Find("mark"), var_6_0 < iter_6_0)
	end

	setActive(self.rtBtns:Find("get"), var_6_1 == 0 and var_6_0 >= 7)
	setActive(self.rtBtns:Find("got"), var_6_1 > 0)
	setActive(self.rtBtns:Find("go"), var_6_0 < 7)
	setActive(self.rtBtns:Find("red"), var_6_1 == 0 and var_6_0 >= 7 and var_6_1 ~= 1)

	return
end

return CelebrationPage
