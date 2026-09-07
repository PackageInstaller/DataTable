local ActivityBossTotalRewardPanel = class("ActivityBossTotalRewardPanel", import("view.level.BaseTotalRewardPanel"))

function ActivityBossTotalRewardPanel:getUIName()
	return "ActivityBossTotalRewardPanel"
end

local var_0_1 = 0.15

function ActivityBossTotalRewardPanel:init()
	ActivityBossTotalRewardPanel.super.init(self)

	self.itemList = self.boxView:Find("Content/ItemGrid2")

	setText(self.window:Find("Fixed/top/bg/obtain/title"), i18n("autofight_rewards"))
	setText(self.window:Find("Fixed/ButtonGO/pic"), i18n("text_confirm"))

	return
end

function ActivityBossTotalRewardPanel:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		lockGlobalBlur = true
	})
	self:UpdateView()

	if self.contextData.isAutoFight and PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_AUTO_BATTLE)
		LuaHelper.Vibrate()
	end

	return
end

function ActivityBossTotalRewardPanel:willExit()
	self:SkipAnim()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ActivityBossTotalRewardPanel:UpdateView()
	local var_5_0 = self.contextData

	onButton(self, self._tf:Find("BG"), function()
		if self.isRewardAnimating then
			self:SkipAnim()

			return
		end

		existCall(var_5_0.onClose)
		self:closeView()

		return
	end)
	onButton(self, self.window:Find("Fixed/ButtonGO"), function()
		existCall(var_5_0.onClose)
		self:closeView()

		return
	end, SFX_CONFIRM)

	local var_5_1 = self.contextData.rewards
	local var_5_2 = {}
	local var_5_3 = self.contextData.rewards and #var_5_1 > 0
	local var_5_4 = CustomIndexLayer.Clone2Full(self.itemList, #self.contextData.rewards)

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		local var_5_5 = var_5_1[iter_5_0]

		updateDrop(var_5_4[iter_5_0]:Find("Icon"), var_5_1[iter_5_0])
		onButton(self, var_5_4[iter_5_0]:Find("Icon"), function()
			self:emit(BaseUI.ON_DROP, var_5_5)

			return
		end, SFX_PANEL)
	end

	if var_5_3 then
		self.isRewardAnimating = true

		for iter_5_2 = 1, #var_5_1 do
			local var_5_6 = var_5_4[iter_5_2]

			setActive(var_5_4[iter_5_2], false)
			table.insert(var_5_2, function(arg_9_0)
				if self.exited then
					return
				end

				setActive(var_5_6, true)
				scrollTo(self.boxView:Find("Content"), {
					y = 0
				})

				self.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_9_0)).uniqueId

				return
			end)
		end
	end

	local var_5_7 = {}

	if not self.contextData.stopReason then
		if self.contextData.isAutoFight then
			table.insert(var_5_7, i18n("multiple_sorties_finish"))
		else
			table.insert(var_5_7, i18n("multiple_sorties_stop"))
		end
	else
		table.insert(var_5_7, self.contextData.stopReason .. i18n("multiple_sorties_stop_tip_end"))
	end

	table.insert(var_5_7, i18n("multiple_sorties_end_status", self.contextData.totalBattleTimes, self.contextData.totalBattleTimes - self.contextData.continuousBattleTimes))

	if #var_5_7 > 0 then
		setText(self.boxView:Find("Content/TextArea2/Text"), table.concat(var_5_7, "\n"))
	end

	self:ShowShips(var_5_1)
	seriesAsync(var_5_2, function()
		self:SkipAnim()

		return
	end)

	return
end

function ActivityBossTotalRewardPanel:ShowShips(arg_11_1, arg_11_2)
	local var_11_0 = getProxy(BayProxy):getNewShip(true)
	local var_11_1 = {}

	for iter_11_0 = math.max(1, #var_11_0 - #_.filter(arg_11_1, function(arg_12_0)
		return arg_12_0.type == DROP_TYPE_SHIP
	end) + 1), #var_11_0 do
		local var_11_2 = var_11_0[iter_11_0]
		local var_11_3

		if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
			var_11_3 = var_11_0[iter_11_0].virgin or var_11_0[iter_11_0]:getRarity() >= ShipRarity.Purple
		end

		print(var_11_3)

		if var_11_3 then
			table.insert(var_11_1, function(arg_13_0)
				print("eeeeeeeeeeeee")
				self:emit(ActivityBossTotalRewardPanelMediator.GET_NEW_SHIP, var_11_2, arg_13_0)

				return
			end)
		end
	end

	seriesAsync(var_11_1, arg_11_2)

	return
end

function ActivityBossTotalRewardPanel:SkipAnim()
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

function ActivityBossTotalRewardPanel:onBackPressed()
	existCall(self.contextData.onClose)
	self:closeView()

	return
end

return ActivityBossTotalRewardPanel
