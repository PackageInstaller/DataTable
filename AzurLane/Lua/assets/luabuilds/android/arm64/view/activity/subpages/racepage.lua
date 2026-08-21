local var_0_0 = class("RacePage", import("...base.BaseActivityPage"))
local var_0_1 = 58

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.help = arg_1_0.bg:Find("help")
	arg_1_0.goBtn = arg_1_0.bg:Find("go_btn")
	arg_1_0.ticketStat = arg_1_0.bg:Find("ticket_static")
	arg_1_0.ticketNum = arg_1_0.bg:Find("ticket_num")
	arg_1_0.costTf = arg_1_0.bg:Find("cost")
	arg_1_0.progressBar = arg_1_0.bg:Find("progress_bar")
	arg_1_0.progressTpl = arg_1_0.bg:Find("progress_tpl")
	arg_1_0.progressContainer = arg_1_0.bg:Find("progress")
	arg_1_0.progressList = UIItemList.New(arg_1_0.progressContainer, arg_1_0.progressTpl)
	arg_1_0.rankBtn = arg_1_0.bg:Find("rank_btn")
	arg_1_0.rankPanel = arg_1_0.bg:Find("rank_panel")
	arg_1_0.rankBlank = arg_1_0.bg:Find("rank_panel/static/blank_img")
	arg_1_0.rankSelf = arg_1_0.bg:Find("rank_panel/self")
	arg_1_0.rankContainer = arg_1_0.bg:Find("rank_panel/list_panel/view_content/list")
	arg_1_0.rankTpl = arg_1_0.bg:Find("rank_panel/list_panel/view_content/tpl")
	arg_1_0.rankMask = arg_1_0.bg:Find("rank_panel/mask")

	arg_1_0:hideRankPanel()

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId((arg_2_0.activity:getConfig("config_id")))

	var_0_1 = arg_2_0.activity:getConfig("config_client").gameid and var_0_1
	arg_2_0.is_ranking = pg.mini_game[var_0_1].is_ranking == 1
	arg_2_0.needCount = var_2_0:getConfig("reward_need")
	arg_2_0.leftCount = var_2_0.count
	arg_2_0.playedCount = var_2_0.usedtime
	arg_2_0.curDay = arg_2_0.leftCount + arg_2_0.playedCount

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	local var_3_0 = getProxy(MiniGameProxy)

	if var_3_0:CanFetchRank(var_0_1) then
		pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
			id = var_0_1,
			callback = function(...)
				arg_3_0:updateRankTf(...)

				return
			end
		})
	else
		arg_3_0:updateRankTf((var_3_0:GetRank(var_0_1)))
	end

	setActive(arg_3_0.rankBtn, arg_3_0.is_ranking)
	onButton(arg_3_0, arg_3_0.rankBtn, function()
		local var_5_0 = isActive(arg_3_0.rankPanel)

		setActive(arg_3_0.rankPanel, not var_5_0)

		if not var_5_0 then
			local var_5_1 = {
				hubid = getProxy(MiniGameProxy):GetHubByHubId((arg_3_0.activity:getConfig("config_id"))).id,
				cmd = MiniGameOPCommand.CMD_SPECIAL_TRACK
			}

			;({
				var_0_1
			})[2] = 103
			var_5_1.args1 = {
				var_0_1
			}

			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, var_5_1)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.rankMask, function()
		arg_3_0:hideRankPanel()

		return
	end, SFX_PANEL)
	arg_3_0.progressList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventInit then
			updateDrop(arg_7_2:Find("item_mask/item"), {
				type = pg.mini_game[var_0_1].simple_config_data.drop[arg_7_1 + 1][1],
				id = pg.mini_game[var_0_1].simple_config_data.drop[arg_7_1 + 1][2],
				count = pg.mini_game[var_0_1].simple_config_data.drop[arg_7_1 + 1][3]
			})
			onButton(arg_3_0, arg_7_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setText(arg_7_2:Find("text"), arg_7_1 + 1)
		elseif arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("item_mask/got"), arg_7_1 < arg_3_0.playedCount)
			setActive(arg_7_2:Find("got_sequence"), arg_7_1 < arg_3_0.playedCount)
		end

		return
	end)
	arg_3_0.progressList:align(arg_3_0.needCount)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.racing_minigame_help.tip
		})

		return
	end, SFX_PANEL)
	setText(arg_3_0.costTf:Find("cost_static"), i18n("racing_cost"))
	setText(arg_3_0.rankPanel:Find("static/top_text"), i18n("racing_rank_top_text"))
	setText(arg_3_0.rankPanel:Find("static/half_h_static"), i18n("racing_rank_half_h"))
	setText(arg_3_0.rankBlank:Find("text"), i18n("racing_rank_no_data"))

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	setActive(arg_11_0.ticketStat, arg_11_0.leftCount ~= 0)
	setText(arg_11_0.ticketNum, arg_11_0.leftCount)
	setText(arg_11_0.costTf, arg_11_0.playedCount)
	setSlider(arg_11_0.progressBar, 0, 1, arg_11_0.playedCount / arg_11_0.needCount)

	return
