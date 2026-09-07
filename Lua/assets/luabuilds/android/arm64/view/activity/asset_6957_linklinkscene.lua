local LinkLinkScene = class("LinkLinkScene", import("..base.BaseUI"))

LinkLinkScene.MAX_ROW = 6
LinkLinkScene.MAX_COLUMN = 11
LinkLinkScene.COUNT_DOWN = 3
LinkLinkScene.RESET_CD = 5
LinkLinkScene.GAME_STATE_BEGIN = 0
LinkLinkScene.GAME_STATE_GAMING = 1
LinkLinkScene.GAME_STATE_END = 2
LinkLinkScene.CARD_STATE_NORMAL = 0
LinkLinkScene.CARD_STATE_LINKED = 1
LinkLinkScene.CARD_STATE_BLANK = 2

function LinkLinkScene:getUIName()
	return "LinkLinkUI"
end

function LinkLinkScene:init()
	self.backBtn = self._tf:Find("BackBtn")
	self.helpBtn = self._tf:Find("top/help_btn")
	self.resetBtn = self._tf:Find("info/reset_button")
	self.awardTxt = self._tf:Find("info/award_txt")
	self.timeTxt = self._tf:Find("info/time_txt")
	self.bestTxt = self._tf:Find("info/best_txt")
	self.layout = self._tf:Find("card_con/layout")
	self.item = self.layout:Find("card")
	self.bottom = self._tf:Find("card_con/bottom")
	self.line = self.bottom:Find("card")
	self.result = self._tf:Find("result")
	self.countDown = self._tf:Find("count_down")
	self.resource = self._tf:Find("resource")
	self.bestTitleText = self._tf:Find("info/BestTitle")
	self.curTitleText = self._tf:Find("info/CurTitle")

	setText(self.bestTitleText, i18n("LinkLinkGame_BestTime"))
	setText(self.curTitleText, i18n("LinkLinkGame_CurTime"))

	return
end

function LinkLinkScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(LinkLinkScene.ON_BACK)

		return
	end, SOUND_BACK)
	self:SetState(LinkLinkScene.GAME_STATE_BEGIN)

	return
end

function LinkLinkScene:willExit()
	self:HideResult()
	LeanTween.cancel(go(self.countDown))

	for iter_5_0 = 0, self.layout.childCount - 1 do
		LeanTween.cancel(go(self.layout:GetChild(iter_5_0)))
	end

	if self.countTimer then
		self.countTimer:Stop()

		self.countTimer = nil
	end

	return
end

function LinkLinkScene:SetPlayer(arg_6_1)
	self.player = arg_6_1

	return
end

