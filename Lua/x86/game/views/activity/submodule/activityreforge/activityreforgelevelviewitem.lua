local var_0_0 = class("ActivityReforgeLevelViewItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.clickHandler_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.levelController_ = arg_3_0.controllerEx_:GetController("Level")
	arg_3_0.isPassController_ = arg_3_0.controllerEx_:GetController("ispass")
	arg_3_0.isBattlingController_ = arg_3_0.controllerEx_:GetController("isbattling")
	arg_3_0.isSelectController_ = arg_3_0.controllerEx_:GetController("isselect")
	arg_3_0.isLast_ = false
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index_ = arg_6_1
	arg_6_0.chapterActivityID_ = arg_6_2
	arg_6_0.levelID_ = arg_6_3

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.cfg_ = ActivityReforgeLevelCfg[arg_7_0.levelID_]

	arg_7_0.levelController_:SetSelectedState(arg_7_0.index_)

	if arg_7_0.levelID_ == ActivityReforgeData:GetCurLevel() then
		local var_7_0 = ActivityReforgeData:GetCurLastWinWaveID()
		local var_7_1 = ActivityReforgeLevelCfg[arg_7_0.levelID_].wave_list

		arg_7_0.isLast_ = var_7_1[#var_7_1] == var_7_0

		if arg_7_0.isLast_ then
			arg_7_0.curWaveNum_.text = string.format(GetTips("ACTIVITY_REFORGE_WAVE"), ActivityReforgeData:GetCurLevelFinishWave())
		else
			arg_7_0.curWaveNum_.text = string.format(GetTips("ACTIVITY_REFORGE_WAVE"), ActivityReforgeData:GetCurLevelFinishWave() + 1)
		end

		arg_7_0.isBattlingController_:SetSelectedState("true")
	else
		arg_7_0.isBattlingController_:SetSelectedState("false")
	end

	if ActivityReforgeData:GetLevelIsFinish(arg_7_0.chapterActivityID_, arg_7_0.levelID_) then
		arg_7_0.isPassController_:SetSelectedState("true")
	else
		arg_7_0.isPassController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshSelect(arg_8_0, arg_8_1)
	if arg_8_0.index_ == arg_8_1 then
		arg_8_0.isSelectController_:SetSelectedState("true")
	else
		arg_8_0.isSelectController_:SetSelectedState("false")
	end
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