end

function var_0_0.updateRankTf(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(FriendProxy)
	local var_12_1 = getProxy(PlayerProxy):getData()

	arg_12_1 = underscore.filter(arg_12_1, function(arg_13_0)
		return var_12_0:isFriend(arg_13_0.player_id) or arg_13_0.player_id == var_12_1.id
	end)

	setActive(arg_12_0.rankPanel:Find("list_panel/scroll_bar/handle"), #arg_12_1 > 5)

	if #arg_12_1 == 0 then
		setActive(arg_12_0.rankBlank, true)
		arg_12_0:updateRankSelfTf(#arg_12_1)

		return
	end

	setActive(arg_12_0.rankBlank, false)
	UIItemList.StaticAlign(arg_12_0.rankContainer, arg_12_0.rankTpl, #arg_12_1, function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 ~= UIItemList.EventUpdate then
			return
		end

		setText(arg_14_2:Find("name"), arg_12_1[arg_14_1 + 1].name)
		setText(arg_14_2:Find("score"), arg_12_0:getScoreString(arg_12_1[arg_14_1 + 1].score))
		arg_12_0:updateRankPosTf(arg_14_2:Find("position"), arg_12_1[arg_14_1 + 1].position)
		arg_12_0:updateRankFaceTf(arg_14_2:Find("face"), arg_12_1[arg_14_1 + 1].display, arg_12_1[arg_14_1 + 1].position)

		return
	end)
	arg_12_0:updateRankSelfTf(#arg_12_1, (underscore.detect(arg_12_1, function(arg_15_0)
		return arg_15_0.player_id == var_12_1.id
	end)))

	return
end

function var_0_0.updateRankPosTf(arg_16_0, arg_16_1, arg_16_2)
	setActive(arg_16_1:Find("img1"), arg_16_2 == 1)
	setActive(arg_16_1:Find("img2"), arg_16_2 == 2)
	setActive(arg_16_1:Find("img3"), arg_16_2 == 3)
	setActive(arg_16_1:Find("text"), arg_16_2 > 3 or arg_16_2 == 0)

	if arg_16_2 > 3 then
		setText(arg_16_1:Find("text"), arg_16_2)
	end

	if arg_16_2 == 0 then
		setText(arg_16_1:Find("text"), "--")
	end

	return
end

function var_0_0.updateRankFaceTf(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3 then
		setActive(arg_17_1:Find("frame1"), arg_17_3 == 1)
		setActive(arg_17_1:Find("frame2"), arg_17_3 == 2)
		setActive(arg_17_1:Find("frame3"), arg_17_3 == 3)
		setActive(arg_17_1:Find("frame4"), arg_17_3 > 3)
	end

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_17_2.icon,
		skin_id = arg_17_2.skinId,
		propose = arg_17_2.proposeTime
	}):getPainting(), function(arg_18_0)
		arg_17_1:Find("mask/icon"):GetComponent(typeof(Image)).sprite = arg_18_0

		return
	end)

	return
end

function var_0_0.updateRankSelfTf(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = getProxy(PlayerProxy):getData()
	local var_19_1 = getProxy(BayProxy):getShipById(var_19_0.character)
	local var_19_2 = getProxy(MiniGameProxy)
	local var_19_3 = {}

	if arg_19_2 then
		var_19_3.position = arg_19_2.position or 0
		var_19_3.id = var_19_0.id
		var_19_3.name = var_19_0.name
		var_19_3.score = var_19_2:GetHighScore(var_0_1)
		var_19_3.display = {
			icon = var_19_1:getConfig("id"),
			skinId = var_19_1:getSkinId(),
			proposeTime = var_19_1.proposeTime
		}

		setText(arg_19_0.rankSelf:Find("name"), var_19_3.name)
		setText(arg_19_0.rankSelf:Find("score"), arg_19_0:getScoreString(var_19_3.score))
		arg_19_0:updateRankPosTf(arg_19_0.rankSelf:Find("position"), var_19_3.position)
		arg_19_0:updateRankFaceTf(arg_19_0.rankSelf:Find("face"), var_19_3.display, nil)
		setActive(arg_19_0.rankSelf, true)

		return
	end
end

function var_0_0.showRankPanel(arg_20_0)
	setActive(arg_20_0.rankPanel, true)

	return
end

function var_0_0.hideRankPanel(arg_21_0)
	setActive(arg_21_0.rankPanel, false)

	return
end

function var_0_0.getScoreString(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or 0

	return string.format("%.2fM", arg_22_1 / 100)
end

return var_0_0
