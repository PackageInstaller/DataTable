local var_0_0 = class("AutoChessDesireDatailPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/TradingCard/Activity_AutoChess_WishCheckPopUI"
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
	arg_4_0.friendController_ = arg_4_0.controller_:GetController("friendBtn")
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
		selectCard = 0,
		playerId = arg_6_1.PlayerID,
		cardId = arg_6_1.CardID,
		blessId = arg_6_1.BlessID == 0 and var_6_0[1] or arg_6_1.BlessID,
		otherList = {
			arg_6_1.CardList[1] or 0,
			arg_6_1.CardList[2] or 0,
			arg_6_1.CardList[3] or 0
		},
		selectBlessId = var_6_0[1]
	}
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		if arg_7_0.okHandler_ then
			arg_7_0.okHandler_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.editDesireBtn_, nil, function()
		if arg_7_0.cancelHandler_ then
			arg_7_0.cancelHandler_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.publishDesireBtn_, nil, function()
		if arg_7_0.okHandler_ then
			arg_7_0.okHandler_()
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
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		if arg_7_0.maskHandler_ then
			arg_7_0.maskHandler_()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.openSelectBtn_, nil, function()
		if arg_7_0.dropDownController_:GetSelectedState() == "show" then
			arg_7_0.dropDownController_:SetSelectedState("hide")
		else
			arg_7_0.dropDownController_:SetSelectedState("show")

			for iter_16_0, iter_16_1 in ipairs(arg_7_0.desireBlessItemList_) do
				if arg_7_0.mode_ then
					iter_16_1:SetState(arg_7_0.context.selectBlessId)
				else
					iter_16_1:SetState(arg_7_0.context.blessId)
				end
			end
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnAddFriend_, nil, function()
		arg_7_0.dropDownController_:SetSelectedState("hide")

		if FriendsData:IsFriend(arg_7_0.context.playerId) then
			AutoChessCardTools.JumpChatPage(arg_7_0.context.playerId)
		else
			if FriendsData:IsRequesting(arg_7_0.context.playerId) then
				FriendsAction:TryToDealRequest(arg_7_0.context.playerId, 1)
				arg_7_0.friendController_:SetSelectedState("message")

				return
			end

			if FriendsData:IsInRequest(arg_7_0.context.playerId) then
				return
			end

			if FriendsData:IsCanBeFriend(arg_7_0.context.playerId) then
				FriendsAction:TryToRequestToFriend(arg_7_0.context.playerId, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)
				arg_7_0.friendController_:SetSelectedState("gou")
			end
		end
	end)
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0.dropDownController_:SetSelectedState("hide")
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.onUpdateSelectCard = nil
	arg_19_0.index_ = arg_19_0.params_.index
	arg_19_0.mode_ = arg_19_0.params_.mode

	if arg_19_0.mode_ ~= AutoChessCardConst.DESIRE_TYPE.MY then
		local var_19_0

		if arg_19_0.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND then
			var_19_0 = AutoChessCardData:GetFriendDesire(arg_19_0.index_)
		elseif arg_19_0.mode_ == AutoChessCardConst.DESIRE_TYPE.CHAT then
			var_19_0 = AutoChessCardData:GetChatDesire()
		else
			var_19_0 = AutoChessCardData:GetOtherDesire(arg_19_0.index_)
		end

		arg_19_0:UpdateDesireInfo(var_19_0)
		arg_19_0.needDesireItem_:RefreshHead(var_19_0.Icon, var_19_0.Level, var_19_0.NickName)

		arg_19_0.okHandler_ = handler(arg_19_0, arg_19_0.OnCompleteDesire)
		arg_19_0.cancelHandler_ = handler(arg_19_0, arg_19_0.OnCancelDesire)
		arg_19_0.maskHandler_ = handler(arg_19_0, arg_19_0.OnCancelDesire)
		arg_19_0.addMyBtnHandle_ = handler(arg_19_0, arg_19_0.OnMyCardDisabled)
		arg_19_0.addNeedBtn1Handle_ = handler(arg_19_0, function()
			arg_19_0:OnSelectNeedCard(1)
		end)
		arg_19_0.addNeedBtn2Handle_ = handler(arg_19_0, function()
			arg_19_0:OnSelectNeedCard(2)
		end)
		arg_19_0.addNeedBtn3Handle_ = handler(arg_19_0, function()
			arg_19_0:OnSelectNeedCard(3)
		end)

		arg_19_0.popStateController_:SetSelectedState("other")

		arg_19_0.txtSelectBless_.text = GetTips(arg_19_0.context.selectBlessId)

		arg_19_0.needDesireItem_:SetOwnNumState(2)

		if FriendsData:IsFriend(arg_19_0.context.playerId) then
			arg_19_0.friendController_:SetSelectedState("messag")
		elseif FriendsData:IsInRequest(arg_19_0.context.playerId) then
			arg_19_0.friendController_:SetSelectedState("gou")
		else
			arg_19_0.friendController_:SetSelectedState("add")
		end
	else
		local var_19_1 = AutoChessCardData:GetDesireInfo()

		arg_19_0.isEdit_ = false
		arg_19_0.okHandler_ = handler(arg_19_0, arg_19_0.onPublishDesire)
		arg_19_0.cancelHandler_ = handler(arg_19_0, arg_19_0.OnEditDesire)
		arg_19_0.maskHandler_ = handler(arg_19_0, arg_19_0.OnCancelDesire)

		arg_19_0.popStateController_:SetSelectedState("me")

		local var_19_2 = PlayerData:GetPlayerInfo()

		arg_19_0.needDesireItem_:RefreshHead(var_19_2.portrait, AutoChessCardData:GetRankScore(), var_19_2.nick)

		arg_19_0.addMyBtnHandle_ = handler(arg_19_0, arg_19_0.OnMyCardDisabled)
		arg_19_0.addNeedBtn1Handle_ = handler(arg_19_0, arg_19_0.OnMyCardDisabled)
		arg_19_0.addNeedBtn2Handle_ = handler(arg_19_0, arg_19_0.OnMyCardDisabled)
		arg_19_0.addNeedBtn3Handle_ = handler(arg_19_0, arg_19_0.OnMyCardDisabled)

		if AutoChessCardData:GetCardNum(var_19_1.CardID) > 0 then
			arg_19_0.needDesireItem_:SetOwnNumState(0)
		else
			arg_19_0.needDesireItem_:SetOwnNumState(1)
		end

		arg_19_0:UpdateDesireInfo(var_19_1)

		arg_19_0.txtSelectBless_.text = GetTips(arg_19_0.context.blessId)
	end
