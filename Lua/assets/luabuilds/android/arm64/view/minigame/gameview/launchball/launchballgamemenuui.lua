local var_0_0 = class("LaunchBallGameMenuUI")

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
	arg_1_0.menuUI = findTF(arg_1_0._tf, "ui/menuUI")
	arg_1_0.battleScrollRect = GetComponent(findTF(arg_1_0.menuUI, "battList"), typeof(ScrollRect))
	arg_1_0.totalTimes = LaunchBallGameVo.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}

	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4) > 1 then
			var_2_0 = 1
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_3_0 = arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4)

		if arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4) < 0 then
			var_3_0 = 0
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_3_0)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnBack"), function()
		arg_1_0._event:emit(BeachGuardGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnRule"), function()
		arg_1_0._event:emit(BeachGuardGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)

	arg_1_0.btnStart = findTF(arg_1_0.menuUI, "btnStart")

	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnStart"), function()
		if arg_1_0.playerId == nil then
			return
		end

		arg_1_0._event:emit(BeachGuardGameView.READY_START)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(arg_1_0.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_1 = tf(instantiate(var_1_0))

		var_1_1.name = "battleItem_" .. iter_1_0

		setParent(var_1_1, findTF(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_3 = findTF(var_1_1, "icon")

		onButton(arg_1_0._event, var_1_3, function()
			return
		end, SFX_PANEL)
		table.insert(arg_1_0.dropItems, var_1_3)
		setActive(var_1_1, true)
		table.insert(arg_1_0.battleItems, var_1_1)
	end

	arg_1_0.players = {}

	for iter_1_1 = 1, #var_0_0.player_item do
		local var_1_4 = var_0_0.player_item[iter_1_1]
		local var_1_5 = findTF(arg_1_0.menuUI, "player/" .. var_0_0.player_item[iter_1_1].name)
		local var_1_6 = LaunchBallActivityMgr.GetPlayerZhuanshuIndex(var_0_0.player_item[iter_1_1].id)
		local var_1_7 = false

		var_1_7 = var_1_6 and LaunchBallActivityMgr.CheckZhuanShuAble(ActivityConst.MINIGAME_ZUMA, var_1_6) or true

		if LaunchBallGameVo.game_room_flag then
			var_1_7 = true
		end

		setActive(findTF(var_1_5, "ad/mask"), not var_1_7)
		setScrollText(findTF(var_1_5, "ad/skillPanel/skill1/text"), i18n(var_1_4.skill_1))
		setScrollText(findTF(var_1_5, "ad/skillPanel/skill2/text"), i18n(var_1_4.skill_2))
		setText(findTF(var_1_5, "ad/skillPanel/detail/img"), i18n(var_0_0.skill_detail_desc))

		local var_1_8 = GetComponent(findTF(var_1_5, "ad/icon"), typeof(Animator))

		onButton(arg_1_0._event, findTF(var_1_5, "ad/click"), function()
			if not var_1_7 then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ZUMA_PT_SHOP)

				return
			end

			if arg_1_0.playerId == var_1_4.id then
				arg_1_0:selectPlayer(nil)
			else
				arg_1_0:selectPlayer(var_1_4.id)
			end

			return
		end, SFX_CONFIRM)
		onButton(arg_1_0._event, findTF(var_1_5, "ad/skillPanel"), function()
			arg_1_0:showSkillPanel(var_1_4)
			setActive(arg_1_0.skillDetailPanel, true)

			return
		end, SFX_CONFIRM)
		table.insert(arg_1_0.players, {
			tf = var_1_5,
			data = var_1_4,
			anim = var_1_8
		})
	end

	arg_1_0.skillDetailPanel = findTF(arg_1_0.menuUI, "skillDetail")

	setActive(arg_1_0.skillDetailPanel, false)
	onButton(arg_1_0._event, findTF(arg_1_0.skillDetailPanel, "ad"), function()
		setActive(arg_1_0.skillDetailPanel, false)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.skillDetailPanel, "ad/btnOk"), function()
		setActive(arg_1_0.skillDetailPanel, false)

		return
	end, SFX_CANCEL)

	arg_1_0.selectMask = findTF(arg_1_0.menuUI, "selectMask")

	setText(findTF(arg_1_0.menuUI, "select"), i18n(LaunchBallGameVo.launchball_minigame_select))
	setText(findTF(arg_1_0.menuUI, "selectMask/unSelect"), i18n(LaunchBallGameVo.launchball_minigame_un_select))
	arg_1_0:selectPlayer(nil)

	return
end

function var_0_0.selectPlayer(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_0.players do
		if arg_12_0.players[iter_12_0].data.id == arg_12_1 then
			setActive(findTF(arg_12_0.players[iter_12_0].tf, "ad/select"), true)
			arg_12_0.players[iter_12_0].anim:Play("Attack")
		else
			setActive(findTF(arg_12_0.players[iter_12_0].tf, "ad/select"), false)
			arg_12_0.players[iter_12_0].anim:Play("Idle")
		end
	end

	arg_12_0.playerId = arg_12_1

	LaunchBallGameVo.SetPlayer(arg_12_0.playerId)

	if arg_12_0.playerId == nil then
		setActive(arg_12_0.btnStart, false)
		setActive(arg_12_0.selectMask, false)
		setActive(findTF(arg_12_0.menuUI, "select"), true)
	else
		setActive(arg_12_0.btnStart, true)
		setActive(arg_12_0.selectMask, true)
		setActive(findTF(arg_12_0.menuUI, "select"), false)
	end

	return
end

function var_0_0.showSkillPanel(arg_13_0, arg_13_1)
	local var_13_0 = i18n(arg_13_1.skill_1)
	local var_13_1 = i18n(arg_13_1.skill_2)
	local var_13_2 = i18n(arg_13_1.skill_2_desc)

	if var_13_0 then
		setText(findTF(arg_13_0.skillDetailPanel, "ad/skill1Bg/skill1Name"), var_13_0)
		setText(findTF(arg_13_0.skillDetailPanel, "ad/skill1Desc"), (i18n(arg_13_1.skill_1_desc)))
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill1Desc"), true)
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill1Bg"), true)
	else
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill1Desc"), false)
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill1Bg"), false)
	end

	if var_13_1 then
		setText(findTF(arg_13_0.skillDetailPanel, "ad/skill2Bg/skill2Name"), var_13_1)
		setText(findTF(arg_13_0.skillDetailPanel, "ad/skill2Desc"), var_13_2)
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill2Desc"), true)
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill2Bg"), true)
	else
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill2Desc"), false)
		setActive(findTF(arg_13_0.skillDetailPanel, "ad/skill2Bg"), false)
	end

	return
end

function var_0_0.show(arg_14_0, arg_14_1)
	setActive(arg_14_0.menuUI, arg_14_1)

	return
end

function var_0_0.update(arg_15_0, arg_15_1)
	arg_15_0.mgHubData = arg_15_1

	local var_15_0 = arg_15_0:getGameUsedTimes(arg_15_1)
	local var_15_1 = arg_15_0:getGameTimes(arg_15_1)

	for iter_15_0 = 1, #arg_15_0.battleItems do
		setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_open"), false)
		setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_closed"), false)
		setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_clear"), false)
		setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_current"), false)

		if iter_15_0 <= var_15_0 then
			SetParent(arg_15_0.dropItems[iter_15_0], findTF(arg_15_0.battleItems[iter_15_0], "state_clear/icon"))
			setActive(arg_15_0.dropItems[iter_15_0], true)
			setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_clear"), true)
		elseif iter_15_0 == var_15_0 + 1 and var_15_1 >= 1 then
			setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_current"), true)
			SetParent(arg_15_0.dropItems[iter_15_0], findTF(arg_15_0.battleItems[iter_15_0], "state_current/icon"))
			setActive(arg_15_0.dropItems[iter_15_0], true)
		elseif var_15_0 < iter_15_0 and iter_15_0 <= var_15_0 + var_15_1 then
			setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_open"), true)
			SetParent(arg_15_0.dropItems[iter_15_0], findTF(arg_15_0.battleItems[iter_15_0], "state_open/icon"))
			setActive(arg_15_0.dropItems[iter_15_0], true)
		else
			setActive(findTF(arg_15_0.battleItems[iter_15_0], "state_closed"), true)
			SetParent(arg_15_0.dropItems[iter_15_0], findTF(arg_15_0.battleItems[iter_15_0], "state_closed/icon"))
			setActive(arg_15_0.dropItems[iter_15_0], true)
		end
	end

	local var_15_2 = 1 - (var_15_0 - 3 < 0 and 0 or var_15_0 - 3) / (arg_15_0.totalTimes - 4)

	if 1 - (var_15_0 - 3 < 0 and 0 or var_15_0 - 3) / (arg_15_0.totalTimes - 4) > 1 then
		var_15_2 = 1
	end

	scrollTo(arg_15_0.battleScrollRect, 0, var_15_2)
	setActive(findTF(arg_15_0.menuUI, "btnStart/tip"), var_15_1 > 0)

	return
end

function var_0_0.CheckGet(arg_16_0)
	setActive(findTF(arg_16_0.menuUI, "got"), false)

	local var_16_0 = arg_16_0:getUltimate(arg_16_0.mgHubData)

	if var_16_0 and var_16_0 ~= 0 then
		setActive(findTF(arg_16_0.menuUI, "got"), true)
	end

	if var_16_0 == 0 then
		if LaunchBallGameVo.total_times > arg_16_0:getGameUsedTimes(arg_16_0.mgHubData) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_16_0.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_16_0.menuUI, "got"), true)
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
