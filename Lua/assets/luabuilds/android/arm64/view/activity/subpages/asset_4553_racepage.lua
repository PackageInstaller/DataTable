local RacePage = class("RacePage", import("...base.BaseActivityPage"))
local var_0_1 = 58

function RacePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.help = self.bg:Find("help")
	self.goBtn = self.bg:Find("go_btn")
	self.ticketStat = self.bg:Find("ticket_static")
	self.ticketNum = self.bg:Find("ticket_num")
	self.costTf = self.bg:Find("cost")
	self.progressBar = self.bg:Find("progress_bar")
	self.progressTpl = self.bg:Find("progress_tpl")
	self.progressContainer = self.bg:Find("progress")
	self.progressList = UIItemList.New(self.progressContainer, self.progressTpl)
	self.rankBtn = self.bg:Find("rank_btn")
	self.rankPanel = self.bg:Find("rank_panel")
	self.rankBlank = self.bg:Find("rank_panel/static/blank_img")
	self.rankSelf = self.bg:Find("rank_panel/self")
	self.rankContainer = self.bg:Find("rank_panel/list_panel/view_content/list")
	self.rankTpl = self.bg:Find("rank_panel/list_panel/view_content/tpl")
	self.rankMask = self.bg:Find("rank_panel/mask")

	self:hideRankPanel()

	return
end

function RacePage:OnDataSetting()
	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId((self.activity:getConfig("config_id")))

	var_0_1 = self.activity:getConfig("config_client").gameid and var_0_1
	self.is_ranking = pg.mini_game[var_0_1].is_ranking == 1
	self.needCount = var_2_0:getConfig("reward_need")
	self.leftCount = var_2_0.count
	self.playedCount = var_2_0.usedtime
	self.curDay = self.leftCount + self.playedCount

	return
end

function RacePage:OnFirstFlush()
	local var_3_0 = getProxy(MiniGameProxy)

	if var_3_0:CanFetchRank(var_0_1) then
		pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
			id = var_0_1,
			callback = function(...)
				self:updateRankTf(...)

				return
			end
		})
	else
		self:updateRankTf((var_3_0:GetRank(var_0_1)))
	end

	setActive(self.rankBtn, self.is_ranking)
	onButton(self, self.rankBtn, function()
		local var_5_0 = isActive(self.rankPanel)

		setActive(self.rankPanel, not var_5_0)

		if not var_5_0 then
			local var_5_1 = {
				hubid = getProxy(MiniGameProxy):GetHubByHubId((self.activity:getConfig("config_id"))).id,
				cmd = MiniGameOPCommand.CMD_SPECIAL_TRACK
			}
			local var_5_2 = {
				var_0_1
			}

			var_5_2[2] = 103
			var_5_1.args1 = var_5_2

			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, var_5_1)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.rankMask, function()
		self:hideRankPanel()

		return
	end, SFX_PANEL)
	self.progressList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventInit then
			local var_7_0 = {
				type = pg.mini_game[var_0_1].simple_config_data.drop[arg_7_1 + 1][1],
				id = pg.mini_game[var_0_1].simple_config_data.drop[arg_7_1 + 1][2],
				count = pg.mini_game[var_0_1].simple_config_data.drop[arg_7_1 + 1][3]
			}

			updateDrop(arg_7_2:Find("item_mask/item"), var_7_0)
			onButton(self, arg_7_2, function()
				self:emit(BaseUI.ON_DROP, var_7_0)

				return
			end, SFX_PANEL)
			setText(arg_7_2:Find("text"), arg_7_1 + 1)
		elseif arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("item_mask/got"), arg_7_1 < self.playedCount)
			setActive(arg_7_2:Find("got_sequence"), arg_7_1 < self.playedCount)
		end

		return
	end)
	self.progressList:align(self.needCount)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_PANEL)
	onButton(self, self.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.racing_minigame_help.tip
		})

		return
	end, SFX_PANEL)
	setText(self.costTf:Find("cost_static"), i18n("racing_cost"))
	setText(self.rankPanel:Find("static/top_text"), i18n("racing_rank_top_text"))
	setText(self.rankPanel:Find("static/half_h_static"), i18n("racing_rank_half_h"))
	setText(self.rankBlank:Find("text"), i18n("racing_rank_no_data"))

	return
