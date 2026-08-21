local var_0_0 = class("ChallengeRogueTeamIllustratedEventItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selelctController_ = arg_1_0.controller_:GetController("select")
	arg_1_0.lockController_ = arg_1_0.controller_:GetController("lock")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.callback_ then
			arg_3_0.callback_(arg_3_0.id_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.id_ = arg_5_2
	arg_5_0.cfg_ = RogueTeamEventCfg[arg_5_2]
	arg_5_0.image_.sprite = pureGetSpriteWithoutAtlas(arg_5_0.cfg_.image)
	arg_5_0.text_.text = arg_5_0.cfg_.title
end

function var_0_0.SetClickCallBack(arg_6_0, arg_6_1)
	arg_6_0.callback_ = arg_6_1
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	arg_7_0.selelctController_:SetSelectedState(tostring(arg_7_0.id_ == arg_7_1))
end

function var_0_0.RefreshUnlock(arg_8_0, arg_8_1)
	arg_8_0.lockController_:SetSelectedState(tostring(arg_8_1))
end

return var_0_0
