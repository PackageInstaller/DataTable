local var_0_0 = class("NorseSurpriseGiftResultsview", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftResultsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, NorseSurpriseGiftResultsItem)
	arg_3_0.uiList_2 = LuaList.New(handler(arg_3_0, arg_3_0.indexItem2), arg_3_0.listGo_2, NorseSurpriseGiftResultsItem)
	arg_3_0.effectCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("Effects")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_bg, nil, function()
		arg_4_0:Back()
		manager.notify:Invoke(NORSE_GIFT_PLAYANIM_DRAW)
	end)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	HeroLongHead.SetProxy(arg_6_2, arg_6_0.heroDataProxy)
	arg_6_2:SetData(arg_6_0.draw_list[arg_6_1])

	if arg_6_0.heartList and #arg_6_0.heartList > 0 then
		arg_6_2:SetHeart(arg_6_0.heartList)
	end
end

function var_0_0.indexItem2(arg_7_0, arg_7_1, arg_7_2)
	HeroLongHead.SetProxy(arg_7_2, arg_7_0.heroDataProxy)
	arg_7_2:SetData(arg_7_0.delete_list[arg_7_1])

	if arg_7_0.delete_list and #arg_7_0.delete_list > 0 then
		arg_7_2:SetDelete(arg_7_0.delete_list)
	end
end

function var_0_0.OnEnter(arg_8_0)
	var_0_0.super.OnEnter(arg_8_0)

	if arg_8_0.params_.data then
		arg_8_0.data = arg_8_0.params_.data
	end

	arg_8_0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	arg_8_0:RefreshView()

	arg_8_0.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_5")
	arg_8_0.tipsTxt2_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_6")
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.heroDataProxy then
		arg_10_0.heroDataProxy = nil
	end

	if arg_10_0.uiList_ then
		arg_10_0.uiList_:Dispose()

		arg_10_0.uiList_ = nil
	end

	if arg_10_0.uiList_2 then
		arg_10_0.uiList_2:Dispose()

		arg_10_0.uiList_2 = nil
	end
end

function var_0_0.RefreshView(arg_11_0)
	arg_11_0.delete_list = arg_11_0.data.delete_list
	arg_11_0.draw_list = arg_11_0.data.draw_list

	local var_11_0 = 1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.heartList) do
		if iter_11_1 == arg_11_0.draw_list[1] then
			var_11_0 = 0

			break
		end
	end

	arg_11_0.effectCtrl:SetSelectedIndex(var_11_0)
	arg_11_0.uiList_:StartScroll(#arg_11_0.draw_list)
	arg_11_0.uiList_2:StartScroll(#arg_11_0.delete_list)
end

return var_0_0
