local var_0_0 = class("SummerPubStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_3
	arg_1_0.levelID_ = arg_1_2
	arg_1_0.cfg_ = SummerPubLevelCfg[arg_1_0.levelID_]
	arg_1_0.selectHandler_ = arg_1_4

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("selectState")
	arg_3_0.passController_ = arg_3_0.controllerEx_:GetController("passState")

	arg_3_0:RefreshUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		JumpTools.OpenPageByJump("summerPubStageSectionView", {
			levelID = arg_4_0.levelID_,
			battleType = BattleConst.STAGE_TYPE_NEW.SUMMER_PUB
		})

		if arg_4_0.selectHandler_ then
			arg_4_0.selectHandler_(arg_4_0.index_, arg_4_0.levelID_)
		end
	end)
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.selectController_:SetSelectedState("true")
	else
		arg_6_0.selectController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.selectController_:SetSelectedState("false")

	if SummerPubData:GetLevelIDIsOpen(arg_7_0.levelID_) then
		if arg_7_0.cfg_.type == SummerPubConst.STAGE_TYPE.BALL then
			arg_7_0.passController_:SetSelectedState("unlock")

			if SummerPubData:GetClearNumByStageID(arg_7_0.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				arg_7_0.passController_:SetSelectedState("complete")
			end

			if SummerPubData:GetClearNumByStageID(arg_7_0.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.HARD) > 0 then
				arg_7_0.passController_:SetSelectedState("completehard")
			end
		elseif SummerPubData:GetClearNumByStageID(arg_7_0.levelID_) > 0 then
			arg_7_0.passController_:SetSelectedState("complete")
		else
			arg_7_0.passController_:SetSelectedState("challenge")
		end
	else
		arg_7_0.passController_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
