local var_0_0 = class("AuctionGameLoginPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.sign = arg_1_0.bg:Find("sign")
	arg_1_0.playerInfo = arg_1_0.bg:Find("playerInfo")
	arg_1_0.playerFrame = arg_1_0.playerInfo:Find("frame")
	arg_1_0.playerIcon = arg_1_0.playerInfo:Find("frame/icon")
	arg_1_0.playerName = arg_1_0.playerInfo:Find("name")
	arg_1_0.playerCount = arg_1_0.playerInfo:Find("count")
	arg_1_0.items = {}

	for iter_1_0 = 1, arg_1_0.sign.childCount do
		table.insert(arg_1_0.items, (arg_1_0:getItem(iter_1_0)))
	end

	arg_1_0.btnGet = arg_1_0.bg:Find("btnGet")

	setText(arg_1_0.btnGet:Find("text"), i18n("auction_signin_collect"))

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = arg_2_0.activity:getConfig("config_data")

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.btnGet, function()
		local var_4_0 = getProxy(PlayerProxy):getRawData()
		local var_4_1 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_4_2, var_4_3 = arg_3_0:checkCanGetList()

		if table.isEmpty(var_4_3) then
			return
		end

		local var_4_4, var_4_5 = Task.StaticJudgeOverflow(var_4_0.gold, var_4_0.oil, var_4_1, true, true, var_4_2)

		if var_4_4 then
			table.insert({}, function(arg_5_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_4_5,
					onYes = arg_5_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT_ONESTEP, var_4_3)

			return
		end)

		return
	end)

	return
end

function var_0_0.checkCanGetList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.taskGroup[1]) do
		local var_7_1 = arg_7_0.taskProxy:getTaskById(iter_7_1)

		if var_7_1 and var_7_1:getTaskStatus() == 1 then
			for iter_7_2, iter_7_3 in ipairs(pg.task_data_template[iter_7_1].award_display) do
				(function(arg_8_0)
					for iter_8_0, iter_8_1 in ipairs(var_7_0) do
						if iter_8_1[1] == arg_8_0[1] and iter_8_1[2] == arg_8_0[2] then
							iter_8_1[3] = iter_8_1[3] + arg_8_0[3]

							return
						end
					end

					table.insert(var_7_0, {
						arg_8_0[1],
						arg_8_0[2],
						arg_8_0[3]
					})

					return
				end)(iter_7_3)
			end

			table.insert({}, {
				id = iter_7_1
			})
		end
	end

	return {}, {}
end

function var_0_0.OnUpdateFlush(arg_9_0)
	if not arg_9_0.activity or not arg_9_0.taskGroup then
		return
	end

	arg_9_0.nday = arg_9_0.activity:getNDay()

	arg_9_0:setPlayerInfo()

	local var_9_0 = false

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items) do
		updateDrop(iter_9_1.item, (Drop.Create(pg.task_data_template[arg_9_0.taskGroup[1][iter_9_0]].award_display[1])))
		onButton(arg_9_0, iter_9_1.frame, function()
			arg_9_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		local var_9_1 = arg_9_0.taskProxy:getTaskById(arg_9_0.taskGroup[1][iter_9_0]) or arg_9_0.taskProxy:getFinishTaskById(arg_9_0.taskGroup[1][iter_9_0])
		local var_9_2 = not not var_9_1
		local var_9_3 = var_9_1 and var_9_1:getTaskStatus() == 1
		local var_9_4 = var_9_1 and var_9_1:getTaskStatus() == 2

		var_9_0 = var_9_0 or var_9_3

		setActive(iter_9_1.lock, not var_9_2)
		setActive(iter_9_1.get, var_9_3 and not var_9_4)
		setActive(iter_9_1.got, var_9_4)
		onButton(arg_9_0, iter_9_1.get, function()
			local var_11_0 = var_0.award_display
			local var_11_1 = getProxy(PlayerProxy):getRawData()
			local var_11_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
			local var_11_3, var_11_4 = Task.StaticJudgeOverflow(var_11_1.gold, var_11_1.oil, var_11_2, true, true, var_11_0)

			if var_11_3 then
				table.insert({}, function(arg_12_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_11_4,
						onYes = arg_12_0
					})

					return
				end)
			end

			seriesAsync({}, function()
				arg_9_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_9_1)

				return
			end)

			return
		end, SFX_PANEL)
	end

	setGray(arg_9_0.btnGet, not var_9_0)

	return
end

function var_0_0.getItem(arg_14_0, arg_14_1)
	if arg_14_0.items[arg_14_1] then
		return arg_14_0.items[arg_14_1]
	end

	local var_14_0 = {}
	local var_14_1 = arg_14_0.sign:GetChild(arg_14_1 - 1)

	var_14_0.item = var_14_1:Find("item")
	var_14_0.frame = var_14_1:Find("frame")
	var_14_0.got = var_14_1:Find("got")
	var_14_0.get = var_14_1:Find("get")
	var_14_0.lock = var_14_1:Find("lock")

	return var_14_0
end

function var_0_0.setPlayerInfo(arg_15_0)
	local var_15_9000
	local var_15_0 = getProxy(PlayerProxy)
	local var_15_1 = var_15_0.getRawData(var_15_9000)

	GetImageSpriteFromAtlasAsync("SquareIcon/" .. getProxy(BayProxy).GetShipPhantom(var_15_0, var_15_1:GetShipPhantomMarks()[1]):getPainting(), "", arg_15_0.playerIcon)
	setText(arg_15_0.playerName, var_15_1.name)
	setText(arg_15_0.playerCount, StringHelper.ForamtNumberK(AuctionGameTools.GetCurrencyCnt()))

	return
end

function var_0_0.OnDestroy(arg_16_0)
	if arg_16_0.iconView then
		arg_16_0.iconView:Dispose()

		arg_16_0.iconView = nil
	end

	return
end

return var_0_0