function LinkLinkScene:SetActivity(arg_7_1)
	self.activity = arg_7_1
	self.activityAchieved = arg_7_1.data1
	self.activityProgress = arg_7_1.data2
	self.activityStartTime = arg_7_1.data3
	self.activityBestRecord = arg_7_1.data4

	local var_7_0 = self.activity:getConfig("config_client")[3]
	local var_7_1 = pg.TimeMgr.GetInstance()

	self.activityRestTimes = var_7_1:DiffDay(self.activityStartTime, var_7_1:GetServerTime()) + 1 - self.activityProgress
	self.activityRestTimes = math.clamp(self.activityRestTimes, 0, #var_7_0 - self.activityProgress)

	setText(self.awardTxt, (self.activityRestTimes > 0 or nil) and (var_7_0[self.activityProgress + 1] or 0))
	setText(self.bestTxt, self:FormatRecordTime(self.activityBestRecord))

	return
end

function LinkLinkScene:SetState(arg_8_1)
	if self.state ~= arg_8_1 then
		self.state = arg_8_1

		if arg_8_1 == LinkLinkScene.GAME_STATE_BEGIN then
			self:GameBegin()
		elseif arg_8_1 == LinkLinkScene.GAME_STATE_GAMING then
			self:GameLoop()
		elseif arg_8_1 == LinkLinkScene.GAME_STATE_END then
			self:GameEnd()
		end
	end

	return
end

function LinkLinkScene:GameBegin()
	self.cards = {}

	local var_9_0 = {}

	for iter_9_0 = 0, 17 do
		table.insert(var_9_0, iter_9_0)
		table.insert(var_9_0, iter_9_0)
	end

	while #var_9_0 > 0 do
		local var_9_1 = math.clamp(math.floor(math.random() * #var_9_0 + 1), 1, #var_9_0)
		local var_9_2 = math.floor(0 / (LinkLinkScene.MAX_COLUMN - 2)) + 1

		self.cards[var_9_2] = self.cards[var_9_2] or {}
		self.cards[var_9_2][0 % (LinkLinkScene.MAX_COLUMN - 2) + 1] = {
			row = var_9_2,
			column = 0 % (LinkLinkScene.MAX_COLUMN - 2) + 1,
			id = var_9_0[var_9_1],
			state = LinkLinkScene.CARD_STATE_NORMAL
		}

		table.remove(var_9_0, var_9_1)
	end

	for iter_9_1 = 0, LinkLinkScene.MAX_ROW - 1 do
		for iter_9_2 = 0, LinkLinkScene.MAX_COLUMN - 1 do
			self.cards[iter_9_1] = self.cards[iter_9_1] or {}
			self.cards[iter_9_1][iter_9_2] = self.cards[iter_9_1][iter_9_2] or {
				row = iter_9_1,
				column = iter_9_2,
				state = LinkLinkScene.CARD_STATE_BLANK
			}
		end
	end

	self.list = UIItemList.New(self.layout, self.item)

	self.list:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = math.floor(arg_10_1 / LinkLinkScene.MAX_COLUMN)
			local var_10_1 = self.cards[var_10_0][arg_10_1 % LinkLinkScene.MAX_COLUMN]

			arg_10_2.name = var_10_0 .. "_" .. arg_10_1 % LinkLinkScene.MAX_COLUMN
			arg_10_2.localScale = Vector3.one

			setActive(arg_10_2:Find("display"), var_10_1.state == LinkLinkScene.CARD_STATE_NORMAL)

			if var_10_1.state == LinkLinkScene.CARD_STATE_NORMAL then
				setImageSprite(arg_10_2:Find("display/icon"), (getImageSprite(self.resource:GetChild(var_10_1.id))))
				setActive(arg_10_2:Find("display/selected"), false)
			end
		end

		return
	end)
	self.list:align(LinkLinkScene.MAX_ROW * LinkLinkScene.MAX_COLUMN)

	self.llist = UIItemList.New(self.bottom, self.line)

	self.llist:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = arg_11_2:Find("lines")

			for iter_11_0 = 0, var_11_0.childCount - 1 do
				setActive(var_11_0:GetChild(iter_11_0), false)
			end
		end

		return
	end)
	self.llist:align(LinkLinkScene.MAX_ROW * LinkLinkScene.MAX_COLUMN)
	setActive(self.countDown, true)

	for iter_9_3 = 0, self.countDown.childCount - 1 do
		setActive(self.countDown:GetChild(iter_9_3), false)
	end

	local var_9_4 = 0
	local var_9_5 = self.countDown:GetChild(0)

	setActive(var_9_5, true)
	setImageAlpha(var_9_5, 0)
	LeanTween.value(go(self.countDown), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_12_0)
		arg_12_0 = math.min(arg_12_0 / 0.3, 1)

		setImageAlpha(var_9_5, arg_12_0)
		setLocalScale(var_9_5, {
			x = (1 - arg_12_0) * 2 + 1,
			y = (1 - arg_12_0) * 2 + 1
		})

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_9_5, false)

		var_9_4 = var_9_4 + 1

		if var_9_4 < self.countDown.childCount then
			var_9_5 = self.countDown:GetChild(var_9_4)

			setActive(var_9_5, true)
			setImageAlpha(var_9_5, 0)
		else
			setActive(self.countDown, false)
			self:SetState(LinkLinkScene.GAME_STATE_GAMING)
		end

		return
	end)):setRepeat(4):setLoopType(LeanTweenType.punch):setOnCompleteOnRepeat(true):setEase(LeanTweenType.easeOutSine)

	return
end

