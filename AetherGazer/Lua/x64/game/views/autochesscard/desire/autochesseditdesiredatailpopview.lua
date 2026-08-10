local var_0_0 = class("AutoChessEditDesireDatailPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.needDesireItem_ = AutoChessDesireItem.New(arg_4_0.cardGo_)
	arg_4_0.desireItemList_ = {}

	for iter_4_0 = 1, 3 do
		table.insert(arg_4_0.desireItemList_, AutoChessDesireItem.New(arg_4_0["cardGo" .. iter_4_0 .. "_"]))
	end

	arg_4_0.okHandler_ = nil
	arg_4_0.cancelHandler_ = nil
	arg_4_0.popStateController_ = arg_4_0.controller_:GetController("popState")
	arg_4_0.dropDownController_ = arg_4_0.controller_:GetController("dropDown")
	arg_4_0.btnGreyController_ = arg_4_0.btnController_:GetController("grey")
	arg_4_0.desireBlessItemList_ = {}

	local var_4_0 = GameSetting.auto_chess_2_wish_texts.value

	for iter_4_1, iter_4_2 in ipairs(var_4_0) do
		local var_4_1 = Object.Instantiate(arg_4_0.blessGo_, arg_4_0.blessTrans_)
		local var_4_2 = AutoChessDesireBlessItem.New(var_4_1, handler(arg_4_0, arg_4_0.onSelectBlessItem))

		var_4_2:SetData(iter_4_2)
		var_4_2:SetActive(true)
		table.insert(arg_4_0.desireBlessItemList_, var_4_2)
	end

	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
end

function var_0_0.onSelectBlessItem(arg_5_0, arg_5_1)
	arg_5_0.dropDownController_:SetSelectedState("hide")

	arg_5_0.txtSelectBless_.text = GetTips(arg_5_1)

	if arg_5_0.mode_ then
		arg_5_0.context.selectBlessId = arg_5_1
	else
		arg_5_0.context.blessId = arg_5_1
	end
end

function var_0_0.BuildContext(arg_6_0, arg_6_1)
	local var_6_0 = GameSetting.auto_chess_2_wish_texts.value

	arg_6_0.context = {
		playerId = arg_6_1.PlayerID,
		cardId = arg_6_1.CardID,
		blessId = arg_6_1.BlessID == 0 and var_6_0[1] or arg_6_1.BlessID,
		otherList = {
			arg_6_1.CardList[1] or 0,
			arg_6_1.CardList[2] or 0,
			arg_6_1.CardList[3] or 0
		}
	}
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		if arg_7_0.okHandler_ then
			arg_7_0.okHandler_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		if arg_7_0.cancelHandler_ then
			arg_7_0.cancelHandler_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.addMyBtn_, nil, function()
		if arg_7_0.addMyBtnHandle_ then
			arg_7_0.addMyBtnHandle_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.addNeedBtn1_, nil, function()
		if arg_7_0.addNeedBtn1Handle_ then
			arg_7_0.addNeedBtn1Handle_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.addNeedBtn2_, nil, function()
		if arg_7_0.addNeedBtn2Handle_ then
			arg_7_0.addNeedBtn2Handle_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.addNeedBtn3_, nil, function()
		if arg_7_0.addNeedBtn3Handle_ then
			arg_7_0.addNeedBtn3Handle_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.openSelectBtn_, nil, function()
		if arg_7_0.dropDownController_:GetSelectedState() == "show" then
			arg_7_0.dropDownController_:SetSelectedState("hide")
		else
			arg_7_0.dropDownController_:SetSelectedState("show")

			for iter_14_0, iter_14_1 in ipairs(arg_7_0.desireBlessItemList_) do
				if arg_7_0.mode_ then
					iter_14_1:SetState(arg_7_0.context.selectBlessId)
				else
					iter_14_1:SetState(arg_7_0.context.blessId)
				end
			end
		end
	end)
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.dropDownController_:SetSelectedState("hide")
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.onUpdateSelectCard = nil

	local var_16_0 = AutoChessCardData:GetDesireInfo()
	local var_16_1
	local var_16_2 = var_16_0.CardID == 0 and 0 or 1

	arg_16_0.popStateController_:SetSelectedState("myWish")

	arg_16_0.okHandler_ = handler(arg_16_0, function()
		arg_16_0:onEditConfirmDesire(var_16_2)
	end)
	arg_16_0.cancelHandler_ = handler(arg_16_0, arg_16_0.OnCancelDesire)
	arg_16_0.addMyBtnHandle_ = handler(arg_16_0, arg_16_0.OnAddMyCard)
	arg_16_0.addNeedBtn1Handle_ = handler(arg_16_0, arg_16_0.OnAddProvideCard)
	arg_16_0.addNeedBtn2Handle_ = handler(arg_16_0, arg_16_0.OnAddProvideCard)
	arg_16_0.addNeedBtn3Handle_ = handler(arg_16_0, arg_16_0.OnAddProvideCard)

	arg_16_0.needDesireItem_:SetOwnNumState(0)
	arg_16_0:UpdateDesireInfo(var_16_0)

	arg_16_0.txtSelectBless_.text = GetTips(arg_16_0.context.blessId)
