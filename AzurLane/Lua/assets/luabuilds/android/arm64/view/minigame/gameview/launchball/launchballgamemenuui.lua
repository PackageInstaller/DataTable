class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallGameMenuUI")

var_0_0.player_item = {
	{
		id = 1,
		name = "Hatsuduki",
		skill_1_desc = "launch_ball_hatsuduki_skill_1_desc",
		skill_2_desc = "launch_ball_hatsuduki_skill_2_desc",
		skill_1 = "launch_ball_hatsuduki_skill_1",
		skill_2 = "launch_ball_hatsuduki_skill_2"
	},
	{
		id = 2,
		name = "Shinano",
		skill_1_desc = "launch_ball_shinano_skill_1_desc",
		skill_2_desc = "launch_ball_shinano_skill_2_desc",
		skill_1 = "launch_ball_shinano_skill_1",
		skill_2 = "launch_ball_shinano_skill_2"
	},
	{
		id = 3,
		name = "Yura",
		skill_1_desc = "launch_ball_yura_skill_1_desc",
		skill_2_desc = "launch_ball_yura_skill_2_desc",
		skill_1 = "launch_ball_yura_skill_1",
		skill_2 = "launch_ball_yura_skill_2"
	},
	{
		id = 4,
		name = "Shimakaze",
		skill_1_desc = "launch_ball_shimakaze_skill_1_desc",
		skill_2_desc = "launch_ball_shimakaze_skill_2_desc",
		skill_1 = "launch_ball_shimakaze_skill_1",
		skill_2 = "launch_ball_shimakaze_skill_2"
	}
}
var_0_0.skill_detail_desc = "launch_ball_skill_desc"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.menuUI = var_1_10003(arg_1_0._tf, "ui/menuUI")
	GetComponent = var_3
	findTF = var_5

	local var_1_0 = var_5(arg_1_0.menuUI, "battList")

	typeof = var_6
	ScrollRect = var_8
	arg_1_0.battleScrollRect = var_3(var_1_0, var_6(var_8))
	LaunchBallGameVo = var_3
	arg_1_0.totalTimes = var_3.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	onButton = var_3

	local var_1_1 = arg_1_0._event

	findTF = var_6

	local var_1_2 = var_6(arg_1_0.menuUI, "rightPanelBg/arrowUp")

	local function var_1_3()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if 1 < var_2_0 then
			var_2_0 = 1
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_1, var_1_2, var_1_3, var_8)

	onButton = var_3

	local var_1_4 = arg_1_0._event

	findTF = var_1_2

	local var_1_5 = var_1_2(arg_1_0.menuUI, "rightPanelBg/arrowDown")

	local function var_1_6()
		local var_3_0

		if arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4) < 0 then
			var_3_0 = 0
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_3_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_4, var_1_5, var_1_6, var_8)

	onButton = var_3

	local var_1_7 = arg_1_0._event

	findTF = var_1_5

	local var_1_8 = var_1_5(arg_1_0.menuUI, "btnBack")

	local function var_1_9()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_4_1(var_4_0, var_2_10003.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_7, var_1_8, var_1_9, var_8)

	onButton = var_3

	local var_1_10 = arg_1_0._event

	findTF = var_1_8

	local var_1_11 = var_1_8(arg_1_0.menuUI, "btnRule")

	local function var_1_12()
		local var_5_0 = arg_1_0._event
		local var_5_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_5_1(var_5_0, var_2_10003.SHOW_RULE)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_10, var_1_11, var_1_12, var_8)

	findTF = var_3
	arg_1_0.btnStart = var_3(arg_1_0.menuUI, "btnStart")
	onButton = var_3

	local var_1_13 = arg_1_0._event

	findTF = var_6

	local var_1_14 = var_6(arg_1_0.menuUI, "btnStart")

	local function var_1_15()
		if arg_1_0.playerId == nil then
			return
		end

		local var_6_0 = arg_1_0._event
		local var_6_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_6_1(var_6_0, var_2_10003.READY_START)

		return
	end

	SFX_CANCEL = var_1_17

	var_3(var_1_13, var_1_14, var_1_15, var_1_17)

	findTF = var_3

	local var_1_16 = var_3(arg_1_0.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		tf = var_1_17
		instantiate = var_1_10010

		local var_1_17 = var_1_17(var_1_10010(var_1_16))

		var_1_17.name = "battleItem_" .. iter_1_0
		setParent = var_1_19

		local var_1_18 = var_1_17

		findTF = var_12

		var_1_19(var_1_18, var_12(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_19 = iter_1_0

		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_1_17, "icon")
		onButton = var_1_18

		local var_1_20 = arg_1_0._event

		var_1_10014 = var_1_10010

		local function var_1_21()
			return
		end

		SFX_PANEL = var_1_10016

		var_1_18(var_1_20, var_1_10014, var_1_21, var_1_10016)

		table = var_1_18

		var_1_18.insert(arg_1_0.dropItems, var_1_10010)

		setActive = var_11

		var_11(var_1_17, true)

		table = var_11

		var_11.insert(arg_1_0.battleItems, var_1_17)
	end

	arg_1_0.players = {}

	for iter_1_1 = 1, #var_0_0.player_item do
		local var_1_22 = var_0_0.player_item[iter_1_1]

		findTF = var_1_19
		var_1_19 = var_1_19(arg_1_0.menuUI, "player/" .. var_1_22.name)
		LaunchBallActivityMgr = var_1_10010
		var_1_10010 = var_1_10010.GetPlayerZhuanshuIndex(var_1_22.id)

		local var_1_23 = false
		local var_1_24

		if var_1_10010 then
			LaunchBallActivityMgr = var_1_24
			var_1_24 = var_1_24.CheckZhuanShuAble
			ActivityConst = var_1_10014
			var_1_23 = var_1_24(var_1_10014.MINIGAME_ZUMA, var_1_10010)
		else
			var_1_23 = true
		end

		LaunchBallGameVo = var_1_24

		if var_1_24.game_room_flag then
			var_1_23 = true
		end

		setActive = var_12
		findTF = var_1_10014

		var_12(var_1_10014(var_1_19, "ad/mask"), not var_1_23)

		setScrollText = var_12
		findTF = var_1_10014
		var_1_10014 = var_1_10014(var_1_19, "ad/skillPanel/skill1/text")
		i18n = var_15

		var_12(var_1_10014, var_15(var_1_22.skill_1))

		setScrollText = var_12
		findTF = var_1_10014
		var_1_10014 = var_1_10014(var_1_19, "ad/skillPanel/skill2/text")
		i18n = var_15

		var_12(var_1_10014, var_15(var_1_22.skill_2))

		setText = var_12
		findTF = var_1_10014
		var_1_10014 = var_1_10014(var_1_19, "ad/skillPanel/detail/img")
		i18n = var_15

		var_12(var_1_10014, var_15(var_0_0.skill_detail_desc))

		GetComponent = var_12
		findTF = var_1_10014
		var_1_10014 = var_1_10014(var_1_19, "ad/icon")
		typeof = var_15
		Animator = var_17

		local var_1_25 = var_12(var_1_10014, var_15(var_17))

		onButton = var_13

		local var_1_26 = arg_1_0._event

		findTF = var_16

		local var_1_27 = var_16(var_1_19, "ad/click")

		local function var_1_28()
			if not var_1_23 then
				pg = var_0

				local var_8_0 = var_0.m02
				local var_8_1 = var_0.sendNotification

				GAME = var_2_10003

				local var_8_2 = var_2_10003.GO_SCENE

				SCENE = var_2_10004

				var_8_1(var_8_0, var_8_2, var_2_10004.ZUMA_PT_SHOP)

				return
			end

			if arg_1_0.playerId == var_1_22.id then
				local var_8_3 = arg_1_0

				var_0.selectPlayer(var_8_3, nil)
			else
				local var_8_4 = arg_1_0

				var_0.selectPlayer(var_8_4, var_1_22.id)
			end

			return
		end

		SFX_CONFIRM = var_18

		var_13(var_1_26, var_1_27, var_1_28, var_18)

		onButton = var_13

		local var_1_29 = arg_1_0._event

		findTF = var_1_27

		local var_1_30 = var_1_27(var_1_19, "ad/skillPanel")

		local function var_1_31()
			local var_9_0 = arg_1_0

			var_0.showSkillPanel(var_9_0, var_1_22)

			setActive = var_0

			var_0(arg_1_0.skillDetailPanel, true)

			return
		end

		SFX_CONFIRM = var_18

		var_13(var_1_29, var_1_30, var_1_31, var_18)

		table = var_13

		var_13.insert(arg_1_0.players, {
			tf = var_1_19,
			data = var_1_22,
			anim = var_1_25
		})
	end

	findTF = var_4
	arg_1_0.skillDetailPanel = var_4(arg_1_0.menuUI, "skillDetail")
	setActive = var_4

	var_4(arg_1_0.skillDetailPanel, false)

	onButton = var_4

	local var_1_32 = arg_1_0._event

	findTF = var_7

	local var_1_33 = var_7(arg_1_0.skillDetailPanel, "ad")

	local function var_1_34()
		setActive = var_2_10000

		var_2_10000(arg_1_0.skillDetailPanel, false)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_32, var_1_33, var_1_34, var_9)

	onButton = var_4

	local var_1_35 = arg_1_0._event

	findTF = var_1_33

	local var_1_36 = var_1_33(arg_1_0.skillDetailPanel, "ad/btnOk")

	local function var_1_37()
		setActive = var_2_10000

		var_2_10000(arg_1_0.skillDetailPanel, false)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_1_35, var_1_36, var_1_37, var_9)

	findTF = var_4
	arg_1_0.selectMask = var_4(arg_1_0.menuUI, "selectMask")
	setText = var_4
	findTF = var_6

	local var_1_38 = var_6(arg_1_0.menuUI, "select")

	i18n = var_7
	LaunchBallGameVo = var_9

	var_4(var_1_38, var_7(var_9.launchball_minigame_select))

	setText = var_4
	findTF = var_1_38

	local var_1_39 = var_1_38(arg_1_0.menuUI, "selectMask/unSelect")

	i18n = var_7
	LaunchBallGameVo = var_9

	var_4(var_1_39, var_7(var_9.launchball_minigame_un_select))
	arg_1_0:selectPlayer(nil)

	return
