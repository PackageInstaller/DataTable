local HoloLiveLinkGameView = class("HoloLiveLinkGameView", import("..BaseMiniGameView"))

HoloLiveLinkGameView.MAX_ROW = 6
HoloLiveLinkGameView.MAX_COLUMN = 11
HoloLiveLinkGameView.COUNT_DOWN = 3
HoloLiveLinkGameView.RESET_CD = 5
HoloLiveLinkGameView.GAME_STATE_BEGIN = 0
HoloLiveLinkGameView.GAME_STATE_GAMING = 1
HoloLiveLinkGameView.GAME_STATE_END = 2
HoloLiveLinkGameView.CARD_STATE_NORMAL = 0
HoloLiveLinkGameView.CARD_STATE_LINKED = 1
HoloLiveLinkGameView.CARD_STATE_BLANK = 2
HoloLiveLinkGameView.NAME_TO_INDEX = {
	mio = 4,
	shion = 5,
	aqua = 2,
	fubuki = 0,
	Purifier = 8,
	Kawakaze = 7,
	matsuri = 1,
	sora = 6,
	ayame = 3
}

function HoloLiveLinkGameView:getUIName()
	return "HoloLiveLinkGameUI"
end

function HoloLiveLinkGameView:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function HoloLiveLinkGameView:didEnter()
	self.miniGameData = self:GetMGData()
	self.linkGameID = self.miniGameData:GetRuntimeData("curLinkGameID")
	self.bestScoreTable = self.miniGameData:GetRuntimeData("elements")

	if #self.bestScoreTable == 0 then
		self.bestScoreTable = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}

		self.miniGameData:SetRuntimeData("elements", self.bestScoreTable)
	end

	setText(self.bestTxt, self:FormatRecordTime(self.bestScoreTable[self.linkGameID]))
	self:SetState(HoloLiveLinkGameView.GAME_STATE_BEGIN)

	return
end

function HoloLiveLinkGameView:OnSendMiniGameOPDone()
	return
end

function HoloLiveLinkGameView:onBackPressed()
	triggerButton(self.backBtn)

	return
end

function HoloLiveLinkGameView:willExit()
	LeanTween.cancel(go(self.countDown))

	for iter_6_0 = 0, self.layout.childCount - 1 do
		LeanTween.cancel(go(self.layout:GetChild(iter_6_0)))
	end

	if self.countTimer then
		self.countTimer:Stop()

		self.countTimer = nil
	end

	return
end

function HoloLiveLinkGameView:initData()
	return
end

function HoloLiveLinkGameView:findUI()
	self.backBtn = self._tf:Find("ForNotchPanel/BackBtn")
	self.helpBtn = self._tf:Find("ForNotchPanel/HelpBtn")
	self.resetBtn = self._tf:Find("ResetBtn")
	self.timeTxt = self._tf:Find("ForNotchPanel/CurTime/Text")
	self.bestTxt = self._tf:Find("ForNotchPanel/BestTime/Text")
	self.layout = self._tf:Find("card_con/layout")
	self.item = self.layout:Find("card")
	self.bottom = self._tf:Find("card_con/bottom")
	self.line = self.bottom:Find("card")
	self.countDown = self._tf:Find("count_down")
	self.resource = self._tf:Find("resource")
	self.resultPanel = self._tf:Find("ResultPanel")
	self.resultPanelBG = self.resultPanel:Find("BG")

	local var_8_0 = self.resultPanel:Find("Result")

	self.resultNewImg = var_8_0:Find("NewImg")
	self.resultTimeText = var_8_0:Find("TimeText")
	self.resultRestartBtn = var_8_0:Find("RestartBtn")

	return
end