end

function var_0_0.OnTop(arg_23_0)
	return
end

function var_0_0.UpdateDesireInfo(arg_24_0, arg_24_1)
	arg_24_0:BuildContext(arg_24_1)
	arg_24_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_25_0)
	arg_25_0.txtBless_.text = GetTips(arg_25_0.context.blessId)

	local var_25_0 = arg_25_0.mode_ ~= AutoChessCardConst.DESIRE_TYPE.MY

	arg_25_0.needDesireItem_:SetData(arg_25_0.context.cardId, arg_25_0.URFactoryItem_:GetItem(arg_25_0.context.cardId))
	arg_25_0.needDesireItem_:SetWishState(0)

	if arg_25_0.context.cardId == 0 then
		arg_25_0.needDesireItem_:SetEmptyState(1)
	else
		arg_25_0.needDesireItem_:SetEmptyState(0)

		if AutoChessCardData:GetCardNum(arg_25_0.context.cardId) <= 1 and var_25_0 then
			arg_25_0.needDesireItem_:SetGreyState(true)
		else
			arg_25_0.needDesireItem_:SetGreyState(false)
		end
	end

	for iter_25_0 = 1, 3 do
		arg_25_0.desireItemList_[iter_25_0]:SetOwnNumState(0)
		arg_25_0.desireItemList_[iter_25_0]:SetSelectState(false)
		arg_25_0.desireItemList_[iter_25_0]:SetData(arg_25_0.context.otherList[iter_25_0], arg_25_0.URFactoryItem_:GetItem(arg_25_0.context.otherList[iter_25_0]))
		arg_25_0.desireItemList_[iter_25_0]:RefreshWishState(var_25_0)

		if arg_25_0.context.otherList[iter_25_0] == 0 and not arg_25_0.isEdit_ then
			arg_25_0.desireItemList_[iter_25_0]:SetActive(false)
		else
			arg_25_0.desireItemList_[iter_25_0]:SetActive(true)

			if arg_25_0.context.otherList[iter_25_0] == 0 then
				if arg_25_0.context.cardId == 0 then
					arg_25_0.desireItemList_[iter_25_0]:SetEmptyState(2)
				else
					arg_25_0.desireItemList_[iter_25_0]:SetEmptyState(1)
				end
			else
				arg_25_0.desireItemList_[iter_25_0]:SetEmptyState(0)
			end
		end
	end

	if arg_25_0.context.selectCard == 0 or AutoChessCardData:GetCardNum(arg_25_0.context.cardId) <= 1 then
		arg_25_0.btnGreyController_:SetSelectedState("grey")
	else
		arg_25_0.btnGreyController_:SetSelectedState("normal")
	end