end

function var_0_0.selectPlayer(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_0.players do
		if arg_12_0.players[iter_12_0].data.id == arg_12_1 then
			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(arg_12_0.players[iter_12_0].tf, "ad/select"), true)

			var_1_10008 = arg_12_0.players[iter_12_0].anim

			var_6.Play(var_1_10008, "Attack")
		else
			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(arg_12_0.players[iter_12_0].tf, "ad/select"), false)

			var_1_10008 = arg_12_0.players[iter_12_0].anim

			var_6.Play(var_1_10008, "Idle")
		end
	end

	arg_12_0.playerId = arg_12_1
	LaunchBallGameVo = var_2

	var_2.SetPlayer(arg_12_0.playerId)

	if arg_12_0.playerId == nil then
		setActive = var_2

		var_2(arg_12_0.btnStart, false)

		setActive = var_2

		var_2(arg_12_0.selectMask, false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_12_0.menuUI, "select"), true)
	else
		setActive = var_2

		var_2(arg_12_0.btnStart, true)

		setActive = var_2

		var_2(arg_12_0.selectMask, true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_12_0.menuUI, "select"), false)
	end

	return
end

function var_0_0.showSkillPanel(arg_13_0, arg_13_1)
	i18n = var_1_10002

	local var_13_0 = var_1_10002(arg_13_1.skill_1)

	i18n = var_1_10003

	local var_13_1 = var_1_10003(arg_13_1.skill_1_desc)

	i18n = var_4

	local var_13_2 = var_4(arg_13_1.skill_2)

	i18n = var_5

	local var_13_3 = var_5(arg_13_1.skill_2_desc)

	if var_13_0 then
		setText = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill1Bg/skill1Name"), var_13_0)

		setText = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill1Desc"), var_13_1)

		setActive = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill1Desc"), true)

		setActive = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill1Bg"), true)
	else
		setActive = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill1Desc"), false)

		setActive = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill1Bg"), false)
	end

	if var_13_2 then
		setText = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill2Bg/skill2Name"), var_13_2)

		setText = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill2Desc"), var_13_3)

		setActive = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill2Desc"), true)

		setActive = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill2Bg"), true)
	else
		setActive = var_6
		findTF = var_1_10008

		var_6(var_1_10008(arg_13_0.skillDetailPanel, "ad/skill2Desc"), false)

		setActive = var_6
		findTF = var_8

		var_6(var_8(arg_13_0.skillDetailPanel, "ad/skill2Bg"), false)
	end

	return
