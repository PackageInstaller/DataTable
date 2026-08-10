local var_0_0 = class("BloodCardEntraceItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.stateController_ = arg_2_0.controller_:GetController("deck")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallBack_ then
			if not BloodCardData:GetStageHasUnlock(arg_3_0.cfg_.id) then
				ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARD_LOCK")

				return
			end

			arg_3_0.clickCallBack_(arg_3_0.stageID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.stageID_ = arg_5_1
	arg_5_0.cfg_ = BloodCardGameStageCfg[arg_5_0.stageID_]

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = BloodCardData:GetStageHasPass(arg_6_0.cfg_.id)
	local var_6_1 = BloodCardData:GetStageHasUnlock(arg_6_0.cfg_.id) and ActivityData:GetActivityIsOpen(arg_6_0.cfg_.activity_id)

	if var_6_0 then
		arg_6_0.stateController_:SetSelectedState("clear")
	elseif var_6_1 then
		arg_6_0.stateController_:SetSelectedState("normal")
	else
		arg_6_0.stateController_:SetSelectedState("lock")
	end

	arg_6_0.name_.text = arg_6_0.cfg_.name
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickCallBack_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.clickCallBack_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
