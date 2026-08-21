local var_0_0 = class("DormRecommendBigItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.type

	arg_4_0.recIcon_.sprite = CanteenTools.GetFilterIcon(var_4_0, arg_4_1.tag)

	local var_4_1 = CanteenEntrustData:GetDispatchCharacterList()
	local var_4_2 = false

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if CanteenHeroTools:CheckHeroConcertTag(iter_4_1, arg_4_1.type, arg_4_1.tag) then
			var_4_2 = true

			break
		end
	end

	if var_4_2 then
		arg_4_0.statusController_:SetSelectedState("lightup")
	else
		arg_4_0.statusController_:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