end

function var_0_0.show(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.menuUI, arg_14_1)

	return
end

function var_0_0.update(arg_15_0, arg_15_1)
	arg_15_0.mgHubData = arg_15_1

	local var_15_0 = arg_15_0:getGameUsedTimes(arg_15_1)
	local var_15_1 = arg_15_0:getGameTimes(arg_15_1)

	for iter_15_0 = 1, #arg_15_0.battleItems do
		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_open"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_closed"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_clear"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_current"), false)

		if iter_15_0 <= var_15_0 then
			SetParent = var_1_10008
			var_1_10010 = arg_15_0.dropItems[iter_15_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_15_0.battleItems[iter_15_0], "state_clear/icon"))

			setActive = var_1_10008

			var_1_10008(arg_15_0.dropItems[iter_15_0], true)

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_clear"), true)
		elseif iter_15_0 == var_15_0 + 1 and 1 <= var_15_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_current"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_15_0.dropItems[iter_15_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_15_0.battleItems[iter_15_0], "state_current/icon"))

			setActive = var_1_10008

			var_1_10008(arg_15_0.dropItems[iter_15_0], true)
		elseif var_15_0 < iter_15_0 and iter_15_0 <= var_15_0 + var_15_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_open"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_15_0.dropItems[iter_15_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_15_0.battleItems[iter_15_0], "state_open/icon"))

			setActive = var_1_10008

			var_1_10008(arg_15_0.dropItems[iter_15_0], true)
		else
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_15_0.battleItems[iter_15_0], "state_closed"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_15_0.dropItems[iter_15_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_15_0.battleItems[iter_15_0], "state_closed/icon"))

			setActive = var_1_10008

			var_1_10008(arg_15_0.dropItems[iter_15_0], true)
		end
	end

	local var_15_2 = 1 - (var_15_0 - 3 < 0 and 0 or var_15_0 - 3) / (arg_15_0.totalTimes - 4)

	if 1 < var_15_2 then
		var_15_2 = 1
	end

	scrollTo = var_6

	var_6(arg_15_0.battleScrollRect, 0, var_15_2)

	setActive = var_6
	findTF = var_8

	var_6(var_8(arg_15_0.menuUI, "btnStart/tip"), var_15_1 > 0)

	return
