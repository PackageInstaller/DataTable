local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoNewWarChessView", var_0_0)

function var_0_1.UpdateBar(arg_1_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_1.RefreshHeroDataList(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	arg_2_0.trialHeroList_ = NewWarChessData:GetHeroIDList()

	for iter_2_0, iter_2_1 in pairs(arg_2_0.trialHeroList_) do
		local var_2_2 = HeroStandardSystemCfg[iter_2_1]

		table.insert(var_2_0, {
			id = var_2_2.hero_id,
			trialID = iter_2_1,
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			heroViewProxy = arg_2_0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
		})
		table.insert(var_2_1, iter_2_1)
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_0.heroViewProxyDic_) do
		iter_2_3:SetTempHeroList(var_2_1)
	end

	arg_2_0.filterView_:SetHeroIdList(var_2_0)
end

function var_0_1.GetDefaultHeroData(arg_3_0)
	local var_3_0 = SectionSelectHeroTools.GetCurSelectHeroData()

	if var_3_0 and var_3_0.id ~= 0 then
		return var_3_0
	end

	local var_3_1 = arg_3_0.heroTeam_[arg_3_0.params_.selectHeroPos] or 0

	if var_3_1 == 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.heroDataList_) do
			local var_3_2 = iter_3_1.id
			local var_3_3 = NewWarChessData:GetHeroHp(var_3_2)

			if not arg_3_0:IsInTeam(var_3_2, iter_3_1.trialID) and var_3_3 > 0 then
				return iter_3_1
			end
		end
	end

	if var_3_1 == 0 then
		for iter_3_2, iter_3_3 in pairs(arg_3_0.heroDataList_) do
			if NewWarChessData:GetHeroHp(iter_3_3.id) > 0 then
				return iter_3_3
			end
		end
	end

	return {
		trialID = 0,
		id = var_3_1,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroViewProxy = arg_3_0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function var_0_1.HeadRenderer(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.heroDataList_[arg_4_1].id
	local var_4_1 = arg_4_0.heroDataList_[arg_4_1].trialID

	arg_4_2:SetSectionHeroData(arg_4_0.heroDataList_[arg_4_1], arg_4_0.trialHeroList_)
	arg_4_2:SetSelected(arg_4_2.heroId_ == arg_4_0.selectHeroData_.id and arg_4_2.trialID_ == arg_4_0.selectHeroData_.trialID)
	arg_4_2:RegisterClickListener(function()
		if arg_4_0.backFlag_ then
			return
		end

		if NewWarChessData:GetHeroHp(arg_4_2.heroId_) <= 0 then
			ShowTips("ACTIVITY_NEW_WARCHESS_HERO_DIE")

			return
		end

		arg_4_0:SelectHero(arg_4_0.heroDataList_[arg_4_1])
	end)
	arg_4_2:SetInTeamFlag(arg_4_0:IsInTeam(var_4_0, var_4_1))

	local var_4_2, var_4_3 = arg_4_0.sectionProxy_:CustomGetHeroHP(nil, arg_4_2.heroId_)

	arg_4_2:RefreshHpValue(var_4_3)
	arg_4_2:SetHp(true)

	if var_4_2 <= 0 then
		arg_4_2:SetLocking(true)
	else
		arg_4_2:SetLocking(false)
	end
end

return var_0_1
