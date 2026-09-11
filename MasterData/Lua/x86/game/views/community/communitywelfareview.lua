local CommunityWelfareView = class("CommunityWelfareView", ReduxView)

function CommunityWelfareView:UIName()
	return "Widget/System/Club/ClubWelfarePopUI"
end

function CommunityWelfareView:UIParent()
	return manager.ui.uiPop.transform
end

function CommunityWelfareView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CommunityWelfareView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.goTree_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), nil)

	self.CommunityCon_ = self.controller:GetController("community")
	self.welfareCon_ = self.controller:GetController("welfare")
	self.welfare_ = CommonItemView.New(self.commonItemGo_)
end

function CommunityWelfareView:OnGroupSelect(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1 == self.pageIndex and not self.enterflag then
		return
	end

	self.pageIndex = arg_5_1

	self:RefreshView()
end

function CommunityWelfareView:RefreshView()
	if self.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		self:RefreshWelfare(GameSetting.club_welfare.value[1])

		self.tittleText_.text = ItemCfg[GameSetting.club_welfare.value[1]].name
	elseif self.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		self:RefreshWelfare(GameSetting.club_special_welfare.value[1])

		self.tittleText_.text = ItemCfg[GameSetting.club_special_welfare.value[1]].name
	end
end

function CommunityWelfareView:AddUIListener()
	self:AddBtnListener(self.openBtn_, nil, function()
		if GameSetting.club_welfare_cost.value[1] <= CommunityData:GetCurrenyA() then
			CommunityAction:OpenWelfare()
		else
			ShowTips("ERROR_CLUB_COIN_NO_ENOUGH")
		end
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or self.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
			ShowTips("ERROR_CLUB_REWARD_ONLY_FORMAT_RECEIVE")
		else
			CommunityAction:ReceiveWelfare()
		end
	end)
	self:AddBtnListener(self.deepBtn, nil, function()
		if CommunityData:GetWelfareExchangeCnt() <= 0 then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		JumpTools.OpenPageByJump("communitySpecialWelfareShop")
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btn_lockBtn_, nil, function()
		ShowTips("WELFARE_NOT_OPEN")
	end)
end

function CommunityWelfareView:OnEnter()
	self.enterflag = true

	CommunityAction:RefreshCurrencyA()
	self.tree_:SelectGroup(GuildConst.WELFARE_TYPE.COMMON)

	self.enterflag = false
end

function CommunityWelfareView:RefreshMemberTypeUI()
	manager.windowBar:SetAsLastSibling()

	self.identity_ = CommunityData:GetIdentity()
	self.welfareType_ = CommunityData:GetWelfareType()

	if self.identity_ == CommunityConst.MEMBER_TYPE.HEAD or self.identity_ == CommunityConst.MEMBER_TYPE.DEPUTY then
		self.openBtn_.interactable = true

		self.CommunityCon_:SetSelectedState("type1")
		self:RefreshType1Bar()
	elseif self.identity_ == CommunityConst.MEMBER_TYPE.MEMBER or self.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or self.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
		self.openBtn_.interactable = false

		self.CommunityCon_:SetSelectedState("type2")
		self:RefreshType2Bar()
	else
		print("暂未设计")
	end
end

function CommunityWelfareView:RefreshType1Bar()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function CommunityWelfareView:RefreshType2Bar()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function CommunityWelfareView:RefreshCost()
	if self.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		self.priceImg_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)

		local var_17_0 = GameSetting.club_welfare_cost.value[1]

		self.cost_.text = GameSetting.club_welfare_cost.value[1] <= CommunityData:GetCurrenyA() and "<color='#28282B'>X" .. var_17_0 .. "</color>" or "<color='#FF0000'>X" .. var_17_0 .. "</color>"

		SetActive(self.descText_.gameObject, true)
	elseif self.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		self.tipsText_.text = string.format("%s%d/%d", GetTips("LIMIT_WEEK"), math.abs(CommunityData:GetWelfareExchangeCnt() - GameSetting.club_special_reward_buy_limit_weekly.value[1]), GameSetting.club_special_reward_buy_limit_weekly.value[1])

		SetActive(self.descText_.gameObject, false)
	end
end

function CommunityWelfareView:RefreshWelfare(arg_18_1)
	self:RefreshMemberTypeUI()
	self:RefreshItem(arg_18_1)
	self:RefreshBtnState()
	self:RefreshCost()
end

function CommunityWelfareView:RefreshBtnState()
	if self.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		if self.welfareType_ == CommunityConst.WELFARE_TYPE.CLOSE then
			if self.identity_ == CommunityConst.MEMBER_TYPE.HEAD or self.identity_ == CommunityConst.MEMBER_TYPE.DEPUTY then
				self.welfareCon_:SetSelectedState("close")
			else
				self.welfareCon_:SetSelectedState("lock")
			end
		elseif self.welfareType_ == CommunityConst.WELFARE_TYPE.RECEIVE then
			self.receiveBtn_.interactable = true

			self.welfareCon_:SetSelectedState("receive")
		elseif self.welfareType_ == CommunityConst.WELFARE_TYPE.FINISH then
			self.receiveBtn_.interactable = false

			self.welfareCon_:SetSelectedState("finish")
		else
			print("暂未设计")
		end
	elseif self.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		if CommunityData:GetWelfareExchangeCnt() > 0 then
			self.welfareCon_:SetSelectedState("buyDeep")
		else
			self.welfareCon_:SetSelectedState("buyMax")
		end
	end
end

function CommunityWelfareView:RefreshItem(arg_20_1)
	self.welfare_:SetData({
		id = arg_20_1,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	})
end

function CommunityWelfareView:OnReceiveWelfare()
	self:RefreshView()
end

function CommunityWelfareView:OnRefreshWelfare()
	self:RefreshView()
end

function CommunityWelfareView:OnExit()
	manager.windowBar:HideBar()
end

function CommunityWelfareView:OnExitInput()
	JumpTools.Back()

	return true
end

function CommunityWelfareView:Dispose()
	self:RemoveAllListeners()
	self.welfare_:Dispose()
	self.tree_:Dispose()

	self.tree_ = nil

	CommunityWelfareView.super.Dispose(self)
end

return CommunityWelfareView
