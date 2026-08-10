local var_0_0 = class("AdvanceTestEntraceItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.selectController_ = arg_2_0.controller_:GetController("select")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallBack_ then
			arg_3_0.clickCallBack_(arg_3_0.activityID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.activityID_ = arg_5_1
	arg_5_0.cfg_ = AdvanceTestCfg[AdvanceTestCfg.get_id_list_by_activity_id[arg_5_0.activityID_][1]]

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.text_.text = arg_6_0.cfg_.stage_name
	arg_6_0.bossImg_.spriteSync = "TextureConfig/Character/Icon/" .. arg_6_0.cfg_.hero
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickCallBack_ = arg_7_1
end

function var_0_0.RefreshSelect(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(tostring(arg_8_0.activityID_ == arg_8_1))
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.clickCallBack_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
