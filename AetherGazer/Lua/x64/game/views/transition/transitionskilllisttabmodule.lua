local var_0_0 = class("TransitionSkillListTabModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:BuildContext()
	arg_2_0:AddUIListener()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.controller = {
		comps = arg_3_0.tabController_,
		tab = {
			comps = arg_3_0.tabController_:GetController("pos")
		}
	}
	arg_3_0.constVar = {
		tabPrefix = "tab%dBtn_"
	}
	arg_3_0.data = {
		tabIdx = -1
	}
end

function var_0_0.AddUIListener(arg_4_0)
	for iter_4_0 = 1, 6 do
		arg_4_0:AddBtnListener(arg_4_0[string.format(arg_4_0.constVar.tabPrefix, iter_4_0)], nil, function()
			if arg_4_0.data.tabIdx == iter_4_0 then
				return
			end

			arg_4_0:OnTabClick(iter_4_0)
		end)
	end
end

function var_0_0.RegisterClickCallback(arg_6_0, arg_6_1)
	arg_6_0.data.clickCallback = arg_6_1
end

function var_0_0.OnTabClick(arg_7_0, arg_7_1)
	arg_7_0.data.tabIdx = arg_7_1

	arg_7_0.controller.tab.comps:SetSelectedState(tostring(arg_7_1))

	local var_7_0 = arg_7_0.data.clickCallback

	if var_7_0 then
		var_7_0(arg_7_1)
	end
end

function var_0_0.OnDispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
