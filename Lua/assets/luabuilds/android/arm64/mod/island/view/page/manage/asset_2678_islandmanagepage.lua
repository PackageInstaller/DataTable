local IslandManagePage = class("IslandManagePage", import("...base.IslandBasePage"))

function IslandManagePage:getUIName()
	return "IslandManageUI"
end

function IslandManagePage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_manage_title"))

	local var_2_0 = self._tf:Find("window/view/content")
	local var_2_1 = var_2_0:Find("tpl")

	setText(var_2_1:Find("bg/event/Text"), i18n("island_manage_sp_event"))
	setText(var_2_1:Find("bg/status/prepare/Text"), i18n("island_manage_no_work"))
	setText(var_2_1:Find("bg/status/end/Text"), i18n("island_manage_end_work"))
	setText(var_2_1:Find("btns/opening/Text"), i18n("island_manage_view"))
	setText(var_2_1:Find("btns/close/Text"), i18n("island_manage_result"))

	self.uiList = UIItemList.New(var_2_0, var_2_1)

	return
end

function IslandManagePage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			onButton(self, arg_5_2:Find("btns/prepare"), function()
				self:OpenPage(IslandRestaurantPage, self.restIds[arg_5_1 + 1])

				return
			end, SFX_PANEL)
			onButton(self, arg_5_2:Find("btns/opening"), function()
				self:OpenPage(IslandRestaurantPage, self.restIds[arg_5_1 + 1])

				return
			end, SFX_PANEL)
			onButton(self, arg_5_2:Find("btns/close"), function()
				self:OpenPage(IslandRestaurantPage, self.restIds[arg_5_1 + 1])

				return
			end, SFX_PANEL)
		elseif arg_5_0 == UIItemList.EventUpdate then
			self:UpdataRest(arg_5_1, arg_5_2)
		end

		return
	end)

	self.restIds = pg.island_manage_restaurant.all

	return
end

function IslandManagePage:AddListeners()
	self:AddListener(IslandManageAgecny.UPDATE_RESTAURANT, self.Flush)
	self:AddListener(IslandManageAgecny.ADD_RESTAURANT, self.Flush)
	self:AddListener(IslandManageAgecny.ON_DAILY_REFRESH, self.Flush)

	return
end

function IslandManagePage:RemoveListeners()
	self:RemoveListener(IslandManageAgecny.UPDATE_RESTAURANT, self.Flush)
	self:RemoveListener(IslandManageAgecny.ADD_RESTAURANT, self.Flush)
	self:RemoveListener(IslandManageAgecny.ON_DAILY_REFRESH, self.Flush)

	return
end

function IslandManagePage:OnShow()
	self:BlurPanel()
	self:Flush()

	local var_11_0 = {}

	self.uiList:eachActive(function(arg_12_0, arg_12_1)
		arg_12_1:GetComponent(typeof(CanvasGroup)).alpha = 0

		table.insert(var_11_0, function(arg_13_0)
			arg_12_1:GetComponent(typeof(Animation)):Play()
			self:managedTween(LeanTween.delayedCall, function()
				arg_13_0()

				return
			end, 0.05, nil)

			return
		end)

		return
	end)
	seriesAsync(var_11_0)

	return
end

function IslandManagePage:OnEnable()
	self:Flush()

	return
end

