local AutoChessCardChatItemView = class("AutoChessCardChatItemView", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function AutoChessCardChatItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessCardChatItemView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
	self:Show(true)
end

function AutoChessCardChatItemView:InitUI()
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.needDesireItem_ = AutoChessCardChatItem.New(self.cardGo_)
	self.desireItemList_ = {}

	for iter_3_0 = 1, 3 do
		table.insert(self.desireItemList_, AutoChessCardChatItem.New(self["cardGo" .. iter_3_0 .. "_"]))
	end

	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessCardChatItemView:AddListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.itemData_.userId)
	end)
	self:AddBtnListener(self.jumpBtn_, nil, function()
		self:OnClickCard()
	end)
	self:AddBtnListener(self.buttonContent_, nil, function()
		self:OnClickCard()
	end)
end

function AutoChessCardChatItemView:SetData(arg_8_1, arg_8_2)
	self.itemData_ = arg_8_1
	self.jumpLink_ = arg_8_1.jumpLink
	self.index_ = arg_8_2

	if arg_8_1.userId == USER_ID then
		local var_8_0 = PlayerData:GetPlayerInfo()

		self.textName_.text = var_8_0.nick

		self.commonPortrait_:RenderHead(var_8_0.portrait)
		self.commonPortrait_:RenderFrame(var_8_0.icon_frame)
	else
		self.textName_.text = arg_8_1.nick

		self.commonPortrait_:RenderHead(arg_8_1.icon)
		self.commonPortrait_:RenderFrame(arg_8_1.iconFrame)
	end

	self.needDesireItem_:SetData(arg_8_1.myCardId, self.URFactoryItem_:GetItem(arg_8_1.myCardId))
	self.needDesireItem_:SetClickHandler(handler(self, self.OnClickCard))

	for iter_8_0 = 1, 3 do
		if arg_8_1.otherCardList[iter_8_0] then
			self.desireItemList_[iter_8_0]:SetData(arg_8_1.otherCardList[iter_8_0], self.URFactoryItem_:GetItem(arg_8_1.otherCardList[iter_8_0]))
			self.desireItemList_[iter_8_0]:SetActive(true)
		else
			self.desireItemList_[iter_8_0]:SetActive(false)
		end

		self.desireItemList_[iter_8_0]:SetClickHandler(handler(self, self.OnClickCard))
	end

	self:Show(true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
	self:SetIP(arg_8_1)
end

function AutoChessCardChatItemView:OnClickCard()
	if self.itemData_.userId == USER_ID then
		return
	end

	if FriendsData:IsFriend(self.itemData_.userId) then
		if GameSetting.auto_chess_2_exchange_friend_times.value[1] <= AutoChessCardData:GetFriendExchangeCardNum() then
			ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO_AMIGO")

			return
		end
	elseif GameSetting.auto_chess_2_exchange_stranger_times.value[1] <= AutoChessCardData:GetOtherExchangeCardNum() then
		ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO")

		return
	end

	AutoChessCardAction.RequestViewPlayerDesire(self.itemData_.id, self.itemData_.userId)
end

function AutoChessCardChatItemView:SetIP(arg_10_1)
	if not self.ipGo_ then
		return
	end

	self.ip_.text = arg_10_1.ip

	SetActive(self.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if self.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ipGo_.transform)
	end
end

function AutoChessCardChatItemView:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function AutoChessCardChatItemView:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function AutoChessCardChatItemView:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function AutoChessCardChatItemView:GetNick()
	return self.itemData_.nick
end

function AutoChessCardChatItemView:CalcOffsetX()
	return self.rectReportParent_:InverseTransformPoint(self.rectBg_:TransformPoint(Vector3(self.rectBg_.rect.width / 2, 0, 0))).x - 250
end

function AutoChessCardChatItemView:CalcOffsetY()
	local var_16_0 = self.rectReportParent_:InverseTransformPoint(self.rectScrollView_:TransformPoint(Vector3.zero))

	if self.rectReportParent_.rect.height / 2 > var_16_0.y then
		return var_16_0.y + self.rectReportParent_.rect.height / 2 - self.rectReportParent_:TransformPoint(Vector3(0, var_16_0.y + self.rectReportParent_.rect.height / 2, 0)).y - 20
	else
		return 0
	end
end

function AutoChessCardChatItemView:Dispose()
	self.needDesireItem_:Dispose()

	for iter_17_0 = 1, 3 do
		self.desireItemList_[iter_17_0]:Dispose()
	end

	self.commonPortrait_:Dispose()
	self.URFactoryItem_:Dispose()
	AutoChessCardChatItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return AutoChessCardChatItemView