end

function var_0_0.OnTop(arg_18_0)
	if arg_18_0.onUpdateSelectCard then
		arg_18_0.onUpdateSelectCard()
		arg_18_0:RefreshUI()
	end

	if arg_18_0.params_.type == 2 then
		for iter_18_0 = 1, 3 do
			if arg_18_0.context.otherList[iter_18_0] ~= 0 and not table.indexof(arg_18_0.oldOtherList, arg_18_0.context.otherList[iter_18_0]) then
				arg_18_0.desireItemList_[iter_18_0]:PlayAnim()
			end
		end
	end
end

function var_0_0.UpdateDesireInfo(arg_19_0, arg_19_1)
	arg_19_0:BuildContext(arg_19_1)
	arg_19_0:RefreshUI()
end

function var_0_0.UpdateMyCard(arg_20_0)
	local var_20_0 = arg_20_0.params_.selectList

	if var_20_0 == nil or #var_20_0 == 0 then
		return
	end

	arg_20_0.context.cardId = var_20_0[1]

	local var_20_1 = AutoChessCardCfg[arg_20_0.context.cardId]

	if AutoChessCardData:GetCardNum(arg_20_0.context.cardId) > 0 then
		arg_20_0.needDesireItem_:SetOwnNumState(0)
	else
		arg_20_0.needDesireItem_:SetOwnNumState(1)
	end

	if arg_20_0.context.otherList[1] ~= 0 and AutoChessCardCfg[arg_20_0.context.otherList[1]].type ~= var_20_1.type then
		arg_20_0.context.otherList[1] = 0
		arg_20_0.context.otherList[2] = 0
		arg_20_0.context.otherList[3] = 0
	end
end

