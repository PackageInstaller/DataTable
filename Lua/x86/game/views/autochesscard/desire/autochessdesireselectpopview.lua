local var_0_0 = class("AutoChessDesireSelectPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishSetPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, AutoChessCardNumItem)
	arg_4_0.stateController_ = arg_4_0.controller_:GetController("state")
	arg_4_0.wishController_ = arg_4_0.wishController_:GetController("switch")
	arg_4_0.btnGreyController_ = arg_4_0.btnController_:GetController("grey")
	arg_4_0.data_ = {}
	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.canSelectList_[arg_5_1]
	local var_5_1 = table.indexof(arg_5_0.selectList_, var_5_0) ~= false

	arg_5_2:SetData(var_5_0, var_5_1, arg_5_0.URFactoryItem_:GetItem(var_5_0))
	arg_5_2:SetSelectHandler(handler(arg_5_0, arg_5_0.OnSelectItem))

	if arg_5_0.params_.mode == 1 then
		if AutoChessCardData:GetCardNum(var_5_0) > 0 then
			arg_5_2:SetOwnNumState("hide")
		else
			arg_5_2:SetOwnNumState("none")
		end
	else
		arg_5_2:SetOwnNumState("own")
	end
end

function var_0_0.OnSelectItem(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 then
		local var_6_0 = 0

		if (arg_6_0.params_.mode == 1 and 1 or 3) <= #arg_6_0.selectList_ then
			table.remove(arg_6_0.selectList_, 1)
			table.insert(arg_6_0.selectList_, arg_6_2)
		else
			table.insert(arg_6_0.selectList_, arg_6_2)
		end
	else
		table.remove(arg_6_0.selectList_, table.indexof(arg_6_0.selectList_, arg_6_2))
	end

	arg_6_0.list_:Refresh()
	arg_6_0:RefreshSelectNum()
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		return
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		if arg_7_0.okhandle then
			arg_7_0.okhandle()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
			type = arg_7_0.params_.mode,
			selectList = arg_7_0.params_.selectCard
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
			type = arg_7_0.params_.mode,
			selectList = arg_7_0.params_.selectCard
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.uRBtn_, nil, function()
		if arg_7_0.rareType_ == AutoChessCardConst.CARD_TYPE.UR then
			return
		end

		arg_7_0:RefreshRareList(AutoChessCardConst.CARD_TYPE.UR)
	end)
	arg_7_0:AddBtnListener(arg_7_0.rBtn_, nil, function()
		if arg_7_0.rareType_ == AutoChessCardConst.CARD_TYPE.R then
			return
		end

		arg_7_0:RefreshRareList(AutoChessCardConst.CARD_TYPE.R)
	end)
	arg_7_0:AddBtnListener(arg_7_0.srBtn_, nil, function()
		if arg_7_0.rareType_ == AutoChessCardConst.CARD_TYPE.SR then
			return
		end

		arg_7_0:RefreshRareList(AutoChessCardConst.CARD_TYPE.SR)
	end)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.selectList_ = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.params_.selectCard) do
		table.insert(arg_15_0.selectList_, iter_15_1)
	end

	arg_15_0:RefreshUI()
end

function var_0_0.onChangeMyCard(arg_16_0)
	if #arg_16_0.selectList_ ~= 1 then
		return
	end

	JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
		type = arg_16_0.params_.mode,
		selectList = arg_16_0.selectList_
	})
end

function var_0_0.onChangeOtherCard(arg_17_0)
	if #arg_17_0.selectList_ < 1 or #arg_17_0.selectList_ > 3 then
		return
	end

	JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView", {
		type = arg_17_0.params_.mode,
		selectList = arg_17_0.selectList_
	})
end

