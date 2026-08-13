class = var_0_10000

local var_0_0 = "RacePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = 58

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.help = var_1.Find(var_1_1, "help")

	local var_1_2 = arg_1_0.bg

	arg_1_0.goBtn = var_1.Find(var_1_2, "go_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.ticketStat = var_1.Find(var_1_3, "ticket_static")

	local var_1_4 = arg_1_0.bg

	arg_1_0.ticketNum = var_1.Find(var_1_4, "ticket_num")

	local var_1_5 = arg_1_0.bg

	arg_1_0.costTf = var_1.Find(var_1_5, "cost")

	local var_1_6 = arg_1_0.bg

	arg_1_0.progressBar = var_1.Find(var_1_6, "progress_bar")

	local var_1_7 = arg_1_0.bg

	arg_1_0.progressTpl = var_1.Find(var_1_7, "progress_tpl")

	local var_1_8 = arg_1_0.bg

	arg_1_0.progressContainer = var_1.Find(var_1_8, "progress")
	UIItemList = var_1
	arg_1_0.progressList = var_1.New(arg_1_0.progressContainer, arg_1_0.progressTpl)

	local var_1_9 = arg_1_0.bg

	arg_1_0.rankBtn = var_1.Find(var_1_9, "rank_btn")

	local var_1_10 = arg_1_0.bg

	arg_1_0.rankPanel = var_1.Find(var_1_10, "rank_panel")

	local var_1_11 = arg_1_0.bg

	arg_1_0.rankBlank = var_1.Find(var_1_11, "rank_panel/static/blank_img")

	local var_1_12 = arg_1_0.bg

	arg_1_0.rankSelf = var_1.Find(var_1_12, "rank_panel/self")

	local var_1_13 = arg_1_0.bg

	arg_1_0.rankContainer = var_1.Find(var_1_13, "rank_panel/list_panel/view_content/list")

	local var_1_14 = arg_1_0.bg

	arg_1_0.rankTpl = var_1.Find(var_1_14, "rank_panel/list_panel/view_content/tpl")

	local var_1_15 = arg_1_0.bg

	arg_1_0.rankMask = var_1.Find(var_1_15, "rank_panel/mask")

	arg_1_0:hideRankPanel()

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_id")

	getProxy = var_2_0
	MiniGameProxy = var_3

	local var_2_2 = var_2_0(var_3)
	local var_2_3 = var_2.GetHubByHubId(var_2_2, var_2_1)
	local var_2_4 = arg_2_0.activity
	local var_2_5

	if var_3.getConfig(var_2_4, "config_client").gameid then
		var_2_5 = var_0_2
	end

	var_0_2 = var_2_5
	pg = var_2_5
	arg_2_0.is_ranking = var_2_5.mini_game[var_0_2].is_ranking == 1
	arg_2_0.needCount = var_2_3:getConfig("reward_need")
	arg_2_0.leftCount = var_2_3.count
	arg_2_0.playedCount = var_2_3.usedtime
	arg_2_0.curDay = arg_2_0.leftCount + arg_2_0.playedCount

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_2

	if var_1.CanFetchRank(var_3_0, var_0_2) then
		pg = var_3_2

		local var_3_1 = var_3_2.m02

		var_3_2 = var_3_2.sendNotification
		GAME = var_4

		var_3_2(var_3_1, var_4.MINI_GAME_FRIEND_RANK, {
			id = var_0_2,
			callback = function(...)
				local var_4_0 = arg_3_0

				var_0.updateRankTf(var_4_0, ...)

				return
			end
		})
	else
		var_3_2 = var_1:GetRank(var_0_2)

		arg_3_0:updateRankTf(var_3_2)
	end

	setActive = var_3_2

	var_3_2(arg_3_0.rankBtn, arg_3_0.is_ranking)

	onButton = var_3_2

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.rankBtn

	local function var_3_5()
		isActive = var_2_10000

		local var_5_0 = var_2_10000(arg_3_0.rankPanel)

		setActive = var_1

		var_1(arg_3_0.rankPanel, not var_5_0)

		if not var_5_0 then
			local var_5_1 = arg_3_0.activity
			local var_5_2 = var_1.getConfig(var_5_1, "config_id")

			getProxy = var_5_1
			MiniGameProxy = var_3

			local var_5_3 = var_5_1(var_3)
			local var_5_4 = var_2.GetHubByHubId(var_5_3, var_5_2)
			local var_5_5 = 103

			pg = var_4

			local var_5_6 = var_4.m02
			local var_5_7 = var_4.sendNotification

			GAME = var_2_10006

			local var_5_8 = var_2_10006.SEND_MINI_GAME_OP
			local var_5_9 = {
				hubid = var_5_4.id
			}

			MiniGameOPCommand = var_8
			var_5_9.cmd = var_8.CMD_SPECIAL_TRACK
			var_5_9.args1 = {
				var_0_2,
				var_5_5
			}

			var_5_7(var_5_6, var_5_8, var_5_9)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_3_2(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_3_2

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.rankMask

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.hideRankPanel(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_2(var_3_6, var_3_7, var_3_8, var_1_10006)

	local var_3_9 = arg_3_0.progressList

	var_2.make(var_3_9, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		local var_7_1

		if arg_7_0 == var_2_10003.EventInit then
			local var_7_0 = arg_7_2

			var_7_1 = arg_7_2.Find(var_7_0, "item_mask/item")
			pg = var_7_0

			local var_7_2 = var_7_0.mini_game[var_0_2].simple_config_data.drop[arg_7_1 + 1]
			local var_7_3 = {
				type = var_7_2[1],
				id = var_7_2[2],
				count = var_7_2[3]
			}

			updateDrop = var_6

			var_6(var_7_1, var_7_3)

			onButton = var_6

			local var_7_4 = arg_3_0
			local var_7_5 = arg_7_2

			local function var_7_6()
				local var_8_0 = arg_3_0
				local var_8_1 = var_0.emit

				BaseUI = var_3_10002

				var_8_1(var_8_0, var_3_10002.ON_DROP, var_7_3)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_7_4, var_7_5, var_7_6, var_2_10010)

			setText = var_6

			var_6(arg_7_2:Find("text"), arg_7_1 + 1)
		else
			UIItemList = var_7_1

			if arg_7_0 == var_7_1.EventUpdate then
				setActive = var_3

				var_3(arg_7_2:Find("item_mask/got"), arg_7_1 < arg_3_0.playedCount)

				setActive = var_3

				var_3(arg_7_2:Find("got_sequence"), arg_7_1 < arg_3_0.playedCount)
			end
		end

		return
	end)

	local var_3_10 = arg_3_0.progressList

	var_2.align(var_3_10, arg_3_0.needCount)

	onButton = var_2

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.goBtn

	local function var_3_13()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		GAME = var_2_10002

		var_9_1(var_9_0, var_2_10002.GO_MINI_GAME, var_0_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_11, var_3_12, var_3_13, var_1_10006)

	onButton = var_2

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.help

	local function var_3_16()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		pg = var_2_10003
		var_10_2.helps = var_2_10003.gametip.racing_minigame_help.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_14, var_3_15, var_3_16, var_1_10006)

	setText = var_2

	local var_3_17 = arg_3_0.costTf
	local var_3_18 = var_3.Find(var_3_17, "cost_static")

	i18n = var_3_17

	var_2(var_3_18, var_3_17("racing_cost"))

	setText = var_2

	local var_3_19 = arg_3_0.rankPanel
	local var_3_20 = var_3.Find(var_3_19, "static/top_text")

	i18n = var_3_19

	var_2(var_3_20, var_3_19("racing_rank_top_text"))

	setText = var_2

	local var_3_21 = arg_3_0.rankPanel
	local var_3_22 = var_3.Find(var_3_21, "static/half_h_static")

	i18n = var_3_21

	var_2(var_3_22, var_3_21("racing_rank_half_h"))

	setText = var_2

	local var_3_23 = arg_3_0.rankBlank
	local var_3_24 = var_3.Find(var_3_23, "text")

	i18n = var_3_23

	var_2(var_3_24, var_3_23("racing_rank_no_data"))

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0.ticketStat, arg_11_0.leftCount ~= 0)

	setText = var_1_10001

	var_1_10001(arg_11_0.ticketNum, arg_11_0.leftCount)

	setText = var_1_10001

	var_1_10001(arg_11_0.costTf, arg_11_0.playedCount)

	setSlider = var_1_10001

	var_1_10001(arg_11_0.progressBar, 0, 1, arg_11_0.playedCount / arg_11_0.needCount)

	return
