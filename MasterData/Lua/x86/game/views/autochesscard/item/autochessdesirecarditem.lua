local AutoChessDesireCardItem = class("AutoChessDesireCardItem", ReduxView)

function AutoChessDesireCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessDesireCardItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireCardItem:InitUI()
	self.index_ = 0
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
	self.wishStateController_ = self.controller_:GetController("wishState")
end

function AutoChessDesireCardItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND and GameSetting.auto_chess_2_exchange_friend_times.value[1] <= AutoChessCardData:GetFriendExchangeCardNum() then
			ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO_AMIGO")

			return
		end

		if self.mode_ == AutoChessCardConst.DESIRE_TYPE.OTHER and GameSetting.auto_chess_2_exchange_stranger_times.value[1] <= AutoChessCardData:GetOtherExchangeCardNum() then
			ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO")

			return
		end

		JumpTools.OpenPageByJump("autoChessDesireDatailPopView", {
			mode = self.mode_,
			index = self.index_
		})
	end)
end

function AutoChessDesireCardItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index_ = arg_6_1
	self.mode_ = arg_6_2

	local var_6_0

	if arg_6_2 == AutoChessCardConst.DESIRE_TYPE.FRIEND then
		var_6_0 = AutoChessCardData:GetFriendDesire(arg_6_1)
	elseif arg_6_2 == AutoChessCardConst.DESIRE_TYPE.OTHER then
		var_6_0 = AutoChessCardData:GetOtherDesire(arg_6_1)
	end

	if var_6_0 == nil then
		print("Desire SetData is nil, index:" .. arg_6_1 .. ", mode:" .. arg_6_2 .. ", FriendNum:" .. AutoChessCardData:GetFriendDesireNum() .. ", OtherNum:" .. AutoChessCardData:GetOtherDesireNum())

		return
	end

	self.cardID_ = var_6_0.CardID

	self.cardItem_:SetData(self.cardID_, arg_6_3:GetItem(self.cardID_))
	self:RefreshUI(var_6_0)
end

function AutoChessDesireCardItem:RefreshUI(arg_7_1)
	self.wishStateController_:SetSelectedState("none")

	if table.indexof(arg_7_1.CardList, AutoChessCardData:GetDesireInfo().CardID) then
		self.wishStateController_:SetSelectedState("heart")
	else
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.CardList) do
			if AutoChessCardData:GetCardNum(iter_7_1) <= 0 then
				self.wishStateController_:SetSelectedState("add")

				break
			end
		end
	end

	local var_7_0, var_7_1 = AutoChessTools.GetRankLevelCfg(arg_7_1.Level)

	self.txtRankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_7_0.icon)
	self.txtRankLevel_.text = var_7_0.name
	self.txtPlayerName_.text = arg_7_1.NickName

	self.commonPortrait_:RenderHead(arg_7_1.Icon)

	if AutoChessCardData:GetCardNum(self.cardID_) <= 1 then
		self.cardItem_:SetGreyState(true)
	else
		self.cardItem_:SetGreyState(false)
	end
end

function AutoChessDesireCardItem:Dispose()
	self.commonPortrait_:Dispose()
	self.cardItem_:Dispose()
	AutoChessDesireCardItem.super.Dispose(self)
end

return AutoChessDesireCardItem