function HoloLiveLinkGameView:addListener()
	onButton(self, self.backBtn, function()
		self:emit(HoloLiveLinkGameView.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_lianliankan.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.resultPanelBG, function()
		self:showResultPanel(false)
		self:emit(HoloLiveLinkGameView.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.resultRestartBtn, function()
		self:showResultPanel(false)
		self:SetState(HoloLiveLinkGameView.GAME_STATE_BEGIN)

		return
	end, SFX_PANEL)

	return
end

function HoloLiveLinkGameView:showResultPanel(arg_14_1)
	if not arg_14_1 then
		SetActive(self.resultPanel, false)

		return
	end

	setText(self.resultTimeText, self:FormatRecordTime(self.lastRecord))
	SetActive(self.resultPanel, true)

	return
end

function HoloLiveLinkGameView:playStory()
	local var_15_0 = self.miniGameData:GetConfigCsvLine(self.linkGameID).story

	if var_15_0 == "" then
		self:showResultPanel(true)
	else
		local var_15_1 = var_15_0[1]
		local var_15_2 = pg.NewStoryMgr.GetInstance()

		if not var_15_2:IsPlayed(var_15_0[1]) then
			var_15_2:Play(var_15_1, function()
				self:showResultPanel(true)

				return
			end)
		end
	end

	return
end

function HoloLiveLinkGameView:SetState(arg_17_1)
	if self.state ~= arg_17_1 then
		self.state = arg_17_1

		if arg_17_1 == HoloLiveLinkGameView.GAME_STATE_BEGIN then
			self:GameBegin()
		elseif arg_17_1 == HoloLiveLinkGameView.GAME_STATE_GAMING then
			self:GameLoop()
		elseif arg_17_1 == HoloLiveLinkGameView.GAME_STATE_END then
			self:GameEnd()
		end
	end

	return
end

function HoloLiveLinkGameView:GameBegin()
	self.cards = {}

	local var_18_0 = self:setIconList()

	while #var_18_0 > 0 do
		local var_18_1 = math.clamp(math.floor(math.random() * #var_18_0 + 1), 1, #var_18_0)
		local var_18_2 = math.floor(0 / (HoloLiveLinkGameView.MAX_COLUMN - 2)) + 1

		self.cards[var_18_2] = self.cards[var_18_2] or {}
		self.cards[var_18_2][0 % (HoloLiveLinkGameView.MAX_COLUMN - 2) + 1] = {
			row = var_18_2,
			column = 0 % (HoloLiveLinkGameView.MAX_COLUMN - 2) + 1,
			id = var_18_0[var_18_1],
			state = HoloLiveLinkGameView.CARD_STATE_NORMAL
		}

		table.remove(var_18_0, var_18_1)
	end

	for iter_18_0 = 0, HoloLiveLinkGameView.MAX_ROW - 1 do
		for iter_18_1 = 0, HoloLiveLinkGameView.MAX_COLUMN - 1 do
			self.cards[iter_18_0] = self.cards[iter_18_0] or {}
			self.cards[iter_18_0][iter_18_1] = self.cards[iter_18_0][iter_18_1] or {
				row = iter_18_0,
				column = iter_18_1,
				state = HoloLiveLinkGameView.CARD_STATE_BLANK
			}
		end
	end

	self.list = UIItemList.New(self.layout, self.item)

	self.list:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = math.floor(arg_19_1 / HoloLiveLinkGameView.MAX_COLUMN)
			local var_19_1 = self.cards[var_19_0][arg_19_1 % HoloLiveLinkGameView.MAX_COLUMN]

			arg_19_2.name = var_19_0 .. "_" .. arg_19_1 % HoloLiveLinkGameView.MAX_COLUMN
			arg_19_2.localScale = Vector3.one

			setActive(arg_19_2:Find("display"), var_19_1.state == HoloLiveLinkGameView.CARD_STATE_NORMAL)

			if var_19_1.state == HoloLiveLinkGameView.CARD_STATE_NORMAL then
				setImageSprite(arg_19_2:Find("display/icon"), (getImageSprite(self.resource:GetChild(var_19_1.id))))
				setActive(arg_19_2:Find("display/selected"), false)

				local var_19_2 = GetComponent(arg_19_2, typeof(Animator))

				var_19_2.enabled = true

				var_19_2:SetBool("AniSwitch", false)
			end
		end

		return
	end)
	self.list:align(HoloLiveLinkGameView.MAX_ROW * HoloLiveLinkGameView.MAX_COLUMN)

	self.llist = UIItemList.New(self.bottom, self.line)

	self.llist:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = arg_20_2:Find("lines")

			for iter_20_0 = 0, var_20_0.childCount - 1 do
				setActive(var_20_0:GetChild(iter_20_0), false)
			end
		end

		return
	end)
	self.llist:align(HoloLiveLinkGameView.MAX_ROW * HoloLiveLinkGameView.MAX_COLUMN)
	setText(self.timeTxt, self:FormatRecordTime(0))
	setActive(self.countDown, true)

	for iter_18_2 = 0, self.countDown.childCount - 1 do
		setActive(self.countDown:GetChild(iter_18_2), false)
	end

	local var_18_4 = 0
	local var_18_5 = self.countDown:GetChild(0)

	setActive(var_18_5, true)
	setImageAlpha(var_18_5, 0)
	LeanTween.value(go(self.countDown), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_21_0)
		arg_21_0 = math.min(arg_21_0 / 0.3, 1)

		setImageAlpha(var_18_5, arg_21_0)
		setLocalScale(var_18_5, {
			x = (1 - arg_21_0) * 2 + 1,
			y = (1 - arg_21_0) * 2 + 1
		})

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_18_5, false)

		var_18_4 = var_18_4 + 1

		if var_18_4 < self.countDown.childCount then
			var_18_5 = self.countDown:GetChild(var_18_4)

			setActive(var_18_5, true)
			setImageAlpha(var_18_5, 0)
		else
			setActive(self.countDown, false)
			self:SetState(HoloLiveLinkGameView.GAME_STATE_GAMING)
		end

		return
	end)):setRepeat(4):setLoopType(LeanTweenType.punch):setOnCompleteOnRepeat(true):setEase(LeanTweenType.easeOutSine)

	return
