local var_0_0 = class("NewHeroArchivePlotItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.plotIcon_.immediate = true

	arg_3_0:AddUIListener()

	arg_3_0.picController_ = ControllerUtil.GetController(arg_3_0.transform_, "plot")
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "item")
	arg_3_0.plotPiccontroller_ = ControllerUtil.GetController(arg_3_0.plotBtn_.transform, "get")
	arg_3_0.redPointController_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		if not arg_4_0.isUnlock then
			if arg_4_0.type_ == 1 then
				ShowTips(string.format(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_LOVE"), arg_4_0.all))
			elseif arg_4_0.type_ == 2 then
				local var_5_0 = GetTips("HERO_TRUST_LEVEL_DES_" .. arg_4_0.all)

				ShowTips(string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), arg_4_0.trustTips, var_5_0))
			end

			return
		end

		if arg_4_0.needViewedFrontPlot or arg_4_0.needViewedFrontSuperPlot then
			ShowTips(GetTips("ERROR_HERO_ARCHIVES_PREVIOUS_PLOT_NOT_VIEWED"))

			return
		end

		if arg_4_0.needViewedNormalPlot then
			ShowTips(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_COMMON_PLOT_NOT_VIEWED_TIP"))

			return
		end

		manager.story:StartStoryById(arg_4_0.plotID_, function(arg_6_0)
			HeroAction.ReadStory(arg_4_0.archiveID_, arg_4_0.plotID_, arg_4_0.type_, arg_4_0.index_)

			if arg_4_0.stroyCallBack then
				arg_4_0.stroyCallBack()
			end
		end)
	end)
	arg_4_0:AddBtnListener(arg_4_0.plotBtn_, nil, function()
		if arg_4_0.isLock then
			ShowTips(GetTips("ERROR_NO_UNLOCK_INBETWEENING"))

			return
		end

		if arg_4_0.plotIsViewed == 0 then
			for iter_7_0, iter_7_1 in ipairs(arg_4_0.collectPicList_) do
				IllustratedAction.ViewIllustration(iter_7_1, CollectConst.ILLUSTRATION)
			end

			local var_7_0 = {}

			for iter_7_2, iter_7_3 in ipairs(arg_4_0.collectPicList_) do
				local var_7_1 = IllustratedData:GetIllustrationInfo()[iter_7_3]

				if var_7_1 and var_7_1.is_receive == 0 then
					table.insert(var_7_0, iter_7_3)
				end
			end

			IllustratedAction.ReceiveIllustrationReward(var_7_0)
			arg_4_0:RefreshUI()
		else
			arg_4_0:Go("/illuIllustrationDetail", {
				ID = arg_4_0.collectPicList_[1],
				chapterList = {
					arg_4_0.collectPicList_[1]
				}
			})
		end
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0.data_ = arg_8_1
	arg_8_0.plotID_ = arg_8_2
	arg_8_0.archiveID_ = arg_8_3
	arg_8_0.index_ = arg_8_4
	arg_8_0.type_ = arg_8_5
	arg_8_0.needViewedNormalPlot = false
	arg_8_0.needViewedFrontPlot = false
	arg_8_0.needViewedFrontSuperPlot = false
	arg_8_0.recordData_ = HeroRecordCfg[arg_8_0.archiveID_]
	arg_8_0.archiveData_ = ArchiveData:GetArchive(arg_8_3)
	arg_8_0.collectPicList_ = CollectPictureCfg.get_id_list_by_additional_parameter[arg_8_0.plotID_]

	arg_8_0:RefreshUI()
end

function var_0_0.SetStoryCallBack(arg_9_0, arg_9_1)
	arg_9_0.stroyCallBack = arg_9_1
end

function var_0_0.SetPlotCallBack(arg_10_0, arg_10_1)
	arg_10_0.callPlotback = arg_10_1
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.title_.text = GetI18NText(StoryCfg[arg_11_0.plotID_].name)

	arg_11_0:RefreshPlotPicUI()
	arg_11_0:RefreshPlotUI()
end

function var_0_0.RefreshPlotUI(arg_12_0)
	arg_12_0:CheckIsUnlock()

	if arg_12_0.isUnlock and not arg_12_0.needViewedFrontPlot and not arg_12_0.needViewedNormalPlot and not arg_12_0.needViewedFrontSuperPlot then
		arg_12_0:RefreshUnLockUI()
	else
		arg_12_0:RefreshLockText()
	end
end

function var_0_0.CheckIsUnlock(arg_13_0)
	local var_13_0
	local var_13_1
	local var_13_2 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.archiveData_.video_list) do
		var_13_2 = var_13_2 + 1
	end

	if arg_13_0.type_ == 1 then
		arg_13_0.gameSettingCfgID = GameSetting.hero_plot_unlock_condition.value[arg_13_0.index_]

		local var_13_3

		arg_13_0.isUnlock, var_13_3, var_13_1 = IsConditionAchieved(arg_13_0.gameSettingCfgID, {
			heroId = arg_13_0.archiveID_
		})
		arg_13_0.needViewedFrontPlot = var_13_2 < arg_13_0.index_ - 1
	elseif arg_13_0.type_ == 2 then
		arg_13_0.gameSettingCfgID = GameSetting.hero_super_plot_unlock_condition.value[arg_13_0.index_]
		arg_13_0.isUnlock = false
		arg_13_0.trustTips = GetI18NText(HeroCfg[arg_13_0.recordData_.hero_id[1]].name)

		for iter_13_2, iter_13_3 in pairs(arg_13_0.recordData_.hero_id) do
			local var_13_4
			local var_13_5, var_13_6, var_13_7 = IsConditionAchieved(arg_13_0.gameSettingCfgID, {
				heroId = iter_13_3
			})

			var_13_1 = var_13_7

			local var_13_8 = var_13_6

			if var_13_5 then
				arg_13_0.isUnlock = true
			end

			local var_13_9 = GetI18NText(HeroCfg[iter_13_3].name)

			if iter_13_2 > 1 then
				arg_13_0.trustTips = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_2"), arg_13_0.trustTips, var_13_9)
			end
		end

		arg_13_0.needViewedFrontSuperPlot = #ArchiveData:GetHasViewedSuperHeartList(arg_13_0.archiveID_) < arg_13_0.index_ - 1
		arg_13_0.needViewedNormalPlot = var_13_2 < #arg_13_0.recordData_.plot_id
	end

	arg_13_0.all = var_13_1

	arg_13_0.redPointController_:SetSelectedState("no")
