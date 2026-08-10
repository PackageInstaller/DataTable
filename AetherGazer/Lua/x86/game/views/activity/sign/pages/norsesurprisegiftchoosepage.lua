local var_0_0 = class("NorseSurpriseGiftChoosePage", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftChooseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, NorseSurpriseGiftChooseItem)
	arg_3_0.stateCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	HeroLongHead.SetProxy(arg_4_2, arg_4_0.heroDataProxy)
	arg_4_2:SetData(arg_4_0.heroList[arg_4_1])

	if arg_4_0.heartList and #arg_4_0.heartList > 0 then
		arg_4_2:SetHeart(arg_4_0.heartList)
	end

	if arg_4_0.deleteList and #arg_4_0.deleteList > 0 then
		arg_4_2:SetDelete(arg_4_0.deleteList)
	end

	if arg_4_0.drawList and #arg_4_0.drawList > 0 then
		arg_4_2:SetDraw(arg_4_0.drawList)
	end

	if arg_4_0.result_role_id then
		arg_4_2:SetResultRoleId(arg_4_0.result_role_id)
	end
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnClose_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnAll_, nil, function()
		arg_5_0.heroList = GameSetting.activity_optional_random_role_list.value
		arg_5_0.heroList = arg_5_0:SortList(arg_5_0.heroList)

		arg_5_0.uiList_:StartScroll(#arg_5_0.heroList)
		arg_5_0.stateCtrl:SetSelectedIndex(0)

		arg_5_0.btnIndex = -1
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_0, nil, function()
		arg_5_0:RefreshHeroList(0)
		arg_5_0.stateCtrl:SetSelectedIndex(1)

		arg_5_0.btnIndex = 0
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_2, nil, function()
		arg_5_0:RefreshHeroList(2)
		arg_5_0.stateCtrl:SetSelectedIndex(2)

		arg_5_0.btnIndex = 2
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_4, nil, function()
		arg_5_0:RefreshHeroList(4)
		arg_5_0.stateCtrl:SetSelectedIndex(3)

		arg_5_0.btnIndex = 4
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_14, nil, function()
		arg_5_0:RefreshHeroList(14)
		arg_5_0.stateCtrl:SetSelectedIndex(4)

		arg_5_0.btnIndex = 14
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_10, nil, function()
		arg_5_0:RefreshHeroList(10)
		arg_5_0.stateCtrl:SetSelectedIndex(5)

		arg_5_0.btnIndex = 10
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_12, nil, function()
		arg_5_0:RefreshHeroList(12)
		arg_5_0.stateCtrl:SetSelectedIndex(6)

		arg_5_0.btnIndex = 12
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_6, nil, function()
		arg_5_0:RefreshHeroList(6)
		arg_5_0.stateCtrl:SetSelectedIndex(7)

		arg_5_0.btnIndex = 6
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_8, nil, function()
		arg_5_0:RefreshHeroList(8)
		arg_5_0.stateCtrl:SetSelectedIndex(8)

		arg_5_0.btnIndex = 8
	end)
end

function var_0_0.SortList(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return {}
	end

	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_2 = {
			type = 6,
			id = iter_16_1
		}

		for iter_16_2, iter_16_3 in ipairs(arg_16_0.deleteList) do
			if iter_16_1 == iter_16_3 then
				var_16_2.type = 5
			end
		end

		for iter_16_4, iter_16_5 in ipairs(arg_16_0.drawList) do
			if iter_16_1 == iter_16_5 then
				var_16_2.type = 4
			end
		end

		for iter_16_6, iter_16_7 in ipairs(arg_16_0.heartList) do
			if iter_16_1 == iter_16_7 and var_16_2.type == 4 then
				var_16_2.type = 2
			elseif iter_16_1 == iter_16_7 then
				var_16_2.type = 3
			end
		end

		if iter_16_1 == arg_16_0.result_role_id then
			var_16_2.type = 1
		end

		table.insert(var_16_1, var_16_2)
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		return arg_17_0.type < arg_17_1.type
	end)

	for iter_16_8, iter_16_9 in ipairs(var_16_1) do
		table.insert(var_16_0, iter_16_9.id)
	end

	return var_16_0
end

function var_0_0.RefreshHeroList(arg_18_0, arg_18_1)
	arg_18_0.heroList = GameSetting.activity_optional_random_role_list.value

	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.heroList) do
		if HeroCfg[iter_18_1].ATK_attribute[1] == arg_18_1 then
			table.insert(var_18_0, iter_18_1)
		end
	end

	arg_18_0.heroList = arg_18_0:SortList(var_18_0)

	arg_18_0.uiList_:StartScroll(#arg_18_0.heroList)
end

function var_0_0.OnEnter(arg_19_0)
	var_0_0.super.OnEnter(arg_19_0)

	arg_19_0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	arg_19_0.deleteList = NorseSurpriseGiftReceiveData:GetDelRoleData()
	arg_19_0.drawList = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	arg_19_0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	if arg_19_0.btnIndex and arg_19_0.btnIndex >= 0 then
		arg_19_0:RefreshHeroList(arg_19_0.btnIndex)
	else
		arg_19_0.heroList = GameSetting.activity_optional_random_role_list.value
		arg_19_0.heroList = arg_19_0:SortList(arg_19_0.heroList)

		arg_19_0.uiList_:StartScroll(#arg_19_0.heroList)
		arg_19_0.stateCtrl:SetSelectedIndex(0)
	end
end

function var_0_0.OnExit(arg_20_0)
	var_0_0.super.OnExit(arg_20_0)
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.heroDataProxy then
		arg_21_0.heroDataProxy = nil
	end

	if arg_21_0.uiList_ then
		arg_21_0.uiList_:Dispose()

		arg_21_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
