local var_0_0 = class("HoloLiveLinkGameView", import("..BaseMiniGameView"))

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
var_0_0.NAME_TO_INDEX = {
	mio = 4,
	shion = 5,
	aqua = 2,
	fubuki = 0,
	Purifier = 8,
	Kawakaze = 7,
	matsuri = 1,
	sora = 6,
	ayame = 3
}

function var_0_0.getUIName(arg_1_0)
	return "HoloLiveLinkGameUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.miniGameData = arg_3_0:GetMGData()
	arg_3_0.linkGameID = arg_3_0.miniGameData:GetRuntimeData("curLinkGameID")
	arg_3_0.bestScoreTable = arg_3_0.miniGameData:GetRuntimeData("elements")

	if #arg_3_0.bestScoreTable == 0 then
		arg_3_0.bestScoreTable = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}

		arg_3_0.miniGameData:SetRuntimeData("elements", arg_3_0.bestScoreTable)
	end

	setText(arg_3_0.bestTxt, arg_3_0:FormatRecordTime(arg_3_0.bestScoreTable[arg_3_0.linkGameID]))
	arg_3_0:SetState(var_0_0.GAME_STATE_BEGIN)

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_4_0)
	return
end

function var_0_0.onBackPressed(arg_5_0)
	triggerButton(arg_5_0.backBtn)

	return
end

function var_0_0.willExit(arg_6_0)
	LeanTween.cancel(go(arg_6_0.countDown))

	for iter_6_0 = 0, arg_6_0.layout.childCount - 1 do
		LeanTween.cancel(go(arg_6_0.layout:GetChild(iter_6_0)))
	end

	if arg_6_0.countTimer then
		arg_6_0.countTimer:Stop()

		arg_6_0.countTimer = nil
	end

	return
end

function var_0_0.initData(arg_7_0)
	return
end

function var_0_0.findUI(arg_8_0)
	arg_8_0.backBtn = arg_8_0._tf:Find("ForNotchPanel/BackBtn")
	arg_8_0.helpBtn = arg_8_0._tf:Find("ForNotchPanel/HelpBtn")
	arg_8_0.resetBtn = arg_8_0._tf:Find("ResetBtn")
	arg_8_0.timeTxt = arg_8_0._tf:Find("ForNotchPanel/CurTime/Text")
	arg_8_0.bestTxt = arg_8_0._tf:Find("ForNotchPanel/BestTime/Text")
	arg_8_0.layout = arg_8_0._tf:Find("card_con/layout")
	arg_8_0.item = arg_8_0.layout:Find("card")
	arg_8_0.bottom = arg_8_0._tf:Find("card_con/bottom")
	arg_8_0.line = arg_8_0.bottom:Find("card")
	arg_8_0.countDown = arg_8_0._tf:Find("count_down")
	arg_8_0.resource = arg_8_0._tf:Find("resource")
	arg_8_0.resultPanel = arg_8_0._tf:Find("ResultPanel")
	arg_8_0.resultPanelBG = arg_8_0.resultPanel:Find("BG")

	local var_8_0 = arg_8_0.resultPanel:Find("Result")

	arg_8_0.resultNewImg = var_8_0:Find("NewImg")
	arg_8_0.resultTimeText = var_8_0:Find("TimeText")
	arg_8_0.resultRestartBtn = var_8_0:Find("RestartBtn")

	return
end

