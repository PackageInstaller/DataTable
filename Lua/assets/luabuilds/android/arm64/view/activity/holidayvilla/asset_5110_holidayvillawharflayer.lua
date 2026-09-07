local HolidayVillaWharfLayer = class("HolidayVillaWharfLayer", import("view.base.BaseUI"))
local var_0_1 = pg.activity_holiday_trans

function HolidayVillaWharfLayer:getUIName()
	return "HolidayVillaWharfUI"
end

function HolidayVillaWharfLayer:init()
	self.bg = self._tf:Find("bg")
	self.closeBtn = self._tf:Find("closeBtn")
	self.res = self._tf:Find("res")
	self.wharfResCount = self._tf:Find("frame/resNum")
	self.transportList = self._tf:Find("frame/transportList")
	self.transportCompletePage = self._tf:Find("transportCompletePage")

	setText(self._tf:Find("frame/nameBg/name"), i18n("holiday_tip_trans_tip"))
	setText(self._tf:Find("frame/resDesc"), i18n("holiday_tip_trans_get"))

	return
end

function HolidayVillaWharfLayer:didEnter()
	self:InitData()
	self:RefreshData()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	self:Show()
	setActive(self.transportCompletePage, false)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function HolidayVillaWharfLayer:InitData()
	self.activityId = ActivityConst.HOLIDAY_ACT_ID
	self.taskActivityId = ActivityConst.HOLIDAY_TASK_ID
	self.activityProxy = getProxy(ActivityProxy)
	self.taskProxy = getProxy(TaskProxy)
	self.activity = self.activityProxy:getActivityById(self.activityId)
	self.transTaskIds = self.activity:getConfig("config_client").task_trans

	return
end

function HolidayVillaWharfLayer:RefreshData()
	self.activity = self.activityProxy:getActivityById(self.activityId)

	return
end

function HolidayVillaWharfLayer:Show()
	self:SetRes(self.res, {
		{
			66001,
			self.activity:getVitemNumber(66001)
		},
		{
			66002,
			self.activity:getVitemNumber(66002)
		},
		{
			66003,
			self.activity:getVitemNumber(66003)
		},
		{
			66004,
			self.activity:getVitemNumber(66004)
		}
	})
	setText(self.wharfResCount, self.activity:getVitemNumber(66006))

	local var_8_0 = true

	for iter_8_0, iter_8_1 in ipairs(self.transTaskIds) do
		if not self.taskProxy:getFinishTaskById(iter_8_1) then
			var_8_0 = false

			break
		end
	end

	if not var_8_0 then
		setText(self._tf:Find("frame/desc"), i18n("holiday_tip_trans_desc1"))
		self:SetTransList(1)
	else
		setText(self._tf:Find("frame/desc"), i18n("holiday_tip_trans_desc2"))
		self:SetTransList(2)
	end

	return
end

function HolidayVillaWharfLayer:SetTransList(arg_9_1)
	local var_9_0 = self.transportList:Find("smallTransport")
	local var_9_1 = self.transportList:Find("middleTransport")
	local var_9_2 = self.transportList:Find("bigTransport")
	local var_9_3 = self.transportList:Find("touristTransport")

	setActive(var_9_0, arg_9_1 == 1)
	setActive(var_9_1, arg_9_1 == 1)
	setActive(var_9_2, arg_9_1 == 1)
	setActive(var_9_3, arg_9_1 == 2)

	if arg_9_1 == 1 then
		self:SetTransport(var_9_0, var_0_1[1])
		self:SetTransport(var_9_1, var_0_1[2])
		self:SetTransport(var_9_2, var_0_1[3])
	elseif arg_9_1 == 2 then
		self:SetTransport(var_9_3, var_0_1[4])
	end

	return
end

function HolidayVillaWharfLayer:SetTransport(arg_10_1, arg_10_2)
	setText(arg_10_1:Find("name"), arg_10_2.name)
	LoadImageSpriteAsync(arg_10_2.icon, arg_10_1:Find("picture"))

	local var_10_0 = self.taskProxy:getTaskById(arg_10_2.cost_task_id):getConfig("target_id_2")[1][2]

	setText(arg_10_1:Find("resConsume"), var_10_0)

	local var_10_1 = Clone(arg_10_2.award)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		table.remove(iter_10_1, 1)
	end

	self:SetRes(arg_10_1:Find("awards"), var_10_1)
	onButton(self, arg_10_1, function()
		if self.activity:getVitemNumber(66006) < var_10_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("holiday_tip_trans_not"))

			return
		end

		self.doingTransCfg = arg_10_2

		self:emit(HolidayVillaWharfMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
			arg_10_2.cost_task_id
		})

		return
	end, SFX_PANEL)

	return
end

function HolidayVillaWharfLayer:SetRes(arg_12_1, arg_12_2)
	for iter_12_0 = 0, arg_12_1.childCount - 1 do
		setActive(arg_12_1:GetChild(iter_12_0), false)
	end

	for iter_12_1, iter_12_2 in ipairs(arg_12_2) do
		for iter_12_3 = 0, arg_12_1.childCount - 1 do
			local var_12_0 = arg_12_1:GetChild(iter_12_3)

			if var_12_0.name == tostring(iter_12_2[1]) then
				setActive(var_12_0, true)
				setText(var_12_0:Find("Text"), iter_12_2[2])
			end
		end
	end

	return
end

function HolidayVillaWharfLayer:ShowCompletePage()
	setActive(self.transportCompletePage, true)
	pg.UIMgr.GetInstance():BlurPanel(self.transportCompletePage)
	SetAction(self.transportCompletePage:Find("ani"), "normal" .. self.doingTransCfg.id, false)
	setText(self.transportCompletePage:Find("desc/Text"), self.doingTransCfg.result_desc)
	setActive(self.transportCompletePage:Find("desc/triangle"), false)

	local var_13_0 = GetOrAddComponent(self.transportCompletePage:Find("desc/Text"), typeof(Typewriter))

	var_13_0:setSpeed(0.05)

	function var_13_0.endFunc()
		setActive(self.transportCompletePage:Find("desc/triangle"), true)

		return
	end

	var_13_0:Play()
	onButton(self, self.transportCompletePage:Find("bg"), function()
		setActive(self.transportCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.transportCompletePage, self._tf)

		if not self.hasShowedAwards and #self.awards > 0 then
			self.hasShowedAwards = true

			self:emit(BaseUI.ON_ACHIEVE, self.awards)
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.transportCompletePage:Find("desc"), function()
		setActive(self.transportCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.transportCompletePage, self._tf)

		if not self.hasShowedAwards and #self.awards > 0 then
			self.hasShowedAwards = true

			self:emit(BaseUI.ON_ACHIEVE, self.awards)
		end

		return
	end, SFX_CANCEL)

	return
end

function HolidayVillaWharfLayer:SetAwardsShow(arg_17_1)
	self.awards = arg_17_1
	self.hasShowedAwards = false

	return
end

function HolidayVillaWharfLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function HolidayVillaWharfLayer:onBackPressed()
	if isActive(self.transportCompletePage) then
		setActive(self.transportCompletePage, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.transportCompletePage, self._tf)

		if not self.hasShowedAwards and #self.awards > 0 then
			self.hasShowedAwards = true

			self:emit(BaseUI.ON_ACHIEVE, self.awards)
		end

		return
	end

	self:closeView()

	return
end

return HolidayVillaWharfLayer
