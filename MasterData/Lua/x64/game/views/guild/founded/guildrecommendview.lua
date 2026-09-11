local GuildRecommendView = class("GuildRecommendView", ReduxView)
local var_0_1 = 10

function GuildRecommendView:UIName()
	return "Widget/System/Club/ClubFoundedUI"
end

function GuildRecommendView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildRecommendView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.recommendUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, GuildRecommendItem)
	self.clubController_ = self.controller:GetController("None")
	self.btnComtroller = self.controller:GetController("btn")
	self.emptytroller = self.controller:GetController("descEmpty")
end

function GuildRecommendView:OnEnter()
	self:AddRefreshStamptime()
	self:RefreshScroll()
	self:RegisterEvent()
end

function GuildRecommendView:OnTop()
	self:RefreshWinBar()
end

function GuildRecommendView:OnExit()
	manager.windowBar:HideBar()
	self:StopRefreshStamptime()
	self:RemoveAllEventListener()
end

function GuildRecommendView:RefreshWinBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function()
		self:Back(2)
	end)
end

function GuildRecommendView:Dispose()
	GuildRecommendView.super.Dispose(self)

	if self.recommendUIList_ then
		self.recommendUIList_:Dispose()

		self.recommendUIList_ = nil
	end
end

function GuildRecommendView:RegisterEvent()
	self:RegistEventListener(GUILD_RECOMMEND_CLICK, handler(self, self.ClickRecommendItem))
end

function GuildRecommendView:AddListeners()
	self:AddBtnListener(self.buttonSearch_, nil, function()
		if self.inputField_.text == "" then
			return
		end

		local var_12_0 = tonumber(self.inputField_.text)

		if var_12_0 == nil or var_12_0 < 0 then
			self.inputField_.text = ""

			return ShowTips("ERROR_CLUB_NOT_EXIST")
		end

		GuildAction.SearchGuild(tonumber(self.inputField_.text), function(arg_13_0)
			if isSuccess(arg_13_0.result) then
				ShowTips(arg_13_0.result)

				self.searchFlag_ = true
				self.inputField_.text = ""

				self:RefreshScroll()
			else
				ShowTips(arg_13_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.buttonRefresh_, nil, function()
		self:ClickRefreshBtn()
	end)
	self:AddBtnListener(self.buttonJoin_, nil, function()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.JOIN_CLUB) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = 3
		})

		local var_15_0 = self:GetItemData()[self.selectIndex_]

		GuildAction.GuildRequestJoin(var_15_0.id, function(arg_16_0)
			GuildData:AddJoinData(var_15_0.id)
			self:RefreshInfo()
		end)
	end)
	self:AddBtnListener(self.foundBtn, nil, function()
		JumpTools.OpenPageByJump("guildFoundedView")
	end)
	self:AddBtnListener(self.copyIDBtn, nil, function()
		local var_18_0 = self:GetItemData()

		if self.selectIndex_ and var_18_0[self.selectIndex_] then
			UnityEngine.GUIUtility.systemCopyBuffer = var_18_0[self.selectIndex_].id

			ShowTips("COPY_SUCCESS")
		end
	end)
end

function GuildRecommendView:ClickRefreshBtn()
	if GuildData:GetRecommendRefreshStamptime() + var_0_1 > manager.time:GetServerTime() then
		return
	end

	GuildAction.RequiredGuildRecommendList(function(arg_20_0)
		if isSuccess(arg_20_0.result) then
			GuildData:SetRecommendRefreshStamptime()

			self.searchFlag_ = false

			self:AddRefreshStamptime()
			self:RefreshScroll()
		else
			ShowTips(arg_20_0.result)
		end
	end)
end

function GuildRecommendView:RefreshScroll()
	local var_21_0 = self:GetItemData()

	self.selectIndex_ = 1

	if #var_21_0 <= 0 then
		self.clubController_:SetSelectedState("false")
	else
		self.clubController_:SetSelectedState("true")
	end

	self.recommendUIList_:StartScroll(#var_21_0, self.selectIndex_)
	self:RefreshInfo()
end

function GuildRecommendView:RefreshItem(arg_22_1, arg_22_2)
	arg_22_2:SetData(arg_22_1, self:GetItemData()[arg_22_1], arg_22_1 == self.selectIndex_)
end

function GuildRecommendView:ClickRecommendItem(arg_23_1)
	self.selectIndex_ = arg_23_1

	self:RefreshInfo()
end

function GuildRecommendView:RefreshInfo()
	local var_24_0 = self:GetItemData()[self.selectIndex_]

	if var_24_0 == nil then
		return
	end

	self.textName_.text = GetI18NText(var_24_0.name)
	self.textMember_.text = string.format("%s/%s", var_24_0.member, var_24_0.maxMemberCnt)
	self.textLevel_.text = string.format(GetTips("CLUB_LEVEL"), var_24_0.level)
	self.textContribute_.text = GetI18NText(var_24_0.contribute)
	self.textID_.text = var_24_0.id

	if var_24_0.notice and var_24_0.notice ~= "" then
		self.emptytroller:SetSelectedState("full")

		self.textNotice_.text = GetI18NText(var_24_0.notice)
	else
		self.emptytroller:SetSelectedState("empty")
	end

	self.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[var_24_0.icon].icon_bg)

	self:RefreshBtnState()
end

function GuildRecommendView:RefreshBtnState()
	local var_25_0 = self:GetItemData()[self.selectIndex_]

	if var_25_0 == nil then
		return
	end

	self.btnComtroller:SetSelectedState("can")

	if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.JOIN_CLUB) then
		self.btnComtroller:SetSelectedState("no")

		return
	end

	if var_25_0.is_requested and var_25_0.is_requested == 1 then
		self.btnComtroller:SetSelectedState("had")

		return
	end
end

function GuildRecommendView:GetItemData()
	if self.searchFlag_ then
		return GuildData:GetSearchList()
	else
		return GuildData:GetRecommendList()
	end
end

function GuildRecommendView:AddRefreshStamptime()
	self:RefreshCDText()
	self:StopRefreshStamptime()

	self.refreshTimer_ = Timer.New(function()
		self:RefreshCDText()
	end, 1, -1)

	self.refreshTimer_:Start()
end

function GuildRecommendView:RefreshCDText()
	local var_29_0 = GetTips("CLUB_REFRES_TEXT")
	local var_29_1 = GuildData:GetRecommendRefreshStamptime() + var_0_1 - manager.time:GetServerTime()

	if var_29_1 > 0 then
		self.textRefresh_.text = string.format("%s(%sS)", var_29_0, var_29_1)
	else
		self:StopRefreshStamptime()

		self.textRefresh_.text = var_29_0
	end
end

function GuildRecommendView:StopRefreshStamptime()
	if self.refreshTimer_ then
		self.refreshTimer_:Stop()

		self.refreshTimer_ = nil
	end
end

return GuildRecommendView
