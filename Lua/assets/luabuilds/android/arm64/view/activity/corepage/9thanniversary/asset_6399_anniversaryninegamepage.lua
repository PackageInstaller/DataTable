local AnniversaryNineGamePage = class("AnniversaryNineGamePage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 84

function AnniversaryNineGamePage:OnInit()
	self.mgHubData = getProxy(MiniGameProxy):GetHubByGameId(var_0_1)
	self.drops = pg.mini_game[var_0_1].simple_config_data.drop_ids
	self.totalTimes = #self.drops
	self.useTimes = self.mgHubData.usedtime
	self.gameTimes = self.mgHubData.count

	return
end

function AnniversaryNineGamePage:OnFirstFlush()
	self.highScoreText = findTF(self._tf, "ad/high/text")
	self.btnRule = findTF(self._tf, "ad/rule")
	self.btnRank = findTF(self._tf, "ad/rank")

	onButton(self, self.btnRank, function()
		self:getRankData(var_0_1, function(arg_4_0)
			self:UpdateRankData(arg_4_0)

			return
		end)
		self:PopRankUI(true)

		return
	end, SFX_CANCEL)
	self:initRankUI()
	setText(findTF(self.btnRule, "text"), i18n("pac_game_rule_btn"))
	onButton(self, self.btnRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.sort_minigame_help.tip
		})

		return
	end, SFX_CANCEL)

	self.btnStart = findTF(self._tf, "ad/start")

	onButton(self, self.btnStart, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_CANCEL)

	self.battleItems = {}
	self._tplBattleItem = findTF(self._tf, "ad/awards/Viewport/Content/item_tpl")

	setActive(self._tplBattleItem, false)

	for iter_2_0 = 1, 7 do
		local var_2_1 = tf(instantiate(self._tplBattleItem))

		var_2_1.name = "award_" .. iter_2_0

		setParent(var_2_1, findTF(self._tf, "ad/awards/Viewport/Content"))
		setText(findTF(var_2_1, "ad/desc"), "DAY" .. iter_2_0)

		local var_2_2 = findTF(var_2_1, "ad/iconMask/icon")
		local var_2_3 = {
			type = self.drops[iter_2_0][1],
			id = self.drops[iter_2_0][2],
			count = self.drops[iter_2_0][3]
		}

		updateDrop(var_2_2, var_2_3)
		onButton(self, var_2_2, function()
			self:emit(BaseUI.ON_DROP, var_2_3)

			return
		end, SFX_PANEL)
		setActive(var_2_1, true)
		table.insert(self.battleItems, var_2_1)
	end

	return
end

function AnniversaryNineGamePage:OnUpdateFlush()
	for iter_8_0 = 1, 7 do
		local var_8_0 = findTF(self.battleItems[iter_8_0], "ad/lock")
		local var_8_1 = findTF(self.battleItems[iter_8_0], "ad/got")

		setActive(var_8_0, false)
		setActive(var_8_1, false)

		if iter_8_0 <= self.useTimes then
			setActive(var_8_1, true)
		elseif iter_8_0 == self.useTimes + 1 and self.gameTimes >= 1 then
			-- block empty
		elseif iter_8_0 > self.useTimes and iter_8_0 <= self.useTimes + self.gameTimes then
			-- block empty
		else
			setActive(var_8_0, true)
		end
	end

	local var_8_2 = getProxy(MiniGameProxy):GetHighScore(var_0_1)

	setText(self.highScoreText, tostring((var_8_2 and #var_8_2 > 0 or nil) and (var_8_2[1] or 0)))

	local var_8_3 = self.coreActivityUI:GetActivityIdByPageClass("AnniversaryNineInvitationPage")
	local var_8_4 = var_8_3 and getProxy(ActivityProxy):getActivityById(var_8_3)

	if var_8_4 and not var_8_4:isEnd() then
		updateActivityTaskStatus(var_8_4)
	end

	return
end

function AnniversaryNineGamePage:initRankUI()
	self.rankUI = findTF(self._tf, "pop/RankUI")

	self:PopRankUI(false)

	self._rankImg = findTF(self.rankUI, "ad/img")
	self._rankBtnClose = findTF(self.rankUI, "ad/btnClose")
	self._rankContent = findTF(self.rankUI, "ad/list/content")
	self._rankItemTpl = findTF(self.rankUI, "ad/list/content/itemTpl")
	self._rankEmpty = findTF(self.rankUI, "ad/empty")
	self._rankDesc = findTF(self.rankUI, "ad/desc")
	self._rankItems = {}

	setActive(self._rankItemTpl, false)
	onButton(self._event, findTF(self.rankUI, "ad/close"), function()
		self:PopRankUI(false)

		return
	end, SFX_CANCEL)
	onButton(self._event, self._rankBtnClose, function()
		self:PopRankUI(false)

		return
	end, SFX_CANCEL)
	setText(self._rankDesc, i18n("pipe_minigame_rank"))
	setText(findTF(self.rankUI, "ad/bg/bg_high/text"), i18n("series_enemy_reward_tip4"))

	return
end

function AnniversaryNineGamePage:UpdateRankData(arg_12_1)
	for iter_12_0 = 1, #arg_12_1 do
		if iter_12_0 > #self._rankItems then
			local var_12_1 = tf(instantiate(self._rankItemTpl))

			setActive(var_12_1, false)
			setParent(var_12_1, self._rankContent)
			table.insert(self._rankItems, var_12_1)
		end

		local var_12_2 = self._rankItems[iter_12_0]

		self:SetRankItemData(self._rankItems[iter_12_0], arg_12_1[iter_12_0], iter_12_0)
		setActive(var_12_2, true)
	end

	for iter_12_1 = #arg_12_1 + 1, #self._rankItems do
		setActive(self._rankItems, false)
	end

	setActive(self._rankEmpty, #arg_12_1 == 0)
	setActive(self._rankImg, #arg_12_1 > 0)

	return
end

function AnniversaryNineGamePage:SetRankItemData(arg_13_1, arg_13_2, arg_13_3)
	local var_13_1 = arg_13_2.score
	local var_13_3 = getProxy(PlayerProxy):isSelf(arg_13_2.player_id)

	setText(findTF(arg_13_1, "nameText"), arg_13_2.name)
	self:setChildVisible(findTF(arg_13_1, "bg"), false)
	self:setChildVisible(findTF(arg_13_1, "rank"), false)

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

function AnniversaryNineGamePage:PopRankUI(arg_14_1)
	setActive(self.rankUI, arg_14_1)

	return
end

function AnniversaryNineGamePage:getRankData(arg_15_1, arg_15_2)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = arg_15_1,
		callback = function(self)
			local var_16_0 = {}

			for iter_16_0 = 1, #self do
				local var_16_1 = {}

				for iter_16_1, iter_16_2 in pairs(self[iter_16_0]) do
					var_16_1[iter_16_1] = iter_16_2
				end

				table.insert(var_16_0, var_16_1)
			end

			table.sort(var_16_0, function(arg_17_0, arg_17_1)
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
				arg_15_2(var_16_0)
			end

			return
		end
	})

	return
end

function AnniversaryNineGamePage:setChildVisible(arg_18_1, arg_18_2)
	for iter_18_0 = 1, arg_18_1.childCount do
		setActive(arg_18_1:GetChild(iter_18_0 - 1), arg_18_2)
	end

	return
end

function AnniversaryNineGamePage:willExit()
	return
end

return AnniversaryNineGamePage
