local HeroAstrolabeInfoView = class("HeroAstrolabeInfoView", HeroAstrolabeBaseInfoView)

function HeroAstrolabeInfoView:InitUI()
	self.super.InitUI(self)

	self.itemS_ = {}

	for iter_1_0 = 1, 3 do
		self.itemS_[iter_1_0] = {}

		for iter_1_1 = 1, 3 do
			self.itemS_[iter_1_0][iter_1_1] = AstrolabeItem.New(self, Object.Instantiate(self.nodeitemGo_1, self[string.format("item%d_%dGo_", iter_1_0, iter_1_1)].transform), iter_1_0)
		end
	end
end

function HeroAstrolabeInfoView:AddUIListener()
	return
end

function HeroAstrolabeInfoView:ChangeStyle(arg_3_1)
	self.styleController_:SetSelectedState(arg_3_1)
end

function HeroAstrolabeInfoView:AddUIListener()
	return
end

function HeroAstrolabeInfoView:RefreshUI(arg_5_1, arg_5_2)
	self.heroInfo_ = arg_5_1
	self.astrolabeInfo_ = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(self.itemS_ or {}) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			iter_5_3:SetNodeNameIsHide(self.isHideNodeName)
			iter_5_3:SetProxy(self.heroViewProxy_)
			iter_5_3:RefreshUI(self.astrolabeInfo_[iter_5_0].astrolabe[iter_5_2], self.heroInfo_)
		end
	end
end

function HeroAstrolabeInfoView:RefreshRedPoint()
	for iter_6_0, iter_6_1 in ipairs(self.itemS_) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			local var_6_0 = iter_6_3:GetItemInfo()

			if self.heroViewProxy_ and (self.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW or self.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON) then
				iter_6_3:SetRedPoint(false)
			else
				iter_6_3:SetRedPoint(AstrolabeTools.GetIsCanUnlock(var_6_0.id, var_6_0.heroId))
			end
		end
	end
end

function HeroAstrolabeInfoView:OnEnter(arg_7_1)
	self.heroViewProxy_ = arg_7_1
end

function HeroAstrolabeInfoView:OnExit()
	return
end

function HeroAstrolabeInfoView:GetFirstSelectItem()
	if self.heroInfo_ and self.astrolabeInfo_ then
		if self.heroInfo_.using_astrolabe[#self.heroInfo_.using_astrolabe] then
			for iter_9_0, iter_9_1 in ipairs(self.itemS_ or {}) do
				for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
					if iter_9_3:GetItemInfo().id == self.heroInfo_.using_astrolabe[#self.heroInfo_.using_astrolabe] then
						return iter_9_3
					end
				end
			end
		end
	end

	return self:GetItem(1, 1)
end

function HeroAstrolabeInfoView:GetItem(arg_10_1, arg_10_2)
	return self.itemS_[arg_10_1][arg_10_2]
end

function HeroAstrolabeInfoView:RegistCallBack(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.itemS_ or {}) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			iter_11_3:RegistCallBack(arg_11_1)
		end
	end
end

function HeroAstrolabeInfoView:Dispose()
	if self.itemS_ then
		for iter_12_0, iter_12_1 in ipairs(self.itemS_) do
			for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
				iter_12_3:Dispose()
			end
		end
	end

	self.itemSGo_ = nil
	self.itemS_ = nil
	self.astrolabeInfo_ = nil

	HeroAstrolabeInfoView.super.Dispose(self)
end

function HeroAstrolabeInfoView:SetNodeNameIsHide(arg_13_1)
	self.isHideNodeName = arg_13_1
end

return HeroAstrolabeInfoView