function LinkLinkScene:GameLoop()
	local function var_14_0(arg_15_0)
		local var_15_0 = 0

		for iter_15_0 = 1, #arg_15_0 - 1 do
			local var_15_1 = arg_15_0[iter_15_0 + 1].row - arg_15_0[iter_15_0].row
			local var_15_2 = arg_15_0[iter_15_0 + 1].column - arg_15_0[iter_15_0].column
			local var_15_3 = self.bottom:GetChild(arg_15_0[iter_15_0].row * LinkLinkScene.MAX_COLUMN + arg_15_0[iter_15_0].column):Find("lines")

			for iter_15_1 = 0, var_15_3.childCount - 1 do
				setActive(var_15_3:GetChild(iter_15_1), false)
			end

			if var_15_1 ~= 0 then
				setActive(var_15_3:Find("y" .. var_15_1), true)
			elseif var_15_2 ~= 0 then
				setActive(var_15_3:Find("x" .. var_15_2), true)
			end

			if var_15_1 ~= 0 and var_15_2 ~= var_15_0 then
				local var_15_5 = (var_15_1 == -1 and var_15_0 == 1 or 0 == 1 and var_15_2 == -1) and 0 or (var_15_2 == -1 and 0 == -1 or var_15_1 == 1 and var_15_0 == 1) and 90 or (var_15_1 == 1 and var_15_0 == -1 or 0 == -1 and var_15_2 == 1) and 180 or 270
				local var_15_6 = var_15_3:Find("joint")

				setActive(var_15_6, true)

				var_15_6.localEulerAngles = Vector3(0, 0, var_15_5)
			elseif 0 == 0 and var_15_1 ~= 0 or 0 ~= 0 and var_15_1 == 0 then
				local var_15_7 = var_15_3:Find("cross")

				setActive(var_15_7, true)

				var_15_7.localEulerAngles = Vector3(0, 0, 90)
			elseif var_15_0 == 0 and var_15_2 ~= 0 or var_15_0 ~= 0 and var_15_2 == var_15_0 then
				local var_15_8 = var_15_3:Find("cross")

				setActive(var_15_8, true)

				var_15_8.localEulerAngles = Vector3(0, 0, 0)
				var_15_0 = var_15_2
			end
		end

		return
	end

	local function var_14_1(arg_16_0)
		for iter_16_0 = 1, #arg_16_0 - 1 do
			local var_16_0 = self.bottom:GetChild(arg_16_0[iter_16_0].row * LinkLinkScene.MAX_COLUMN + arg_16_0[iter_16_0].column):Find("lines")

			for iter_16_1 = 0, var_16_0.childCount - 1 do
				setActive(var_16_0:GetChild(iter_16_1), false)
			end
		end

		return
	end

	local var_14_2
	local var_14_3
	local var_14_4

	self.list:each(function(arg_17_0, arg_17_1)
		onButton(self, arg_17_1:Find("display/icon"), function()
			local var_18_0 = self.cards[math.floor(arg_17_0 / LinkLinkScene.MAX_COLUMN)][arg_17_0 % LinkLinkScene.MAX_COLUMN]

			if var_18_0.state ~= LinkLinkScene.CARD_STATE_NORMAL then
				return
			elseif not var_14_2 then
				var_14_2 = var_18_0
				var_14_3 = arg_17_1

				setActive(arg_17_1:Find("display/selected"), true)
			elseif var_14_4 then
				return
			elseif var_14_2 == var_18_0 then
				setActive(arg_17_1:Find("display/selected"), false)

				var_14_3 = nil
				var_14_2 = nil
			elseif var_14_2.id ~= var_18_0.id then
				setActive(var_14_3:Find("display/selected"), false)

				var_14_3 = nil
				var_14_2 = nil
			else
				local var_18_1 = self:LinkLink(var_14_2, var_18_0)

				if not var_18_1 then
					setActive(var_14_3:Find("display/selected"), false)

					var_14_3 = nil
					var_14_2 = nil
				else
					var_18_0.state = LinkLinkScene.CARD_STATE_LINKED
					var_14_2.state = LinkLinkScene.CARD_STATE_LINKED

					setActive(arg_17_1:Find("display/selected"), true)
					var_14_0(var_18_1)

					var_14_4 = true

					local var_18_2 = arg_17_1
					local var_18_3 = var_14_3

					LeanTween.value(go(arg_17_1), 1, 0.15, 0.3):setEase(LeanTweenType.easeInBack):setOnUpdate(System.Action_float(function(arg_19_0)
						var_18_2.localScale = Vector3(arg_19_0, arg_19_0, 1)
						var_18_3.localScale = Vector3(arg_19_0, arg_19_0, 1)

						return
					end)):setOnComplete(System.Action(function()
						var_14_1(var_18_1)
						setActive(var_18_2:Find("display"), false)
						setActive(var_18_3:Find("display"), false)

						var_14_4 = false

						return
					end))

					var_14_3 = nil
					var_14_2 = nil

					local var_18_4 = true

					for iter_18_0 = 0, LinkLinkScene.MAX_ROW - 1 do
						for iter_18_1 = 0, LinkLinkScene.MAX_COLUMN - 1 do
							if self.cards[iter_18_0][iter_18_1].state == LinkLinkScene.CARD_STATE_NORMAL then
								var_18_4 = false

								break
							end
						end
					end

					if var_18_4 then
						self:SetState(LinkLinkScene.GAME_STATE_END)
					end
				end
			end

			return
		end, SFX_PANEL)

		return
	end)

	if IsUnityEditor and AUTO_LINKLINK then
		setActive(self.helpBtn, true)
		onButton(self, self.helpBtn, function()
			var_14_2 = nil
			var_14_3 = nil

			for iter_21_0 = 0, LinkLinkScene.MAX_ROW - 1 do
				for iter_21_1 = 0, LinkLinkScene.MAX_COLUMN - 1 do
					local var_21_0 = self.layout:GetChild(self.cards[iter_21_0][iter_21_1].row * LinkLinkScene.MAX_COLUMN + self.cards[iter_21_0][iter_21_1].column)

					if self.cards[iter_21_0][iter_21_1].state == LinkLinkScene.CARD_STATE_NORMAL then
						for iter_21_2 = 0, LinkLinkScene.MAX_ROW - 1 do
							for iter_21_3 = 0, LinkLinkScene.MAX_COLUMN - 1 do
								if iter_21_0 == iter_21_2 then
									if iter_21_1 ~= iter_21_3 then
										if self.cards[iter_21_0][iter_21_1].id == self.cards[iter_21_2][iter_21_3].id then
											triggerButton(var_21_0:Find("display/icon"))
											triggerButton(self.layout:GetChild(self.cards[iter_21_2][iter_21_3].row * LinkLinkScene.MAX_COLUMN + self.cards[iter_21_2][iter_21_3].column):Find("display/icon"))

											if var_14_4 then
												Timer.New(function()
													triggerButton(self.helpBtn)

													return
												end, 0.4, 1):Start()

												return
											end
										end
									end
								end
							end
						end
					end
				end
			end

			return
		end)
	end

	local var_14_5 = 0

	onButton(self, self.resetBtn, function()
		if self.state ~= LinkLinkScene.GAME_STATE_GAMING then
			return
		elseif Time.realtimeSinceStartup - var_14_5 < LinkLinkScene.RESET_CD then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_wait"))
		else
			if var_14_2 then
				setActive(var_14_3:Find("display/selected"), false)

				var_14_3 = nil
				var_14_2 = nil
			end

			local var_23_0 = {}
			local var_23_1 = {}

			for iter_23_0 = 0, LinkLinkScene.MAX_ROW - 1 do
				for iter_23_1 = 0, LinkLinkScene.MAX_COLUMN - 1 do
					if self.cards[iter_23_0][iter_23_1].state == LinkLinkScene.CARD_STATE_NORMAL then
						table.insert(var_23_0, {
							row = iter_23_0,
							column = iter_23_1
						})
						table.insert(var_23_1, self.cards[iter_23_0][iter_23_1].id)
					end
				end
			end

			while #var_23_1 > 0 do
				local var_23_2 = math.clamp(math.floor(math.random() * #var_23_1 + 1), 1, #var_23_1)

				self.cards[var_23_0[1].row][var_23_0[1].column].id = var_23_1[var_23_2]

				table.remove(var_23_1, var_23_2)
			end

			self.list:each(function(arg_24_0, arg_24_1)
				local var_24_0 = self.cards[math.floor(arg_24_0 / LinkLinkScene.MAX_COLUMN)][arg_24_0 % LinkLinkScene.MAX_COLUMN]

				if var_24_0.state == LinkLinkScene.CARD_STATE_NORMAL then
					setImageSprite(arg_24_1:Find("display/icon"), (getImageSprite(self.resource:GetChild(var_24_0.id))))
				end

				return
			end)

			var_14_5 = Time.realtimeSinceStartup
		end

		return
	end, SFX_PANEL)

	self.startTime = Time.realtimeSinceStartup
	self.countTimer = Timer.New(function()
		setText(self.timeTxt, self:FormatRecordTime((math.floor((Time.realtimeSinceStartup - self.startTime) * 1000))))

		return
	end, 0.033, -1)

	self.countTimer:Start()
	self.countTimer.func()

	return
end

function LinkLinkScene:GameEnd()
	self.countTimer:Stop()

	self.countTimer = nil
	self.lastRecord = math.floor((Time.realtimeSinceStartup - self.startTime) * 1000)

	if self.activityRestTimes <= 0 then
		if self.lastRecord < self.activityBestRecord then
			local var_26_0 = {
				cmd = 1,
				activity_id = self.activity.id
			}

			var_26_0.arg1 = self.activityProgress + (self.activityRestTimes > 0 and 1 or 0)
			var_26_0.arg2 = self.lastRecord

			self:emit(LinkLinkMediator.EVENT_OPERATION, var_26_0)

			goto label_26_0
		end
	end

	self:DisplayResult(self.activity)

	::label_26_0::

	return
end

function LinkLinkScene:DisplayResult(arg_27_1)
	setActive(self.result, true)

	local var_27_0 = self.result:Find("bg")

	setActive(var_27_0:Find("pic_new_record"), arg_27_1.data4 < self.activityBestRecord)
	setActive(var_27_0:Find("pic_win"), arg_27_1.data4 >= self.activityBestRecord)
	setText(var_27_0:Find("time_txt"), self:FormatRecordTime(self.lastRecord))
	setText(var_27_0:Find("award_txt"), (arg_27_1.data2 > self.activityProgress or nil) and (arg_27_1:getConfig("config_client")[3][arg_27_1.data2] or 0))
	onButton(self, var_27_0:Find("button"), function()
		self:HideResult()
		self:SetActivity(arg_27_1)
		self:SetState(LinkLinkScene.GAME_STATE_BEGIN)

		return
	end, SFX_PANEL)
	onButton(self, self.result, function()
		triggerButton(self.backBtn)

		return
	end, SFX_CANCEL)
	pg.UIMgr.GetInstance():BlurPanel(self.result)

	return
end

function LinkLinkScene:HideResult()
	if isActive(self.result) then
		setActive(self.result, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.result, self._tf)
	end

	return
end

function LinkLinkScene:FormatRecordTime(arg_31_1)
	local var_31_0 = math.floor(arg_31_1 / 60000)

	var_31_0 = var_31_0 >= 10 and var_31_0 or "0" .. var_31_0

	local var_31_1 = math.floor(arg_31_1 % 60000 / 1000)

	var_31_1 = var_31_1 >= 10 and var_31_1 or "0" .. var_31_1

	local var_31_2 = math.floor(arg_31_1 % 1000 / 10)

	var_31_2 = var_31_2 >= 10 and var_31_2 or "0" .. var_31_2

	return var_31_0 .. "'" .. var_31_1 .. "'" .. var_31_2
end

function LinkLinkScene:LinkLink(arg_32_1, arg_32_2)
	assert(arg_32_1.row ~= arg_32_2.row or arg_32_1.column ~= arg_32_2.column)
	assert(arg_32_1.id == arg_32_2.id)

	local var_32_0 = {
		row = arg_32_1.row,
		column = arg_32_1.column
	}
	local var_32_1 = {
		row = arg_32_2.row,
		column = arg_32_2.column
	}
	local var_32_2 = {}
	local var_32_3 = {}

	table.insert(var_32_2, var_32_0)
	table.insert(var_32_3, var_32_0)

	for iter_32_0 = 1, 3 do
		local var_32_4 = self:IterateByOneSnap(var_32_1, arg_32_1.id, var_32_2, var_32_3)

		if var_32_4 then
			local var_32_5 = {
				var_32_4
			}

			while var_32_4 and var_32_4.from do
				if var_32_4.row ~= var_32_4.from.row then
					for iter_32_1 = var_32_4.row + (var_32_4.row > var_32_4.from.row and -1 or 1), var_32_4.from.row, var_32_4.row > var_32_4.from.row and -1 or 1 do
						table.insert(var_32_5, {
							row = iter_32_1,
							column = var_32_4.column
						})
					end
				elseif var_32_4.from.column ~= var_32_4.column then
					for iter_32_2 = var_32_4.column + (var_32_4.column > var_32_4.from.column and -1 or 1), var_32_4.from.column, var_32_4.column > var_32_4.from.column and -1 or 1 do
						table.insert(var_32_5, {
							row = var_32_4.row,
							column = iter_32_2
						})
					end
				else
					assert(false)
				end

				var_32_4 = var_32_4.from
			end

			return var_32_5
		end
	end

	return
end

function LinkLinkScene:IterateByOneSnap(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	for iter_33_0 = 1, #arg_33_3 do
		for iter_33_1, iter_33_2 in ipairs((self:FindDirectLinkPoint(arg_33_2, arg_33_3[iter_33_0], arg_33_4))) do
			if iter_33_2.row == arg_33_1.row and iter_33_2.column == arg_33_1.column then
				return iter_33_2
			end

			table.insert(arg_33_3, iter_33_2)
		end
	end

	_.each(arg_33_3, function(arg_34_0)
		arg_33_4[arg_34_0.row .. "_" .. arg_34_0.column] = true

		return
	end)

	return
end

function LinkLinkScene:FindDirectLinkPoint(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = {}

	for iter_35_0 = arg_35_2.row - 1, 0, -1 do
		if self.cards[iter_35_0][arg_35_2.column].state == LinkLinkScene.CARD_STATE_NORMAL and self.cards[iter_35_0][arg_35_2.column].id ~= arg_35_1 or arg_35_3[iter_35_0 .. "_" .. arg_35_2.column] then
			break
		end

		table.insert(var_35_0, {
			row = iter_35_0,
			column = arg_35_2.column,
			from = arg_35_2
		})
	end

	for iter_35_1 = arg_35_2.row + 1, LinkLinkScene.MAX_ROW - 1 do
		if self.cards[iter_35_1][arg_35_2.column].state == LinkLinkScene.CARD_STATE_NORMAL and self.cards[iter_35_1][arg_35_2.column].id ~= arg_35_1 or arg_35_3[iter_35_1 .. "_" .. arg_35_2.column] then
			break
		end

		table.insert(var_35_0, {
			row = iter_35_1,
			column = arg_35_2.column,
			from = arg_35_2
		})
	end

	for iter_35_2 = arg_35_2.column - 1, 0, -1 do
		if self.cards[arg_35_2.row][iter_35_2].state == LinkLinkScene.CARD_STATE_NORMAL and self.cards[arg_35_2.row][iter_35_2].id ~= arg_35_1 or arg_35_3[arg_35_2.row .. "_" .. iter_35_2] then
			break
		end

		table.insert(var_35_0, {
			row = arg_35_2.row,
			column = iter_35_2,
			from = arg_35_2
		})
	end

	for iter_35_3 = arg_35_2.column + 1, LinkLinkScene.MAX_COLUMN - 1 do
		if self.cards[arg_35_2.row][iter_35_3].state == LinkLinkScene.CARD_STATE_NORMAL and self.cards[arg_35_2.row][iter_35_3].id ~= arg_35_1 or arg_35_3[arg_35_2.row .. "_" .. iter_35_3] then
			break
		end

		table.insert(var_35_0, {
			row = arg_35_2.row,
			column = iter_35_3,
			from = arg_35_2
		})
	end

	return var_35_0
end

function LinkLinkScene:LinkLink1(arg_36_1, arg_36_2)
	assert(arg_36_1.row ~= arg_36_2.row or arg_36_1.column ~= arg_36_2.column)
	assert(arg_36_1.id == arg_36_2.id)

	local var_36_0
	local var_36_1 = {
		[arg_36_1.row .. "_" .. arg_36_1.column] = {
			rdir = 0,
			cdir = 0,
			snap = 0,
			row = arg_36_1.row,
			column = arg_36_1.column,
			path = {}
		}
	}
	local var_36_2 = {
		row = arg_36_2.row,
		column = arg_36_2.column
	}
	local var_36_3 = {
		{
			row = arg_36_1.row,
			column = arg_36_1.column
		}
	}
	local var_36_4 = {}

	while #var_36_3 > 0 do
		local var_36_5 = table.remove(var_36_3, 1)

		if var_36_5.row == var_36_2.row and var_36_5.column == var_36_2.column then
			var_36_0 = var_36_1[var_36_5.row .. "_" .. var_36_5.column].path

			break
		end

		table.insert(var_36_4, var_36_5)
		_.each({
			{
				row = 1,
				column = 0
			},
			{
				row = -1,
				column = 0
			},
			{
				row = 0,
				column = 1
			},
			{
				row = 0,
				column = -1
			}
		}, function(arg_37_0)
			arg_37_0.row = var_36_5.row + arg_37_0.row
			arg_37_0.column = var_36_5.column + arg_37_0.column

			if self.cards[arg_37_0.row] then
				local var_37_0 = self.cards[arg_37_0.row][arg_37_0.column] or nil

				if not (_.any(var_36_3, function(arg_38_0)
					return arg_38_0.row == arg_37_0.row and arg_38_0.column == arg_37_0.column
				end) or _.any(var_36_4, function(arg_39_0)
					return arg_39_0.row == arg_37_0.row and arg_39_0.column == arg_37_0.column
				end)) and (not var_37_0 or var_37_0.state == LinkLinkScene.CARD_STATE_LINKED or var_37_0.state == LinkLinkScene.CARD_STATE_BLANK or var_37_0.id == arg_36_1.id) and arg_37_0.row >= 0 and arg_37_0.row < LinkLinkScene.MAX_ROW and arg_37_0.column >= 0 and arg_37_0.column < LinkLinkScene.MAX_COLUMN then
					local var_37_1 = var_36_1[var_36_5.row .. "_" .. var_36_5.column]
					local var_37_2 = var_36_1[var_36_5.row .. "_" .. var_36_5.column].snap
					local var_37_3 = arg_37_0.row - var_36_5.row
					local var_37_4 = arg_37_0.column - var_36_5.column

					if var_36_1[var_36_5.row .. "_" .. var_36_5.column].rdir ~= 0 and var_37_1.rdir ~= var_37_3 or var_37_1.cdir ~= 0 and var_37_1.cdir ~= var_37_4 then
						var_37_2 = var_37_2 + 1
					end

					if var_37_2 <= 2 then
						local var_37_5 = Clone(var_37_1.path)

						table.insert(var_37_5, arg_37_0)

						var_36_1[arg_37_0.row .. "_" .. arg_37_0.column] = {
							row = arg_37_0.row,
							column = arg_37_0.column,
							snap = var_37_2,
							rdir = var_37_3,
							cdir = var_37_4,
							path = var_37_5
						}

						local var_37_6 = 0

						for iter_37_0 = #var_36_3, 1, -1 do
							local var_37_7 = var_36_1[var_36_3[iter_37_0].row .. "_" .. var_36_3[iter_37_0].column]

							if var_37_2 > var_37_7.snap or var_37_2 == var_37_7.snap and #var_37_5 > #var_37_7.path then
								var_37_6 = iter_37_0

								break
							end
						end

						table.insert(var_36_3, var_37_6 + 1, arg_37_0)
					end
				end
			end

			return
		end)
	end

	return var_36_0
end

return LinkLinkScene
