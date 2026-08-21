local var_0_0 = class("LinkLinkScene", import("..base.BaseUI"))

var_0_0.MAX_ROW = 6
var_0_0.MAX_COLUMN = 11
var_0_0.COUNT_DOWN = 3
var_0_0.RESET_CD = 5
var_0_0.GAME_STATE_BEGIN = 0
var_0_0.GAME_STATE_GAMING = 1
var_0_0.GAME_STATE_END = 2
var_0_0.CARD_STATE_NORMAL = 0
var_0_0.CARD_STATE_LINKED = 1
var_0_0.CARD_STATE_BLANK = 2

function var_0_0.getUIName(arg_1_0)
	return "LinkLinkUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("BackBtn")
	arg_2_0.helpBtn = arg_2_0._tf:Find("top/help_btn")
	arg_2_0.resetBtn = arg_2_0._tf:Find("info/reset_button")
	arg_2_0.awardTxt = arg_2_0._tf:Find("info/award_txt")
	arg_2_0.timeTxt = arg_2_0._tf:Find("info/time_txt")
	arg_2_0.bestTxt = arg_2_0._tf:Find("info/best_txt")
	arg_2_0.layout = arg_2_0._tf:Find("card_con/layout")
	arg_2_0.item = arg_2_0.layout:Find("card")
	arg_2_0.bottom = arg_2_0._tf:Find("card_con/bottom")
	arg_2_0.line = arg_2_0.bottom:Find("card")
	arg_2_0.result = arg_2_0._tf:Find("result")
	arg_2_0.countDown = arg_2_0._tf:Find("count_down")
	arg_2_0.resource = arg_2_0._tf:Find("resource")
	arg_2_0.bestTitleText = arg_2_0._tf:Find("info/BestTitle")
	arg_2_0.curTitleText = arg_2_0._tf:Find("info/CurTitle")

	setText(arg_2_0.bestTitleText, i18n("LinkLinkGame_BestTime"))
	setText(arg_2_0.curTitleText, i18n("LinkLinkGame_CurTime"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	arg_3_0:SetState(var_0_0.GAME_STATE_BEGIN)

	return
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:HideResult()
	LeanTween.cancel(go(arg_5_0.countDown))

	for iter_5_0 = 0, arg_5_0.layout.childCount - 1 do
		LeanTween.cancel(go(arg_5_0.layout:GetChild(iter_5_0)))
	end

	if arg_5_0.countTimer then
		arg_5_0.countTimer:Stop()

		arg_5_0.countTimer = nil
	end

	return
end

function var_0_0.SetPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	return
end

function var_0_0.SetActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1
	arg_7_0.activityAchieved = arg_7_1.data1
	arg_7_0.activityProgress = arg_7_1.data2
	arg_7_0.activityStartTime = arg_7_1.data3
	arg_7_0.activityBestRecord = arg_7_1.data4

	local var_7_0 = arg_7_0.activity:getConfig("config_client")[3]
	local var_7_1 = pg.TimeMgr.GetInstance()

	arg_7_0.activityRestTimes = var_7_1:DiffDay(arg_7_0.activityStartTime, var_7_1:GetServerTime()) + 1 - arg_7_0.activityProgress
	arg_7_0.activityRestTimes = math.clamp(arg_7_0.activityRestTimes, 0, #var_7_0 - arg_7_0.activityProgress)

	local var_7_3 = arg_7_0.awardTxt

	if arg_7_0.activityRestTimes > 0 then
		local var_7_4 = var_7_0[arg_7_0.activityProgress + 1] or 0

		var_7_2(var_7_3, var_7_4)
		setText(arg_7_0.bestTxt, arg_7_0:FormatRecordTime(arg_7_0.activityBestRecord))

		return
	end
end

function var_0_0.SetState(arg_8_0, arg_8_1)
	if arg_8_0.state ~= arg_8_1 then
		arg_8_0.state = arg_8_1

		if arg_8_1 == var_0_0.GAME_STATE_BEGIN then
			arg_8_0:GameBegin()
		elseif arg_8_1 == var_0_0.GAME_STATE_GAMING then
			arg_8_0:GameLoop()
		elseif arg_8_1 == var_0_0.GAME_STATE_END then
			arg_8_0:GameEnd()
		end
	end

	return
end

function var_0_0.GameBegin(arg_9_0)
	arg_9_0.cards = {}

	for iter_9_0 = 0, 17 do
		table.insert({}, iter_9_0)
		table.insert({}, iter_9_0)
	end

	while #{} > 0 do
		local var_9_0 = math.clamp(math.floor(math.random() * #{} + 1), 1, #{})
		local var_9_1 = math.floor(0 / (var_0_0.MAX_COLUMN - 2)) + 1

		arg_9_0.cards[var_9_1] = arg_9_0.cards[var_9_1] or {}
		arg_9_0.cards[var_9_1][0 % (var_0_0.MAX_COLUMN - 2) + 1] = {
			row = var_9_1,
			column = 0 % (var_0_0.MAX_COLUMN - 2) + 1,
			id = ({})[var_9_0],
			state = var_0_0.CARD_STATE_NORMAL
		}

		table.remove({}, var_9_0)
	end

	for iter_9_1 = 0, var_0_0.MAX_ROW - 1 do
		for iter_9_2 = 0, var_0_0.MAX_COLUMN - 1 do
			arg_9_0.cards[iter_9_1] = arg_9_0.cards[iter_9_1] or {}
			arg_9_0.cards[iter_9_1][iter_9_2] = arg_9_0.cards[iter_9_1][iter_9_2] or {
				row = iter_9_1,
				column = iter_9_2,
				state = var_0_0.CARD_STATE_BLANK
			}
		end
	end

	arg_9_0.list = UIItemList.New(arg_9_0.layout, arg_9_0.item)

	arg_9_0.list:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = math.floor(arg_10_1 / var_0_0.MAX_COLUMN)
			local var_10_1 = arg_9_0.cards[var_10_0][arg_10_1 % var_0_0.MAX_COLUMN]

			arg_10_2.name = var_10_0 .. "_" .. arg_10_1 % var_0_0.MAX_COLUMN
			arg_10_2.localScale = Vector3.one

			setActive(arg_10_2:Find("display"), var_10_1.state == var_0_0.CARD_STATE_NORMAL)

			if var_10_1.state == var_0_0.CARD_STATE_NORMAL then
				setImageSprite(arg_10_2:Find("display/icon"), (getImageSprite(arg_9_0.resource:GetChild(var_10_1.id))))
				setActive(arg_10_2:Find("display/selected"), false)
			end
		end

		return
	end)
	arg_9_0.list:align(var_0_0.MAX_ROW * var_0_0.MAX_COLUMN)

	arg_9_0.llist = UIItemList.New(arg_9_0.bottom, arg_9_0.line)

	arg_9_0.llist:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = arg_11_2:Find("lines")

			for iter_11_0 = 0, var_11_0.childCount - 1 do
				setActive(var_11_0:GetChild(iter_11_0), false)
			end
		end

		return
	end)
	arg_9_0.llist:align(var_0_0.MAX_ROW * var_0_0.MAX_COLUMN)
	setActive(arg_9_0.countDown, true)

	for iter_9_3 = 0, arg_9_0.countDown.childCount - 1 do
		setActive(arg_9_0.countDown:GetChild(iter_9_3), false)
	end

	local var_9_3 = arg_9_0.countDown:GetChild(0)

	setActive(var_9_3, true)
	setImageAlpha(var_9_3, 0)
	LeanTween.value(go(arg_9_0.countDown), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_12_0)
		arg_12_0 = math.min(arg_12_0 / 0.3, 1)

		setImageAlpha(var_9_3, arg_12_0)
		setLocalScale(var_9_3, {
			x = (1 - arg_12_0) * 2 + 1,
			y = (1 - arg_12_0) * 2 + 1
		})

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_9_3, false)

		var_0 = var_0 + 1

		if var_0 < arg_9_0.countDown.childCount then
			var_9_3 = arg_9_0.countDown:GetChild(var_0)

			setActive(var_9_3, true)
			setImageAlpha(var_9_3, 0)
		else
			setActive(arg_9_0.countDown, false)
			arg_9_0:SetState(var_0_0.GAME_STATE_GAMING)
		end

		return
	end)):setRepeat(4):setLoopType(LeanTweenType.punch):setOnCompleteOnRepeat(true):setEase(LeanTweenType.easeOutSine)

	return
