local LevelContinuousOperationTotalRewardPanel = class("LevelContinuousOperationTotalRewardPanel", import("view.level.LevelStageTotalRewardPanel"))

function LevelContinuousOperationTotalRewardPanel:getUIName()
	return "LevelContinuousOperationTotalRewardPanel"
end

function LevelContinuousOperationTotalRewardPanel:init()
	LevelContinuousOperationTotalRewardPanel.super.init(self)

	return
end

function LevelContinuousOperationTotalRewardPanel:didEnter()
	LevelContinuousOperationTotalRewardPanel.super.didEnter(self)

	return
end

function LevelContinuousOperationTotalRewardPanel:UpdateView()
	LevelContinuousOperationTotalRewardPanel.super.UpdateView(self)
	setActive(self.boxView, true)
	setActive(self.emptyTip, false)

	local var_4_0 = self.contextData.continuousData
	local var_4_1 = self.contextData.continuousData:GetTotalBattleTime()
	local var_4_2 = math.min(var_4_1, (self.contextData.chapter:GetMaxBattleCount()))
	local var_4_3 = var_4_2 > 0 and var_4_0:IsActive()

	onButton(self, self.window:Find("Fixed/ButtonGO"), function()
		if self.contextData.spItemID and PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) ~= 1 then
			PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
			PlayerPrefs.Save()

			local function var_5_0()
				self.contextData.spItemID = nil

				self:UpdateSPItem()

				return
			end

			self:HandleShowMsgBox({
				hideNo = true,
				content = i18n("autofight_special_operation_tip"),
				onYes = var_5_0,
				onNo = var_5_0
			})

			return
		end

		PlayerPrefs.SetInt(Chapter.GetSPOperationItemCacheKey(self.contextData.chapter.id), self.contextData.spItemID or 0)

		if var_4_3 then
			getProxy(ChapterProxy):InitContinuousTime(SYSTEM_SCENARIO, var_4_2)
		end

		self:emit(LevelMediator2.ON_RETRACKING, self.contextData.chapter, true)
		self:closeView()

		return
	end, SFX_CONFIRM)

	local var_4_4 = {}
	local var_4_5 = var_4_0:IsActive()

	if var_4_5 then
		table.insert(var_4_4, i18n("multiple_sorties_finish"))
	else
		table.insert(var_4_4, i18n("multiple_sorties_stop"))
	end

	setActive(self.boxView:Find("Content/TextArea2/Title/Sucess"), var_4_5)
	setActive(self.boxView:Find("Content/TextArea2/Title/Failure"), not var_4_5)
	table.insert(var_4_4, i18n("multiple_sorties_main_end", var_4_1, var_4_1 - var_4_0:GetRestBattleTime()))

	if #var_4_4 > 0 then
		setText(self.boxView:Find("Content/TextArea2/Title/Text"), var_4_4[1])
		setText(self.boxView:Find("Content/TextArea2/Detail"), var_4_4[2])
	end

	if var_4_3 then
		setActive(self.spList, go(self.spList).activeSelf and self.contextData.chapter:GetRestDailyBonus() < var_4_2)
	end

	setActive(self.window:Find("RetryTimes"), var_4_3)
	setText(self.window:Find("RetryTimes/Text"), i18n("multiple_sorties_retry_desc", var_4_2))

	return
end

function LevelContinuousOperationTotalRewardPanel:willExit()
	LevelContinuousOperationTotalRewardPanel.super.willExit(self)

	return
end

return LevelContinuousOperationTotalRewardPanel