function var_0_0.addListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		arg_9_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(arg_9_0, arg_9_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_lianliankan.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.resultPanelBG, function()
		arg_9_0:showResultPanel(false)
		arg_9_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.resultRestartBtn, function()
		arg_9_0:showResultPanel(false)
		arg_9_0:SetState(var_0_0.GAME_STATE_BEGIN)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showResultPanel(arg_14_0, arg_14_1)
	if not arg_14_1 then
		SetActive(arg_14_0.resultPanel, false)

		return
	end

	setText(arg_14_0.resultTimeText, arg_14_0:FormatRecordTime(arg_14_0.lastRecord))
	SetActive(arg_14_0.resultPanel, true)

	return
end

function var_0_0.playStory(arg_15_0)
	local var_15_0 = arg_15_0.miniGameData:GetConfigCsvLine(arg_15_0.linkGameID).story

	if var_15_0 == "" then
		arg_15_0:showResultPanel(true)
	else
		local var_15_1 = var_15_0[1]
		local var_15_2 = pg.NewStoryMgr.GetInstance()

		if not var_15_2:IsPlayed(var_15_0[1]) then
			var_15_2:Play(var_15_1, function()
				arg_15_0:showResultPanel(true)

				return
			end)
		end
	end

	return
end

function var_0_0.SetState(arg_17_0, arg_17_1)
	if arg_17_0.state ~= arg_17_1 then
		arg_17_0.state = arg_17_1

		if arg_17_1 == var_0_0.GAME_STATE_BEGIN then
			arg_17_0:GameBegin()
		elseif arg_17_1 == var_0_0.GAME_STATE_GAMING then
			arg_17_0:GameLoop()
		elseif arg_17_1 == var_0_0.GAME_STATE_END then
			arg_17_0:GameEnd()
		end
	end

	return
end

function var_0_0.GameBegin(arg_18_0)
	arg_18_0.cards = {}

	local var_18_0 = arg_18_0:setIconList()

	while #var_18_0 > 0 do
		local var_18_1 = math.clamp(math.floor(math.random() * #var_18_0 + 1), 1, #var_18_0)
		local var_18_2 = math.floor(0 / (var_0_0.MAX_COLUMN - 2)) + 1

		arg_18_0.cards[var_18_2] = arg_18_0.cards[var_18_2] or {}
		arg_18_0.cards[var_18_2][0 % (var_0_0.MAX_COLUMN - 2) + 1] = {
			row = var_18_2,
			column = 0 % (var_0_0.MAX_COLUMN - 2) + 1,
			id = var_18_0[var_18_1],
			state = var_0_0.CARD_STATE_NORMAL
		}

		table.remove(var_18_0, var_18_1)
	end

	for iter_18_0 = 0, var_0_0.MAX_ROW - 1 do
		for iter_18_1 = 0, var_0_0.MAX_COLUMN - 1 do
			arg_18_0.cards[iter_18_0] = arg_18_0.cards[iter_18_0] or {}
			arg_18_0.cards[iter_18_0][iter_18_1] = arg_18_0.cards[iter_18_0][iter_18_1] or {
				row = iter_18_0,
				column = iter_18_1,
				state = var_0_0.CARD_STATE_BLANK
			}
		end
	end

	arg_18_0.list = UIItemList.New(arg_18_0.layout, arg_18_0.item)

	arg_18_0.list:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = math.floor(arg_19_1 / var_0_0.MAX_COLUMN)
			local var_19_1 = arg_18_0.cards[var_19_0][arg_19_1 % var_0_0.MAX_COLUMN]

			arg_19_2.name = var_19_0 .. "_" .. arg_19_1 % var_0_0.MAX_COLUMN
			arg_19_2.localScale = Vector3.one

			setActive(arg_19_2:Find("display"), var_19_1.state == var_0_0.CARD_STATE_NORMAL)

			if var_19_1.state == var_0_0.CARD_STATE_NORMAL then
				setImageSprite(arg_19_2:Find("display/icon"), (getImageSprite(arg_18_0.resource:GetChild(var_19_1.id))))
				setActive(arg_19_2:Find("display/selected"), false)

				local var_19_2 = GetComponent(arg_19_2, typeof(Animator))

				var_19_2.enabled = true

				var_19_2:SetBool("AniSwitch", false)
			end
		end

		return
	end)
	arg_18_0.list:align(var_0_0.MAX_ROW * var_0_0.MAX_COLUMN)

	arg_18_0.llist = UIItemList.New(arg_18_0.bottom, arg_18_0.line)

	arg_18_0.llist:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = arg_20_2:Find("lines")

			for iter_20_0 = 0, var_20_0.childCount - 1 do
				setActive(var_20_0:GetChild(iter_20_0), false)
			end
		end

		return
	end)
	arg_18_0.llist:align(var_0_0.MAX_ROW * var_0_0.MAX_COLUMN)
	setText(arg_18_0.timeTxt, arg_18_0:FormatRecordTime(0))
	setActive(arg_18_0.countDown, true)

	for iter_18_2 = 0, arg_18_0.countDown.childCount - 1 do
		setActive(arg_18_0.countDown:GetChild(iter_18_2), false)
	end

	local var_18_4 = arg_18_0.countDown:GetChild(0)

	setActive(var_18_4, true)
	setImageAlpha(var_18_4, 0)
	LeanTween.value(go(arg_18_0.countDown), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_21_0)
		arg_21_0 = math.min(arg_21_0 / 0.3, 1)

		setImageAlpha(var_18_4, arg_21_0)
		setLocalScale(var_18_4, {
			x = (1 - arg_21_0) * 2 + 1,
			y = (1 - arg_21_0) * 2 + 1
		})

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_18_4, false)

		var_0 = var_0 + 1

		if var_0 < arg_18_0.countDown.childCount then
			var_18_4 = arg_18_0.countDown:GetChild(var_0)

			setActive(var_18_4, true)
			setImageAlpha(var_18_4, 0)
		else
			setActive(arg_18_0.countDown, false)
			arg_18_0:SetState(var_0_0.GAME_STATE_GAMING)
		end

		return
	end)):setRepeat(4):setLoopType(LeanTweenType.punch):setOnCompleteOnRepeat(true):setEase(LeanTweenType.easeOutSine)

	return