end

function RacePage:OnUpdateFlush()
	setActive(self.ticketStat, self.leftCount ~= 0)
	setText(self.ticketNum, self.leftCount)
	setText(self.costTf, self.playedCount)
	setSlider(self.progressBar, 0, 1, self.playedCount / self.needCount)

	return
end

function RacePage:updateRankTf(arg_12_1)
	local var_12_0 = getProxy(FriendProxy)
	local var_12_1 = getProxy(PlayerProxy):getData()

	arg_12_1 = underscore.filter(arg_12_1, function(arg_13_0)
		return var_12_0:isFriend(arg_13_0.player_id) or arg_13_0.player_id == var_12_1.id
	end)

	setActive(self.rankPanel:Find("list_panel/scroll_bar/handle"), #arg_12_1 > 5)

	if #arg_12_1 == 0 then
		setActive(self.rankBlank, true)
		self:updateRankSelfTf(#arg_12_1)

		return
	end

	setActive(self.rankBlank, false)
	UIItemList.StaticAlign(self.rankContainer, self.rankTpl, #arg_12_1, function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 ~= UIItemList.EventUpdate then
			return
		end

		setText(arg_14_2:Find("name"), arg_12_1[arg_14_1 + 1].name)
		setText(arg_14_2:Find("score"), self:getScoreString(arg_12_1[arg_14_1 + 1].score))
		self:updateRankPosTf(arg_14_2:Find("position"), arg_12_1[arg_14_1 + 1].position)
		self:updateRankFaceTf(arg_14_2:Find("face"), arg_12_1[arg_14_1 + 1].display, arg_12_1[arg_14_1 + 1].position)

		return
	end)
	self:updateRankSelfTf(#arg_12_1, (underscore.detect(arg_12_1, function(arg_15_0)
		return arg_15_0.player_id == var_12_1.id
	end)))

	return
end

function RacePage:updateRankPosTf(arg_16_1, arg_16_2)
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

function RacePage:updateRankFaceTf(arg_17_1, arg_17_2, arg_17_3)
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

function RacePage:updateRankSelfTf(arg_19_1, arg_19_2)
	local var_19_0 = getProxy(PlayerProxy):getData()
	local var_19_1 = getProxy(BayProxy):getShipById(var_19_0.character)
	local var_19_2 = {}

	if arg_19_2 then
		var_19_2.position = arg_19_2.position or 0
	end

	var_19_2.id = var_19_0.id
	var_19_2.name = var_19_0.name
	var_19_2.score = getProxy(MiniGameProxy):GetHighScore(var_0_1)
	var_19_2.display = {
		icon = var_19_1:getConfig("id"),
		skinId = var_19_1:getSkinId(),
		proposeTime = var_19_1.proposeTime
	}

	setText(self.rankSelf:Find("name"), var_19_2.name)
	setText(self.rankSelf:Find("score"), self:getScoreString(var_19_2.score))
	self:updateRankPosTf(self.rankSelf:Find("position"), var_19_2.position)
	self:updateRankFaceTf(self.rankSelf:Find("face"), var_19_2.display, nil)
	setActive(self.rankSelf, true)

	return
end

function RacePage:showRankPanel()
	setActive(self.rankPanel, true)

	return
end

function RacePage:hideRankPanel()
	setActive(self.rankPanel, false)

	return
end

function RacePage:getScoreString(arg_22_1)
	arg_22_1 = arg_22_1 or 0

	return string.format("%.2fM", arg_22_1 / 100)
end

return RacePage
