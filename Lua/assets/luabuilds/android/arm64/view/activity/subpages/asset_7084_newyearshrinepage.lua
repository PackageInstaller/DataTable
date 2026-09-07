local NewYearShrinePage = class("NewYearShrinePage", import("...base.BaseActivityPage"))

NewYearShrinePage.MAX_COUNT = 7
NewYearShrinePage.GO_MINI_GAME_ID = 34
NewYearShrinePage.GO_BACKHILL_SCENE = SCENE.NEWYEAR_BACKHILL_2022

function NewYearShrinePage:OnInit()
	self.progressTpl = self._tf:Find("ProgressTpl")
	self.progressTplContainer = self._tf:Find("ProgressList")
	self.progressUIItemList = UIItemList.New(self.progressTplContainer, self.progressTpl)
	self.countText = self._tf:Find("CountText")

	local var_1_0 = self._tf:Find("Award")

	self.lockTF = var_1_0:Find("Unlock")
	self.getBtn = var_1_0:Find("Achieve")
	self.gotTag = var_1_0:Find("Got")
	self.goBtn = self._tf:Find("GoBtn")

	return
end

function NewYearShrinePage:OnDataSetting()
	self.isAchieved = self.activity.data1
	self.playCount = self.activity.data2
	self.startTimestamp = self.activity.data3
	self.dayFromStart = pg.TimeMgr.GetInstance():DiffDay(self.startTimestamp, pg.TimeMgr.GetInstance():GetServerTime()) + 1
	self.curDay = math.clamp(self.dayFromStart, 1, NewYearShrinePage.MAX_COUNT)
	self.storyIDTable = {}

	local var_2_0 = self.activity:getConfig("config_client").story

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if iter_2_1[1] then
				self.storyIDTable[iter_2_0] = iter_2_1[1]
			end
		end
	end

	return
end

function NewYearShrinePage:OnFirstFlush()
	local var_3_0 = math.clamp(self.playCount, 0, NewYearShrinePage.MAX_COUNT)

	setText(self.countText, var_3_0)
	self.progressUIItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_4_2:Find("Achieve")
			local var_4_1 = arg_4_2:Find("Unlock")

			setActive(arg_4_2:Find("Lock"), not (arg_4_1 <= self.curDay))

			if arg_4_1 <= self.curDay then
				setActive(var_4_0, arg_4_1 <= var_3_0)
				setActive(var_4_1, arg_4_1 > var_3_0)
			else
				setActive(var_4_0, false)
				setActive(var_4_1, true)
			end
		end

		return
	end)
	self.progressUIItemList:align(NewYearShrinePage.MAX_COUNT)
	onButton(self, self.getBtn, function()
		if self.curDay >= NewYearShrinePage.MAX_COUNT and self.playCount >= NewYearShrinePage.MAX_COUNT and self.isAchieved <= 0 then
			self:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = self.activity.id
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, NewYearShrinePage.GO_MINI_GAME_ID, {
			callback = function()
				local var_7_0 = Context.New()

				SCENE.SetSceneInfo(var_7_0, NewYearShrinePage.GO_BACKHILL_SCENE)
				getProxy(ContextProxy):PushContext2Prev(var_7_0)

				return
			end
		})

		return
	end, SFX_PANEL)

	local var_3_1 = {}
	local var_3_2 = pg.NewStoryMgr.GetInstance()
	local var_3_3 = math.clamp(self.playCount, 0, NewYearShrinePage.MAX_COUNT)

	for iter_3_0 = 1, NewYearShrinePage.MAX_COUNT do
		local var_3_4 = self.storyIDTable[iter_3_0]

		if self.storyIDTable[iter_3_0] and iter_3_0 <= self.curDay and iter_3_0 <= var_3_3 then
			table.insert(var_3_1, function(arg_8_0)
				var_3_2:Play(var_3_4, arg_8_0)

				return
			end)
		end
	end

	seriesAsync(var_3_1, function()
		print("play story done,count:", #var_3_1)

		return
	end)

	return
end

function NewYearShrinePage:OnUpdateFlush()
	setActive(self.gotTag, self.isAchieved > 0)

	if self.curDay >= NewYearShrinePage.MAX_COUNT and self.playCount >= NewYearShrinePage.MAX_COUNT and self.isAchieved <= 0 then
		setActive(self.lockTF, false)
		setActive(self.getBtn, true)
		triggerButton(self.getBtn)
	elseif self.isAchieved > 0 then
		setActive(self.lockTF, false)
		setActive(self.getBtn, true)
	else
		setActive(self.lockTF, true)
		setActive(self.getBtn, false)
	end

	return
end

function NewYearShrinePage:OnDestroy()
	return
end

function NewYearShrinePage.IsTip()
	local var_12_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.NEWYEAR_SHRINE_PAGE_ID.act_id)

	if var_12_0 and not var_12_0:isEnd() then
		return math.clamp(pg.TimeMgr.GetInstance():DiffDay(var_12_0.data3, pg.TimeMgr.GetInstance():GetServerTime()) + 1, 1, NewYearShrinePage.MAX_COUNT) > math.clamp(var_12_0.data2, 0, NewYearShrinePage.MAX_COUNT)
	end

	return
end

return NewYearShrinePage
