local SummerRaceBattleRecordItemView = class("SummerRaceBattleRecordItemView", ReduxView)

function SummerRaceBattleRecordItemView:ResolveWaveText(arg_1_1)
	if type(arg_1_1) ~= "table" then
		return ""
	end

	if arg_1_1.waveText ~= nil and arg_1_1.waveText ~= "" then
		return arg_1_1.waveText
	end

	local var_1_0 = tonumber(arg_1_1.waveIndex) or 0

	if var_1_0 <= 0 then
		return ""
	end

	return string.format(GetTips("ACTIVITY_TANK_WAVE"), var_1_0)
end

function SummerRaceBattleRecordItemView:BuildRecordDataRefreshKey(arg_2_1, arg_2_2)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = tostring(arg_2_1.enemyName or "")
	local var_2_1 = tostring(arg_2_1.timeText or "--:--")
	local var_2_2 = tostring(arg_2_1.enemyAvatarPath or "")
	local var_2_3

	if not arg_2_2 then
		::label_2_0::

		var_2_3 = arg_2_1.resultState or "none"
	end

	local var_2_4 = tostring(var_2_3)
	local var_2_5 = arg_2_1.score
	local var_2_6

	if not arg_2_1.score then
		var_2_5 = ""
		var_2_6 = {
			var_2_0,
			self:ResolveWaveText(arg_2_1),
			var_2_1,
			var_2_2,
			var_2_4
		}
	end

	var_2_6[6] = tostring(var_2_5)

	return table.concat(var_2_6, "|")
end

function SummerRaceBattleRecordItemView:OnCtor(arg_3_1)
	self.gameObject_ = arg_3_1
	self.transform_ = arg_3_1.transform

	self:Init()
end

function SummerRaceBattleRecordItemView:Init()
	self:BindCfgUI()

	self.resultController_ = self.controllerEx_:GetController("result")
end

function SummerRaceBattleRecordItemView:SetData(arg_5_1, arg_5_2)
	self.recordData_ = arg_5_1 or {}
	self.resultStateOverride_ = arg_5_2

	local var_5_0 = self:BuildRecordDataRefreshKey(self.recordData_, self.resultStateOverride_)

	if self.recordRefreshKey_ == var_5_0 then
		return
	end

	self.recordRefreshKey_ = var_5_0

	self:RefreshView()
end

function SummerRaceBattleRecordItemView:RefreshView()
	local var_6_0 = self.recordData_ or {}
	local var_6_1 = tostring(self.resultStateOverride_ or var_6_0.resultState or "none")
	local var_6_2 = tostring(var_6_0.enemyAvatarPath or "")

	if var_6_1 == "challenge" or var_6_1 == "challengeNode" then
		self.enemyNameText_.text = tostring(var_6_0.enemyName or "")
		self.enemyCountText_.text = self:ResolveWaveText(var_6_0)

		local var_6_4 = self.timeText_

		if var_6_1 == "challenge" then
			var_6_4.text = tostring(var_6_0.timeText or "--:--") or "--:--"
		end

		self.icon_.spriteSync = nil

		local var_6_7 = self.recordText_

		if var_6_1 == "challenge" then
			var_6_7.text = tostring(var_6_0.score or 0) or ""
		end
	else
		self.enemyNameText_.text = tostring((not var_6_0.enemyName or nil) and "")
		self.enemyCountText_.text = self:ResolveWaveText(var_6_0)
		self.timeText_.text = tostring(var_6_0.timeText or "--:--")
		self.icon_.spriteSync = var_6_2 ~= "" and var_6_2 or nil
		self.recordText_.text = tostring(var_6_0.score or 0)
	end

	self.resultController_:SetSelectedState(var_6_1)
end

function SummerRaceBattleRecordItemView:Dispose()
	self.recordData_ = nil
	self.resultStateOverride_ = nil
	self.recordRefreshKey_ = nil

	SummerRaceBattleRecordItemView.super.Dispose(self)
end

return SummerRaceBattleRecordItemView