end

function var_0_0.GameLoop(arg_14_0)
	local function var_14_0(arg_15_0)
		local var_15_0 = 0

		for iter_15_0 = 1, #arg_15_0 - 1 do
			local var_15_1 = arg_15_0[iter_15_0 + 1].row - arg_15_0[iter_15_0].row
			local var_15_2 = arg_15_0[iter_15_0 + 1].column - arg_15_0[iter_15_0].column
			local var_15_3 = arg_14_0.bottom:GetChild(arg_15_0[iter_15_0].row * var_0_0.MAX_COLUMN + arg_15_0[iter_15_0].column):Find("lines")

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
			local var_16_0 = arg_14_0.bottom:GetChild(arg_16_0[iter_16_0].row * var_0_0.MAX_COLUMN + arg_16_0[iter_16_0].column):Find("lines")

			for iter_16_1 = 0, var_16_0.childCount - 1 do
				setActive(var_16_0:GetChild(iter_16_1), false)
			end
		end

		return
	end

	local var_14_2
	local var_14_3
	local var_14_4

	arg_14_0.list:each(function(arg_17_0, arg_17_1)
		onButton(arg_14_0, arg_17_1:Find("display/icon"), function()
			local var_18_0 = arg_14_0.cards[math.floor(arg_17_0 / var_0_0.MAX_COLUMN)][arg_17_0 % var_0_0.MAX_COLUMN]

			if var_18_0.state ~= var_0_0.CARD_STATE_NORMAL then
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
				local var_18_1 = arg_14_0:LinkLink(var_14_2, var_18_0)

				if not var_18_1 then
					setActive(var_14_3:Find("display/selected"), false)

					var_14_3 = nil
					var_14_2 = nil
				else
					var_18_0.state = var_0_0.CARD_STATE_LINKED
					var_14_2.state = var_0_0.CARD_STATE_LINKED

					setActive(arg_17_1:Find("display/selected"), true)
					var_14_0(var_18_1)

					var_14_4 = true

					local var_18_2 = var_14_3

					LeanTween.value(go(arg_17_1), 1, 0.15, 0.3):setEase(LeanTweenType.easeInBack):setOnUpdate(System.Action_float(function(arg_19_0)
						var_0.localScale = Vector3(arg_19_0, arg_19_0, 1)
						var_18_2.localScale = Vector3(arg_19_0, arg_19_0, 1)

						return
					end)):setOnComplete(System.Action(function()
						var_14_1(var_18_1)
						setActive(var_0:Find("display"), false)
						setActive(var_18_2:Find("display"), false)

						var_14_4 = false

						return
					end))

					var_14_3 = nil
					var_14_2 = nil

					local var_18_3 = true

					for iter_18_0 = 0, var_0_0.MAX_ROW - 1 do
						for iter_18_1 = 0, var_0_0.MAX_COLUMN - 1 do
							if arg_14_0.cards[iter_18_0][iter_18_1].state == var_0_0.CARD_STATE_NORMAL then
								var_18_3 = false

								break
							end
						end
					end

					if var_18_3 then
						arg_14_0:SetState(var_0_0.GAME_STATE_END)
					end
				end
			end

			return
		end, SFX_PANEL)

		return
	end)

	if IsUnityEditor and AUTO_LINKLINK then
		setActive(arg_14_0.helpBtn, true)
		onButton(arg_14_0, arg_14_0.helpBtn, function()
			var_14_2 = nil
			var_14_3 = nil

			for iter_21_0 = 0, var_0_0.MAX_ROW - 1 do
				for iter_21_1 = 0, var_0_0.MAX_COLUMN - 1 do
					local var_21_0 = arg_14_0.layout:GetChild(arg_14_0.cards[iter_21_0][iter_21_1].row * var_0_0.MAX_COLUMN + arg_14_0.cards[iter_21_0][iter_21_1].column)

					if arg_14_0.cards[iter_21_0][iter_21_1].state == var_0_0.CARD_STATE_NORMAL then
						for iter_21_2 = 0, var_0_0.MAX_ROW - 1 do
							for iter_21_3 = 0, var_0_0.MAX_COLUMN - 1 do
								if iter_21_0 == iter_21_2 then
									if iter_21_1 ~= iter_21_3 then
										local var_21_1 = arg_14_0.layout:GetChild(arg_14_0.cards[iter_21_2][iter_21_3].row * var_0_0.MAX_COLUMN + arg_14_0.cards[iter_21_2][iter_21_3].column)

										if arg_14_0.cards[iter_21_0][iter_21_1].id == arg_14_0.cards[iter_21_2][iter_21_3].id then
											triggerButton(var_21_0:Find("display/icon"))
											triggerButton(var_21_1:Find("display/icon"))

											if var_14_4 then
												Timer.New(function()
													triggerButton(arg_14_0.helpBtn)

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

	onButton(arg_14_0, arg_14_0.resetBtn, function()
		if arg_14_0.state ~= var_0_0.GAME_STATE_GAMING then
			return
		elseif Time.realtimeSinceStartup - var_14_5 < var_0_0.RESET_CD then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_wait"))
		else
			if var_14_2 then
				setActive(var_14_3:Find("display/selected"), false)

				var_14_3 = nil
				var_14_2 = nil
			end

			local var_23_0 = {}

			for iter_23_0 = 0, var_0_0.MAX_ROW - 1 do
				for iter_23_1 = 0, var_0_0.MAX_COLUMN - 1 do
					if arg_14_0.cards[iter_23_0][iter_23_1].state == var_0_0.CARD_STATE_NORMAL then
						table.insert(var_23_0, {
							row = iter_23_0,
							column = iter_23_1
						})
						table.insert({}, arg_14_0.cards[iter_23_0][iter_23_1].id)
					end
				end
			end

			while #{} > 0 do
				local var_23_1 = math.clamp(math.floor(math.random() * #{} + 1), 1, #{})

				arg_14_0.cards[var_23_0[1].row][var_23_0[1].column].id = ({})[var_23_1]

				table.remove({}, var_23_1)
			end

			arg_14_0.list:each(function(arg_24_0, arg_24_1)
				local var_24_0 = arg_14_0.cards[math.floor(arg_24_0 / var_0_0.MAX_COLUMN)][arg_24_0 % var_0_0.MAX_COLUMN]

				if var_24_0.state == var_0_0.CARD_STATE_NORMAL then
					setImageSprite(arg_24_1:Find("display/icon"), (getImageSprite(arg_14_0.resource:GetChild(var_24_0.id))))
				end

				return
			end)

			var_14_5 = Time.realtimeSinceStartup
		end

		return
	end, SFX_PANEL)

	arg_14_0.startTime = Time.realtimeSinceStartup
	arg_14_0.countTimer = Timer.New(function()
		setText(arg_14_0.timeTxt, arg_14_0:FormatRecordTime((math.floor((Time.realtimeSinceStartup - arg_14_0.startTime) * 1000))))

		return
	end, 0.033, -1)

	arg_14_0.countTimer:Start()
	arg_14_0.countTimer.func()

	return
end

function var_0_0.GameEnd(arg_26_0)
	arg_26_0.countTimer:Stop()

	arg_26_0.countTimer = nil
	arg_26_0.lastRecord = math.floor((Time.realtimeSinceStartup - arg_26_0.startTime) * 1000)

	if arg_26_0.activityRestTimes <= 0 then
		if arg_26_0.lastRecord < arg_26_0.activityBestRecord then
			({
				cmd = 1,
				activity_id = arg_26_0.activity.id
			}).arg1 = arg_26_0.activityProgress + (arg_26_0.activityRestTimes > 0 and 1 or 0)
			;({
				cmd = 1,
				activity_id = arg_26_0.activity.id
			}).arg2 = arg_26_0.lastRecord

			arg_26_0:emit(LinkLinkMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_26_0.activity.id
			})
		else
			arg_26_0:DisplayResult(arg_26_0.activity)
		end

		return
	end
end

function var_0_0.DisplayResult(arg_27_0, arg_27_1)
	setActive(arg_27_0.result, true)

	local var_27_0 = arg_27_0.result:Find("bg")

	setActive(var_27_0:Find("pic_new_record"), arg_27_1.data4 < arg_27_0.activityBestRecord)
	setActive(var_27_0:Find("pic_win"), arg_27_1.data4 >= arg_27_0.activityBestRecord)
	setText(var_27_0:Find("time_txt"), arg_27_0:FormatRecordTime(arg_27_0.lastRecord))

	local var_27_1 = arg_27_1:getConfig("config_client")[3]
	local var_27_3 = var_27_0:Find("award_txt")

	if arg_27_1.data2 > arg_27_0.activityProgress then
		local var_27_4 = var_27_1[arg_27_1.data2] or 0

		var_27_2(var_27_3, var_27_4)
		onButton(arg_27_0, var_27_0:Find("button"), function()
			arg_27_0:HideResult()
			arg_27_0:SetActivity(arg_27_1)
			arg_27_0:SetState(var_0_0.GAME_STATE_BEGIN)

			return
		end, SFX_PANEL)
		onButton(arg_27_0, arg_27_0.result, function()
			triggerButton(arg_27_0.backBtn)

			return
		end, SFX_CANCEL)
		pg.UIMgr.GetInstance():BlurPanel(arg_27_0.result)

		return
	end
end

function var_0_0.HideResult(arg_30_0)
	if isActive(arg_30_0.result) then
		setActive(arg_30_0.result, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0.result, arg_30_0._tf)
	end

	return
end

function var_0_0.FormatRecordTime(arg_31_0, arg_31_1)
	local var_31_0 = math.floor(arg_31_1 / 60000)

	var_31_0 = var_31_0 >= 10 and var_31_0 or "0" .. var_31_0

	local var_31_1 = math.floor(arg_31_1 % 60000 / 1000)

	var_31_1 = var_31_1 >= 10 and var_31_1 or "0" .. var_31_1

	local var_31_2 = math.floor(arg_31_1 % 1000 / 10)

	var_31_2 = var_31_2 >= 10 and var_31_2 or "0" .. var_31_2

	return var_31_0 .. "'" .. var_31_1 .. "'" .. var_31_2
end

function var_0_0.LinkLink(arg_32_0, arg_32_1, arg_32_2)
	assert(arg_32_1.row ~= arg_32_2.row or arg_32_1.column ~= arg_32_2.column)
	assert(arg_32_1.id == arg_32_2.id)
	table.insert({}, {
		row = arg_32_1.row,
		column = arg_32_1.column
	})
	table.insert({}, {
		row = arg_32_1.row,
		column = arg_32_1.column
	})

	for iter_32_0 = 1, 3 do
		local var_32_0 = arg_32_0:IterateByOneSnap({
			row = arg_32_2.row,
			column = arg_32_2.column
		}, arg_32_1.id, {}, {})

		if var_32_0 then
			local var_32_1 = {
				var_32_0
			}

			while var_32_0 and var_32_0.from do
				if var_32_0.row ~= var_32_0.from.row then
					for iter_32_1 = var_32_0.row + (var_32_0.row > var_32_0.from.row and -1 or 1), var_32_0.from.row, var_32_0.row > var_32_0.from.row and -1 or 1 do
						table.insert(var_32_1, {
							row = iter_32_1,
							column = var_32_0.column
						})
					end
				elseif var_32_0.from.column ~= var_32_0.column then
					for iter_32_2 = var_32_0.column + (var_32_0.column > var_32_0.from.column and -1 or 1), var_32_0.from.column, var_32_0.column > var_32_0.from.column and -1 or 1 do
						table.insert(var_32_1, {
							row = var_32_0.row,
							column = iter_32_2
						})
					end
				else
					assert(false)
				end

				var_32_0 = var_32_0.from
			end

			return var_32_1
		end
	end

	return
end

function var_0_0.IterateByOneSnap(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	for iter_33_0 = 1, #arg_33_3 do
		for iter_33_1, iter_33_2 in ipairs((arg_33_0:FindDirectLinkPoint(arg_33_2, arg_33_3[iter_33_0], arg_33_4))) do
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

function var_0_0.FindDirectLinkPoint(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	for iter_35_0 = arg_35_2.row - 1, 0, -1 do
		if arg_35_0.cards[iter_35_0][arg_35_2.column].state == var_0_0.CARD_STATE_NORMAL and arg_35_0.cards[iter_35_0][arg_35_2.column].id ~= arg_35_1 or arg_35_3[iter_35_0 .. "_" .. arg_35_2.column] then
			break
		end

		table.insert({}, {
			row = iter_35_0,
			column = arg_35_2.column,
			from = arg_35_2
		})
	end

	for iter_35_1 = arg_35_2.row + 1, var_0_0.MAX_ROW - 1 do
		if arg_35_0.cards[iter_35_1][arg_35_2.column].state == var_0_0.CARD_STATE_NORMAL and arg_35_0.cards[iter_35_1][arg_35_2.column].id ~= arg_35_1 or arg_35_3[iter_35_1 .. "_" .. arg_35_2.column] then
			break
		end

		table.insert({}, {
			row = iter_35_1,
			column = arg_35_2.column,
			from = arg_35_2
		})
	end

	for iter_35_2 = arg_35_2.column - 1, 0, -1 do
		if arg_35_0.cards[arg_35_2.row][iter_35_2].state == var_0_0.CARD_STATE_NORMAL and arg_35_0.cards[arg_35_2.row][iter_35_2].id ~= arg_35_1 or arg_35_3[arg_35_2.row .. "_" .. iter_35_2] then
			break
		end

		table.insert({}, {
			row = arg_35_2.row,
			column = iter_35_2,
			from = arg_35_2
		})
	end

	for iter_35_3 = arg_35_2.column + 1, var_0_0.MAX_COLUMN - 1 do
		if arg_35_0.cards[arg_35_2.row][iter_35_3].state == var_0_0.CARD_STATE_NORMAL and arg_35_0.cards[arg_35_2.row][iter_35_3].id ~= arg_35_1 or arg_35_3[arg_35_2.row .. "_" .. iter_35_3] then
			break
		end

		table.insert({}, {
			row = arg_35_2.row,
			column = iter_35_3,
			from = arg_35_2
		})
	end

	return {}
end

function var_0_0.LinkLink1(arg_36_0, arg_36_1, arg_36_2)
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
		{
			row = arg_36_1.row,
			column = arg_36_1.column
		}
	}
	local var_36_3 = {}

	while #{
		{
			row = arg_36_1.row,
			column = arg_36_1.column
		}
	} > 0 do
		local var_36_4 = table.remove({
			{
				row = arg_36_1.row,
				column = arg_36_1.column
			}
		}, 1)

		if var_36_4.row == ({
			row = arg_36_2.row,
			column = arg_36_2.column
		}).row and var_36_4.column == ({
			row = arg_36_2.row,
			column = arg_36_2.column
		}).column then
			var_36_0 = ({
				[arg_36_1.row .. "_" .. arg_36_1.column] = {
					rdir = 0,
					cdir = 0,
					snap = 0,
					row = arg_36_1.row,
					column = arg_36_1.column,
					path = {}
				}
			})[var_36_4.row .. "_" .. var_36_4.column].path

			break
		end

		table.insert({}, var_36_4)
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
			arg_37_0.row = var_36_4.row + arg_37_0.row
			arg_37_0.column = var_36_4.column + arg_37_0.column

			local var_37_0 = _.any(var_36_2, function(arg_38_0)
				return arg_38_0.row == arg_37_0.row and arg_38_0.column == arg_37_0.column
			end) or _.any(var_36_3, function(arg_39_0)
				return arg_39_0.row == arg_37_0.row and arg_39_0.column == arg_37_0.column
			end)

			if arg_36_0.cards[arg_37_0.row] then
				local var_37_1 = arg_36_0.cards[arg_37_0.row][arg_37_0.column] or nil

				if not var_37_0 and (not var_37_1 or var_37_1.state == var_0_0.CARD_STATE_LINKED or var_37_1.state == var_0_0.CARD_STATE_BLANK or var_37_1.id == arg_36_1.id) and arg_37_0.row >= 0 and arg_37_0.row < var_0_0.MAX_ROW and arg_37_0.column >= 0 and arg_37_0.column < var_0_0.MAX_COLUMN then
					local var_37_2 = var_36_1[var_36_4.row .. "_" .. var_36_4.column]
					local var_37_3 = var_36_1[var_36_4.row .. "_" .. var_36_4.column].snap
					local var_37_4 = arg_37_0.row - var_36_4.row
					local var_37_5 = arg_37_0.column - var_36_4.column

					if var_36_1[var_36_4.row .. "_" .. var_36_4.column].rdir ~= 0 and var_37_2.rdir ~= var_37_4 or var_37_2.cdir ~= 0 and var_37_2.cdir ~= var_37_5 then
						var_37_3 = var_37_3 + 1
					end

					if var_37_3 <= 2 then
						local var_37_6 = Clone(var_37_2.path)

						table.insert(var_37_6, arg_37_0)

						var_36_1[arg_37_0.row .. "_" .. arg_37_0.column] = {
							row = arg_37_0.row,
							column = arg_37_0.column,
							snap = var_37_3,
							rdir = var_37_4,
							cdir = var_37_5,
							path = var_37_6
						}

						local var_37_7 = 0

						for iter_37_0 = #var_36_2, 1, -1 do
							if var_37_3 > var_36_1[var_36_2[iter_37_0].row .. "_" .. var_36_2[iter_37_0].column].snap or var_37_3 == var_36_1[var_36_2[iter_37_0].row .. "_" .. var_36_2[iter_37_0].column].snap and #var_37_6 > #var_36_1[var_36_2[iter_37_0].row .. "_" .. var_36_2[iter_37_0].column].path then
								var_37_7 = iter_37_0

								break
							end
						end

						table.insert(var_36_2, var_37_7 + 1, arg_37_0)
					end
				end

				return
			end
		end)
	end

	return var_36_0
end

return var_0_0
