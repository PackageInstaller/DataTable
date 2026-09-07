local WinterFestival2025ShrinePage = class("WinterFestival2025ShrinePage", import("view.activity.CorePage.CoreActivityPage"))

WinterFestival2025ShrinePage.GO_MINI_GAME_ID = 80

function WinterFestival2025ShrinePage:getUIName()
	return "WinterFestival2025ShrinePage"
end

function WinterFestival2025ShrinePage:OnInit()
	local var_2_0 = self._tf:Find("AD")

	self.progressTpl = var_2_0:Find("progress_tpl")
	self.progressTplContainer = var_2_0:Find("progress")
	self.progressUIItemList = UIItemList.New(self.progressTplContainer, self.progressTpl)

	local var_2_1 = var_2_0:Find("Award")

	self.lockTF = var_2_1:Find("Unlock")
	self.getTag = var_2_1:Find("Achieve")
	self.gotTag = var_2_1:Find("Got")
	self.goBtn = var_2_0:Find("btn_go")
	self.goBtnRedDot = self.goBtn:Find("red")
	self.gotBtn = var_2_0:Find("btn_got")
	self.getBtn = var_2_0:Find("btn_get")

	setActive(self.gotBtn, false)

	return
end

function WinterFestival2025ShrinePage:OnDataSetting()
	self.isAchieved = self.activity.data1
	self.playCount = self.activity.data2
	self.startTimestamp = self.activity.data3
	self.maxDay = self.activity:getConfig("config_id")
	self.dayFromStart = pg.TimeMgr.GetInstance():DiffDay(self.startTimestamp, pg.TimeMgr.GetInstance():GetServerTime()) + 1
	self.curDay = math.clamp(self.dayFromStart, 1, self.maxDay)
	self.storyIDTable = {}

	local var_3_0 = self.activity:getConfig("config_client")

	if var_3_0 and type(var_3_0) == "table" then
		if var_3_0.story then
			for iter_3_0, iter_3_1 in ipairs(var_3_0.story) do
				if iter_3_1[1] then
					self.storyIDTable[iter_3_0] = iter_3_1[1]
				end
			end
		end
	end

	print(tostring(self.isAchieved), tostring(self.playCount), tostring(self.curDay))

	return
end

function WinterFestival2025ShrinePage:OnFirstFlush()
	local var_4_0 = math.clamp(self.playCount, 0, self.maxDay)

	self.progressUIItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_5_1 = arg_5_1 + 1

			if arg_5_1 <= self.curDay then
				setActive(arg_5_2, arg_5_1 <= var_4_0)
			else
				setActive(arg_5_2, false)
			end
		end

		return
	end)
	self.progressUIItemList:align(self.maxDay)
	onButton(self, self.getBtn, function()
		if self.curDay >= self.maxDay and self.playCount >= self.maxDay and self.isAchieved <= 0 then
			self:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = self.activity.id
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, WinterFestival2025ShrinePage.GO_MINI_GAME_ID, {})

		return
	end, SFX_PANEL)

	local var_4_1 = {}
	local var_4_2 = pg.NewStoryMgr.GetInstance()
	local var_4_3 = math.clamp(self.playCount, 0, self.maxDay)

	for iter_4_0 = 1, self.maxDay do
		local var_4_4 = self.storyIDTable[iter_4_0]

		if self.storyIDTable[iter_4_0] and iter_4_0 <= self.curDay and iter_4_0 <= var_4_3 then
			table.insert(var_4_1, function(arg_8_0)
				var_4_2:Play(var_4_4, arg_8_0)

				return
			end)
		end
	end

	seriesAsync(var_4_1, function()
		print("play story done,count:", #var_4_1)

		return
	end)

	return
end

function WinterFestival2025ShrinePage:OnUpdateFlush()
	setActive(self.gotTag, self.isAchieved > 0)
	setActive(self.goBtnRedDot, Shrine2022View.IsNeedShowTipForShipCount())

	if self.curDay >= self.maxDay and self.playCount >= self.maxDay and self.isAchieved <= 0 then
		setActive(self.lockTF, false)
		setActive(self.getTag, true)
		setActive(self.getBtn, true)
		setActive(self.goBtn, false)
	elseif self.isAchieved > 0 then
		setActive(self.lockTF, false)
		setActive(self.getTag, true)
		setActive(self.getBtn, false)
		setActive(self.goBtn, true)
	else
		setActive(self.lockTF, true)
		setActive(self.getTag, false)
		setActive(self.getBtn, false)
		setActive(self.goBtn, true)
	end

	return
end

return WinterFestival2025ShrinePage