function var_0_0.UpdateOtherCard(arg_21_0)
	local var_21_0 = arg_21_0.params_.selectList

	if var_21_0 == nil or #var_21_0 == 0 then
		return
	end

	arg_21_0.oldOtherList = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.context.otherList) do
		if iter_21_1 ~= 0 then
			table.insert(arg_21_0.oldOtherList, iter_21_1)
		end

		if var_21_0[iter_21_0] then
			local var_21_1 = var_21_0[iter_21_0]

			arg_21_0.context.otherList[iter_21_0] = var_21_0[iter_21_0]
		else
			arg_21_0.context.otherList[iter_21_0] = 0
		end
	end
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0.txtBless_.text = GetTips(arg_22_0.context.blessId)

	local var_22_0 = arg_22_0.mode_ ~= AutoChessCardConst.DESIRE_TYPE.MY

	arg_22_0.needDesireItem_:SetData(arg_22_0.context.cardId, arg_22_0.URFactoryItem_:GetItem(arg_22_0.context.cardId))
	arg_22_0.needDesireItem_:SetWishState(0)

	if arg_22_0.context.cardId == 0 then
		arg_22_0.needDesireItem_:SetEmptyState(1)
	else
		arg_22_0.needDesireItem_:SetEmptyState(0)
	end

	for iter_22_0 = 1, 3 do
		arg_22_0.desireItemList_[iter_22_0]:SetOwnNumState(0)
		arg_22_0.desireItemList_[iter_22_0]:SetSelectState(false)
		arg_22_0.desireItemList_[iter_22_0]:SetData(arg_22_0.context.otherList[iter_22_0], arg_22_0.URFactoryItem_:GetItem(arg_22_0.context.otherList[iter_22_0]))
		arg_22_0.desireItemList_[iter_22_0]:RefreshWishState(var_22_0)
		arg_22_0.desireItemList_[iter_22_0]:SetActive(true)

		if arg_22_0.context.otherList[iter_22_0] == 0 then
			if arg_22_0.context.cardId == 0 then
				arg_22_0.desireItemList_[iter_22_0]:SetEmptyState(2)
			else
				arg_22_0.desireItemList_[iter_22_0]:SetEmptyState(1)
			end
		else
			arg_22_0.desireItemList_[iter_22_0]:SetEmptyState(0)
		end
	end

	if arg_22_0.context.cardId == 0 then
		arg_22_0.btnGreyController_:SetSelectedState("grey")

		return
	end

	if arg_22_0.context.otherList[1] == 0 and arg_22_0.context.otherList[2] == 0 and arg_22_0.context.otherList[3] == 0 then
		arg_22_0.btnGreyController_:SetSelectedState("grey")

		return
	end

	arg_22_0.btnGreyController_:SetSelectedState("normal")
end

function var_0_0.onEditConfirmDesire(arg_23_0, arg_23_1)
	if arg_23_0.context.cardId == 0 then
		return
	end

	if arg_23_0.context.blessId == 0 then
		return
	end

	if arg_23_0.context.otherList[1] == 0 and arg_23_0.context.otherList[2] == 0 and arg_23_0.context.otherList[3] == 0 then
		return
	end

	AutoChessCardAction.EditDesire(arg_23_1, arg_23_0.context)
end

function var_0_0.OnCancelDesire(arg_24_0)
	arg_24_0:Back()
end

function var_0_0.OnAddMyCard(arg_25_0)
	arg_25_0.dropDownController_:SetSelectedState("hide")

	arg_25_0.onUpdateSelectCard = handler(arg_25_0, arg_25_0.UpdateMyCard)

	if arg_25_0.context.cardId == 0 then
		JumpTools.OpenPageByJump("autoChessDesireSelectPopView", {
			mode = 1,
			selectCard = {}
		})
	else
		JumpTools.OpenPageByJump("autoChessDesireSelectPopView", {
			mode = 1,
			selectCard = {
				arg_25_0.context.cardId
			}
		})
	end
end

function var_0_0.OnAddProvideCard(arg_26_0)
	arg_26_0.dropDownController_:SetSelectedState("hide")

	if arg_26_0.context.cardId == 0 then
		ShowTips(GetTips("AUTO_CHESS_2_WISH_UNSET"))

		return
	end

	arg_26_0.onUpdateSelectCard = handler(arg_26_0, arg_26_0.UpdateOtherCard)

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0.context.otherList) do
		if iter_26_1 ~= 0 then
			table.insert(var_26_0, iter_26_1)
		end
	end

	JumpTools.OpenPageByJump("autoChessDesireSelectPopView", {
		mode = 2,
		selectCard = var_26_0,
		myCardId = arg_26_0.context.cardId
	})
end

function var_0_0.Dispose(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.desireBlessItemList_) do
		iter_27_1:Dispose()
	end

	arg_27_0.needDesireItem_:Dispose()

	for iter_27_2 = 1, 3 do
		arg_27_0.desireItemList_[iter_27_2]:Dispose()
	end

	arg_27_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_27_0)
end

return var_0_0
