local var_0_0 = class("SkuldTravelShowPlotItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statuController_ = ControllerUtil.GetController(arg_3_0.transform_, "statu")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if SkuldTravelData:GetPlotIsGeted(arg_4_0.poltid_) then
			JumpTools.OpenPageByJump("skuldTravelPlotView", {
				poltid = arg_4_0.poltid_
			})
		else
			ShowTips(GetTips("NO_RECORD"))
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.poltid_ = arg_6_1
	arg_6_0.nametext_.text = GetI18NText(TravelSkuldStoryCfg[arg_6_1].story_name)

	if SkuldTravelData:GetPlotIsGeted(arg_6_1) then
		arg_6_0.statuController_:SetSelectedState("get")
	else
		arg_6_0.statuController_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
