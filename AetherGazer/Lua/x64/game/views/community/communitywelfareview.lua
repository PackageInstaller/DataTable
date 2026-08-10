local var_0_0 = class("CommunityWelfareView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubWelfarePopUI"
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

	arg_4_0.tree_ = LuaTree.New(arg_4_0.goTree_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), nil)

	arg_4_0.CommunityCon_ = arg_4_0.controller:GetController("community")
	arg_4_0.welfareCon_ = arg_4_0.controller:GetController("welfare")
	arg_4_0.welfare_ = CommonItemView.New(arg_4_0.commonItemGo_)
end

function var_0_0.OnGroupSelect(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1 == arg_5_0.pageIndex and not arg_5_0.enterflag then
		return
	end

	arg_5_0.pageIndex = arg_5_1

	arg_5_0:RefreshView()
end

function var_0_0.RefreshView(arg_6_0)
	if arg_6_0.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		arg_6_0:RefreshWelfare(GameSetting.club_welfare.value[1])

		arg_6_0.tittleText_.text = ItemCfg[GameSetting.club_welfare.value[1]].name
	elseif arg_6_0.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		arg_6_0:RefreshWelfare(GameSetting.club_special_welfare.value[1])

		arg_6_0.tittleText_.text = ItemCfg[GameSetting.club_special_welfare.value[1]].name
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.openBtn_, nil, function()
		if GameSetting.club_welfare_cost.value[1] <= CommunityData:GetCurrenyA() then
			CommunityAction:OpenWelfare()
		else
			ShowTips("ERROR_CLUB_COIN_NO_ENOUGH")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.receiveBtn_, nil, function()
		if arg_7_0.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or arg_7_0.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
			ShowTips("ERROR_CLUB_REWARD_ONLY_FORMAT_RECEIVE")
		else
			CommunityAction:ReceiveWelfare()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.deepBtn, nil, function()
		if CommunityData:GetWelfareExchangeCnt() <= 0 then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		JumpTools.OpenPageByJump("communitySpecialWelfareShop")
	end)
	arg_7_0:AddBtnListener(arg_7_0.backBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btn_lockBtn_, nil, function()
		ShowTips("WELFARE_NOT_OPEN")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.enterflag = true

	CommunityAction:RefreshCurrencyA()
	arg_13_0.tree_:SelectGroup(GuildConst.WELFARE_TYPE.COMMON)

	arg_13_0.enterflag = false
end

function var_0_0.RefreshMemberTypeUI(arg_14_0)
	manager.windowBar:SetAsLastSibling()

	arg_14_0.identity_ = CommunityData:GetIdentity()
	arg_14_0.welfareType_ = CommunityData:GetWelfareType()

	if arg_14_0.identity_ == CommunityConst.MEMBER_TYPE.HEAD or arg_14_0.identity_ == CommunityConst.MEMBER_TYPE.DEPUTY then
		arg_14_0.openBtn_.interactable = true

		arg_14_0.CommunityCon_:SetSelectedState("type1")
		arg_14_0:RefreshType1Bar()
	elseif arg_14_0.identity_ == CommunityConst.MEMBER_TYPE.MEMBER or arg_14_0.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or arg_14_0.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
		arg_14_0.openBtn_.interactable = false

		arg_14_0.CommunityCon_:SetSelectedState("type2")
		arg_14_0:RefreshType2Bar()
	else
		print("暂未设计")
	end
end

function var_0_0.RefreshType1Bar(arg_15_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function var_0_0.RefreshType2Bar(arg_16_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function var_0_0.RefreshCost(arg_17_0)
	if arg_17_0.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		arg_17_0.priceImg_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)

		local var_17_0 = GameSetting.club_welfare_cost.value[1]

		if var_17_0 <= CommunityData:GetCurrenyA() then
			arg_17_0.cost_.text = "<color='#28282B'>X" .. var_17_0 .. "</color>"
		else
			arg_17_0.cost_.text = "<color='#FF0000'>X" .. var_17_0 .. "</color>"
		end

		SetActive(arg_17_0.descText_.gameObject, true)
	elseif arg_17_0.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		local var_17_1 = math.abs(CommunityData:GetWelfareExchangeCnt() - GameSetting.club_special_reward_buy_limit_weekly.value[1])

		arg_17_0.tipsText_.text = string.format("%s%d/%d", GetTips("LIMIT_WEEK"), var_17_1, GameSetting.club_special_reward_buy_limit_weekly.value[1])

		SetActive(arg_17_0.descText_.gameObject, false)
	end
end

function var_0_0.RefreshWelfare(arg_18_0, arg_18_1)
	arg_18_0:RefreshMemberTypeUI()
	arg_18_0:RefreshItem(arg_18_1)
	arg_18_0:RefreshBtnState()
	arg_18_0:RefreshCost()
end

function var_0_0.RefreshBtnState(arg_19_0)
	if arg_19_0.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		if arg_19_0.welfareType_ == CommunityConst.WELFARE_TYPE.CLOSE then
			if arg_19_0.identity_ == CommunityConst.MEMBER_TYPE.HEAD or arg_19_0.identity_ == CommunityConst.MEMBER_TYPE.DEPUTY then
				arg_19_0.welfareCon_:SetSelectedState("close")
			else
				arg_19_0.welfareCon_:SetSelectedState("lock")
			end
		elseif arg_19_0.welfareType_ == CommunityConst.WELFARE_TYPE.RECEIVE then
			arg_19_0.receiveBtn_.interactable = true

			arg_19_0.welfareCon_:SetSelectedState("receive")
		elseif arg_19_0.welfareType_ == CommunityConst.WELFARE_TYPE.FINISH then
			arg_19_0.receiveBtn_.interactable = false

			arg_19_0.welfareCon_:SetSelectedState("finish")
		else
			print("暂未设计")
		end
	elseif arg_19_0.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		if CommunityData:GetWelfareExchangeCnt() > 0 then
			arg_19_0.welfareCon_:SetSelectedState("buyDeep")
		else
			arg_19_0.welfareCon_:SetSelectedState("buyMax")
		end
	end
end

function var_0_0.RefreshItem(arg_20_0, arg_20_1)
	local var_20_0 = {
		id = arg_20_1,
		clickFun = function(arg_21_0)
			ShowPopItem(POP_ITEM, {
				arg_21_0.id
			})
		end
	}

	arg_20_0.welfare_:SetData(var_20_0)
end

function var_0_0.OnReceiveWelfare(arg_22_0)
	arg_22_0:RefreshView()
end

function var_0_0.OnRefreshWelfare(arg_23_0)
	arg_23_0:RefreshView()
end

function var_0_0.OnExit(arg_24_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExitInput(arg_25_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0:RemoveAllListeners()
	arg_26_0.welfare_:Dispose()
	arg_26_0.tree_:Dispose()

	arg_26_0.tree_ = nil

	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
