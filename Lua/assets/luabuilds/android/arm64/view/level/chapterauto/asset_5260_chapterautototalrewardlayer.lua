local ChapterAutoTotalRewardLayer = class("ChapterAutoTotalRewardLayer", import("view.base.BaseUI"))

function ChapterAutoTotalRewardLayer:getUIName()
	return "ChapterAutoTotalRewardPanel"
end

local var_0_1 = 0.15

function ChapterAutoTotalRewardLayer:init()
	self.window = self._tf:Find("Window")
	self.boxView = self.window:Find("Layout/Box/ScrollView")
	self.TextTF = self.boxView:Find("Content/TextArea2/Text")
	self.eventTF = self.boxView:Find("Content/TextArea")

	setActive(self.eventTF, false)

	self.emptyTip = self.window:Find("Layout/Box/EmptyTip")

	setText(self.emptyTip, i18n("autofight_rewards_none"))
	setText(self.window:Find("Fixed/top/bg/obtain/title"), i18n("autofight_rewards"))
	setText(self.window:Find("Fixed/top/bg/obtain/title/title_en"), i18n("total_rewards_subtitle"))
	setText(self.window:Find("Fixed/ButtonGO/pic"), i18n("text_confirm"))
	setText(self.window:Find("Fixed/ButtonExit/pic"), i18n("autofight_leave"))

	self.itemList = self.boxView:Find("Content/ItemGrid2")

	return
end

function ChapterAutoTotalRewardLayer:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		if self.isRewardAnimating then
			self:SkipAnim()

			return
		end

		existCall(self.contextData.onClose)
		self:closeView()

		return
	end)
	onButton(self, self.window:Find("Fixed/ButtonGO"), function()
		existCall(self.contextData.onClose)
		self:closeView()

		return
	end, SFX_CONFIRM)
	onButton(self, self.window:Find("Fixed/ButtonExit"), function()
		existCall(self.contextData.onClose)
		self:closeView()

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		lockGlobalBlur = true
	})
	getProxy(ChapterAutoProxy):SetSkipBatchBuildFlag(false)
	self:UpdateView()

	return
end

function ChapterAutoTotalRewardLayer:UpdateView()
	local var_7_0 = {}
	local var_7_1 = self.contextData.rewards
	local var_7_2 = self.contextData.rewards and #var_7_1 > 0
	local var_7_3 = CustomIndexLayer.Clone2Full(self.itemList, #self.contextData.rewards)

	for iter_7_0, iter_7_1 in ipairs(var_7_3) do
		local var_7_4 = var_7_1[iter_7_0]

		updateDrop(var_7_3[iter_7_0]:Find("Icon"), var_7_1[iter_7_0])
		onButton(self, var_7_3[iter_7_0]:Find("Icon"), function()
			self:emit(BaseUI.ON_DROP, var_7_4)

			return
		end, SFX_PANEL)
	end

	if var_7_2 then
		self.isRewardAnimating = true

		for iter_7_2 = 1, #var_7_1 do
			local var_7_5 = var_7_3[iter_7_2]

			setActive(var_7_3[iter_7_2], false)
			table.insert(var_7_0, function(arg_9_0)
				if not self:isLoaded() then
					return
				end

				setActive(var_7_5, true)
				scrollTo(self.boxView:Find("Content"), {
					y = 0
				})

				self.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_9_0)).uniqueId

				return
			end)
		end
	end

	local var_7_6 = {}

	if self.contextData.isFinished then
		table.insert(var_7_6, i18n("auto_battle_finish"))
	else
		table.insert(var_7_6, i18n("auto_battle_stop"))
	end

	table.insert(var_7_6, i18n("auto_battle_end_exp", self.contextData.proficiency))
	table.insert(var_7_6, i18n("auto_battle_end_status", self.contextData.totalTimes, self.contextData.finishTimes))

	if #var_7_6 > 0 then
		setText(self.TextTF, table.concat(var_7_6, "\n"))
	end

	self:ShowShips(var_7_1)
	seriesAsync(var_7_0, function()
		self:SkipAnim()
		self:UpdateEvent()

		return
	end)

	return
end

function ChapterAutoTotalRewardLayer:ShowShips(arg_11_1, arg_11_2)
	local var_11_0 = getProxy(BayProxy):getNewShip(true)
	local var_11_1 = {}

	for iter_11_0 = math.max(1, #var_11_0 - #_.filter(arg_11_1, function(arg_12_0)
		return arg_12_0.type == DROP_TYPE_SHIP
	end) + 1), #var_11_0 do
		local var_11_2 = iter_11_0 == #var_11_0
		local var_11_3 = var_11_0[iter_11_0]

		if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
			if var_11_3.virgin or var_11_3:getRarity() >= ShipRarity.Purple then
				table.insert(var_11_1, function(arg_13_0)
					if getProxy(ChapterAutoProxy):GetSkipBatchBuildFlag() then
						arg_13_0()
					else
						self:emit(ChapterAutoTotalRewardMediator.GET_NEW_SHIP, var_11_3, var_11_2, arg_13_0)
					end

					return
				end)
			end
		end
	end

	seriesAsync(var_11_1, arg_11_2)

	return
end

function ChapterAutoTotalRewardLayer:SkipAnim()
	if not self.isRewardAnimating then
		return
	end

	self.isRewardAnimating = nil

	if self.LTid then
		LeanTween.cancel(self.LTid)

		self.LTid = nil
	end

	eachChild(self.itemList, function(arg_15_0)
		setActive(arg_15_0, true)

		return
	end)

	return
end

function ChapterAutoTotalRewardLayer:UpdateEvent()
	local var_16_0 = getProxy(ChapterAutoProxy):GetNewEventIds()

	self.eventTF = self.boxView:Find("Content/TextArea")

	setActive(self.eventTF, #var_16_0 > 0)

	if #var_16_0 <= 0 then
		return
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		table.insert(var_16_1, i18n("autofight_entrust", (pg.collection_template[iter_16_1] or nil) and (pg.collection_template[iter_16_1].title or "")))
	end

	setText(self.eventTF:Find("Text"), table.concat(var_16_1, "\n"))

	return
end

function ChapterAutoTotalRewardLayer:onBackPressed()
	existCall(self.contextData.onClose)
	self:closeView()

	return
end

function ChapterAutoTotalRewardLayer:willExit()
	getProxy(ChapterAutoProxy):ClearEventIds()

	self.contextData.onClose = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ChapterAutoTotalRewardLayer
