local NormalAstrolabe = class("NormalAstrolabe", (import("game.views.astrolabe.BaseAstrolabe")))

function NormalAstrolabe:InitItem()
	local var_1_0 = HeroTools.IsSpHero(self.heroID)

	if var_1_0 then
		var_1_0 = self.lastHeroID and HeroTools.IsSpHero(self.lastHeroID)
	end

	if var_1_0 == false then
		self:ClearItem()

		self.itemS_ = {}
	end

	local var_1_1

	if HeroTools.IsSpHero(self.heroID) then
		var_1_1 = AstrolabeConst.AstrolabeListCfg2 or AstrolabeConst.AstrolabeListCfg1
	end

	for iter_1_0 = 1, #var_1_1 do
		self.itemS_[iter_1_0] = self.itemS_[iter_1_0] or {}

		for iter_1_1 = 1, var_1_1[iter_1_0] do
			local var_1_2 = self[string.format("item%d_%dGo_", iter_1_0, iter_1_1)]

			if not self.itemS_[iter_1_0][iter_1_1] then
				self.itemS_[iter_1_0][iter_1_1] = AstrolabeNode.New(self, Object.Instantiate(Asset.Load((self:GetItemName(self.heroID, iter_1_0))), var_1_2.transform), iter_1_0)
				self.itemS_[iter_1_0][iter_1_1].lineStar = var_1_2.transform:Find("line_star")

				local var_1_3 = var_1_2.transform:Find("line_star_01")

				if var_1_3 then
					self.itemS_[iter_1_0][iter_1_1].lineStar2 = var_1_3
				end
			end

			self.itemS_[iter_1_0][iter_1_1]:SetParent(var_1_2.transform)
		end
	end
end

function NormalAstrolabe:GetItemName(arg_2_1, arg_2_2)
	if HeroTools.IsSpHero(self.heroID) then
		if arg_2_2 == 1 then
			return "UI/HeroGodHood/item_SP_02"
		end

		return "UI/HeroGodHood/item_SP_01"
	else
		return "UI/HeroGodHood/item"
	end
end

function NormalAstrolabe:RegistCallBack(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.itemS_ or {}) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			iter_3_3:RegistCallBack(arg_3_1)
		end
	end
end

function NormalAstrolabe:RefreshData(arg_4_1, arg_4_2)
	self.heroInfo_ = arg_4_1
	self.astrolabeInfo_ = arg_4_2

	for iter_4_0, iter_4_1 in ipairs(self.itemS_ or {}) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			iter_4_3:SetNodeNameIsHide(self.isHideNodeName)
			iter_4_3:SetProxy(self.heroViewProxy_)
			iter_4_3:RefreshUI(self.astrolabeInfo_[iter_4_0].astrolabe[iter_4_2], self.heroInfo_)
			iter_4_3:ResetEffect()

			if HeroTools.IsSpHero(self.heroInfo_.id) then
				iter_4_3:ShowSelfEffect()
				iter_4_3:ShowNextSpEffect()
			else
				iter_4_3:ShowNextEffect()
			end
		end
	end
end

function NormalAstrolabe:SetNodeNameIsHide(arg_5_1)
	self.isHideNodeName = arg_5_1
end

function NormalAstrolabe:RefreshRedPoint()
	for iter_6_0, iter_6_1 in ipairs(self.itemS_) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			local var_6_0 = iter_6_3:GetItemInfo()

			if self.heroViewProxy_ and (self.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW or self.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON or self.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.FOREIGN) then
				iter_6_3:SetRedPoint(false)
			else
				local var_6_1 = AstrolabeTools.GetIsCanUnlock(var_6_0.id, var_6_0.heroId)

				if HeroTools.IsSpHero(var_6_0.heroId) then
					iter_6_3:SetRedPoint((AstrolabeTools.GetSpAstrolabeNodeCanEquiped(var_6_0.id, var_6_0.heroId)))
				else
					iter_6_3:SetRedPoint(var_6_1)
				end
			end
		end
	end
end

function NormalAstrolabe:GetFirstSelectItem()
	if self.heroInfo_ and self.astrolabeInfo_ then
		if self.heroInfo_.using_astrolabe[#self.heroInfo_.using_astrolabe] then
			for iter_7_0, iter_7_1 in ipairs(self.itemS_ or {}) do
				for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
					if iter_7_3:GetItemInfo().id == self.heroInfo_.using_astrolabe[#self.heroInfo_.using_astrolabe] then
						return iter_7_3
					end
				end
			end
		end
	end

	return self:GetItem(1, 1)
end

function NormalAstrolabe:GetItem(arg_8_1, arg_8_2)
	return self.itemS_[arg_8_1][arg_8_2]
end

function NormalAstrolabe:ClearItem()
	for iter_9_0, iter_9_1 in ipairs(self.itemS_) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if iter_9_3 and iter_9_3.Dispose then
				iter_9_3:Dispose()
			end
		end
	end
end

function NormalAstrolabe:Dispose()
	self.super.Dispose(self)
end

return NormalAstrolabe
