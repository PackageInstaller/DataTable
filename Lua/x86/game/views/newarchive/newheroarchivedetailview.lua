local var_0_0 = class("NewHeroArchiveDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_chain/HeroChainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.bgImg_.immediate = true
	arg_4_0.bgController_ = ControllerUtil.GetController(arg_4_0.transform_, "bg")

	arg_4_0:AddUIListener()
	arg_4_0:RegistEventListener(UPDATE_WALLPAPER, function()
		arg_4_0:RefreshBgUI()
	end)
	arg_4_0:RegistEventListener(UPDATE_HEARTLIST, function()
		arg_4_0:RefreshPlotList()
	end)

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexPlotItem), arg_4_0.plotList_, NewHeroArchivePlotItemView)
	arg_4_0.uiStoryList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexStoryItem), arg_4_0.storyList_, NewHeroArchiveStoryItemView)
end

function var_0_0.IndexPlotItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == #arg_7_0.plotIdList_ or arg_7_1 == #arg_7_0.superPlotIdList_ + #arg_7_0.plotIdList_ then
		SetActive(arg_7_2.nextLine_, false)
	else
		SetActive(arg_7_2.nextLine_, true)
	end

	if arg_7_1 <= #arg_7_0.plotIdList_ then
		arg_7_2:SetData(arg_7_0.recordData_, arg_7_0.recordData_.plot_id[arg_7_1], arg_7_0.data_.archive_id, arg_7_1, 1)
	else
		arg_7_2:SetData(arg_7_0.recordData_, arg_7_0.recordData_.super_plot_id[arg_7_1 - #arg_7_0.plotIdList_], arg_7_0.data_.archive_id, arg_7_1 - #arg_7_0.plotIdList_, 2)
	end

	arg_7_2:SetStoryCallBack(function()
		saveData("ModuleList_" .. USER_ID, "PlotIndex_" .. arg_7_0.data_.archive_id, arg_7_1)

		arg_7_0.index_ = arg_7_1
	end)
end

function var_0_0.IndexStoryItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(HeroAnedoteCfg[arg_9_0.storyList_[arg_9_1]], arg_9_0.data_.archive_id)
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.backgroundBtn_, nil, function()
		JumpTools.OpenPageByJump("newHeroWallPaperPopView", {
			data = arg_10_0.data_
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.giftBtn_, nil, function()
		local var_12_0 = arg_10_0.recordData_.hero_id

		table.sort(var_12_0, function(arg_13_0, arg_13_1)
			local var_13_0 = HeroData:GetHeroData(arg_13_0)
			local var_13_1 = HeroData:GetHeroData(arg_13_1)
			local var_13_2 = ArchiveData:GetTrustLevel(arg_13_0)
			local var_13_3 = ArchiveData:GetTrustLevel(arg_13_1)

			if var_13_0.unlock == 1 and var_13_1.unlock == 0 then
				return true
			elseif var_13_0.unlock == 0 and var_13_1.unlock == 1 then
				return false
			elseif var_13_3 < var_13_2 then
				return true
			elseif var_13_2 < var_13_3 then
				return false
			else
				return arg_13_0 < arg_13_1
			end
		end)
		JumpTools.GoToSystem("/heroArchive", {
			pageID = 3,
			heroID = var_12_0[1]
		})
	end)
end

function var_0_0.OnEnter(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_14_0.isBackHome_ = arg_14_0.params_.isBackHome

	manager.windowBar:RegistBackCallBack(function()
		if arg_14_0.isBackHome_ then
			JumpTools.OpenPageByJump("/home")
		else
			JumpTools.Back()
		end
	end)

	arg_14_0.id_ = arg_14_0.params_.id
	arg_14_0.data_ = ArchiveData:GetArchive(arg_14_0.id_)
	arg_14_0.recordData_ = HeroRecordCfg[arg_14_0.data_.archive_id]
	arg_14_0.index_ = getData("ModuleList_" .. USER_ID, "PlotIndex_" .. arg_14_0.data_.archive_id) or 0
	arg_14_0.plotIdList_ = arg_14_0.recordData_.plot_id
	arg_14_0.superPlotIdList_ = arg_14_0.recordData_.super_plot_id

	arg_14_0.uiList_:StartScroll(#arg_14_0.plotIdList_ + #arg_14_0.superPlotIdList_, arg_14_0.index_, true, false)

	arg_14_0.storyList_ = {}
	arg_14_0.heroIdList_ = arg_14_0.recordData_.hero_id

	local var_14_0 = arg_14_0.uiList_:GetScrolledPosition()

	arg_14_0.timer = Timer.New(function()
		arg_14_0.filmAni_:SetFloat("floatSpeed", (arg_14_0.uiList_:GetScrolledPosition().x - var_14_0.x) * 3)

		var_14_0 = arg_14_0.uiList_:GetScrolledPosition()
	end, 0.1, -1, true)

	arg_14_0.timer:Start()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.heroIdList_) do
		if HeroAnedoteCfg[iter_14_1] then
			table.insert(arg_14_0.storyList_, iter_14_1)
		end
	end

	arg_14_0.uiStoryList_:StartScroll(#arg_14_0.storyList_)
	arg_14_0:RefreshUI()

	local var_14_1 = HeroTools.GetHeroOntologyID(arg_14_0.id_)

	manager.redPoint:setTip(RedPointConst.HERO_STORY_ID .. var_14_1, 0)
	manager.redPoint:setTip(RedPointConst.HERO_SUPER_STORY_ID .. var_14_1, 0)
	manager.redPoint:setTip(RedPointConst.HERO_ANEDOTE_ID .. var_14_1, 0)

	local var_14_2 = "heartStroy_" .. PlayerData:GetPlayerInfo().userID .. "_" .. HeroRecordCfg.get_id_list_by_hero_id[arg_14_0.id_][1]
	local var_14_3, var_14_4, var_14_5 = ArchiveData:GetUnlockHeartListInfoLengthByHeroId(arg_14_0.id_)
	local var_14_6 = {
		var_14_3,
		var_14_4,
		var_14_5
	}

	saveData("HearListRedPoint", var_14_2, var_14_6)
end

function var_0_0.RefreshUI(arg_17_0)
	if not arg_17_0.favorItemList_ then
		arg_17_0.favorItemList_ = {}
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.favorItemList_) do
		SetActive(iter_17_1.gameObject_, false)
		iter_17_1:ResetData()
	end

	local var_17_0 = false

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.heroIdList_) do
		if ArchiveData:GetTrustLevel(iter_17_3) > 0 then
			var_17_0 = true
		end
	end

	local var_17_1 = 0

	for iter_17_4, iter_17_5 in ipairs(arg_17_0.heroIdList_) do
		local var_17_2 = HeroData:GetHeroData(arg_17_0.heroIdList_[iter_17_4])

		if var_17_2.unlock == 1 then
			var_17_1 = var_17_1 + 1

			if not arg_17_0.favorItemList_[var_17_1] then
				local var_17_3 = Object.Instantiate(arg_17_0.favorabilityItem_)
				local var_17_4 = NewHeroArchiveHerofavorItemView.New(var_17_3, var_17_1)

				var_17_4.transform_:SetParent(arg_17_0.favorabilityList_, false)
				table.insert(arg_17_0.favorItemList_, var_17_4)
			end

			arg_17_0.favorItemList_[var_17_1]:SetData(arg_17_0.data_, var_17_2.id, var_17_1)
			SetActive(arg_17_0.favorItemList_[var_17_1].gameObject_, true)
		end
	end

	for iter_17_6, iter_17_7 in ipairs(arg_17_0.favorItemList_) do
		iter_17_7:RefreshUI(var_17_0)
	end

	arg_17_0.uiStoryList_:Refresh()
	arg_17_0:RefreshBgUI()
end

function var_0_0.RefreshBgUI(arg_18_0)
	local var_18_0 = ArchiveData:GetSelectPicture(arg_18_0.data_.archive_id)

	arg_18_0.bgController_:SetSelectedState("role")

	if table.isEmpty(var_18_0) or var_18_0.type == 0 then
		local var_18_1 = false

		for iter_18_0, iter_18_1 in ipairs(arg_18_0.heroIdList_) do
			if HeroData:GetHeroData(iter_18_1).unlock == 1 and not var_18_1 then
				ArchiveAction.SendSetWallPaper(arg_18_0.data_.archive_id, iter_18_1, 1)

				arg_18_0.bgImg_.spriteSync = "TextureConfig/Character/Icon/" .. iter_18_1
				var_18_1 = true
			end
		end

		if not var_18_1 then
			arg_18_0.bgImg_.spriteSync = "TextureConfig/Character/Icon/" .. arg_18_0.heroIdList_[1]
		end
	elseif var_18_0.type == 1 or var_18_0.type == 2 then
		arg_18_0.bgController_:SetSelectedState("role")

		arg_18_0.bgImg_.spriteSync = "TextureConfig/Character/Portrait/" .. var_18_0.id
	elseif var_18_0.type == 3 then
		arg_18_0.bgController_:SetSelectedState("plot")

		local var_18_2 = CollectPictureCfg[var_18_0.id].picture

		arg_18_0.plotImg_.spriteDownload = "TextureConfig/Background/" .. var_18_2
	end
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()

	if arg_19_0.timer then
		arg_19_0.timer:Stop()

		arg_19_0.timer = nil
	end
end

function var_0_0.OnReceiveIllustrationReward(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.item_list
	local var_20_1 = formatRewardCfgList(var_20_0)
	local var_20_2 = mergeReward(var_20_1)

	getReward(var_20_2)
	arg_20_0:RefreshPlotList()
end

function var_0_0.OnReceiveIllustration(arg_21_0)
	arg_21_0:RefreshPlotList()
end

function var_0_0.RefreshPlotList(arg_22_0)
	arg_22_0.uiList_:Refresh()
	arg_22_0.uiList_:ScrollToIndex(arg_22_0.index_, true, false)
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.uiList_ then
		arg_23_0.uiList_:Dispose()

		arg_23_0.uiList_ = nil
	end

	if arg_23_0.uiStoryList_ then
		arg_23_0.uiStoryList_:Dispose()

		arg_23_0.uiStoryList_ = nil
	end

	if arg_23_0.favorItemList_ then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.favorItemList_) do
			iter_23_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_23_0)
	arg_23_0:RemoveAllEventListener()
end

return var_0_0
