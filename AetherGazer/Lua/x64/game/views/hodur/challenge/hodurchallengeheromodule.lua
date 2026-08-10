local var_0_0 = class("HodurChallengeHeroModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.heroItemList_ = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.heroItemList_[iter_2_0] = HodurChallengeHeroItem.New(arg_2_0["heroGo_" .. iter_2_0])
	end

	arg_2_0.itemList_ = {}
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.chapterID_ = arg_3_1

	local var_3_0 = HodurTools.GetChallengeAffix()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = arg_3_0.itemList_[#arg_3_0.itemList_ + 1]

		if not var_3_1 then
			var_3_1 = HodurChallengeSelectAffixItem.New(Object.Instantiate(arg_3_0.affixGo_, arg_3_0.affixContentTrs_))
			arg_3_0.itemList_[#arg_3_0.itemList_ + 1] = var_3_1
		end

		var_3_1:SetData(iter_3_1)
		var_3_1:SetActive(true)
		var_3_1:SetClickHandler(function(arg_4_0)
			arg_3_0:OnClickAffixItem(arg_4_0, var_3_1)
		end)
	end

	for iter_3_2 = #var_3_0 + 1, #arg_3_0.itemList_ do
		arg_3_0.itemList_[iter_3_2]:SetActive(false)
	end

	arg_3_0:RefreshHero()
	arg_3_0:ShowTips(false)

	for iter_3_3, iter_3_4 in ipairs(arg_3_0.itemList_) do
		if iter_3_4.selected_ then
			iter_3_4:SetSelected(false)
		end
	end
end

function var_0_0.OnClickAffixItem(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2.selected_ then
		arg_5_2:SetSelected(false)
		arg_5_0:ShowTips(false)
	else
		arg_5_2:SetSelected(true)
		arg_5_0:ShowTips(true, arg_5_1)

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList_) do
			if iter_5_1 ~= arg_5_2 and iter_5_1.selected_ then
				iter_5_1:SetSelected(false)
			end
		end
	end
end

function var_0_0.ShowTips(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.showTips_ = arg_6_1

	SetActive(arg_6_0.tipsGo_, arg_6_1)

	if arg_6_1 then
		arg_6_0.affixNameText_.text = AffixTypeCfg[arg_6_2].name
		arg_6_0.affixDesText_.text = DescriptionCfg[AffixTypeCfg[arg_6_2].description[1]].description
	end
end

function var_0_0.RefreshHero(arg_7_0)
	arg_7_0.heroList_ = HodurTools.GetChallengeHero()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.heroItemList_) do
		local var_7_0 = arg_7_0.heroList_[iter_7_0]
		local var_7_1
		local var_7_2

		if var_7_0 then
			var_7_1, var_7_2 = HodurTools.GetChallengeHeroHP(var_7_0)
		end

		iter_7_1:SetData(var_7_0, var_7_1, var_7_2)
	end
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList_) do
		iter_8_1:Dispose()
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.heroItemList_) do
		iter_8_3:Dispose()
	end

	var_0_0.super.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
end

return var_0_0
