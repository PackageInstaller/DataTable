local BossRushTotalRewardPanel = class("BossRushTotalRewardPanel", import("view.activity.worldboss.ActivityBossTotalRewardPanel"))

function BossRushTotalRewardPanel:getUIName()
	return "BossRushTotalRewardPanel"
end

local var_0_1 = 0.15

function BossRushTotalRewardPanel:init()
	BossRushTotalRewardPanel.super.init(self)

	return
end

function BossRushTotalRewardPanel:didEnter()
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

function BossRushTotalRewardPanel:UpdateView()
	local var_4_0 = self.contextData

	onButton(self, self._tf:Find("BG"), function()
		if self.isRewardAnimating then
			self:SkipAnim()

			return
		end

		existCall(var_4_0.onClose)
		self:closeView()

		return
	end)
	setText(self.window:Find("Fixed/ButtonGO/pic"), i18n("text_confirm"))
	onButton(self, self.window:Find("Fixed/ButtonGO"), function()
		existCall(var_4_0.onClose)
		self:closeView()

		return
	end, SFX_CONFIRM)
	setText(self.window:Find("Fixed/ButtonExit/pic"), i18n("autofight_leave"))
	onButton(self, self.window:Find("Fixed/ButtonExit"), function()
		existCall(var_4_0.onClose)
		self:closeView()

		return
	end, SFX_CANCEL)

	local var_4_1 = self.contextData.rewards
	local var_4_2 = {}

	setActive(self.boxView:Find("Content/TextArea2"), self.contextData.totalBattleTimes)

	local var_4_3 = var_4_1 and #var_4_1 > 0
	local var_4_4 = CustomIndexLayer.Clone2Full(self.itemList, #var_4_1)

	for iter_4_0, iter_4_1 in ipairs(var_4_4) do
		local var_4_5 = var_4_1[iter_4_0]

		updateDrop(var_4_4[iter_4_0]:Find("Icon"), var_4_1[iter_4_0])
		onButton(self, var_4_4[iter_4_0]:Find("Icon"), function()
			self:emit(BaseUI.ON_DROP, var_4_5)

			return
		end, SFX_PANEL)
	end

	if var_4_3 then
		self.isRewardAnimating = true

		for iter_4_2 = 1, #var_4_1 do
			local var_4_6 = var_4_4[iter_4_2]

			setActive(var_4_4[iter_4_2], false)
			table.insert(var_4_2, function(arg_9_0)
				if self.exited then
					return
				end

				setActive(var_4_6, true)
				scrollTo(self.boxView:Find("Content"), {
					y = 0
				})

				self.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_9_0)).uniqueId

				return
			end)
		end
	end

	local var_4_7 = {}

	if not self.contextData.stopReason then
		if self.contextData.isAutoFight then
			table.insert(var_4_7, i18n("multiple_sorties_finish"))
		else
			table.insert(var_4_7, i18n("multiple_sorties_stop"))
		end
	else
		table.insert(var_4_7, self.contextData.stopReason .. i18n("multiple_sorties_stop_tip_end"))
	end

	if self.contextData.totalBattleTimes then
		table.insert(var_4_7, i18n("multiple_sorties_end_status", self.contextData.totalBattleTimes, self.contextData.totalBattleTimes - self.contextData.continuousBattleTimes))

		if #var_4_7 > 0 then
			setText(self.boxView:Find("Content/TextArea2/Text"), table.concat(var_4_7, "\n"))
		end
	end

	self:ShowShips(var_4_1)
	seriesAsync(var_4_2, function()
		self:SkipAnim()

		return
	end)

	return
end

function BossRushTotalRewardPanel:ShowShips(arg_11_1, arg_11_2)
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
				self:emit(BossRushTotalRewardPanelMediator.GET_NEW_SHIP, var_11_2, arg_13_0)

				return
			end)
		end
	end

	seriesAsync(var_11_1, arg_11_2)

	return
end

function BossRushTotalRewardPanel:willExit()
	pg.m02:sendNotification(BossRushTotalRewardPanelMediator.ON_WILL_EXIT)

	return
end

return BossRushTotalRewardPanel
