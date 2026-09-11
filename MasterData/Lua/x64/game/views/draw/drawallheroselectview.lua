local DrawAllHeroSelectView = class("DrawAllHeroSelectView", ReduxView)

function DrawAllHeroSelectView:UIName()
	return "Widget/System/Pool/pool_3000304_SelectPop"
end

function DrawAllHeroSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function DrawAllHeroSelectView:OnCtor()
	return
end

function DrawAllHeroSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawAllHeroSelectView:InitUI()
	self:BindCfgUI()
	self:InitTapView()

	self.btnCon_ = self.collection_:GetController("btn")
	self.tipCon_ = self.collection_:GetController("tips")
	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DrawAllHeroSelectItem)
end

function DrawAllHeroSelectView:indexItem(arg_6_1, arg_6_2)
	arg_6_2.gameObject_.name = tostring(self.curList_[arg_6_1])

	arg_6_2:SetHeroID(self.curList_[arg_6_1], self.type_)
	arg_6_2:SetSelected(arg_6_2.heroID_ == self.curHeroId_)
	arg_6_2:RegisterClickListener(handler(self, self.OnHeroClick))
end

function DrawAllHeroSelectView:OnHeroClick(arg_7_1)
	self.curHeroId_ = arg_7_1

	self:UpdateBtnState()
	self.scrollHelper_:Refresh()
end

function DrawAllHeroSelectView:AddUIListener()
	self:AddBtnListener(self.btnLock_, nil, function()
		ShowTips("DRAW_NOT_SELECT_TIPS")
	end)
	self:AddBtnListener(self.btnrenewalBtn_, nil, function()
		if self.curHeroId_ == nil or self.curHeroId_ == 0 then
			return
		end

		if self.curHeroId_ == self.params_.heroId then
			self:Back()
		else
			if self.params_.isFirst then
				self:ChangeUp()

				return
			end

			if DrawPoolCfg[self.params_.poolId].pool_change == 0 then
				self:ChangeUp()
			else
				self:ShowChangeUpPopTip()
			end
		end
	end)
end

function DrawAllHeroSelectView:ChangeUp()
	DrawAction.SetPollUpID(self.params_.poolId, DrawPoolCfg[self.params_.poolId].optional_lists_poolId[table.indexof(DrawPoolCfg[self.params_.poolId].optional_detail, self.curHeroId_)])
end

function DrawAllHeroSelectView:ShowChangeUpPopTip()
	ShowMessageBox({
		isTop = true,
		title = GetTips("PROMPT"),
		content = GetTips("DRAW_SWITCH_LIMIT_CONFIRM_TIP"),
		SecondTip = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), ""),
		SecondValue = DrawData:GetUpRemainTime(self.params_.poolId),
		OkCallback = function()
			self:ChangeUp()
		end,
		CancelCallback = function()
			return
		end
	})
end

function DrawAllHeroSelectView:OnEnter()
	self.upID = DrawData:GetPollUpID(self.params_.poolId)
	self.upHeroID = DrawData:ConvertUpId(self.params_.poolId, self.upID, 0)
	self.curHeroId_ = self.upHeroID

	self:RefreshData()
	self:UpdateBtnState()
	self:UpdateTipState()
	self:RefreshTap()
	self:AddEventListeners()

	if self.curHeroId_ == 0 then
		self.btnCon_:SetSelectedState("false")
	else
		self.btnCon_:SetSelectedState("current")
	end

	self:UpdateTitleTxt()
end

function DrawAllHeroSelectView:UpdateTitleTxt()
	self.titleTxt_.text = DrawPoolCfg[self.params_.poolId].pool_type == 9 and GetTips("NEW_REGRESSION__POOL_SCREEN_TYPE_3") or GetTips("NEW_REGRESSION__POOL_SCREEN_TYPE_2")
end

function DrawAllHeroSelectView:RefreshData()
	if self.poolID_ ~= self.params_.poolId then
		self.allHeroList_ = self.params_.heroIdList
		self.poolID_ = self.params_.poolId
		self.tapSort_ = {}
	end
