local var_0_0 = class("DormInfomationHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.emptyController = arg_2_0.controller_:GetController("empty")
	arg_2_0.characterItem = DormCharacterItem.New(arg_2_0.heroItem)

	arg_2_0:SetState(true, true)
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn, nil, function()
		if arg_3_0.clickFunc_ then
			arg_3_0.clickFunc_(arg_3_0.heroID)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.heroID = arg_5_1.heroID

		arg_5_0.characterItem:RefreshHeroInfo(arg_5_1.heroID)
		arg_5_0.emptyController:SetSelectedState("off")
	else
		arg_5_0.heroID = nil

		arg_5_0.emptyController:SetSelectedState("on")
	end
end

function var_0_0.SetState(arg_6_0, arg_6_1)
	arg_6_0.characterItem:SetCanClickAndState(arg_6_1, true, false)
end

function var_0_0.RefreshState(arg_7_0)
	arg_7_0.characterItem:RefreshState()
end

function var_0_0.SetShowMaskCallback(arg_8_0, arg_8_1)
	arg_8_0.showMaskCallback = arg_8_1

	arg_8_0.characterItem:ShowMaskCallBack(arg_8_1)
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	if arg_9_0.showMaskCallback and arg_9_0.showMaskCallback(arg_9_0.heroID) then
		return
	end

	arg_9_0.clickFunc_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.characterItem:Dispose()
	arg_10_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