end

function var_0_0.GameLoop(arg_23_0)
	local function var_23_0(arg_24_0)
		for iter_24_0 = 1, #arg_24_0 - 1 do
			local var_24_2 = arg_23_0.bottom:GetChild(arg_24_0[iter_24_0].row * var_0_0.MAX_COLUMN + arg_24_0[iter_24_0].column):Find("lines")

			for iter_24_1 = 0, var_24_2.childCount - 1 do
				setActive(var_24_2:GetChild(iter_24_1), false)
			end

			if arg_24_0[iter_24_0 + 1].row - arg_24_0[iter_24_0].row ~= 0 then
				setActive(var_24_2:Find("y" .. arg_24_0[iter_24_0 + 1].row - arg_24_0[iter_24_0].row), true)
			elseif arg_24_0[iter_24_0 + 1].column - arg_24_0[iter_24_0].column ~= 0 then
				setActive(var_24_2:Find("x" .. arg_24_0[iter_24_0 + 1].column - arg_24_0[iter_24_0].column), true)
			end
		end

		return
	end

	local function var_23_1(arg_25_0)
		for iter_25_0 = 1, #arg_25_0 - 1 do
			local var_25_0 = arg_23_0.bottom:GetChild(arg_25_0[iter_25_0].row * var_0_0.MAX_COLUMN + arg_25_0[iter_25_0].column):Find("lines")

			for iter_25_1 = 0, var_25_0.childCount - 1 do
				setActive(var_25_0:GetChild(iter_25_1), false)
			end
		end

		return
	end

	local var_23_2
	local var_23_3
	local var_23_4

	arg_23_0.list:each(function(arg_26_0, arg_26_1)
		onButton(arg_23_0, arg_26_1:Find("display/icon"), function()
			local var_27_0 = arg_23_0.cards[math.floor(arg_26_0 / var_0_0.MAX_COLUMN)][arg_26_0 % var_0_0.MAX_COLUMN]

			if var_27_0.state ~= var_0_0.CARD_STATE_NORMAL then
				return
			elseif not var_23_2 then
				var_23_2 = var_27_0
				var_23_3 = arg_26_1

				setActive(arg_26_1:Find("display/selected"), true)
			elseif var_23_4 then
				return
			elseif var_23_2 == var_27_0 then
				setActive(arg_26_1:Find("display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			elseif var_23_2.id ~= var_27_0.id then
				setActive(var_23_3:Find("display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			else
				local var_27_1 = arg_23_0:LinkLink(var_23_2, var_27_0)

				if not var_27_1 then
					setActive(var_23_3:Find("display/selected"), false)

					var_23_3 = nil
					var_23_2 = nil
				else
					var_27_0.state = var_0_0.CARD_STATE_LINKED
					var_23_2.state = var_0_0.CARD_STATE_LINKED

					setActive(arg_26_1:Find("display/selected"), true)
					var_23_0(var_27_1)

					var_23_4 = true

					local var_27_2 = GetComponent(arg_26_1, "DftAniEvent")

					GetComponent(arg_26_1, typeof(Animator)):SetBool("AniSwitch", true)
					GetComponent(var_23_3, typeof(Animator)):SetBool("AniSwitch", true)
					GetComponent(var_23_3, "DftAniEvent"):SetEndEvent(function(arg_28_0)
						var_23_1(var_27_1)

						var_23_4 = false
						var_23_3 = nil
						var_23_2 = nil

						local var_28_0 = true

						for iter_28_0 = 0, var_0_0.MAX_ROW - 1 do
							for iter_28_1 = 0, var_0_0.MAX_COLUMN - 1 do
								if arg_23_0.cards[iter_28_0][iter_28_1].state == var_0_0.CARD_STATE_NORMAL then
									var_28_0 = false

									break
								end
							end
						end

						if var_28_0 then
							arg_23_0:SetState(var_0_0.GAME_STATE_END)
						end

						return
					end)
				end
			end

			return
		end, SFX_PANEL)

		return
	end)

	if IsUnityEditor and AUTO_LINKLINK then
		setActive(arg_23_0.helpBtn, true)
		onButton(arg_23_0, arg_23_0.helpBtn, function()
			var_23_2 = nil
			var_23_3 = nil

			for iter_29_0 = 0, var_0_0.MAX_ROW - 1 do
				for iter_29_1 = 0, var_0_0.MAX_COLUMN - 1 do
					local var_29_0 = arg_23_0.layout:GetChild(arg_23_0.cards[iter_29_0][iter_29_1].row * var_0_0.MAX_COLUMN + arg_23_0.cards[iter_29_0][iter_29_1].column)

					if arg_23_0.cards[iter_29_0][iter_29_1].state == var_0_0.CARD_STATE_NORMAL then
						for iter_29_2 = 0, var_0_0.MAX_ROW - 1 do
							for iter_29_3 = 0, var_0_0.MAX_COLUMN - 1 do
								if iter_29_0 == iter_29_2 then
									if iter_29_1 ~= iter_29_3 then
										local var_29_1 = arg_23_0.layout:GetChild(arg_23_0.cards[iter_29_2][iter_29_3].row * var_0_0.MAX_COLUMN + arg_23_0.cards[iter_29_2][iter_29_3].column)

										if arg_23_0.cards[iter_29_0][iter_29_1].id == arg_23_0.cards[iter_29_2][iter_29_3].id then
											triggerButton(var_29_0:Find("display/icon"))
											triggerButton(var_29_1:Find("display/icon"))

											if var_23_4 then
												Timer.New(function()
													triggerButton(arg_23_0.helpBtn)

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

	local var_23_5 = 0

	onButton(arg_23_0, arg_23_0.resetBtn, function()
		if arg_23_0.state ~= var_0_0.GAME_STATE_GAMING then
			return
		elseif Time.realtimeSinceStartup - var_23_5 < var_0_0.RESET_CD then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_wait"))
		else
			if var_23_2 then
				setActive(var_23_3:Find("display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			end

			local var_31_0 = {}

			for iter_31_0 = 0, var_0_0.MAX_ROW - 1 do
				for iter_31_1 = 0, var_0_0.MAX_COLUMN - 1 do
					if arg_23_0.cards[iter_31_0][iter_31_1].state == var_0_0.CARD_STATE_NORMAL then
						table.insert(var_31_0, {
							row = iter_31_0,
							column = iter_31_1
						})
						table.insert({}, arg_23_0.cards[iter_31_0][iter_31_1].id)
					end
				end
			end

			while #{} > 0 do
				local var_31_1 = math.clamp(math.floor(math.random() * #{} + 1), 1, #{})

				arg_23_0.cards[var_31_0[1].row][var_31_0[1].column].id = ({})[var_31_1]

				table.remove({}, var_31_1)
			end

			arg_23_0.list:each(function(arg_32_0, arg_32_1)
				local var_32_0 = arg_23_0.cards[math.floor(arg_32_0 / var_0_0.MAX_COLUMN)][arg_32_0 % var_0_0.MAX_COLUMN]

				if var_32_0.state == var_0_0.CARD_STATE_NORMAL then
					setImageSprite(arg_32_1:Find("display/icon"), (getImageSprite(arg_23_0.resource:GetChild(var_32_0.id))))
				end

				return
			end)

			var_23_5 = Time.realtimeSinceStartup
		end

		return
	end, SFX_PANEL)

	arg_23_0.startTime = Time.realtimeSinceStartup
	arg_23_0.countTimer = Timer.New(function()
		arg_23_0.lastRecord = math.floor((Time.realtimeSinceStartup - arg_23_0.startTime) * 1000)

		setText(arg_23_0.timeTxt, arg_23_0:FormatRecordTime((math.floor(arg_23_0.lastRecord))))

		return
	end, 0.033, -1)

	arg_23_0.countTimer:Start()
	arg_23_0.countTimer.func()

	return
end

function var_0_0.GameEnd(arg_34_0)
	arg_34_0.countTimer:Stop()

	arg_34_0.countTimer = nil

	if arg_34_0.bestScoreTable[arg_34_0.linkGameID] == 0 then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_34_0.miniGameData:getConfig("hub_id"),
			cmd = MiniGameOPCommand.CMD_COMPLETE,
			args1 = {
				arg_34_0.linkGameID == #pg.activity_event_linkgame.all and 0 or 1,
				arg_34_0.linkGameID
			}
		})

		arg_34_0.bestScoreTable[arg_34_0.linkGameID] = arg_34_0.lastRecord

		setText(arg_34_0.bestTxt, arg_34_0:FormatRecordTime(arg_34_0.bestScoreTable[arg_34_0.linkGameID]))
		SetActive(arg_34_0.resultNewImg, true)
		arg_34_0:StoreDataToServer(arg_34_0.bestScoreTable)
	elseif arg_34_0.lastRecord < arg_34_0.bestScoreTable[arg_34_0.linkGameID] then
		arg_34_0.bestScoreTable[arg_34_0.linkGameID] = arg_34_0.lastRecord

		setText(arg_34_0.bestTxt, arg_34_0:FormatRecordTime(arg_34_0.bestScoreTable[arg_34_0.linkGameID]))
		SetActive(arg_34_0.resultNewImg, true)
		arg_34_0:StoreDataToServer(arg_34_0.bestScoreTable)
		arg_34_0:showResultPanel(true)
	else
		SetActive(arg_34_0.resultNewImg, false)
		arg_34_0:showResultPanel(true)
	end

	return
end

function var_0_0.LinkLink(arg_35_0, arg_35_1, arg_35_2)
	assert(arg_35_1.row ~= arg_35_2.row or arg_35_1.column ~= arg_35_2.column)
	assert(arg_35_1.id == arg_35_2.id)
	table.insert({}, {
		row = arg_35_1.row,
		column = arg_35_1.column
	})
	table.insert({}, {
		row = arg_35_1.row,
		column = arg_35_1.column
	})

	for iter_35_0 = 1, 3 do
		local var_35_0 = arg_35_0:IterateByOneSnap({
			row = arg_35_2.row,
			column = arg_35_2.column
		}, arg_35_1.id, {}, {})

		if var_35_0 then
			local var_35_1 = {
				var_35_0
			}

			while var_35_0 and var_35_0.from do
				if var_35_0.row ~= var_35_0.from.row then
					for iter_35_1 = var_35_0.row + (var_35_0.row > var_35_0.from.row and -1 or 1), var_35_0.from.row, var_35_0.row > var_35_0.from.row and -1 or 1 do
						table.insert(var_35_1, {
							row = iter_35_1,
							column = var_35_0.column
						})
					end
				elseif var_35_0.from.column ~= var_35_0.column then
					for iter_35_2 = var_35_0.column + (var_35_0.column > var_35_0.from.column and -1 or 1), var_35_0.from.column, var_35_0.column > var_35_0.from.column and -1 or 1 do
						table.insert(var_35_1, {
							row = var_35_0.row,
							column = iter_35_2
						})
					end
				else
					assert(false)
				end

				var_35_0 = var_35_0.from
			end

			return var_35_1
		end
	end

	return
end

function var_0_0.IterateByOneSnap(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	for iter_36_0 = 1, #arg_36_3 do
		for iter_36_1, iter_36_2 in ipairs((arg_36_0:FindDirectLinkPoint(arg_36_2, arg_36_3[iter_36_0], arg_36_4, arg_36_1))) do
			if iter_36_2.row == arg_36_1.row and iter_36_2.column == arg_36_1.column then
				return iter_36_2
			end

			table.insert(arg_36_3, iter_36_2)
		end
	end

	_.each(arg_36_3, function(arg_37_0)
		arg_36_4[arg_37_0.row .. "_" .. arg_37_0.column] = true

		return
	end)

	return
end

function var_0_0.FindDirectLinkPoint(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	for iter_38_0 = arg_38_2.row - 1, 0, -1 do
		if arg_38_0.cards[iter_38_0][arg_38_2.column].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[iter_38_0][arg_38_2.column].id == arg_38_1 then
			if iter_38_0 == arg_38_4.row and arg_38_2.column == arg_38_4.column then
				table.insert({}, {
					row = iter_38_0,
					column = arg_38_2.column,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if arg_38_0.cards[iter_38_0][arg_38_2.column].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[iter_38_0][arg_38_2.column].id ~= arg_38_1 or arg_38_3[iter_38_0 .. "_" .. arg_38_2.column] then
			break
		end

		table.insert({}, {
			row = iter_38_0,
			column = arg_38_2.column,
			from = arg_38_2
		})
	end

	for iter_38_1 = arg_38_2.row + 1, var_0_0.MAX_ROW - 1 do
		if arg_38_0.cards[iter_38_1][arg_38_2.column].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[iter_38_1][arg_38_2.column].id == arg_38_1 then
			if iter_38_1 == arg_38_4.row and arg_38_2.column == arg_38_4.column then
				table.insert({}, {
					row = iter_38_1,
					column = arg_38_2.column,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if arg_38_0.cards[iter_38_1][arg_38_2.column].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[iter_38_1][arg_38_2.column].id ~= arg_38_1 or arg_38_3[iter_38_1 .. "_" .. arg_38_2.column] then
			break
		end

		table.insert({}, {
			row = iter_38_1,
			column = arg_38_2.column,
			from = arg_38_2
		})
	end

	for iter_38_2 = arg_38_2.column - 1, 0, -1 do
		if arg_38_0.cards[arg_38_2.row][iter_38_2].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[arg_38_2.row][iter_38_2].id == arg_38_1 then
			if arg_38_2.row == arg_38_4.row and iter_38_2 == arg_38_4.column then
				table.insert({}, {
					row = arg_38_2.row,
					column = iter_38_2,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if arg_38_0.cards[arg_38_2.row][iter_38_2].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[arg_38_2.row][iter_38_2].id ~= arg_38_1 or arg_38_3[arg_38_2.row .. "_" .. iter_38_2] then
			break
		end

		table.insert({}, {
			row = arg_38_2.row,
			column = iter_38_2,
			from = arg_38_2
		})
	end

	for iter_38_3 = arg_38_2.column + 1, var_0_0.MAX_COLUMN - 1 do
		if arg_38_0.cards[arg_38_2.row][iter_38_3].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[arg_38_2.row][iter_38_3].id == arg_38_1 then
			if arg_38_2.row == arg_38_4.row and iter_38_3 == arg_38_4.column then
				table.insert({}, {
					row = arg_38_2.row,
					column = iter_38_3,
					from = arg_38_2
				})
			end

			break
		end

		if false then
			break
		end

		if arg_38_0.cards[arg_38_2.row][iter_38_3].state == var_0_0.CARD_STATE_NORMAL and arg_38_0.cards[arg_38_2.row][iter_38_3].id ~= arg_38_1 or arg_38_3[arg_38_2.row .. "_" .. iter_38_3] then
			break
		end

		table.insert({}, {
			row = arg_38_2.row,
			column = iter_38_3,
			from = arg_38_2
		})
	end

	return {}
end

function var_0_0.setIconList(arg_39_0)
	local var_39_0 = arg_39_0:GetMGData()
	local var_39_1 = var_39_0:GetRuntimeData("curLinkGameID")

	print("当前地图ID", tostring(var_39_1))

	for iter_39_0, iter_39_1 in ipairs(var_39_0:GetConfigCsvLine(var_39_1).block) do
		if iter_39_1[2] % 2 ~= 0 then
			assert(false, "资源名" .. iter_39_1[1] .. "数量不为偶数" .. iter_39_1[2])
		end

		local var_39_2 = var_0_0.NAME_TO_INDEX[iter_39_1[1]]

		assert(var_0_0.NAME_TO_INDEX[iter_39_1[1]], "没有定义该资源名" .. iter_39_1[1])

		for iter_39_2 = 1, iter_39_1[2] do
			table.insert({}, var_39_2)
		end
	end

	if #{} ~= 36 then
		assert(false, "总数不为36")
	end

	return {}
end

function var_0_0.FormatRecordTime(arg_40_0, arg_40_1)
	local var_40_0 = math.floor(arg_40_1 / 60000)

	var_40_0 = var_40_0 >= 10 and var_40_0 or "0" .. var_40_0

	local var_40_1 = math.floor(arg_40_1 % 60000 / 1000)

	var_40_1 = var_40_1 >= 10 and var_40_1 or "0" .. var_40_1

	local var_40_2 = math.floor(arg_40_1 % 1000 / 10)

	var_40_2 = var_40_2 >= 10 and var_40_2 or "0" .. var_40_2

	return var_40_0 .. "'" .. var_40_1 .. "'" .. var_40_2
end

return var_0_0
