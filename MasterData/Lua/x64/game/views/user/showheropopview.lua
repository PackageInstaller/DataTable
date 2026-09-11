local ShowHeroPopView = class("ShowHeroPopView", ReduxView)

function ShowHeroPopView:UIName()
	return "Widget/System/UserInfor/HeroshowUI"
end

function ShowHeroPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ShowHeroPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ShowHeroPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ShowHeroPopItem)
end

function ShowHeroPopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData(self.list_[arg_5_1], self.isForeign_)
	arg_5_2:RegistClickFunction(function()
		if manager.windowBar:GetWhereTag() ~= nil then
			if not self.isForeign_ then
				ShowTips("PROFILE_ROLES_SET_PROMPT")
			end

			return
		end

		if not self.isForeign_ then
			JumpTools.OpenPageByJump("/HeroShowChange", {
				heroID = (self.list_[arg_5_1].hero_id ~= 0 or nil) and (self.list_[arg_5_1].hero_id or nil)
			})
		else
			local var_6_0 = self.list_[arg_5_1].hero_id

			if self.list_[arg_5_1].hero_id ~= 0 then
				ForeignInfoAction:TryToCheckForeignHeroInfo(self.userID_, var_6_0, 1, function()
					JumpTools.OpenPageByJump("/newHero", {
						pageIndex = 1,
						isEnter = true,
						notShowBar = true,
						hid = var_6_0,
						type = HeroConst.HERO_DATA_TYPE.FOREIGN
					}, ViewConst.SYSTEM_ID.PLAYER_INFO)
				end)
			end
		end
	end)
end

function ShowHeroPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ShowHeroPopView:OnEnter()
	self.list_ = {}
	self.userID_ = self.params_.userID
	self.isForeign_ = self.params_.isForeign

	if self.params_.isBack and self.params_.heroListGetter then
		self.params_.heroList = self.params_.heroListGetter()
	end

	for iter_10_0, iter_10_1 in ipairs(self.params_.heroList) do
		self.list_[iter_10_0] = iter_10_1
	end

	for iter_10_2 = #self.list_ + 1, 3 do
		self.list_[iter_10_2] = {}
		self.list_[iter_10_2].hero_id = 0
		self.list_[iter_10_2].star = 0
		self.list_[iter_10_2].level = 0
		self.list_[iter_10_2].using_skin = 0
	end

	self.scrollHelper_:StartScroll(#self.list_)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function ShowHeroPopView:OnExit()
	for iter_11_0, iter_11_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_11_1:OnExit()
	end
end

function ShowHeroPopView:Dispose()
	self:RemoveAllEventListener()

	for iter_12_0, iter_12_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_12_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	ShowHeroPopView.super.Dispose(self)
end

return ShowHeroPopView