end

function DrawAllHeroSelectView:UpdateBtnState()
	self.btnCon_:SetSelectedState(self.curHeroId_ ~= DrawData:ConvertUpId(self.params_.poolId, DrawData:GetPollUpID(self.params_.poolId), 0) and "true" or "current")
end

function DrawAllHeroSelectView:UpdateTipState()
	if DrawPoolCfg[self.params_.poolId].pool_change == 0 or self.params_.isFirst then
		self.tipCon_:SetSelectedState("true")
	else
		self.tipCon_:SetSelectedState("false")

		self.timesText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[self.params_.poolId].pool_change - DrawData:GetPoolUpTimes(self.params_.poolId)))
	end
end

function DrawAllHeroSelectView:RefreshTap()
	if not self.params_.isBack then
		self.tapView_:Reset()
	end

	self.tapView_:Refresh()
end

function DrawAllHeroSelectView:RefreshList()
	local var_21_0

	if self.isAll_ then
		var_21_0 = self.allHeroList_
	else
		if not self.tapSort_[self.selectTapID_] then
			local var_21_1 = {}

			for iter_21_0, iter_21_1 in ipairs(self.allHeroList_) do
				if self.selectTapID_ == HeroCfg[iter_21_1].ATK_attribute[1] then
					table.insert(var_21_1, iter_21_1)
				end
			end

			self.tapSort_[self.selectTapID_] = var_21_1
		end

		var_21_0 = self.tapSort_[self.selectTapID_]
	end

	if not self.curList_ or not table.equal(self.curList_, var_21_0, "all") then
		self.curList_ = var_21_0

		self.scrollHelper_:StartScroll(#self.curList_)
	end
end

function DrawAllHeroSelectView:AddEventListeners()
	return
end

function DrawAllHeroSelectView:OnSetPollUpID(arg_23_1, arg_23_2)
	self:Back()
end

function DrawAllHeroSelectView:OnTop()
	self:UpdateBar()
end

function DrawAllHeroSelectView:OnBehind()
	manager.windowBar:HideBar()
end

function DrawAllHeroSelectView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function DrawAllHeroSelectView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function DrawAllHeroSelectView:OnMainHomeViewTop()
	return
end

function DrawAllHeroSelectView:Dispose()
	if self.tapView_ then
		self.tapView_:Dispose()

		self.tapView_ = nil
	end

	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	DrawAllHeroSelectView.super.Dispose(self)
end

function DrawAllHeroSelectView:InitTapView()
	self.tapTypeList_ = {
		HeroConst.HERO_ATTACK_TYPE.ALL,
		HeroConst.HERO_ATTACK_TYPE.PYISICS,
		HeroConst.HERO_ATTACK_TYPE.WIND,
		HeroConst.HERO_ATTACK_TYPE.FLAME,
		HeroConst.HERO_ATTACK_TYPE.THUNDER,
		HeroConst.HERO_ATTACK_TYPE.DARK,
		HeroConst.HERO_ATTACK_TYPE.LIGHT,
		HeroConst.HERO_ATTACK_TYPE.FREEZE,
		HeroConst.HERO_ATTACK_TYPE.WATER,
		HeroConst.HERO_ATTACK_TYPE.RANDOM
	}
	self.tapView_ = CommonHeroSkillAttributeFilter.New(self.tapGo_)

	self.tapView_:SetAttributeIdList(self.tapTypeList_)
	self.tapView_:SetSelectAttributeCallback(handler(self, self.OnSelectTap))
end

function DrawAllHeroSelectView:ResetTap()
	self.selectTapID_ = 1

	self.tapView_:Reset()
end

function DrawAllHeroSelectView:OnSelectTap(arg_32_1, arg_32_2)
	self.selectTapID_ = arg_32_1
	self.isAll_ = arg_32_2

	self:RefreshList()
end

return DrawAllHeroSelectView