end

function var_0_0.OnCompleteDesire(arg_26_0)
	if AutoChessCardData:GetCardNum(arg_26_0.context.cardId) <= 1 then
		ShowTips(GetTips("AUTO_CHESS_2_EXCHANGE_INSUFFICIENT_CARD"))

		return
	end

	if arg_26_0.context.selectBlessId == 0 then
		return
	end

	if arg_26_0.context.selectCard == 0 then
		return
	end

	AutoChessCardAction.CompleteDesire(arg_26_0.context, arg_26_0.index_, arg_26_0.mode_)
end

function var_0_0.OnCancelDesire(arg_27_0)
	arg_27_0:Back()
end

function var_0_0.onEditCancelDesire(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.context.otherList) do
		if iter_28_1 ~= 0 then
			AutoChessCardData:AddCardNum(iter_28_1, -1)
		end
	end

	arg_28_0:Back()
end

function var_0_0.onPublishDesire(arg_29_0)
	local var_29_0 = AutoChessCardData:GetLastShareTimestamp()

	if manager.time:GetServerTime() - var_29_0 <= GameSetting.auto_chess_2_chat_send_cd.value[1] then
		ShowTips(GetTips("ERROR_CHAT_WORD_TOO_FREQUENTLY"))

		return
	end

	AutoChessCardAction.PublishDesire()
end

function var_0_0.OnEditDesire(arg_30_0)
	JumpTools.Back()
	JumpTools.OpenPageByJump("autoChessEditDesireDatailPopView")
end

function var_0_0.OnMyCardDisabled(arg_31_0)
	arg_31_0.dropDownController_:SetSelectedState("hide")
end

function var_0_0.OnSelectNeedCard(arg_32_0, arg_32_1)
	arg_32_0.dropDownController_:SetSelectedState("hide")

	if arg_32_0.context.selectCard ~= 0 then
		arg_32_0.desireItemList_[arg_32_0.context.selectCard]:SetSelectState(false)
	end

	arg_32_0.context.selectCard = arg_32_1

	arg_32_0.desireItemList_[arg_32_1]:SetSelectState(true)

	if AutoChessCardData:GetCardNum(arg_32_0.context.cardId) <= 1 then
		arg_32_0.btnGreyController_:SetSelectedState("grey")
	else
		arg_32_0.btnGreyController_:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.desireBlessItemList_) do
		iter_33_1:Dispose()
	end

	arg_33_0.needDesireItem_:Dispose()

	for iter_33_2 = 1, 3 do
		arg_33_0.desireItemList_[iter_33_2]:Dispose()
	end

	arg_33_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
