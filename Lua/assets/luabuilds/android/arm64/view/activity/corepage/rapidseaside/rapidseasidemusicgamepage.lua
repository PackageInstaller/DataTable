local var_0_0 = class("RapidSeasideMusicGamePage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 88

function var_0_0.OnInit(arg_1_0)
	arg_1_0.mgHubData = getProxy(MiniGameProxy):GetHubByGameId(var_0_1)
	arg_1_0.drops = pg.mini_game[var_0_1].simple_config_data.drop_ids
	arg_1_0.totalTimes = #arg_1_0.drops
	arg_1_0.useTimes = arg_1_0.mgHubData.usedtime
	arg_1_0.gameTimes = arg_1_0.mgHubData.count
	arg_1_0.highestScore = arg_1_0._tf:Find("ad/record/img/Text")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.btnStart = findTF(arg_2_0._tf, "ad/list/start")
	arg_2_0.btnRule = findTF(arg_2_0._tf, "ad/list/rule")
	arg_2_0.btnRank = findTF(arg_2_0._tf, "ad/list/rank")

	setText(findTF(arg_2_0.btnStart, "Text"), i18n("beat_game_go"))
	setText(findTF(arg_2_0.btnRule, "Text"), i18n("beat_game_rule"))
	setText(findTF(arg_2_0.btnRank, "Text"), i18n("beat_game_rank"))
	GetComponent(findTF(arg_2_0._tf, "ad/desc"), typeof(Image)):SetNativeSize()

	arg_2_0.awardsTf = findTF(arg_2_0._tf, "ad/awards")
	arg_2_0.awardContent = findTF(arg_2_0._tf, "ad/awards/content")
	arg_2_0.awardsRect = GetComponent(arg_2_0.awardsTf, typeof(ScrollRect))
	arg_2_0.itemTpl = findTF(arg_2_0._tf, "ad/awards/content/itemTpl")

	setActive(arg_2_0.itemTpl, false)

	for iter_2_0 = 1, #arg_2_0.drops do
		local var_2_0 = tf(Instantiate(arg_2_0.itemTpl))

		setParent(var_2_0, arg_2_0.awardContent)
		setActive(var_2_0, true)
		updateDrop(findTF(var_2_0, "ad/IconTpl"), {
			type = arg_2_0.drops[iter_2_0][1],
			id = arg_2_0.drops[iter_2_0][2],
			count = arg_2_0.drops[iter_2_0][3]
		})
		onButton(arg_2_0, var_2_0, function()
			arg_2_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setText(findTF(var_2_0, "ad/day"), "DAY" .. iter_2_0)
		setActive(findTF(var_2_0, "ad/lock"), iter_2_0 > arg_2_0.useTimes + arg_2_0.gameTimes)
		setActive(findTF(var_2_0, "ad/got"), iter_2_0 <= arg_2_0.useTimes)
	end

	onButton(arg_2_0, arg_2_0.btnStart, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0, arg_2_0.btnRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.musicbeat_minigame_help.tip
		})

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0, arg_2_0.btnRank, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, {
			rank = true,
			id = var_0_1
		})

		return
	end, SFX_CONFIRM)

	local var_2_1 = 0

	if arg_2_0.mgHubData.highScores[var_0_1] and arg_2_0.mgHubData.highScores[var_0_1][1] then
		var_2_1 = arg_2_0.mgHubData.highScores[var_0_1][1]
	end

	setText(arg_2_0.highestScore, var_2_1)
	scrollTo(arg_2_0.awardsRect, 1 - (arg_2_0.totalTimes - 7 < 0 and 0 or arg_2_0.totalTimes - 7) / (arg_2_0.totalTimes - 7), 0)

	return
end

function var_0_0.willExit(arg_7_0)
	return
end

return var_0_0
