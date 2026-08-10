local var_0_0 = class("BloodCardRecommendCardGroupItem", ReduxView)

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
	arg_2_0.collectController_ = arg_2_0.controller_:GetController("collect")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallBack_ then
			arg_3_0.clickCallBack_(arg_3_0.groupID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.groupID_ = arg_5_1
	arg_5_0.cfg_ = BloodCardGameRecommendCardSetCfg[arg_5_0.groupID_]

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.nameText_.text = arg_6_0.cfg_.name
	arg_6_0.ownCardNum_ = BloodCardData:GetGroupOwnCardNum(arg_6_0.cfg_.card_list)
	arg_6_0.progressText_.text = arg_6_0.ownCardNum_ .. "/" .. #arg_6_0.cfg_.card_list

	arg_6_0.collectController_:SetSelectedState(tostring(arg_6_0.ownCardNum_ == #arg_6_0.cfg_.card_list))
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickCallBack_ = arg_7_1
end

function var_0_0.RefreshSelect(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(tostring(arg_8_0.groupID_ == arg_8_1))
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.clickCallBack_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
