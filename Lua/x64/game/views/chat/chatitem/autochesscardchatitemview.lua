local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("AutoChessCardChatItemView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
	arg_2_0:Show(true)
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
	arg_3_0.needDesireItem_ = AutoChessCardChatItem.New(arg_3_0.cardGo_)
	arg_3_0.desireItemList_ = {}

	for iter_3_0 = 1, 3 do
		table.insert(arg_3_0.desireItemList_, AutoChessCardChatItem.New(arg_3_0["cardGo" .. iter_3_0 .. "_"]))
	end

	arg_3_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_3_0.URItemGo_)
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0.commonPortrait_:RegisteClickCallback(function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0.itemData_.userId)
	end)
	arg_4_0:AddBtnListener(arg_4_0.jumpBtn_, nil, function()
		arg_4_0:OnClickCard()
	end)
	arg_4_0:AddBtnListener(arg_4_0.buttonContent_, nil, function()
		arg_4_0:OnClickCard()
	end)
end

function var_0_1.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.itemData_ = arg_8_1
	arg_8_0.jumpLink_ = arg_8_1.jumpLink
	arg_8_0.index_ = arg_8_2

	if arg_8_1.userId == USER_ID then
		local var_8_0 = PlayerData:GetPlayerInfo()

		arg_8_0.textName_.text = var_8_0.nick

		arg_8_0.commonPortrait_:RenderHead(var_8_0.portrait)
		arg_8_0.commonPortrait_:RenderFrame(var_8_0.icon_frame)
	else
		arg_8_0.textName_.text = arg_8_1.nick

		arg_8_0.commonPortrait_:RenderHead(arg_8_1.icon)
		arg_8_0.commonPortrait_:RenderFrame(arg_8_1.iconFrame)
	end

	arg_8_0.needDesireItem_:SetData(arg_8_1.myCardId, arg_8_0.URFactoryItem_:GetItem(arg_8_1.myCardId))
	arg_8_0.needDesireItem_:SetClickHandler(handler(arg_8_0, arg_8_0.OnClickCard))

	for iter_8_0 = 1, 3 do
		if arg_8_1.otherCardList[iter_8_0] then
			arg_8_0.desireItemList_[iter_8_0]:SetData(arg_8_1.otherCardList[iter_8_0], arg_8_0.URFactoryItem_:GetItem(arg_8_1.otherCardList[iter_8_0]))
			arg_8_0.desireItemList_[iter_8_0]:SetActive(true)
		else
			arg_8_0.desireItemList_[iter_8_0]:SetActive(false)
		end

		arg_8_0.desireItemList_[iter_8_0]:SetClickHandler(handler(arg_8_0, arg_8_0.OnClickCard))
	end

	arg_8_0:Show(true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.transform_)
	arg_8_0:SetIP(arg_8_1)
end

function var_0_1.OnClickCard(arg_9_0)
	if arg_9_0.itemData_.userId == USER_ID then
		return
	end

	if FriendsData:IsFriend(arg_9_0.itemData_.userId) then
		if GameSetting.auto_chess_2_exchange_friend_times.value[1] <= AutoChessCardData:GetFriendExchangeCardNum() then
			ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO_AMIGO")

			return
		end
	elseif GameSetting.auto_chess_2_exchange_stranger_times.value[1] <= AutoChessCardData:GetOtherExchangeCardNum() then
		ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO")

		return
	end

	AutoChessCardAction.RequestViewPlayerDesire(arg_9_0.itemData_.id, arg_9_0.itemData_.userId)
end

function var_0_1.SetIP(arg_10_0, arg_10_1)
	if not arg_10_0.ipGo_ then
		return
	end

	arg_10_0.ip_.text = arg_10_1.ip

	SetActive(arg_10_0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if arg_10_0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.ipGo_.transform)
	end
end

function var_0_1.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_1.SetAsLastSibling(arg_12_0)
	arg_12_0.transform_:SetAsLastSibling()
end

function var_0_1.SetAsFirstSibling(arg_13_0)
	arg_13_0.transform_:SetAsFirstSibling()
end

function var_0_1.GetNick(arg_14_0)
	return arg_14_0.itemData_.nick
end

function var_0_1.CalcOffsetX(arg_15_0)
	local var_15_0 = arg_15_0.rectBg_.rect.width

	return arg_15_0.rectReportParent_:InverseTransformPoint(arg_15_0.rectBg_:TransformPoint(Vector3(var_15_0 / 2, 0, 0))).x - 250
end

function var_0_1.CalcOffsetY(arg_16_0)
	local var_16_0 = arg_16_0.rectReportParent_:InverseTransformPoint(arg_16_0.rectScrollView_:TransformPoint(Vector3.zero))
	local var_16_1 = arg_16_0.rectReportParent_.rect.height / 2

	if var_16_1 > var_16_0.y then
		return var_16_0.y + var_16_1 - arg_16_0.rectReportParent_:TransformPoint(Vector3(0, var_16_0.y + var_16_1, 0)).y - 20
	else
		return 0
	end
end

function var_0_1.Dispose(arg_17_0)
	arg_17_0.needDesireItem_:Dispose()

	for iter_17_0 = 1, 3 do
		arg_17_0.desireItemList_[iter_17_0]:Dispose()
	end

	arg_17_0.commonPortrait_:Dispose()
	arg_17_0.URFactoryItem_:Dispose()
	var_0_1.super.Dispose(arg_17_0)
	Object.Destroy(arg_17_0.gameObject_)

	arg_17_0.gameObject_ = nil
	arg_17_0.transform_ = nil
end

return var_0_1
