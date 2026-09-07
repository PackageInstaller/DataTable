local LaunchBallGameMenuUI = class("LaunchBallGameMenuUI")

LaunchBallGameMenuUI.player_item = {
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
LaunchBallGameMenuUI.skill_detail_desc = "launch_ball_skill_desc"

function LaunchBallGameMenuUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self.menuUI = findTF(self._tf, "ui/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = LaunchBallGameVo.total_times
	self.battleItems = {}
	self.dropItems = {}

	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnBack"), function()
		self._event:emit(BeachGuardGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnRule"), function()
		self._event:emit(BeachGuardGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self.menuUI, "btnStart")

	onButton(self._event, findTF(self.menuUI, "btnStart"), function()
		if self.playerId == nil then
			return
		end

		self._event:emit(BeachGuardGameView.READY_START)

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(self.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_1 = tf(instantiate(var_1_0))

		var_1_1.name = "battleItem_" .. iter_1_0

		setParent(var_1_1, findTF(self.menuUI, "battList/Viewport/Content"))

		local var_1_3 = findTF(var_1_1, "icon")

		onButton(self._event, var_1_3, function()
			return
		end, SFX_PANEL)
		table.insert(self.dropItems, var_1_3)
		setActive(var_1_1, true)
		table.insert(self.battleItems, var_1_1)
	end

	self.players = {}

	for iter_1_1 = 1, #LaunchBallGameMenuUI.player_item do
		local var_1_4 = LaunchBallGameMenuUI.player_item[iter_1_1]
		local var_1_5 = findTF(self.menuUI, "player/" .. LaunchBallGameMenuUI.player_item[iter_1_1].name)
		local var_1_6 = LaunchBallActivityMgr.GetPlayerZhuanshuIndex(LaunchBallGameMenuUI.player_item[iter_1_1].id)
		local var_1_7 = false

		var_1_7 = var_1_6 and LaunchBallActivityMgr.CheckZhuanShuAble(ActivityConst.MINIGAME_ZUMA, var_1_6) or true

		if LaunchBallGameVo.game_room_flag then
			var_1_7 = true
		end

		setActive(findTF(var_1_5, "ad/mask"), not var_1_7)
		setScrollText(findTF(var_1_5, "ad/skillPanel/skill1/text"), i18n(var_1_4.skill_1))
		setScrollText(findTF(var_1_5, "ad/skillPanel/skill2/text"), i18n(var_1_4.skill_2))
		setText(findTF(var_1_5, "ad/skillPanel/detail/img"), i18n(LaunchBallGameMenuUI.skill_detail_desc))

		local var_1_8 = GetComponent(findTF(var_1_5, "ad/icon"), typeof(Animator))

		onButton(self._event, findTF(var_1_5, "ad/click"), function()
			if not var_1_7 then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ZUMA_PT_SHOP)

				return
			end

			if self.playerId == var_1_4.id then
				self:selectPlayer(nil)
			else
				self:selectPlayer(var_1_4.id)
			end

			return
		end, SFX_CONFIRM)
		onButton(self._event, findTF(var_1_5, "ad/skillPanel"), function()
			self:showSkillPanel(var_1_4)
			setActive(self.skillDetailPanel, true)

			return
		end, SFX_CONFIRM)
		table.insert(self.players, {
			tf = var_1_5,
			data = var_1_4,
			anim = var_1_8
		})
	end

	self.skillDetailPanel = findTF(self.menuUI, "skillDetail")

	setActive(self.skillDetailPanel, false)
	onButton(self._event, findTF(self.skillDetailPanel, "ad"), function()
		setActive(self.skillDetailPanel, false)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.skillDetailPanel, "ad/btnOk"), function()
		setActive(self.skillDetailPanel, false)

		return
	end, SFX_CANCEL)

	self.selectMask = findTF(self.menuUI, "selectMask")

	setText(findTF(self.menuUI, "select"), i18n(LaunchBallGameVo.launchball_minigame_select))
	setText(findTF(self.menuUI, "selectMask/unSelect"), i18n(LaunchBallGameVo.launchball_minigame_un_select))
	self:selectPlayer(nil)

	return
end

function LaunchBallGameMenuUI:selectPlayer(arg_12_1)
	for iter_12_0 = 1, #self.players do
		if self.players[iter_12_0].data.id == arg_12_1 then
			setActive(findTF(self.players[iter_12_0].tf, "ad/select"), true)
			self.players[iter_12_0].anim:Play("Attack")
		else
			setActive(findTF(self.players[iter_12_0].tf, "ad/select"), false)
			self.players[iter_12_0].anim:Play("Idle")
		end
	end

	self.playerId = arg_12_1

	LaunchBallGameVo.SetPlayer(self.playerId)

	if self.playerId == nil then
		setActive(self.btnStart, false)
		setActive(self.selectMask, false)
		setActive(findTF(self.menuUI, "select"), true)
	else
		setActive(self.btnStart, true)
		setActive(self.selectMask, true)
		setActive(findTF(self.menuUI, "select"), false)
	end

	return
end

function LaunchBallGameMenuUI:showSkillPanel(arg_13_1)
	local var_13_0 = i18n(arg_13_1.skill_1)
	local var_13_1 = i18n(arg_13_1.skill_2)
	local var_13_2 = i18n(arg_13_1.skill_2_desc)

	if var_13_0 then
		setText(findTF(self.skillDetailPanel, "ad/skill1Bg/skill1Name"), var_13_0)
		setText(findTF(self.skillDetailPanel, "ad/skill1Desc"), (i18n(arg_13_1.skill_1_desc)))
		setActive(findTF(self.skillDetailPanel, "ad/skill1Desc"), true)
		setActive(findTF(self.skillDetailPanel, "ad/skill1Bg"), true)
	else
		setActive(findTF(self.skillDetailPanel, "ad/skill1Desc"), false)
		setActive(findTF(self.skillDetailPanel, "ad/skill1Bg"), false)
	end

	if var_13_1 then
		setText(findTF(self.skillDetailPanel, "ad/skill2Bg/skill2Name"), var_13_1)
		setText(findTF(self.skillDetailPanel, "ad/skill2Desc"), var_13_2)
		setActive(findTF(self.skillDetailPanel, "ad/skill2Desc"), true)
		setActive(findTF(self.skillDetailPanel, "ad/skill2Bg"), true)
	else
		setActive(findTF(self.skillDetailPanel, "ad/skill2Desc"), false)
		setActive(findTF(self.skillDetailPanel, "ad/skill2Bg"), false)
	end

	return
end

function LaunchBallGameMenuUI:show(arg_14_1)
	setActive(self.menuUI, arg_14_1)

	return
end

function LaunchBallGameMenuUI:update(arg_15_1)
	self.mgHubData = arg_15_1

	local var_15_0 = self:getGameUsedTimes(arg_15_1)
	local var_15_1 = self:getGameTimes(arg_15_1)

	for iter_15_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_15_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_15_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_15_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_15_0], "state_current"), false)

		if iter_15_0 <= var_15_0 then
			SetParent(self.dropItems[iter_15_0], findTF(self.battleItems[iter_15_0], "state_clear/icon"))
			setActive(self.dropItems[iter_15_0], true)
			setActive(findTF(self.battleItems[iter_15_0], "state_clear"), true)
		elseif iter_15_0 == var_15_0 + 1 and var_15_1 >= 1 then
			setActive(findTF(self.battleItems[iter_15_0], "state_current"), true)
			SetParent(self.dropItems[iter_15_0], findTF(self.battleItems[iter_15_0], "state_current/icon"))
			setActive(self.dropItems[iter_15_0], true)
		elseif var_15_0 < iter_15_0 and iter_15_0 <= var_15_0 + var_15_1 then
			setActive(findTF(self.battleItems[iter_15_0], "state_open"), true)
			SetParent(self.dropItems[iter_15_0], findTF(self.battleItems[iter_15_0], "state_open/icon"))
			setActive(self.dropItems[iter_15_0], true)
		else
			setActive(findTF(self.battleItems[iter_15_0], "state_closed"), true)
			SetParent(self.dropItems[iter_15_0], findTF(self.battleItems[iter_15_0], "state_closed/icon"))
			setActive(self.dropItems[iter_15_0], true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_15_0 - 3 < 0 and 0 or var_15_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_15_1 > 0)

	return
end

function LaunchBallGameMenuUI:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	local var_16_0 = self:getUltimate(self.mgHubData)

	if var_16_0 and var_16_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if var_16_0 == 0 then
		if LaunchBallGameVo.total_times > self:getGameUsedTimes(self.mgHubData) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function LaunchBallGameMenuUI:getGameTimes(arg_17_1)
	return arg_17_1.count
end

function LaunchBallGameMenuUI:getGameUsedTimes(arg_18_1)
	return arg_18_1.usedtime
end

function LaunchBallGameMenuUI:getUltimate(arg_19_1)
	return arg_19_1.ultimate
end

return LaunchBallGameMenuUI
