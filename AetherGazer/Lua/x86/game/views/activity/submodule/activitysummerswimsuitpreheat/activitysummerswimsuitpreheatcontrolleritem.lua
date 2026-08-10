local var_0_0 = class("ActivitySummerSwimsuitPreheatControllerItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitController()
end

function var_0_0.InitController(arg_3_0)
	arg_3_0.tipsController_ = arg_3_0.controllerEx_:GetController("tips")
end

function var_0_0.InitData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.stageId_ = arg_4_1
	arg_4_0.controllerIndex_ = arg_4_2
	arg_4_0.stageType_ = ActivitySummerSwimsuitPreheatCfg[arg_4_0.stageId_].type

	local var_4_0 = GameSetting.summer_preheat_foolproof_range.value

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1[1] == arg_4_0.stageType_ then
			arg_4_0.minValue_ = iter_4_1[2][arg_4_0.controllerIndex_]
		end
	end

	arg_4_0.curValue_ = 100
	arg_4_0.curTipsStatus_ = nil
	arg_4_0.lastTipsStatus_ = nil

	arg_4_0:UpdateTipsStatus()
end

function var_0_0.SetCanShowTips(arg_5_0, arg_5_1)
	arg_5_0.canShowTips_ = arg_5_1
end

function var_0_0.UpdateGameData(arg_6_0, arg_6_1)
	arg_6_0.gameData_ = arg_6_1
	arg_6_0.curValue_ = arg_6_0.controllerIndex_ == 1 and arg_6_0.gameData_.xValue or arg_6_0.gameData_.yValue

	arg_6_0:Refresh()
end

function var_0_0.Refresh(arg_7_0)
	arg_7_0:UpdateTipsStatus()
end

function var_0_0.UpdateTipsStatus(arg_8_0)
	arg_8_0.curTipsStatus_ = arg_8_0.curValue_ <= arg_8_0.minValue_

	if arg_8_0.curTipsStatus_ ~= arg_8_0.lastTipsStatus_ then
		arg_8_0.tipsController_:SetSelectedState(arg_8_0.curTipsStatus_ and "on" or "off")

		arg_8_0.lastTipsStatus_ = arg_8_0.curTipsStatus_
	end
end

return var_0_0
