local AuctionGameLoginPage = class("AuctionGameLoginPage", import("view.activity.CorePage.CoreActivityPage"))

function AuctionGameLoginPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.sign = self.bg:Find("sign")
	self.playerInfo = self.bg:Find("playerInfo")
	self.playerFrame = self.playerInfo:Find("frame")
	self.playerIcon = self.playerInfo:Find("frame/icon")
	self.playerName = self.playerInfo:Find("name")
	self.playerCount = self.playerInfo:Find("count")
	self.items = {}

	for iter_1_0 = 1, self.sign.childCount do
		table.insert(self.items, (self:getItem(iter_1_0)))
	end

	self.btnGet = self.bg:Find("btnGet")

	setText(self.btnGet:Find("text"), i18n("auction_signin_collect"))

	return
end

function AuctionGameLoginPage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_data")

	return
end

function AuctionGameLoginPage:OnFirstFlush()
	onButton(self, self.btnGet, function()
		local var_4_0 = {}
		local var_4_1 = getProxy(PlayerProxy):getRawData()
		local var_4_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_4_3, var_4_4 = self:checkCanGetList()

		if table.isEmpty(var_4_4) then
			return
		end

		local var_4_5, var_4_6 = Task.StaticJudgeOverflow(var_4_1.gold, var_4_1.oil, var_4_2, true, true, var_4_3)

		if var_4_5 then
			table.insert(var_4_0, function(arg_5_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_4_6,
					onYes = arg_5_0
				})

				return
			end)
		end

		seriesAsync(var_4_0, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT_ONESTEP, var_4_4)

			return
		end)

		return
	end)

	return
end

function AuctionGameLoginPage:checkCanGetList()
	local var_7_0 = {}
	local var_7_1 = {}

	local function var_7_2(arg_8_0)
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
	end

	for iter_7_0, iter_7_1 in ipairs(self.taskGroup[1]) do
		local var_7_3 = self.taskProxy:getTaskById(iter_7_1)

		if var_7_3 and var_7_3:getTaskStatus() == 1 then
			for iter_7_2, iter_7_3 in ipairs(pg.task_data_template[iter_7_1].award_display) do
				var_7_2(iter_7_3)
			end

			table.insert(var_7_1, {
				id = iter_7_1
			})
		end
	end

	return var_7_0, var_7_1
end

function AuctionGameLoginPage:OnUpdateFlush()
	if not self.activity or not self.taskGroup then
		return
	end

	self.nday = self.activity:getNDay()

	self:setPlayerInfo()

	local var_9_0 = false

	for iter_9_0, iter_9_1 in ipairs(self.items) do
		local var_9_1 = pg.task_data_template[self.taskGroup[1][iter_9_0]]
		local var_9_2 = Drop.Create(pg.task_data_template[self.taskGroup[1][iter_9_0]].award_display[1])

		updateDrop(iter_9_1.item, var_9_2)
		onButton(self, iter_9_1.frame, function()
			self:emit(BaseUI.ON_DROP, var_9_2)

			return
		end, SFX_PANEL)

		local var_9_3 = self.taskProxy:getTaskById(self.taskGroup[1][iter_9_0]) or self.taskProxy:getFinishTaskById(self.taskGroup[1][iter_9_0])
		local var_9_4 = not not var_9_3
		local var_9_5 = var_9_3 and var_9_3:getTaskStatus() == 1
		local var_9_6 = var_9_3 and var_9_3:getTaskStatus() == 2

		var_9_0 = var_9_0 or var_9_5

		setActive(iter_9_1.lock, not var_9_4)
		setActive(iter_9_1.get, var_9_5 and not var_9_6)
		setActive(iter_9_1.got, var_9_6)
		onButton(self, iter_9_1.get, function()
			local var_11_0 = {}
			local var_11_1 = var_9_1.award_display
			local var_11_2 = getProxy(PlayerProxy):getRawData()
			local var_11_3, var_11_4 = Task.StaticJudgeOverflow(var_11_2.gold, var_11_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_11_1)

			if var_11_3 then
				table.insert(var_11_0, function(arg_12_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_11_4,
						onYes = arg_12_0
					})

					return
				end)
			end

			seriesAsync(var_11_0, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_9_3)

				return
			end)

			return
		end, SFX_PANEL)
	end

	setGray(self.btnGet, not var_9_0)

	return
end

function AuctionGameLoginPage:getItem(arg_14_1)
	if self.items[arg_14_1] then
		return self.items[arg_14_1]
	end

	local var_14_0 = {}
	local var_14_1 = self.sign:GetChild(arg_14_1 - 1)

	var_14_0.item = var_14_1:Find("item")
	var_14_0.frame = var_14_1:Find("frame")
	var_14_0.got = var_14_1:Find("got")
	var_14_0.get = var_14_1:Find("get")
	var_14_0.lock = var_14_1:Find("lock")

	return var_14_0
end

function AuctionGameLoginPage:setPlayerInfo()
	local var_15_0 = getProxy(PlayerProxy):getRawData()

	GetImageSpriteFromAtlasAsync("SquareIcon/" .. getProxy(BayProxy):GetShipPhantom(var_15_0:GetShipPhantomMarks()[1]):getPainting(), "", self.playerIcon)
	setText(self.playerName, var_15_0.name)
	setText(self.playerCount, StringHelper.ForamtNumberK(AuctionGameTools.GetCurrencyCnt()))

	return
end

function AuctionGameLoginPage:OnDestroy()
	if self.iconView then
		self.iconView:Dispose()

		self.iconView = nil
	end

	return
end

return AuctionGameLoginPage
