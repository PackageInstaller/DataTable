local var_0_0 = class("NorseSurpriseGiftInStockPage", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftInStockUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, NorseSurpriseGiftInStockItem)
	arg_3_0.stateCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
	arg_3_0.btnCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("choosebtn")
	arg_3_0.sortList = {}
	arg_3_0.isSel = {}
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	HeroLongHead.SetProxy(arg_4_2, arg_4_0.heroDataProxy)
	arg_4_2:SetData(arg_4_0.heroList[arg_4_1])

	arg_4_2.isChoose = arg_4_0.isSel[arg_4_1]

	arg_4_2:SetChoose(arg_4_0.sortList)
	arg_4_2:RegistCallBack(function(arg_5_0)
		arg_4_0.scroPos = arg_4_0.uiList_:GetScrolledPosition()

		if arg_4_2.isChoose == 1 then
			arg_4_2.isChoose = 0

			local var_5_0 = {}

			for iter_5_0, iter_5_1 in ipairs(arg_4_0.sortList) do
				if iter_5_1.id ~= arg_5_0 then
					table.insert(var_5_0, iter_5_1)
				end
			end

			arg_4_0.sortList = var_5_0
		elseif arg_4_0.sortList and #arg_4_0.sortList >= 6 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_1")
		else
			arg_4_2.isChoose = 1

			local var_5_1 = {
				id = arg_5_0,
				flag = arg_4_2.isChoose
			}

			table.insert(arg_4_0.sortList, var_5_1)
		end

		arg_4_0.isSel[arg_4_1] = arg_4_2.isChoose

		arg_4_0.uiList_:StartScroll(#arg_4_0.heroList)
		arg_4_0.uiList_:SetScrolledPosition(arg_4_0.scroPos)
		arg_4_0:RefreshChooseBtn()
	end)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_choose, nil, function()
		if #arg_6_0.sortList == 6 then
			JumpTools.OpenPageByJump("norseSurpriseGiftChooseAgainPage", {
				sortList = arg_6_0.sortList
			})
		else
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_2")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnClose_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnAll_, nil, function()
		arg_6_0.heroList = GameSetting.activity_optional_random_role_list.value

		arg_6_0.uiList_:StartScroll(#arg_6_0.heroList)
		arg_6_0.stateCtrl:SetSelectedIndex(0)

		arg_6_0.btnIndex = -1
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_0, nil, function()
		arg_6_0:RefreshHeroList(0)
		arg_6_0.stateCtrl:SetSelectedIndex(1)

		arg_6_0.btnIndex = 0
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_2, nil, function()
		arg_6_0:RefreshHeroList(2)
		arg_6_0.stateCtrl:SetSelectedIndex(2)

		arg_6_0.btnIndex = 2
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_4, nil, function()
		arg_6_0:RefreshHeroList(4)
		arg_6_0.stateCtrl:SetSelectedIndex(3)

		arg_6_0.btnIndex = 4
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_14, nil, function()
		arg_6_0:RefreshHeroList(14)
		arg_6_0.stateCtrl:SetSelectedIndex(4)

		arg_6_0.btnIndex = 14
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_10, nil, function()
		arg_6_0:RefreshHeroList(10)
		arg_6_0.stateCtrl:SetSelectedIndex(5)

		arg_6_0.btnIndex = 10
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_12, nil, function()
		arg_6_0:RefreshHeroList(12)
		arg_6_0.stateCtrl:SetSelectedIndex(6)

		arg_6_0.btnIndex = 12
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_6, nil, function()
		arg_6_0:RefreshHeroList(6)
		arg_6_0.stateCtrl:SetSelectedIndex(7)

		arg_6_0.btnIndex = 6
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_8, nil, function()
		arg_6_0:RefreshHeroList(8)
		arg_6_0.stateCtrl:SetSelectedIndex(8)

		arg_6_0.btnIndex = 8
	end)
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

	arg_18_0.heroList = var_18_0

	arg_18_0.uiList_:StartScroll(#var_18_0)
end

function var_0_0.OnEnter(arg_19_0)
	var_0_0.super.OnEnter(arg_19_0)

	arg_19_0.sortList = {}
	arg_19_0.isSel = {}
	arg_19_0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	arg_19_0:RefreshView()

	if arg_19_0.btnIndex and arg_19_0.btnIndex >= 0 then
		arg_19_0:RefreshHeroList(arg_19_0.btnIndex)
	else
		arg_19_0.heroList = GameSetting.activity_optional_random_role_list.value

		arg_19_0.uiList_:StartScroll(#arg_19_0.heroList)
		arg_19_0.stateCtrl:SetSelectedIndex(0)
	end
end

function var_0_0.RefreshView(arg_20_0)
	arg_20_0.btnCtrl:SetSelectedState("false")

	arg_20_0.chooseTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_2")
	arg_20_0.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_3")
end

function var_0_0.RefreshChooseBtn(arg_21_0)
	if #arg_21_0.sortList == 6 then
		arg_21_0.btnCtrl:SetSelectedState("true")
	else
		arg_21_0.btnCtrl:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_22_0)
	var_0_0.super.OnExit(arg_22_0)
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.heroDataProxy then
		arg_23_0.heroDataProxy = nil
	end

	if arg_23_0.uiList_ then
		arg_23_0.uiList_:Dispose()

		arg_23_0.uiList_ = nil
	end

	if arg_23_0.heartList then
		arg_23_0.heartList = nil
	end

	if arg_23_0.heroList then
		arg_23_0.heroList = nil
	end

	if arg_23_0.sortList then
		arg_23_0.sortList = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
