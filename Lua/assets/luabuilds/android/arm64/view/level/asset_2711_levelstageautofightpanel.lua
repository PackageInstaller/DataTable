local LevelStageAutoFightPanel = class("LevelStageAutoFightPanel", BaseSubView)

function LevelStageAutoFightPanel:Ctor(...)
	LevelStageAutoFightPanel.super.Ctor(self, ...)

	self.buffer = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				self:ActionInvoke(arg_2_1, ...)

				return
			end
		end,
		__newindex = function()
			errorMsg("Cant write Data in ActionInvoke buffer")

			return
		end
	})
	self.isFrozen = nil

	self:bind(LevelUIConst.ON_FROZEN, function()
		self.isFrozen = true

		return
	end)
	self:bind(LevelUIConst.ON_UNFROZEN, function()
		self.isFrozen = nil

		return
	end)

	self.loader = AutoLoader.New()
	self.isCO = false

	return
end

function LevelStageAutoFightPanel:getUIName()
	return "LevelStageAutoFightPanel"
end

function LevelStageAutoFightPanel:OnInit()
	self.btnOn = self._tf:Find("On")
	self.btnOff = self._tf:Find("Off")

	onButton(self, self.btnOn, function()
		getProxy(ChapterProxy):SetChapterAutoFlag(self.contextData.chapterVO.id, false, ChapterConst.AUTOFIGHT_STOP_REASON.MANUAL)
		PlayerPrefs.SetInt("chapter_autofight_flag_" .. self.contextData.chapterVO.id, 0)
		PlayerPrefs.Save()
		self:UpdateAutoFightMark()

		return
	end, SFX_PANEL)
	onButton(self, self.btnOff, function()
		getProxy(ChapterProxy):SetChapterAutoFlag(self.contextData.chapterVO.id, true)
		PlayerPrefs.SetInt("chapter_autofight_flag_" .. self.contextData.chapterVO.id, 1)
		PlayerPrefs.Save()
		self:UpdateAutoFightMark()

		if not self.isFrozen then
			self:emit(LevelUIConst.TRIGGER_ACTION)
		end

		return
	end, SFX_PANEL)

	self.restTime = self.btnOn:Find("Rest")

	local var_8_0 = string.split(i18n("multiple_sorties_rest_time"), "$1/$2")

	setText(self.restTime:Find("Text"), var_8_0[1])
	setText(self.restTime:Find("Text (2)"), var_8_0[2])

	return
end

function LevelStageAutoFightPanel:UpdateAutoFightMark()
	local var_11_0 = getProxy(ChapterProxy):GetChapterAutoFlag(self.contextData.chapterVO.id) == 1

	setActive(self.btnOn, var_11_0)
	setActive(self.btnOff, not var_11_0)
	self:UpdateContinuousOperation()
	self:emit(LevelUIConst.STRATEGY_PANEL_AUTOFIGHT_ACTIVE, var_11_0)

	return
end

function LevelStageAutoFightPanel:UpdateContinuousOperation()
	local var_12_0 = getProxy(ChapterProxy):GetContinuousData(SYSTEM_SCENARIO)

	if var_12_0 and var_12_0:IsActive() then
		local var_12_1 = "$1/$2"

		for iter_12_0, iter_12_1 in ipairs({
			var_12_0:GetTotalBattleTime() - var_12_0:GetRestBattleTime() + 1,
			var_12_0:GetTotalBattleTime()
		}) do
			var_12_1 = string.gsub(var_12_1, "$" .. iter_12_0, iter_12_1)
		end

		setText(self.restTime:Find("Count"), var_12_1)
		setActive(self.restTime, true)

		if not self.isCO then
			self.loader:GetSprite("ui/levelstageview_atlas", "continuous_operation_on", self.btnOn)

			self.isCO = true
		end
	else
		setActive(self.restTime, false)

		if self.isCO then
			self.loader:GetSprite("ui/levelstageview_atlas", "continuous_operation_on", self.btnOn)

			self.isCO = false
		end
	end

	return
end

function LevelStageAutoFightPanel:OnDestroy()
	self.loader:Clear()
	LevelStageAutoFightPanel.super.OnDestroy(self)

	return
end

return LevelStageAutoFightPanel
