local var_0_0 = class("SpringFestivalZumaEndlessEffectPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaEffectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.talentList = {}

	local var_4_0 = ZumaData:GetEndlessTalentList()

	for iter_4_0 = 2, #var_4_0 do
		local var_4_1 = var_4_0[iter_4_0]
		local var_4_2 = arg_4_0:CreateTalentItem()

		var_4_2:SetData(var_4_1)
		table.insert(arg_4_0.talentList, var_4_2)
	end
end

function var_0_0.CreateTalentItem(arg_5_0)
	local var_5_0 = GameObject.Instantiate(arg_5_0.effectdetailsitemGo_, arg_5_0.contentTrs_)

	return (SpringFestivalZumaEndlessTalentItem.New(var_5_0))
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.talentList) do
		iter_8_1:RefreshUI()
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.talentList) do
		if iter_9_1 then
			iter_9_1:Dispose()

			iter_9_1 = nil
		end
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
