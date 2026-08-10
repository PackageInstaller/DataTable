local var_0_0 = class("HeroAstrolabeInfoView", HeroAstrolabeBaseInfoView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0.super.InitUI(arg_1_0)

	arg_1_0.itemS_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.itemS_[iter_1_0] = {}

		for iter_1_1 = 1, 3 do
			local var_1_0 = arg_1_0[string.format("item%d_%dGo_", iter_1_0, iter_1_1)]
			local var_1_1 = Object.Instantiate(arg_1_0.nodeitemGo_1, var_1_0.transform)

			arg_1_0.itemS_[iter_1_0][iter_1_1] = AstrolabeItem.New(arg_1_0, var_1_1, iter_1_0)
		end
	end
end

function var_0_0.AddUIListener(arg_2_0)
	return
end

function var_0_0.ChangeStyle(arg_3_0, arg_3_1)
	arg_3_0.styleController_:SetSelectedState(arg_3_1)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.heroInfo_ = arg_5_1
	arg_5_0.astrolabeInfo_ = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemS_ or {}) do
		local var_5_0 = arg_5_0.astrolabeInfo_[iter_5_0]

		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			local var_5_1 = var_5_0.astrolabe[iter_5_2]

			iter_5_3:SetNodeNameIsHide(arg_5_0.isHideNodeName)
			iter_5_3:SetProxy(arg_5_0.heroViewProxy_)
			iter_5_3:RefreshUI(var_5_1, arg_5_0.heroInfo_)
		end
	end
end

function var_0_0.RefreshRedPoint(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemS_) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			local var_6_0 = iter_6_3:GetItemInfo()

			if arg_6_0.heroViewProxy_ and (arg_6_0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW or arg_6_0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON) then
				iter_6_3:SetRedPoint(false)
			else
				iter_6_3:SetRedPoint(AstrolabeTools.GetIsCanUnlock(var_6_0.id, var_6_0.heroId))
			end
		end
	end
end

function var_0_0.OnEnter(arg_7_0, arg_7_1)
	arg_7_0.heroViewProxy_ = arg_7_1
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.GetFirstSelectItem(arg_9_0)
	if arg_9_0.heroInfo_ and arg_9_0.astrolabeInfo_ then
		local var_9_0 = arg_9_0.heroInfo_.using_astrolabe[#arg_9_0.heroInfo_.using_astrolabe]

		if var_9_0 then
			for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemS_ or {}) do
				for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
					if iter_9_3:GetItemInfo().id == var_9_0 then
						return iter_9_3
					end
				end
			end
		end
	end

	return arg_9_0:GetItem(1, 1)
end

function var_0_0.GetItem(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0.itemS_[arg_10_1][arg_10_2]
end

function var_0_0.RegistCallBack(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemS_ or {}) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			iter_11_3:RegistCallBack(arg_11_1)
		end
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.itemS_ then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.itemS_) do
			for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
				iter_12_3:Dispose()
			end
		end
	end

	arg_12_0.itemSGo_ = nil
	arg_12_0.itemS_ = nil
	arg_12_0.astrolabeInfo_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.SetNodeNameIsHide(arg_13_0, arg_13_1)
	arg_13_0.isHideNodeName = arg_13_1
end

return var_0_0
