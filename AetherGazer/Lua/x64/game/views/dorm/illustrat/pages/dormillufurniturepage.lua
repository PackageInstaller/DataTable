local var_0_0 = class("DormIlluFurniturePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitData()
	arg_1_0:InitUI()
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.allShopList_ = {}
	arg_2_0.allThemeIDList_ = {}
	arg_2_0.curState_ = 0
	arg_2_0.isBack = false
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.themeUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexThemeItem), arg_3_0.uiListGo_, DormIlluThemeItem)
	arg_3_0.furnitureUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexFurItem), arg_3_0.furnitureUiListGo_, FurnitureItem)
	arg_3_0.stateController_ = arg_3_0.mainControllerEx_:GetController("category")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		arg_4_0:ExitFurState()
	end)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.isBack = false

	if not arg_6_1 then
		arg_6_0:InitData()
	end

	arg_6_0:RefreshThemeData()
	arg_6_0:RefreshUI()

	if arg_6_1 and arg_6_0.themeID_ then
		arg_6_0.isBack = true

		arg_6_0:EnterFurState(arg_6_0.themeID_)
	else
		arg_6_0.isBack = true

		arg_6_0:ExitFurState()
	end
end

function var_0_0.Hide(arg_7_0)
	return
end

function var_0_0.RefreshThemeData(arg_8_0)
	arg_8_0.allThemeIDList_ = BackHomeFurnitureThemeCfg.all

	table.sort(arg_8_0.allThemeIDList_)
end

function var_0_0.RefreshFurData(arg_9_0, arg_9_1)
	arg_9_0.themeID_ = arg_9_1
	arg_9_0.furIDList_ = DormIlluTools.GetFurList(arg_9_1)

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.furIDList_) do
		local var_9_1 = DormData:GetFurNumInfo(iter_9_1)

		if var_9_1 and var_9_1.num > 0 then
			var_9_0 = var_9_0 + 1
		end
	end

	arg_9_0.numText_.text = string.format("%d/%d", var_9_0, #arg_9_0.furIDList_)
	arg_9_0.themeText_.text = BackHomeFurnitureThemeCfg[arg_9_1].name

	arg_9_0.furnitureUIList_:StartScroll(#arg_9_0.furIDList_)
	arg_9_0.furnitureUIList_:Refresh()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.themeUIList_:StartScroll(#arg_10_0.allThemeIDList_)
	arg_10_0.themeUIList_:Refresh()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.furIndex_ = nil
	arg_11_0.themeIndex_ = nil

	if arg_11_0.themeUIList_ then
		arg_11_0.themeUIList_:Dispose()
	end

	if arg_11_0.furnitureUIList_ then
		arg_11_0.furnitureUIList_:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.IndexThemeItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, arg_12_0.allThemeIDList_[arg_12_1])
	arg_12_2:RegistCallBack(function(arg_13_0, arg_13_1)
		arg_12_0:EnterFurState(arg_13_0, arg_13_1)
	end)
end

function var_0_0.IndexFurItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.furIDList_[arg_14_1]
	local var_14_1 = DormData:GetFurNumInfo(var_14_0)
	local var_14_2 = {
		furID = var_14_0,
		num = var_14_1.num
	}

	arg_14_2:RefreshUI(var_14_2, _, DormEnum.FurItemType.Illu, _, arg_14_1)
	arg_14_2:OnClickBtn(function(arg_15_0, arg_15_1)
		arg_14_0:OpenDetailView(arg_15_0, arg_15_1)
	end)
end

function var_0_0.EnterFurState(arg_16_0, arg_16_1, arg_16_2)
	DormRedPointTools:SetIlluNewTagRed("furNew", RedPointConst.DORM_ILLU_FUR_THEME, false, arg_16_1)

	arg_16_0.themeIndex_ = arg_16_2

	arg_16_0:RefreshFurData(arg_16_1)
	arg_16_0.stateController_:SetSelectedIndex(1)

	arg_16_0.curState_ = 1

	if arg_16_0.furIndex_ and arg_16_0.isBack then
		arg_16_0.furnitureUIList_:ScrollToIndex(arg_16_0.furIndex_)

		arg_16_0.isBack = false
	end
end

function var_0_0.ExitFurState(arg_17_0)
	arg_17_0.stateController_:SetSelectedIndex(0)

	arg_17_0.curState_ = 0

	if arg_17_0.themeIndex_ then
		arg_17_0.themeUIList_:ScrollToIndex(arg_17_0.themeIndex_)
	end
end

function var_0_0.OpenDetailView(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.furIndex_ = arg_18_2

	JumpTools.OpenPageByJump("/dormIlluFurnitureDetail", {
		furID = arg_18_1,
		themeID = arg_18_0.themeID_,
		list = arg_18_0.furIDList_
	})
end

return var_0_0
