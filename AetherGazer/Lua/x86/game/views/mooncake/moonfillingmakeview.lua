local var_0_0 = class("MoonFillingMakeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonFillingMakeUI"
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

	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
	arg_4_0.menuList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, MoonFillingMenuItem)
	arg_4_0.chooseMenuHandler_ = handler(arg_4_0, arg_4_0.OnChooseMenu)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.makeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not arg_5_0.curChoosedID_ then
			ShowTips("MID_AUTUMN_FESTIVAL_FILLING_MAKING_MATERIALS_SELECT")

			return
		end

		MoonCakeAction.MakeFilling(arg_5_0.activityID_, arg_5_0.curChoosedID_, arg_5_0.curTimes_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.addBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0.curTimes_ = arg_5_0.curTimes_ + 1

		arg_5_0:RefreshMakePanel()
	end)
	arg_5_0:AddBtnListener(arg_5_0.subBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0.curTimes_ = arg_5_0.curTimes_ - 1

		arg_5_0:RefreshMakePanel()
	end)
	arg_5_0:AddBtnListener(arg_5_0.maxBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0.curTimes_ = arg_5_0.maxTimes_

		arg_5_0:RefreshMakePanel()
	end)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.menuList_:Dispose()

	arg_11_0.menuList_ = nil
	arg_11_0.chooseMenuHandler_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.activityID

	arg_12_0:RefreshUI()

	arg_12_0.materialAnim_.enabled = false
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0.curChoosedID_ = nil
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0.statusController_:SetSelectedState("none")
	arg_14_0:RefreshMenu()
end

function var_0_0.RefreshMenu(arg_15_0)
	arg_15_0.fillingIdList_ = MoonCakeTools.GetSortedFilling(arg_15_0.activityID_)

	arg_15_0.menuList_:StartScroll(#arg_15_0.fillingIdList_)
end

function var_0_0.RefreshMakePanel(arg_16_0)
	arg_16_0:RefreshMultiBtn()
	arg_16_0:RefreshMaterial()

	arg_16_0.curTimesText_.text = arg_16_0.curTimes_
	arg_16_0.makeBtn_.interactable = arg_16_0.curTimes_ > 0

	local var_16_0 = MoonCakeFillingCfg[arg_16_0.curChoosedID_].patties

	arg_16_0.chooseFillingIcon_.sprite = ItemTools.getItemSprite(var_16_0)
	arg_16_0.chooseFillingNameText_.text = ItemTools.getItemName(var_16_0)
	arg_16_0.chooseFillingNum_.text = string.format(GetTips("ALREADY_HAVE_COUNT"), ItemTools.getItemNum(var_16_0))
end

function var_0_0.RefreshMultiBtn(arg_17_0)
	arg_17_0.subBtn_.interactable = arg_17_0.curTimes_ > arg_17_0.minTimes_
	arg_17_0.addBtn_.interactable = arg_17_0.curTimes_ < arg_17_0.maxTimes_
	arg_17_0.maxBtn_.interactable = arg_17_0.curTimes_ < arg_17_0.maxTimes_
end

function var_0_0.RefreshMaterial(arg_18_0)
	local var_18_0 = MoonCakeFillingCfg[arg_18_0.curChoosedID_].recipe

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		arg_18_0[string.format("materialIcon%d_", iter_18_0)].sprite = ItemTools.getItemSprite(iter_18_1[1])
		arg_18_0[string.format("materialNum%d_", iter_18_0)].text = "X" .. iter_18_1[2] * arg_18_0.curTimes_
	end
end

function var_0_0.IndexItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.fillingIdList_[arg_19_1]

	arg_19_2:SetData(var_19_0, arg_19_0.activityID_)
	arg_19_2:SetChooseHandler(arg_19_0.chooseMenuHandler_)
end

function var_0_0.OnChooseMenu(arg_20_0, arg_20_1)
	if arg_20_0.curChoosedID_ == arg_20_1 then
		return
	end

	arg_20_0.statusController_:SetSelectedState("select")

	local var_20_0 = arg_20_0.curChoosedID_ == arg_20_1

	arg_20_0.curChoosedID_ = arg_20_1

	local var_20_1 = arg_20_0.menuList_:GetItemList()

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		iter_20_1:SetSelect(arg_20_1)
	end

	arg_20_0.maxTimes_, arg_20_0.minTimes_ = MoonCakeTools.GetFillingMultiTimes(arg_20_0.curChoosedID_)
	arg_20_0.curTimes_ = arg_20_0.minTimes_

	arg_20_0:RefreshMakePanel()

	if not var_20_0 then
		arg_20_0.materialAnim_.enabled = true

		arg_20_0.materialAnim_:Play("Fx_icon_cx", -1, 0)
		arg_20_0.materialAnim_:Update(0)
	end
end

function var_0_0.OnMoonCakeFillingMade(arg_21_0)
	arg_21_0.maxTimes_, arg_21_0.minTimes_ = MoonCakeTools.GetFillingMultiTimes(arg_21_0.curChoosedID_)

	if arg_21_0.minTimes_ > 0 then
		arg_21_0.curTimes_ = arg_21_0.minTimes_

		arg_21_0:RefreshMakePanel()

		local var_21_0 = table.indexof(arg_21_0.fillingIdList_)

		arg_21_0.menuList_:StartScroll(#arg_21_0.fillingIdList_, var_21_0)
	else
		arg_21_0:RefreshUI()

		arg_21_0.curChoosedID_ = nil

		local var_21_1 = arg_21_0.menuList_:GetItemList()

		for iter_21_0, iter_21_1 in ipairs(var_21_1) do
			iter_21_1:SetSelect(nil)
		end
	end
end

function var_0_0.BindRedPoint(arg_22_0)
	return
end

function var_0_0.UnBindRedPoint(arg_23_0)
	return
end

return var_0_0