end

function var_0_0.RefreshUnLockUI(arg_14_0)
	local var_14_0

	if arg_14_0.type_ == 1 then
		arg_14_0.controller_:SetSelectedState("1")

		var_14_0 = ArchiveData:IsStoryRead(arg_14_0.archiveID_, arg_14_0.plotID_)
	elseif arg_14_0.type_ == 2 then
		arg_14_0.controller_:SetSelectedState("3")

		var_14_0 = ArchiveData:IsSuperHeartRead(arg_14_0.archiveID_, arg_14_0.index_)
	end

	if var_14_0 then
		arg_14_0.redPointController_:SetSelectedState("no")
	else
		arg_14_0.redPointController_:SetSelectedState("yes")
	end
end

function var_0_0.RefreshLockText(arg_15_0)
	local var_15_0 = ConditionCfg[arg_15_0.gameSettingCfgID]

	arg_15_0.lockText_.text = GetI18NText(var_15_0.desc)

	if arg_15_0.type_ == 1 then
		arg_15_0.controller_:SetSelectedState("2")

		if arg_15_0.needViewedFrontPlot and arg_15_0.isUnlock then
			arg_15_0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_PREVIOUS_PLOT_NOT_VIEWED")
		end
	elseif arg_15_0.type_ == 2 then
		arg_15_0.controller_:SetSelectedState("4")

		if arg_15_0.isUnlock then
			if arg_15_0.needViewedFrontPlot or arg_15_0.needViewedFrontSuperPlot then
				arg_15_0.lockText_.text = GetTips("ERROR_HERO_ARCHIVES_PREVIOUS_PLOT_NOT_VIEWED")
			elseif arg_15_0.needViewedNormalPlot then
				arg_15_0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_COMMON_PLOT_NOT_VIEWED_TIP")
			end
		else
			local var_15_1 = GetTips("HERO_TRUST_LEVEL_DES_" .. arg_15_0.all)

			arg_15_0.lockText_.text = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), arg_15_0.trustTips, var_15_1)
		end
	end
end

function var_0_0.RefreshPlotPicUI(arg_16_0)
	if arg_16_0.collectPicList_ then
		arg_16_0.picController_:SetSelectedState("yes")
	else
		arg_16_0.picController_:SetSelectedState("no")

		return
	end

	local var_16_0 = arg_16_0.collectPicList_[1]

	arg_16_0.plotIcon_.spriteSync = "TextureConfig/IllustratedHandbook/Collect_s/" .. CollectPictureCfg[var_16_0].picture

	local var_16_1 = 0

	arg_16_0.overLappingGo_:SetActive(#arg_16_0.collectPicList_ > 1)

	for iter_16_0, iter_16_1 in pairs(arg_16_0.collectPicList_) do
		var_16_1 = var_16_1 + CollectPictureCfg[iter_16_1].reward[1][2]

		local var_16_2 = IllustratedData:GetIllustrationInfo()[iter_16_1]

		if var_16_2 then
			arg_16_0.plotIsViewed = var_16_2.is_receive or 0
		else
			arg_16_0.plotIsViewed = 0
		end
	end

	arg_16_0.rewardCount_.text = "x" .. var_16_1
	arg_16_0.isLock = false

	for iter_16_2, iter_16_3 in pairs(arg_16_0.collectPicList_) do
		if IllustratedData:GetIllustrationInfo()[iter_16_3] == nil then
			arg_16_0.plotPiccontroller_:SetSelectedState("lock")

			arg_16_0.isLock = true

			return
		end
	end

	if arg_16_0.plotIsViewed == 1 then
		arg_16_0.plotPiccontroller_:SetSelectedState("yes")
	else
		arg_16_0.plotPiccontroller_:SetSelectedState("no")
	end
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
