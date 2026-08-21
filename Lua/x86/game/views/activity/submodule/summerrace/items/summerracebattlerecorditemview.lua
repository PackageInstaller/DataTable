local var_0_0 = class("SummerRaceBattleRecordItemView", ReduxView)

function var_0_0.ResolveWaveText(arg_1_0, arg_1_1)
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

function var_0_0.BuildRecordDataRefreshKey(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = tostring(arg_2_1.enemyName or "")
	local var_2_1 = arg_2_0:ResolveWaveText(arg_2_1)
	local var_2_2 = tostring(arg_2_1.timeText or "--:--")
	local var_2_3 = tostring(arg_2_1.enemyAvatarPath or "")
	local var_2_4 = tostring(arg_2_2 or arg_2_1.resultState or "none")
	local var_2_5 = tostring(arg_2_1.score or "")

	return table.concat({
		var_2_0,
		var_2_1,
		var_2_2,
		var_2_3,
		var_2_4,
		var_2_5
	}, "|")
end

function var_0_0.OnCtor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_1.transform

	arg_3_0:Init()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.resultController_ = arg_4_0.controllerEx_:GetController("result")
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.recordData_ = arg_5_1 or {}
	arg_5_0.resultStateOverride_ = arg_5_2

	local var_5_0 = arg_5_0:BuildRecordDataRefreshKey(arg_5_0.recordData_, arg_5_0.resultStateOverride_)

	if arg_5_0.recordRefreshKey_ == var_5_0 then
		return
	end

	arg_5_0.recordRefreshKey_ = var_5_0

	arg_5_0:RefreshView()
end

function var_0_0.RefreshView(arg_6_0)
	local var_6_0 = arg_6_0.recordData_ or {}
	local var_6_1 = tostring(arg_6_0.resultStateOverride_ or var_6_0.resultState or "none")
	local var_6_2 = tostring(var_6_0.enemyAvatarPath or "")

	if var_6_1 == "challenge" or var_6_1 == "challengeNode" then
		arg_6_0.enemyNameText_.text = tostring(var_6_0.enemyName or "")
		arg_6_0.enemyCountText_.text = arg_6_0:ResolveWaveText(var_6_0)
		arg_6_0.timeText_.text = var_6_1 == "challenge" and tostring(var_6_0.timeText or "--:--") or "--:--"
		arg_6_0.icon_.spriteSync = nil
		arg_6_0.recordText_.text = var_6_1 == "challenge" and tostring(var_6_0.score or 0) or ""
	else
		arg_6_0.enemyNameText_.text = tostring(var_6_0.enemyName or "")
		arg_6_0.enemyCountText_.text = arg_6_0:ResolveWaveText(var_6_0)
		arg_6_0.timeText_.text = tostring(var_6_0.timeText or "--:--")
		arg_6_0.icon_.spriteSync = var_6_2 ~= "" and var_6_2 or nil
		arg_6_0.recordText_.text = tostring(var_6_0.score or 0)
	end

	arg_6_0.resultController_:SetSelectedState(var_6_1)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.recordData_ = nil
	arg_7_0.resultStateOverride_ = nil
	arg_7_0.recordRefreshKey_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