end

function HoloLiveLinkGameView:GameLoop()
	local function var_23_0(arg_24_0)
		for iter_24_0 = 1, #arg_24_0 - 1 do
			local var_24_2 = self.bottom:GetChild(arg_24_0[iter_24_0].row * HoloLiveLinkGameView.MAX_COLUMN + arg_24_0[iter_24_0].column):Find("lines")

			for iter_24_1 = 0, var_24_2.childCount - 1 do
				setActive(var_24_2:GetChild(iter_24_1), false)
			end

			if arg_24_0[iter_24_0 + 1].row - arg_24_0[iter_24_0].row ~= 0 then
				setActive(var_24_2:Find("y" .. arg_24_0[iter_24_0 + 1].row - arg_24_0[iter_24_0].row), true)
			elseif arg_24_0[iter_24_0 + 1].column - arg_24_0[iter_24_0].column ~= 0 then
				setActive(var_24_2:Find("x" .. arg_24_0[iter_24_0 + 1].column - arg_24_0[iter_24_0].column), true)
			end
		end

		return
	end

	local function var_23_1(arg_25_0)
		for iter_25_0 = 1, #arg_25_0 - 1 do
			local var_25_0 = self.bottom:GetChild(arg_25_0[iter_25_0].row * HoloLiveLinkGameView.MAX_COLUMN + arg_25_0[iter_25_0].column):Find("lines")

			for iter_25_1 = 0, var_25_0.childCount - 1 do
				setActive(var_25_0:GetChild(iter_25_1), false)
			end
		end

		return
	end

	local var_23_2
	local var_23_3
	local var_23_4

	self.list:each(function(arg_26_0, arg_26_1)
		onButton(self, arg_26_1:Find("display/icon"), function()
			local var_27_0 = self.cards[math.floor(arg_26_0 / HoloLiveLinkGameView.MAX_COLUMN)][arg_26_0 % HoloLiveLinkGameView.MAX_COLUMN]

			if var_27_0.state ~= HoloLiveLinkGameView.CARD_STATE_NORMAL then
				return
			elseif not var_23_2 then
				var_23_2 = var_27_0
				var_23_3 = arg_26_1

				setActive(arg_26_1:Find("display/selected"), true)
			elseif var_23_4 then
				return
			elseif var_23_2 == var_27_0 then
				setActive(arg_26_1:Find("display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			elseif var_23_2.id ~= var_27_0.id then
				setActive(var_23_3:Find("display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			else
				local var_27_1 = self:LinkLink(var_23_2, var_27_0)

				if not var_27_1 then
					setActive(var_23_3:Find("display/selected"), false)

					var_23_3 = nil
					var_23_2 = nil
				else
					var_27_0.state = HoloLiveLinkGameView.CARD_STATE_LINKED
					var_23_2.state = HoloLiveLinkGameView.CARD_STATE_LINKED

					setActive(arg_26_1:Find("display/selected"), true)
					var_23_0(var_27_1)

					var_23_4 = true

					local var_27_2 = GetComponent(arg_26_1, "DftAniEvent")

					GetComponent(arg_26_1, typeof(Animator)):SetBool("AniSwitch", true)
					GetComponent(var_23_3, typeof(Animator)):SetBool("AniSwitch", true)
					GetComponent(var_23_3, "DftAniEvent"):SetEndEvent(function(arg_28_0)
						var_23_1(var_27_1)

						var_23_4 = false
						var_23_3 = nil
						var_23_2 = nil

						local var_28_0 = true

						for iter_28_0 = 0, HoloLiveLinkGameView.MAX_ROW - 1 do
							for iter_28_1 = 0, HoloLiveLinkGameView.MAX_COLUMN - 1 do
								if self.cards[iter_28_0][iter_28_1].state == HoloLiveLinkGameView.CARD_STATE_NORMAL then
									var_28_0 = false

									break
								end
							end
						end

						if var_28_0 then
							self:SetState(HoloLiveLinkGameView.GAME_STATE_END)
						end

						return
					end)
				end
			end

			return
		end, SFX_PANEL)

		return
	end)

	if IsUnityEditor and AUTO_LINKLINK then
		setActive(self.helpBtn, true)
		onButton(self, self.helpBtn, function()
			var_23_2 = nil
			var_23_3 = nil

			for iter_29_0 = 0, HoloLiveLinkGameView.MAX_ROW - 1 do
				for iter_29_1 = 0, HoloLiveLinkGameView.MAX_COLUMN - 1 do
					local var_29_0 = self.layout:GetChild(self.cards[iter_29_0][iter_29_1].row * HoloLiveLinkGameView.MAX_COLUMN + self.cards[iter_29_0][iter_29_1].column)

					if self.cards[iter_29_0][iter_29_1].state == HoloLiveLinkGameView.CARD_STATE_NORMAL then
						for iter_29_2 = 0, HoloLiveLinkGameView.MAX_ROW - 1 do
							for iter_29_3 = 0, HoloLiveLinkGameView.MAX_COLUMN - 1 do
								if iter_29_0 == iter_29_2 then
									if iter_29_1 ~= iter_29_3 then
										if self.cards[iter_29_0][iter_29_1].id == self.cards[iter_29_2][iter_29_3].id then
											triggerButton(var_29_0:Find("display/icon"))
											triggerButton(self.layout:GetChild(self.cards[iter_29_2][iter_29_3].row * HoloLiveLinkGameView.MAX_COLUMN + self.cards[iter_29_2][iter_29_3].column):Find("display/icon"))

											if var_23_4 then
												Timer.New(function()
													triggerButton(self.helpBtn)

													return
												end, 0.4, 1):Start()

												return
											end
										end
									end
								end
							end
						end
					end
				end
			end

			return
		end)
	end

	local var_23_5 = 0

	onButton(self, self.resetBtn, function()
		if self.state ~= HoloLiveLinkGameView.GAME_STATE_GAMING then
			return
		elseif Time.realtimeSinceStartup - var_23_5 < HoloLiveLinkGameView.RESET_CD then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_wait"))
		else
			if var_23_2 then
				setActive(var_23_3:Find("display/selected"), false)

				var_23_3 = nil
				var_23_2 = nil
			end

			local var_31_0 = {}
			local var_31_1 = {}

			for iter_31_0 = 0, HoloLiveLinkGameView.MAX_ROW - 1 do
				for iter_31_1 = 0, HoloLiveLinkGameView.MAX_COLUMN - 1 do
					if self.cards[iter_31_0][iter_31_1].state == HoloLiveLinkGameView.CARD_STATE_NORMAL then
						table.insert(var_31_0, {
							row = iter_31_0,
							column = iter_31_1
						})
						table.insert(var_31_1, self.cards[iter_31_0][iter_31_1].id)
					end
				end
			end

			while #var_31_1 > 0 do
				local var_31_2 = math.clamp(math.floor(math.random() * #var_31_1 + 1), 1, #var_31_1)

				self.cards[var_31_0[1].row][var_31_0[1].column].id = var_31_1[var_31_2]

				table.remove(var_31_1, var_31_2)
			end

			self.list:each(function(arg_32_0, arg_32_1)
				local var_32_0 = self.cards[math.floor(arg_32_0 / HoloLiveLinkGameView.MAX_COLUMN)][arg_32_0 % HoloLiveLinkGameView.MAX_COLUMN]

				if var_32_0.state == HoloLiveLinkGameView.CARD_STATE_NORMAL then
					setImageSprite(arg_32_1:Find("display/icon"), (getImageSprite(self.resource:GetChild(var_32_0.id))))
				end

				return
			end)

			var_23_5 = Time.realtimeSinceStartup
		end

		return
	end, SFX_PANEL)

	self.startTime = Time.realtimeSinceStartup
	self.countTimer = Timer.New(function()
		self.lastRecord = math.floor((Time.realtimeSinceStartup - self.startTime) * 1000)

		setText(self.timeTxt, self:FormatRecordTime((math.floor(self.lastRecord))))

		return
	end, 0.033, -1)

	self.countTimer:Start()
	self.countTimer.func()

	return
end

function HoloLiveLinkGameView:GameEnd()
	self.countTimer:Stop()

	self.countTimer = nil

	if self.bestScoreTable[self.linkGameID] == 0 then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self.miniGameData:getConfig("hub_id"),
			cmd = MiniGameOPCommand.CMD_COMPLETE,
			args1 = {
				self.linkGameID == #pg.activity_event_linkgame.all and 0 or 1,
				self.linkGameID
			}
		})

		self.bestScoreTable[self.linkGameID] = self.lastRecord

		setText(self.bestTxt, self:FormatRecordTime(self.bestScoreTable[self.linkGameID]))
		SetActive(self.resultNewImg, true)
		self:StoreDataToServer(self.bestScoreTable)
	elseif self.lastRecord < self.bestScoreTable[self.linkGameID] then
		self.bestScoreTable[self.linkGameID] = self.lastRecord

		setText(self.bestTxt, self:FormatRecordTime(self.bestScoreTable[self.linkGameID]))
		SetActive(self.resultNewImg, true)
		self:StoreDataToServer(self.bestScoreTable)
		self:showResultPanel(true)
	else
		SetActive(self.resultNewImg, false)
		self:showResultPanel(true)
	end

	return
end

function HoloLiveLinkGameView:LinkLink(arg_35_1, arg_35_2)
	assert(arg_35_1.row ~= arg_35_2.row or arg_35_1.column ~= arg_35_2.column)
	assert(arg_35_1.id == arg_35_2.id)

	local var_35_0 = {
		row = arg_35_1.row,
		column = arg_35_1.column
	}
	local var_35_1 = {
		row = arg_35_2.row,
		column = arg_35_2.column
	}
	local var_35_2 = {}
	local var_35_3 = {}

	table.insert(var_35_2, var_35_0)
	table.insert(var_35_3, var_35_0)

	for iter_35_0 = 1, 3 do
		local var_35_4 = self:IterateByOneSnap(var_35_1, arg_35_1.id, var_35_2, var_35_3)

		if var_35_4 then
			local var_35_5 = {
				var_35_4
			}

			while var_35_4 and var_35_4.from do
				if var_35_4.row ~= var_35_4.from.row then
					for iter_35_1 = var_35_4.row + (var_35_4.row > var_35_4.from.row and -1 or 1), var_35_4.from.row, var_35_4.row > var_35_4.from.row and -1 or 1 do
						table.insert(var_35_5, {
							row = iter_35_1,
							column = var_35_4.column
						})
					end
				elseif var_35_4.from.column ~= var_35_4.column then
					for iter_35_2 = var_35_4.column + (var_35_4.column > var_35_4.from.column and -1 or 1), var_35_4.from.column, var_35_4.column > var_35_4.from.column and -1 or 1 do
						table.insert(var_35_5, {
							row = var_35_4.row,
							column = iter_35_2
						})
					end
				else
					assert(false)
				end

				var_35_4 = var_35_4.from
			end

			return var_35_5
		end
	end

	return
end

function HoloLiveLinkGameView:IterateByOneSnap(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	for iter_36_0 = 1, #arg_36_3 do
		for iter_36_1, iter_36_2 in ipairs((self:FindDirectLinkPoint(arg_36_2, arg_36_3[iter_36_0], arg_36_4, arg_36_1))) do
			if iter_36_2.row == arg_36_1.row and iter_36_2.column == arg_36_1.column then
				return iter_36_2
			end

			table.insert(arg_36_3, iter_36_2)
		end
	end

	_.each(arg_36_3, function(arg_37_0)
		arg_36_4[arg_37_0.row .. "_" .. arg_37_0.column] = true

		return
	end)

	return
end

function HoloLiveLinkGameView:FindDirectLinkPoint(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	local var_38_0 = {}

	for iter_38_0 = arg_38_2.row - 1, 0, -1 do
		if self.cards[iter_38_0][arg_38_2.column].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[iter_38_0][arg_38_2.column].id == arg_38_1 then
			if iter_38_0 == arg_38_4.row and arg_38_2.column == arg_38_4.column then
				table.insert(var_38_0, {
					row = iter_38_0,
					column = arg_38_2.column,
					from = arg_38_2
				})
			end

			break
		end

		if self.cards[iter_38_0][arg_38_2.column].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[iter_38_0][arg_38_2.column].id ~= arg_38_1 or arg_38_3[iter_38_0 .. "_" .. arg_38_2.column] then
			break
		end

		table.insert(var_38_0, {
			row = iter_38_0,
			column = arg_38_2.column,
			from = arg_38_2
		})
	end

	for iter_38_1 = arg_38_2.row + 1, HoloLiveLinkGameView.MAX_ROW - 1 do
		if self.cards[iter_38_1][arg_38_2.column].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[iter_38_1][arg_38_2.column].id == arg_38_1 then
			if iter_38_1 == arg_38_4.row and arg_38_2.column == arg_38_4.column then
				table.insert(var_38_0, {
					row = iter_38_1,
					column = arg_38_2.column,
					from = arg_38_2
				})
			end

			break
		end

		if self.cards[iter_38_1][arg_38_2.column].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[iter_38_1][arg_38_2.column].id ~= arg_38_1 or arg_38_3[iter_38_1 .. "_" .. arg_38_2.column] then
			break
		end

		table.insert(var_38_0, {
			row = iter_38_1,
			column = arg_38_2.column,
			from = arg_38_2
		})
	end

	for iter_38_2 = arg_38_2.column - 1, 0, -1 do
		if self.cards[arg_38_2.row][iter_38_2].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[arg_38_2.row][iter_38_2].id == arg_38_1 then
			if arg_38_2.row == arg_38_4.row and iter_38_2 == arg_38_4.column then
				table.insert(var_38_0, {
					row = arg_38_2.row,
					column = iter_38_2,
					from = arg_38_2
				})
			end

			break
		end

		if self.cards[arg_38_2.row][iter_38_2].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[arg_38_2.row][iter_38_2].id ~= arg_38_1 or arg_38_3[arg_38_2.row .. "_" .. iter_38_2] then
			break
		end

		table.insert(var_38_0, {
			row = arg_38_2.row,
			column = iter_38_2,
			from = arg_38_2
		})
	end

	for iter_38_3 = arg_38_2.column + 1, HoloLiveLinkGameView.MAX_COLUMN - 1 do
		if self.cards[arg_38_2.row][iter_38_3].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[arg_38_2.row][iter_38_3].id == arg_38_1 then
			if arg_38_2.row == arg_38_4.row and iter_38_3 == arg_38_4.column then
				table.insert(var_38_0, {
					row = arg_38_2.row,
					column = iter_38_3,
					from = arg_38_2
				})
			end

			break
		end

		if self.cards[arg_38_2.row][iter_38_3].state == HoloLiveLinkGameView.CARD_STATE_NORMAL and self.cards[arg_38_2.row][iter_38_3].id ~= arg_38_1 or arg_38_3[arg_38_2.row .. "_" .. iter_38_3] then
			break
		end

		table.insert(var_38_0, {
			row = arg_38_2.row,
			column = iter_38_3,
			from = arg_38_2
		})
	end

	return var_38_0
end

function HoloLiveLinkGameView:setIconList()
	local var_39_0 = {}
	local var_39_1 = self:GetMGData()
	local var_39_2 = var_39_1:GetRuntimeData("curLinkGameID")

	print("当前地图ID", tostring(var_39_2))

	for iter_39_0, iter_39_1 in ipairs(var_39_1:GetConfigCsvLine(var_39_2).block) do
		if iter_39_1[2] % 2 ~= 0 then
			assert(false, "资源名" .. iter_39_1[1] .. "数量不为偶数" .. iter_39_1[2])
		end

		local var_39_3 = HoloLiveLinkGameView.NAME_TO_INDEX[iter_39_1[1]]

		assert(HoloLiveLinkGameView.NAME_TO_INDEX[iter_39_1[1]], "没有定义该资源名" .. iter_39_1[1])

		for iter_39_2 = 1, iter_39_1[2] do
			table.insert(var_39_0, var_39_3)
		end
	end

	if #var_39_0 ~= 36 then
		assert(false, "总数不为36")
	end

	return var_39_0
end

function HoloLiveLinkGameView:FormatRecordTime(arg_40_1)
	local var_40_0 = math.floor(arg_40_1 / 60000)

	var_40_0 = var_40_0 >= 10 and var_40_0 or "0" .. var_40_0

	local var_40_1 = math.floor(arg_40_1 % 60000 / 1000)

	var_40_1 = var_40_1 >= 10 and var_40_1 or "0" .. var_40_1

	local var_40_2 = math.floor(arg_40_1 % 1000 / 10)

	var_40_2 = var_40_2 >= 10 and var_40_2 or "0" .. var_40_2

	return var_40_0 .. "'" .. var_40_1 .. "'" .. var_40_2
end

return HoloLiveLinkGameView
