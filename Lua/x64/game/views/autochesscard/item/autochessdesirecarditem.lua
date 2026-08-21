local var_0_0 = class("AutoChessDesireCardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.index_ = 0
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
	arg_3_0.cardItem_ = AutoChessCardItem.New(arg_3_0.cardGo_)
	arg_3_0.wishStateController_ = arg_3_0.controller_:GetController("wishState")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0
		local var_5_1

		if arg_4_0.mode_ == AutoChessCardConst.DESIRE_TYPE.FRIEND and GameSetting.auto_chess_2_exchange_friend_times.value[1] <= AutoChessCardData:GetFriendExchangeCardNum() then
			ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO_AMIGO")

			return
		end

		if arg_4_0.mode_ == AutoChessCardConst.DESIRE_TYPE.OTHER and GameSetting.auto_chess_2_exchange_stranger_times.value[1] <= AutoChessCardData:GetOtherExchangeCardNum() then
			ShowTips("AUTO_CHESS_2_EXCHANGE_TIME_ZERO")

			return
		end

		JumpTools.OpenPageByJump("autoChessDesireDatailPopView", {
			mode = arg_4_0.mode_,
			index = arg_4_0.index_
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index_ = arg_6_1
	arg_6_0.mode_ = arg_6_2

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

	arg_6_0.cardID_ = var_6_0.CardID

	arg_6_0.cardItem_:SetData(arg_6_0.cardID_, arg_6_3:GetItem(arg_6_0.cardID_))
	arg_6_0:RefreshUI(var_6_0)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	local var_7_0 = AutoChessCardData:GetDesireInfo()

	arg_7_0.wishStateController_:SetSelectedState("none")

	if table.indexof(arg_7_1.CardList, var_7_0.CardID) then
		arg_7_0.wishStateController_:SetSelectedState("heart")
	else
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.CardList) do
			if AutoChessCardData:GetCardNum(iter_7_1) <= 0 then
				arg_7_0.wishStateController_:SetSelectedState("add")

				break
			end
		end
	end

	local var_7_1, var_7_2 = AutoChessTools.GetRankLevelCfg(arg_7_1.Level)

	arg_7_0.txtRankImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_7_1.icon)
	arg_7_0.txtRankLevel_.text = var_7_1.name
	arg_7_0.txtPlayerName_.text = arg_7_1.NickName

	arg_7_0.commonPortrait_:RenderHead(arg_7_1.Icon)

	if AutoChessCardData:GetCardNum(arg_7_0.cardID_) <= 1 then
		arg_7_0.cardItem_:SetGreyState(true)
	else
		arg_7_0.cardItem_:SetGreyState(false)
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.commonPortrait_:Dispose()
	arg_8_0.cardItem_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