end

function var_0_0.CheckGet(arg_16_0)
	local var_16_0 = arg_16_0.mgHubData

	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_16_0.menuUI, "got"), false)

	if arg_16_0:getUltimate(var_16_0) and var_2 ~= 0 then
		setActive = var_1_10003
		findTF = var_5

		var_1_10003(var_5(arg_16_0.menuUI, "got"), true)
	end

	if var_2 == 0 then
		LaunchBallGameVo = var_1_10003

		if var_1_10003.total_times > arg_16_0:getGameUsedTimes(var_16_0) then
			return
		end

		pg = var_5

		local var_16_1 = var_5.m02
		local var_16_2 = var_5.sendNotification

		GAME = var_1_10008

		local var_16_3 = var_1_10008.SEND_MINI_GAME_OP
		local var_16_4 = {
			hubid = var_16_0.id
		}

		MiniGameOPCommand = var_10
		var_16_4.cmd = var_10.CMD_ULTIMATE
		var_16_4.args1 = {}

		var_16_2(var_16_1, var_16_3, var_16_4)

		setActive = var_16_2
		findTF = var_16_1

		var_16_2(var_16_1(arg_16_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_17_0, arg_17_1)
	return arg_17_1.count
end

function var_0_0.getGameUsedTimes(arg_18_0, arg_18_1)
	return arg_18_1.usedtime
end

function var_0_0.getUltimate(arg_19_0, arg_19_1)
	return arg_19_1.ultimate
end

return var_0_0
