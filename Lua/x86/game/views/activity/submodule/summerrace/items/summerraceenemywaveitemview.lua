local var_0_0 = class("SummerRaceEnemyWaveItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.resultController_ = arg_2_0.controllerEx_:GetController("result")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.clickBtn_, nil, function()
		if arg_3_0.clickHandler_ then
			arg_3_0.clickHandler_(arg_3_0.index_, arg_3_0.waveData_, "battleInfo")
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.waveData_ = arg_5_1
	arg_5_0.index_ = arg_5_2
	arg_5_0.clickHandler_ = arg_5_3

	arg_5_0:RefreshView()
end

function var_0_0.RefreshView(arg_6_0)
	local var_6_0 = tostring(arg_6_0.waveData_.enemyAvatarPath or "")

	arg_6_0.enemyNameText_.text = tostring(arg_6_0.waveData_.enemyName or "")
	arg_6_0.enemyCountText_.text = tostring(arg_6_0.waveData_.waveText or "")
	arg_6_0.timeText_.text = tonumber(arg_6_0.waveData_.enemyCount) and arg_6_0.waveData_.enemyCount > 1 and "x" .. tostring(arg_6_0.waveData_.enemyCount or 0) or ""
	arg_6_0.icon_.spriteSync = var_6_0 ~= "" and var_6_0 or nil

	arg_6_0.resultController_:SetSelectedState("win")
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.waveData_ = nil
	arg_7_0.clickHandler_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
