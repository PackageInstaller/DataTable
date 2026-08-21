local var_0_0 = class("AnniversaryNineGamePage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 84

function var_0_0.OnInit(arg_1_0)
	arg_1_0.mgHubData = getProxy(MiniGameProxy):GetHubByGameId(var_0_1)
	arg_1_0.drops = pg.mini_game[var_0_1].simple_config_data.drop_ids
	arg_1_0.totalTimes = #arg_1_0.drops
	arg_1_0.useTimes = arg_1_0.mgHubData.usedtime
	arg_1_0.gameTimes = arg_1_0.mgHubData.count

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.highScoreText = findTF(arg_2_0._tf, "ad/high/text")
	arg_2_0.btnRule = findTF(arg_2_0._tf, "ad/rule")
	arg_2_0.btnRank = findTF(arg_2_0._tf, "ad/rank")

	onButton(arg_2_0, arg_2_0.btnRank, function()
		arg_2_0:getRankData(var_0_1, function(arg_4_0)
			arg_2_0:UpdateRankData(arg_4_0)

			return
		end)
		arg_2_0:PopRankUI(true)

		return
	end, SFX_CANCEL)
	arg_2_0:initRankUI()
	setText(findTF(arg_2_0.btnRule, "text"), i18n("pac_game_rule_btn"))
	onButton(arg_2_0, arg_2_0.btnRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.sort_minigame_help.tip
		})

		return
	end, SFX_CANCEL)

	arg_2_0.btnStart = findTF(arg_2_0._tf, "ad/start")

	onButton(arg_2_0, arg_2_0.btnStart, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_CANCEL)

	arg_2_0.battleItems = {}
	arg_2_0._tplBattleItem = findTF(arg_2_0._tf, "ad/awards/Viewport/Content/item_tpl")

	setActive(arg_2_0._tplBattleItem, false)

	for iter_2_0 = 1, 7 do
		local var_2_1 = tf(instantiate(arg_2_0._tplBattleItem))

		var_2_1.name = "award_" .. iter_2_0

		setParent(var_2_1, findTF(arg_2_0._tf, "ad/awards/Viewport/Content"))
		setText(findTF(var_2_1, "ad/desc"), "DAY" .. iter_2_0)

		local var_2_2 = findTF(var_2_1, "ad/iconMask/icon")

		updateDrop(var_2_2, {
			type = arg_2_0.drops[iter_2_0][1],
			id = arg_2_0.drops[iter_2_0][2],
			count = arg_2_0.drops[iter_2_0][3]
		})
		onButton(arg_2_0, var_2_2, function()
			arg_2_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setActive(var_2_1, true)
		table.insert(arg_2_0.battleItems, var_2_1)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	for iter_8_0 = 1, 7 do
		local var_8_0 = findTF(arg_8_0.battleItems[iter_8_0], "ad/lock")
		local var_8_1 = findTF(arg_8_0.battleItems[iter_8_0], "ad/got")

		setActive(var_8_0, false)
		setActive(var_8_1, false)

		if iter_8_0 <= arg_8_0.useTimes then
			setActive(var_8_1, true)
		elseif iter_8_0 == arg_8_0.useTimes + 1 and arg_8_0.gameTimes >= 1 then
			-- block empty
		elseif iter_8_0 > arg_8_0.useTimes and iter_8_0 <= arg_8_0.useTimes + arg_8_0.gameTimes then
			-- block empty
		else
			setActive(var_8_0, true)
		end
	end

	local var_8_2 = getProxy(MiniGameProxy):GetHighScore(var_0_1)

	if var_8_2 and #var_8_2 > 0 then
		setText(arg_8_0.highScoreText, tostring(var_8_3))

		local var_8_4 = arg_8_0.coreActivityUI:GetActivityIdByPageClass("AnniversaryNineInvitationPage")
		local var_8_5 = var_8_4 and getProxy(ActivityProxy):getActivityById(var_8_4)

		if var_8_5 and not var_8_5:isEnd() then
			updateActivityTaskStatus(var_8_5)
		end

		return
	end
end

function var_0_0.initRankUI(arg_9_0)
	arg_9_0.rankUI = findTF(arg_9_0._tf, "pop/RankUI")

	arg_9_0:PopRankUI(false)

	arg_9_0._rankImg = findTF(arg_9_0.rankUI, "ad/img")
	arg_9_0._rankBtnClose = findTF(arg_9_0.rankUI, "ad/btnClose")
	arg_9_0._rankContent = findTF(arg_9_0.rankUI, "ad/list/content")
	arg_9_0._rankItemTpl = findTF(arg_9_0.rankUI, "ad/list/content/itemTpl")
	arg_9_0._rankEmpty = findTF(arg_9_0.rankUI, "ad/empty")
	arg_9_0._rankDesc = findTF(arg_9_0.rankUI, "ad/desc")
	arg_9_0._rankItems = {}

	setActive(arg_9_0._rankItemTpl, false)
	onButton(arg_9_0._event, findTF(arg_9_0.rankUI, "ad/close"), function()
		arg_9_0:PopRankUI(false)

		return
	end, SFX_CANCEL)
	onButton(arg_9_0._event, arg_9_0._rankBtnClose, function()
		arg_9_0:PopRankUI(false)

		return
	end, SFX_CANCEL)
	setText(arg_9_0._rankDesc, i18n("pipe_minigame_rank"))
	setText(findTF(arg_9_0.rankUI, "ad/bg/bg_high/text"), i18n("series_enemy_reward_tip4"))

	return
end

function var_0_0.UpdateRankData(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_1 do
		if iter_12_0 > #arg_12_0._rankItems then
			local var_12_1 = tf(instantiate(arg_12_0._rankItemTpl))

			setActive(var_12_1, false)
			setParent(var_12_1, arg_12_0._rankContent)
			table.insert(arg_12_0._rankItems, var_12_1)
		end

		local var_12_2 = arg_12_0._rankItems[iter_12_0]

		arg_12_0:SetRankItemData(arg_12_0._rankItems[iter_12_0], arg_12_1[iter_12_0], iter_12_0)
		setActive(var_12_2, true)
	end

	for iter_12_1 = #arg_12_1 + 1, #arg_12_0._rankItems do
		setActive(arg_12_0._rankItems, false)
	end

	setActive(arg_12_0._rankEmpty, #arg_12_1 == 0)
	setActive(arg_12_0._rankImg, #arg_12_1 > 0)

	return
end

function var_0_0.SetRankItemData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_3 = getProxy(PlayerProxy):isSelf(arg_13_2.player_id)

	setText(findTF(arg_13_1, "nameText"), arg_13_2.name)
	arg_13_0:setChildVisible(findTF(arg_13_1, "bg"), false)
	arg_13_0:setChildVisible(findTF(arg_13_1, "rank"), false)

	if arg_13_3 <= 3 then
		setActive(findTF(arg_13_1, "bg/" .. arg_13_3), true)
		setActive(findTF(arg_13_1, "rank/" .. arg_13_3), true)
	elseif var_13_3 then
		setActive(findTF(arg_13_1, "bg/me"), true)
		setActive(findTF(arg_13_1, "rank/count"), true)
	else
		setActive(findTF(arg_13_1, "bg/other"), true)
		setActive(findTF(arg_13_1, "rank/count"), true)
	end

	setText(findTF(arg_13_1, "rank/count"), tostring(arg_13_3))
	setText(findTF(arg_13_1, "score"), tostring(var_13_1))
	setActive(findTF(arg_13_1, "imgMy"), var_13_3)

	return
end

function var_0_0.PopRankUI(arg_14_0, arg_14_1)
	setActive(arg_14_0.rankUI, arg_14_1)

	return
end

function var_0_0.getRankData(arg_15_0, arg_15_1, arg_15_2)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = arg_15_1,
		callback = function(arg_16_0)
			for iter_16_0 = 1, #arg_16_0 do
				for iter_16_1, iter_16_2 in pairs(arg_16_0[iter_16_0]) do
					({})[iter_16_1] = iter_16_2
				end

				table.insert({}, {})
			end

			table.sort({}, function(arg_17_0, arg_17_1)
				if arg_17_0.score ~= arg_17_1.score then
					return arg_17_0.score > arg_17_1.score
				elseif arg_17_0.time_data ~= arg_17_1.time_data then
					return arg_17_0.time_data > arg_17_1.time_data
				else
					return arg_17_0.player_id < arg_17_1.player_id
				end

				return
			end)

			if arg_15_2 then
				arg_15_2({})
			end

			return
		end
	})

	return
end

function var_0_0.setChildVisible(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0 = 1, arg_18_1.childCount do
		setActive(arg_18_1:GetChild(iter_18_0 - 1), arg_18_2)
	end

	return
end

function var_0_0.willExit(arg_19_0)
	return
end

return var_0_0