function var_0_0.RefreshSelectNum(arg_18_0)
	if arg_18_0.params_.mode == 1 then
		if #arg_18_0.selectList_ == 1 then
			arg_18_0.btnGreyController_:SetSelectedState("normal")
		else
			arg_18_0.btnGreyController_:SetSelectedState("grey")
		end

		arg_18_0.txtWish_.text = #arg_18_0.selectList_ .. " / " .. 1
	else
		if #arg_18_0.selectList_ < 1 or #arg_18_0.selectList_ > 3 then
			arg_18_0.btnGreyController_:SetSelectedState("grey")
		else
			arg_18_0.btnGreyController_:SetSelectedState("normal")
		end

		arg_18_0.txtOffer_.text = #arg_18_0.selectList_ .. " / " .. 3
	end
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:RefreshSelectNum()

	arg_19_0.txtUR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.UR])
	arg_19_0.txtSR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.SR])
	arg_19_0.txtR_.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardConst.CARD_TYPE.R])

	if arg_19_0.params_.mode == 1 then
		arg_19_0.stateController_:SetSelectedState("setWish")

		arg_19_0.okhandle = handler(arg_19_0, arg_19_0.onChangeMyCard)

		local var_19_0 = arg_19_0.selectList_[1]
		local var_19_1 = AutoChessCardCfg[var_19_0]
		local var_19_2 = var_19_1 and var_19_1.type or AutoChessCardConst.CARD_TYPE.UR

		arg_19_0:RefreshRareList(var_19_2)
	else
		arg_19_0.stateController_:SetSelectedState("setOffer")

		arg_19_0.okhandle = handler(arg_19_0, arg_19_0.onChangeOtherCard)

		local var_19_3 = arg_19_0.params_.myCardId
		local var_19_4 = AutoChessCardCfg[var_19_3]
		local var_19_5 = AutoChessCardData:GetCardList()

		arg_19_0.canSelectList_ = {}

		local var_19_6 = AutoChessCardData:GetDesireInfo()

		for iter_19_0, iter_19_1 in pairs(var_19_5) do
			local var_19_7 = AutoChessCardCfg[iter_19_0]

			if table.indexof(var_19_6.CardList, iter_19_0) then
				iter_19_1 = iter_19_1 + 1
			end

			if iter_19_1 > 1 and var_19_7.type == var_19_4.type and var_19_3 ~= iter_19_0 then
				table.insert(arg_19_0.canSelectList_, iter_19_0)
			end
		end

		local var_19_8 = arg_19_0.selectList_[1]
		local var_19_9 = var_19_8 and table.indexof(arg_19_0.canSelectList_, var_19_8) or 1

		arg_19_0.list_:StartScroll(#arg_19_0.canSelectList_, var_19_9)
	end
end

function var_0_0.RefreshRareList(arg_20_0, arg_20_1)
	arg_20_0.rareType_ = arg_20_1

	arg_20_0.wishController_:SetSelectedIndex(arg_20_0.rareType_ - 1)

	arg_20_0.canSelectList_ = {}

	for iter_20_0, iter_20_1 in ipairs(AutoChessCardCfg.get_id_list_by_type_is_card_pool[arg_20_0.rareType_][1]) do
		table.insert(arg_20_0.canSelectList_, iter_20_1)
	end

	table.sort(arg_20_0.canSelectList_, function(arg_21_0, arg_21_1)
		if AutoChessCardData:GetCardNum(arg_21_0) == AutoChessCardData:GetCardNum(arg_21_1) then
			return arg_21_0 < arg_21_1
		end

		return AutoChessCardData:GetCardNum(arg_21_0) < AutoChessCardData:GetCardNum(arg_21_1)
	end)

	local var_20_0 = arg_20_0.selectList_[1]
	local var_20_1 = var_20_0 and table.indexof(arg_20_0.canSelectList_, var_20_0) or 1

	arg_20_0.list_:StartScroll(#arg_20_0.canSelectList_, var_20_1)
end

function var_0_0.OnExit(arg_22_0)
	return
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.list_ then
		arg_23_0.list_:Dispose()

		arg_23_0.list_ = nil
	end

	arg_23_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