function IslandManagePage:Flush()
	self:StopTimer()

	self.rests = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurants()

	table.sort(self.restIds, CompareFuncs({
		function(arg_17_0)
			return self.rests[arg_17_0] and 0 or 1
		end,
		function(arg_18_0)
			return arg_18_0
		end
	}))
	self.uiList:align(#self.restIds)
	self:StartTimer()
	self:UpdateTime()

	return
end

function IslandManagePage:UpdataRest(arg_19_1, arg_19_2)
	arg_19_2.name = self.restIds[arg_19_1 + 1]

	LoadImageSpriteAsync("island/islandrestaurant/" .. pg.island_manage_restaurant[self.restIds[arg_19_1 + 1]].icon, arg_19_2:Find("bg"))
	setText(arg_19_2:Find("bg/name/Text"), pg.island_manage_restaurant[self.restIds[arg_19_1 + 1]].name)
	setText(arg_19_2:Find("bg/name_en/Text"), pg.island_manage_restaurant[self.restIds[arg_19_1 + 1]].name_en)

	local var_19_0 = self.rests[self.restIds[arg_19_1 + 1]]

	setActive(arg_19_2:Find("bg/rank"), not not self.rests[self.restIds[arg_19_1 + 1]])
	setActive(arg_19_2:Find("bg/lock"), not self.rests[self.restIds[arg_19_1 + 1]])
	setActive(arg_19_2:Find("bg/event"), not not self.rests[self.restIds[arg_19_1 + 1]])
	setActive(arg_19_2:Find("bg/status"), not not self.rests[self.restIds[arg_19_1 + 1]])
	setActive(arg_19_2:Find("btns"), not not self.rests[self.restIds[arg_19_1 + 1]])

	if var_19_0 then
		local var_19_1 = var_19_0:getConfig("opening_number")
		local var_19_2 = var_19_0:GetRemainCnt()

		setText(arg_19_2:Find("btns/prepare/Text"), string.format("%s(%d/%d)", i18n("island_manage_prepare"), var_19_2, var_19_1))
		setText(arg_19_2:Find("btns/end/Text"), string.format("%s(%d/%d)", i18n("island_manage_daily_cnt_tip"), var_19_2, var_19_1))
		LoadImageSpriteAsync("island/islandrestaurant/" .. var_19_0:GetRankIcon(), arg_19_2:Find("bg/rank"))
		setActive(arg_19_2:Find("bg/event"), var_19_0:GetEventInfo() ~= 0)
		self:UpdataStatusInfo(arg_19_2, var_19_0)
	end

	return
end

function IslandManagePage:UpdataStatusInfo(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2:GetStatus()
	local var_20_1 = var_20_0 == IslandRestaurant.STATUS.OPENING or var_20_0 == IslandRestaurant.STATUS.CLOSE

	setActive(arg_20_1:Find("bg/status/prepare"), var_20_0 == IslandRestaurant.STATUS.PREPARE)
	setActive(arg_20_1:Find("bg/status/opening"), var_20_1)
	setActive(arg_20_1:Find("bg/status/end"), var_20_0 == IslandRestaurant.STATUS.END)

	if var_20_0 == IslandRestaurant.STATUS.OPENING then
		local var_20_2 = pg.TimeMgr.GetInstance()

		setText(arg_20_1:Find("bg/status/opening/Text"), var_20_2:DescCDTime(arg_20_2:GetEndTime() - var_20_2:GetServerTime()))
	elseif var_20_0 == IslandRestaurant.STATUS.CLOSE then
		setText(arg_20_1:Find("bg/status/opening/Text"), "00:00:00")
	end

	eachChild(arg_20_1:Find("btns"), function(arg_21_0)
		setActive(arg_21_0, arg_21_0.name == var_20_0)

		return
	end)

	return
end

function IslandManagePage:UpdateTime()
	self.uiList:eachActive(function(arg_23_0, arg_23_1)
		if self.rests[self.restIds[arg_23_0 + 1]] then
			self:UpdataStatusInfo(arg_23_1, self.rests[self.restIds[arg_23_0 + 1]])
		end

		return
	end)

	return
end

function IslandManagePage:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTime()

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function IslandManagePage:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandManagePage:OnHide()
	self:StopTimer()
	self:UnBlurPanel()

	return
end

function IslandManagePage:OnDisable()
	self:OnHide()

	return
end

function IslandManagePage:OnDestroy()
	self:OnHide()

	return
end

return IslandManagePage
