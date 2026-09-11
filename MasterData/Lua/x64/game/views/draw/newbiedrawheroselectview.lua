local NewbieDrawHeroSelectView = class("NewbieDrawHeroSelectView", ReduxView)

function NewbieDrawHeroSelectView:UIName()
	return "Widget/System/Pool/NewbiePoolSelectPopUI"
end

function NewbieDrawHeroSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function NewbieDrawHeroSelectView:OnCtor()
	return
end

function NewbieDrawHeroSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewbieDrawHeroSelectView:InitUI()
	self:BindCfgUI()

	self.btnController_ = self.controller_:GetController("btn")
	self.limitController_ = self.controller_:GetController("tips")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, NewBieDrawHeroItem)
end

function NewbieDrawHeroSelectView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.idList_[arg_6_1])
	arg_6_2:RegistClickFunc(function()
		self:OnHeroClick(self.idList_[arg_6_1])
	end)
	arg_6_2:RefreshSelect(self.curHeroId_ == self.idList_[arg_6_1])
end

function NewbieDrawHeroSelectView:OnHeroClick(arg_8_1)
	if self.upHeroID == arg_8_1 then
		self.btnController_:SetSelectedState("current")
	else
		self.btnController_:SetSelectedState(self.upID ~= arg_8_1 and "true" or "current")
	end

	self.curHeroId_ = arg_8_1

	self.uiList_:Refresh()
end

function NewbieDrawHeroSelectView:AddUIListener()
	local function var_9_0()
		DrawAction.SetPollUpID(self.params_.poolId, DrawPoolCfg[self.params_.poolId].optional_lists_poolId[table.indexof(DrawPoolCfg[self.params_.poolId].optional_detail, self.curHeroId_)])
	end

	self:AddBtnListener(self.btnrenewalBtn_, nil, function()
		if self.curHeroId_ == nil or self.curHeroId_ == 0 then
			return
		end

		if self.curHeroId_ == self.upHeroID then
			self:Back()

			return
		end

		if DrawPoolCfg[self.params_.poolId].pool_type == 1 then
			var_9_0()

			return
		end

		if self.params_.isFirst then
			var_9_0()

			return
		end

		if self.upHeroID == 0 then
			var_9_0()
		elseif DrawPoolCfg[self.params_.poolId].pool_change == 0 then
			var_9_0()
		else
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("DRAW_POOL_SCREEN_TYPE_4"),
				SecondTip = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), ""),
				SecondValue = DrawData:GetUpRemainTime(self.params_.poolId),
				OkCallback = var_9_0
			})
		end
	end)
	self:AddBtnListener(self.btnLock_, nil, function()
		if self.curHeroId_ == nil or self.curHeroId_ == 0 then
			ShowTips("DRAW_NOT_SELECT_TIPS")

			return
		end
	end)
end

function NewbieDrawHeroSelectView:OnSetPollUpID(arg_13_1, arg_13_2)
	self:Back()
end

function NewbieDrawHeroSelectView:OnTop()
	self:UpdateBar()
end

function NewbieDrawHeroSelectView:OnBehind()
	manager.windowBar:HideBar()
end

function NewbieDrawHeroSelectView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NewbieDrawHeroSelectView:OnEnter()
	self.upID = DrawData:GetPollUpID(self.params_.poolId)
	self.upHeroID = DrawData:ConvertUpId(self.params_.poolId, self.upID, 0)
	self.curHeroId_ = self.upHeroID

	if self.curHeroId_ == 0 then
		self.btnController_:SetSelectedState("false")
	else
		self.btnController_:SetSelectedState("current")
	end

	local var_17_0 = DrawPoolCfg[self.params_.poolId]

	self.titleTxt1_.text = GetTips(DrawPoolCfg[self.params_.poolId].pool_type == 1 and "DRAW_SELECT_STANDARD_TIPS" or "DRAW_SELECT_NEWBEE_TIPS")
	self.titleTxt2_.text = GetTips(var_17_0.pool_type == 1 and "DRAW_STANDARD_TIPS" or "DRAW_NEWBEE_TIPS")

	self:UpdateList()
end

function NewbieDrawHeroSelectView:OnExit()
	self:RemoveAllEventListener()

	self.params_.heroId = self.curHeroId_
	self.params_.poolId = self.params_.poolId
	self.params_.isFirst = self.params_.isFirst

	manager.windowBar:HideBar()
end

function NewbieDrawHeroSelectView:UpdateList()
	self.idList_ = self.params_.heroIdList

	self.uiList_:StartScroll(#self.idList_)

	local var_19_0 = DrawPoolCfg[self.params_.poolId]

	if DrawPoolCfg[self.params_.poolId].pool_change == 0 or self.params_.isFirst then
		self.limitController_:SetSelectedState("false")
	else
		self.limitController_:SetSelectedState("true")

		self.timesText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[self.params_.poolId].pool_change - DrawData:GetPoolUpTimes(self.params_.poolId)))
	end

	self.uilistSrex_.enabled = var_19_0.pool_type == 9
end

function NewbieDrawHeroSelectView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	NewbieDrawHeroSelectView.super.Dispose(self)
end

return NewbieDrawHeroSelectView
