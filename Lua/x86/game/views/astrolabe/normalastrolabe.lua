local var_0_0 = import("game.views.astrolabe.BaseAstrolabe")
local var_0_1 = class("NormalAstrolabe", var_0_0)

function var_0_1.InitItem(arg_1_0)
	if (HeroTools.IsSpHero(arg_1_0.heroID) and arg_1_0.lastHeroID and HeroTools.IsSpHero(arg_1_0.lastHeroID)) == false then
		arg_1_0:ClearItem()

		arg_1_0.itemS_ = {}
	end

	local var_1_0 = HeroTools.IsSpHero(arg_1_0.heroID) and AstrolabeConst.AstrolabeListCfg2 or AstrolabeConst.AstrolabeListCfg1

	for iter_1_0 = 1, #var_1_0 do
		if not arg_1_0.itemS_[iter_1_0] then
			arg_1_0.itemS_[iter_1_0] = {}
		end

		local var_1_1 = var_1_0[iter_1_0]

		for iter_1_1 = 1, var_1_1 do
			local var_1_2 = arg_1_0[string.format("item%d_%dGo_", iter_1_0, iter_1_1)]

			if not arg_1_0.itemS_[iter_1_0][iter_1_1] then
				local var_1_3 = arg_1_0:GetItemName(arg_1_0.heroID, iter_1_0)
				local var_1_4 = Object.Instantiate(Asset.Load(var_1_3), var_1_2.transform)

				arg_1_0.itemS_[iter_1_0][iter_1_1] = AstrolabeNode.New(arg_1_0, var_1_4, iter_1_0)

				local var_1_5 = var_1_2.transform:Find("line_star")

				arg_1_0.itemS_[iter_1_0][iter_1_1].lineStar = var_1_5

				local var_1_6 = var_1_2.transform:Find("line_star_01")

				if var_1_6 then
					arg_1_0.itemS_[iter_1_0][iter_1_1].lineStar2 = var_1_6
				end
			end

			arg_1_0.itemS_[iter_1_0][iter_1_1]:SetParent(var_1_2.transform)
		end
	end
end

function var_0_1.GetItemName(arg_2_0, arg_2_1, arg_2_2)
	if HeroTools.IsSpHero(arg_2_0.heroID) then
		if arg_2_2 == 1 then
			return "UI/HeroGodHood/item_SP_02"
		end

		return "UI/HeroGodHood/item_SP_01"
	else
		return "UI/HeroGodHood/item"
	end
end

function var_0_1.RegistCallBack(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.itemS_ or {}) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			iter_3_3:RegistCallBack(arg_3_1)
		end
	end
end

function var_0_1.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.heroInfo_ = arg_4_1
	arg_4_0.astrolabeInfo_ = arg_4_2

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemS_ or {}) do
		local var_4_0 = arg_4_0.astrolabeInfo_[iter_4_0]

		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_1 = var_4_0.astrolabe[iter_4_2]

			iter_4_3:SetNodeNameIsHide(arg_4_0.isHideNodeName)
			iter_4_3:SetProxy(arg_4_0.heroViewProxy_)
			iter_4_3:RefreshUI(var_4_1, arg_4_0.heroInfo_)
			iter_4_3:ResetEffect()

			if HeroTools.IsSpHero(arg_4_0.heroInfo_.id) then
				iter_4_3:ShowSelfEffect()
				iter_4_3:ShowNextSpEffect()
			else
				iter_4_3:ShowNextEffect()
			end
		end
	end
end

function var_0_1.SetNodeNameIsHide(arg_5_0, arg_5_1)
	arg_5_0.isHideNodeName = arg_5_1
end

function var_0_1.RefreshRedPoint(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemS_) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			local var_6_0 = iter_6_3:GetItemInfo()

			if arg_6_0.heroViewProxy_ and (arg_6_0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW or arg_6_0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON or arg_6_0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.FOREIGN) then
				iter_6_3:SetRedPoint(false)
			else
				local var_6_1 = AstrolabeTools.GetIsCanUnlock(var_6_0.id, var_6_0.heroId)

				if HeroTools.IsSpHero(var_6_0.heroId) then
					local var_6_2 = AstrolabeTools.GetSpAstrolabeNodeCanEquiped(var_6_0.id, var_6_0.heroId)

					iter_6_3:SetRedPoint(var_6_2)
				else
					iter_6_3:SetRedPoint(var_6_1)
				end
			end
		end
	end
end

function var_0_1.GetFirstSelectItem(arg_7_0)
	if arg_7_0.heroInfo_ and arg_7_0.astrolabeInfo_ then
		local var_7_0 = arg_7_0.heroInfo_.using_astrolabe[#arg_7_0.heroInfo_.using_astrolabe]

		if var_7_0 then
			for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemS_ or {}) do
				for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
					if iter_7_3:GetItemInfo().id == var_7_0 then
						return iter_7_3
					end
				end
			end
		end
	end

	return arg_7_0:GetItem(1, 1)
end

function var_0_1.GetItem(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0.itemS_[arg_8_1][arg_8_2]
end

function var_0_1.ClearItem(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemS_) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if iter_9_3 and iter_9_3.Dispose then
				iter_9_3:Dispose()
			end
		end
	end
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_1