end

function var_0_1.updateRankTf(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	FriendProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_12_1 = var_1_10003(var_1_10004)
	local var_12_2 = var_3.getData(var_12_1)

	underscore = var_12_1
	arg_12_1 = var_12_1.filter(arg_12_1, function(arg_13_0)
		local var_13_0 = var_12_0
		local var_13_1

		if not var_1.isFriend(var_13_0, arg_13_0.player_id) then
			var_13_1 = arg_13_0.player_id == var_12_2.id
		end

		return var_13_1
	end)
	setActive = var_5

	local var_12_3 = arg_12_0.rankPanel

	var_5(var_6.Find(var_12_3, "list_panel/scroll_bar/handle"), #arg_12_1 > 5)

	if #arg_12_1 == 0 then
		setActive = var_5

		var_5(arg_12_0.rankBlank, true)
		arg_12_0:updateRankSelfTf(#arg_12_1)

		return
	end

	setActive = var_5

	var_5(arg_12_0.rankBlank, false)

	UIItemList = var_5

	var_5.StaticAlign(arg_12_0.rankContainer, arg_12_0.rankTpl, #arg_12_1, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 ~= var_2_10003.EventUpdate then
			return
		end

		setText = var_3

		var_3(arg_14_2:Find("name"), arg_12_1[arg_14_1 + 1].name)

		setText = var_3

		local var_14_0 = arg_14_2:Find("score")
		local var_14_1 = arg_12_0

		var_3(var_14_0, var_5.getScoreString(var_14_1, arg_12_1[arg_14_1 + 1].score))

		local var_14_2 = arg_12_0

		var_3.updateRankPosTf(var_14_2, arg_14_2:Find("position"), arg_12_1[arg_14_1 + 1].position)

		local var_14_3 = arg_12_0

		var_3.updateRankFaceTf(var_14_3, arg_14_2:Find("face"), arg_12_1[arg_14_1 + 1].display, arg_12_1[arg_14_1 + 1].position)

		return
	end)

	underscore = var_5

	local var_12_4 = var_5.detect(arg_12_1, function(arg_15_0)
		return arg_15_0.player_id == var_12_2.id
	end)

	arg_12_0:updateRankSelfTf(#arg_12_1, var_12_4)

	return
end

function var_0_1.updateRankPosTf(arg_16_0, arg_16_1, arg_16_2)
	setActive = var_1_10003

	var_1_10003(arg_16_1:Find("img1"), arg_16_2 == 1)

	setActive = var_1_10003

	var_1_10003(arg_16_1:Find("img2"), arg_16_2 == 2)

	setActive = var_1_10003

	var_1_10003(arg_16_1:Find("img3"), arg_16_2 == 3)

	setActive = var_1_10003

	var_1_10003(arg_16_1:Find("text"), arg_16_2 > 3 or arg_16_2 == 0)

	if 3 < arg_16_2 then
		setText = var_3

		var_3(arg_16_1:Find("text"), arg_16_2)
	end

	if arg_16_2 == 0 then
		setText = var_3

		var_3(arg_16_1:Find("text"), "--")
	end

	return
end

function var_0_1.updateRankFaceTf(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3 then
		setActive = var_1_10004

		var_1_10004(arg_17_1:Find("frame1"), arg_17_3 == 1)

		setActive = var_1_10004

		var_1_10004(arg_17_1:Find("frame2"), arg_17_3 == 2)

		setActive = var_1_10004

		var_1_10004(arg_17_1:Find("frame3"), arg_17_3 == 3)

		setActive = var_1_10004

		var_1_10004(arg_17_1:Find("frame4"), arg_17_3 > 3)
	end

	pg = var_1_10004

	local var_17_0 = var_1_10004.ship_data_statistics[arg_17_2.icon]

	Ship = var_5

	local var_17_1 = var_5.New({
		configId = arg_17_2.icon,
		skin_id = arg_17_2.skinId,
		propose = arg_17_2.proposeTime
	})

	LoadSpriteAsync = var_6

	var_6("qicon/" .. var_17_1:getPainting(), function(arg_18_0)
		local var_18_0 = arg_17_1
		local var_18_1 = var_1.Find(var_18_0, "mask/icon")
		local var_18_2 = var_1.GetComponent

		typeof = var_3
		Image = var_2_10004
		var_18_2(var_18_1, var_3(var_2_10004)).sprite = arg_18_0

		return
	end)

	return
end

function var_0_1.updateRankSelfTf(arg_19_0, arg_19_1, arg_19_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_19_0 = var_1_10003(var_1_10004)
	local var_19_1 = var_3.getData(var_19_0)

	getProxy = var_19_0
	BayProxy = var_1_10006

	local var_19_2 = var_19_0(var_1_10006)
	local var_19_3 = var_5.getShipById(var_19_2, var_19_1.character)

	getProxy = var_19_2
	MiniGameProxy = var_7

	local var_19_4 = var_19_2(var_7)
	local var_19_5 = {}
	local var_19_6

	if not arg_19_2 or not arg_19_2.position then
		var_19_6 = 0
	end

	var_19_5.position = var_19_6
	var_19_5.id = var_19_1.id
	var_19_5.name = var_19_1.name
	var_19_5.score = var_19_4:GetHighScore(var_0_2)
	var_19_5.display = {
		icon = var_19_3:getConfig("id"),
		skinId = var_19_3:getSkinId(),
		proposeTime = var_19_3.proposeTime
	}
	setText = var_8

	local var_19_7 = arg_19_0.rankSelf

	var_8(var_9.Find(var_19_7, "name"), var_19_5.name)

	setText = var_8

	local var_19_8 = arg_19_0.rankSelf

	var_8(var_9.Find(var_19_8, "score"), arg_19_0:getScoreString(var_19_5.score))

	local var_19_9 = arg_19_0
	local var_19_10 = arg_19_0.updateRankPosTf
	local var_19_11 = arg_19_0.rankSelf

	var_19_10(var_19_9, var_10.Find(var_19_11, "position"), var_19_5.position)

	local var_19_12 = arg_19_0
	local var_19_13 = arg_19_0.updateRankFaceTf
	local var_19_14 = arg_19_0.rankSelf

	var_19_13(var_19_12, var_10.Find(var_19_14, "face"), var_19_5.display, nil)

	setActive = var_19_13

	var_19_13(arg_19_0.rankSelf, true)

	return
end

function var_0_1.showRankPanel(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.rankPanel, true)

	return
end

function var_0_1.hideRankPanel(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.rankPanel, false)

	return
end

function var_0_1.getScoreString(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or 0
	string = var_1_10002

	return var_1_10002.format("%.2fM", arg_22_1 / 100)
end

return var_0_1
