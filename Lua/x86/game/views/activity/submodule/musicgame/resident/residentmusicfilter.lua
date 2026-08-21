local var_0_0 = class("ResidentMusicFilter", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitFilterContent()
	arg_3_0:RegistEventListener(MUSIC_FILTER_CLICK_ITEM, handler(arg_3_0, arg_3_0.OnFilterClickItem))

	arg_3_0.bottomFilter = ResidentMusicBottomFilter.New(arg_3_0.filterBottomObj_)

	arg_3_0.bottomFilter:SetClearCallback(function()
		arg_3_0:ClearFilter()
	end)
end

function var_0_0.ClearFilter(arg_5_0)
	arg_5_0.filter_data_list = {
		[MusicConst.MusicFilterType.verFilterKey] = {},
		[MusicConst.MusicFilterType.tagFilterKey] = {}
	}

	arg_5_0:UpdateFilterSelect()
end

function var_0_0.OnOkBtn(arg_6_0)
	MusicData:UpdateFilterList(arg_6_0.filter_data_list)
	manager.notify:Invoke(MUSIC_FILTER_UPDATE)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		manager.notify:Invoke(MUSIC_FILTER_COLSE)
	end)
	arg_8_0:AddBtnListener(arg_8_0.okBtn_, nil, function()
		arg_8_0:OnOkBtn()
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.filter_data_list = MusicData:GetFilterList()

	arg_11_0:UpdateFilterSelect()
end

function var_0_0.ShowView(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.InitFilterContent(arg_13_0)
	arg_13_0.typeFilterList = {}
	arg_13_0.versionFilterList = {}

	for iter_13_0, iter_13_1 in pairs(MusicConst.MusicTag) do
		local var_13_0 = arg_13_0:CreateFilterItem(arg_13_0.typeContent_, MusicConst.MusicFilterType.tagFilterKey)

		var_13_0:RefreshUI(iter_13_0, iter_13_1, MusicConst.MusicFilterType.tagFilterKey)

		arg_13_0.typeFilterList[iter_13_0] = var_13_0
	end

	local var_13_1 = MusicData:GetActThemeList()

	for iter_13_2, iter_13_3 in pairs(var_13_1 or {}) do
		local var_13_2 = arg_13_0:CreateFilterItem(arg_13_0.versionContent_, MusicConst.MusicFilterType.verFilterKey)

		var_13_2:RefreshUI(iter_13_2, iter_13_3, MusicConst.MusicFilterType.verFilterKey)

		arg_13_0.versionFilterList[iter_13_2] = var_13_2
	end
end

function var_0_0.CreateFilterItem(arg_14_0, arg_14_1)
	local var_14_0 = Object.Instantiate(arg_14_0.filterItemObj_, arg_14_1)

	return MusicFilterItem.New(var_14_0)
end

function var_0_0.OnFilterClickItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0

	if arg_15_1 == MusicConst.MusicFilterType.tagFilterKey then
		var_15_0 = arg_15_0.typeFilterList[arg_15_2]
	elseif arg_15_1 == MusicConst.MusicFilterType.verFilterKey then
		var_15_0 = arg_15_0.versionFilterList[arg_15_2]
	end

	var_15_0:UpdateSelect(arg_15_3)

	arg_15_0.filter_data_list[arg_15_1][var_15_0:GetFilterValue()] = arg_15_3

	arg_15_0:UpdateBottomFiler()
end

function var_0_0.UpdateFilterSelect(arg_16_0)
	local var_16_0 = arg_16_0.filter_data_list
	local var_16_1 = var_16_0[MusicConst.MusicFilterType.verFilterKey] or {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.versionFilterList) do
		local var_16_2 = false

		if var_16_1[iter_16_1.filterValue] then
			var_16_2 = true
		end

		iter_16_1:UpdateSelect(var_16_2)
	end

	local var_16_3 = var_16_0[MusicConst.MusicFilterType.tagFilterKey] or {}

	for iter_16_2, iter_16_3 in pairs(arg_16_0.typeFilterList) do
		local var_16_4 = false

		if var_16_3[iter_16_3.filterValue] then
			var_16_4 = true
		end

		iter_16_3:UpdateSelect(var_16_4)
	end

	arg_16_0:UpdateBottomFiler()
end

function var_0_0.UpdateBottomFiler(arg_17_0)
	arg_17_0.bottomFilter:RefreshUI(arg_17_0.filter_data_list)
end

function var_0_0.ChcekIsHaveFilter(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2[arg_18_1]
	local var_18_1 = false

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if iter_18_1 then
			var_18_1 = true

			break
		end
	end

	return var_18_1
end

function var_0_0.CheckisClose(arg_19_0, arg_19_1)
	local var_19_0 = false

	if arg_19_1.tagType == MusicConst.MusicLinkTag.LimitLink then
		if ActivityData:GetActivityIsOpen(arg_19_1.activity_id) then
			return false
		end

		local var_19_1 = ActivityMusicCfg.get_id_list_by_activity_id[arg_19_1.activity_id]
		local var_19_2 = false

		for iter_19_0, iter_19_1 in ipairs(var_19_1) do
			if MusicData:GetIsComplete(iter_19_1) ~= 0 then
				var_19_2 = true

				break
			end
		end

		if var_19_2 then
			return false
		else
			return true
		end
	end

	return false
end

function var_0_0.GetSelectMusicList(arg_20_0)
	local var_20_0 = MusicData:GetFilterList()
	local var_20_1 = {}
	local var_20_2 = arg_20_0:ChcekIsHaveFilter(MusicConst.MusicFilterType.verFilterKey, var_20_0)
	local var_20_3 = arg_20_0:ChcekIsHaveFilter(MusicConst.MusicFilterType.tagFilterKey, var_20_0)
	local var_20_4 = {}

	for iter_20_0, iter_20_1 in ipairs(ActivityMusicCfg.all) do
		local var_20_5 = ActivityMusicCfg[iter_20_1]
		local var_20_6 = var_20_5.activity_id

		if not var_20_4[var_20_6] then
			var_20_4[var_20_6] = true

			local var_20_7 = arg_20_0:CheckisClose(var_20_5)
			local var_20_8 = false
			local var_20_9 = false

			if not var_20_7 then
				var_20_8 = not var_20_2 and true or arg_20_0:CheckIsMeetActTheme(var_20_6, var_20_0)
				var_20_9 = not var_20_3 and true or arg_20_0:CheckIsMeetTag(var_20_6, var_20_0)
			end

			if var_20_8 and var_20_9 and not var_20_7 then
				local var_20_10 = ActivityTools.GetActivityTheme(var_20_6)

				if var_20_1[var_20_10] == nil then
					var_20_1[var_20_10] = {}
					var_20_1[var_20_10].theme = var_20_10
					var_20_1[var_20_10].musicActList = {}
				end

				table.insert(var_20_1[var_20_10].musicActList, var_20_6)
			end
		end
	end

	local var_20_11 = {}

	for iter_20_2, iter_20_3 in pairs(var_20_1) do
		table.insert(var_20_11, iter_20_3)
	end

	table.sort(var_20_11, function(arg_21_0, arg_21_1)
		return arg_21_0.theme > arg_21_1.theme
	end)

	return var_20_11
end

function var_0_0.CheckIsMeetActTheme(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0:GetFilterCount(arg_22_2, MusicConst.MusicFilterType.verFilterKey) == 0 then
		return true
	end

	local var_22_0 = ActivityTools.GetActivityTheme(arg_22_1)

	return arg_22_2[MusicConst.MusicFilterType.verFilterKey][var_22_0]
end

function var_0_0.GetFilterCount(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = 0

	if arg_23_1[arg_23_2] then
		for iter_23_0, iter_23_1 in pairs(arg_23_1[arg_23_2]) do
			if iter_23_1 then
				var_23_0 = var_23_0 + 1
			end
		end
	end

	return var_23_0
end

function var_0_0.CheckIsMeetTag(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0:GetFilterCount(arg_24_2, MusicConst.MusicFilterType.tagFilterKey) == 0 then
		return true
	end

	local var_24_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_24_1]
	local var_24_1 = false

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_24_2 = ActivityMusicCfg[iter_24_1]

		if MusicConst.MusicFinishState.Unfinished ~= MusicData:GetIsComplete(iter_24_1) then
			var_24_1 = true

			break
		end
	end

	local var_24_3 = var_24_0[1] and ActivityMusicCfg[var_24_0[1]].tagType or -1

	for iter_24_2, iter_24_3 in pairs(arg_24_2[MusicConst.MusicFilterType.tagFilterKey]) do
		if iter_24_3 then
			if iter_24_2 == MusicConst.MusicTag.New then
				if ActivityData:GetActivityIsOpen(arg_24_1) then
					return true
				end
			elseif iter_24_2 == MusicConst.MusicTag.Link then
				if var_24_3 == MusicConst.MusicLinkTag.Link or var_24_3 == MusicConst.MusicLinkTag.LimitLink then
					return true
				end
			elseif iter_24_2 == MusicConst.MusicTag.Original then
				if var_24_3 == MusicConst.MusicLinkTag.None then
					return true
				end
			elseif iter_24_2 == MusicConst.MusicTag.Unfinished then
				if not var_24_1 then
					return true
				end
			elseif iter_24_2 == MusicConst.MusicTag.Finished and var_24_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.OnExit(arg_25_0)
	return
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0:RemoveAllEventListener()

	for iter_26_0, iter_26_1 in pairs(arg_26_0.typeFilterList or {}) do
		iter_26_1:Dispose()

		iter_26_1 = nil
	end

	arg_26_0.typeFilterList = nil

	for iter_26_2, iter_26_3 in pairs(arg_26_0.versionFilterList or {}) do
		iter_26_3:Dispose()

		iter_26_3 = nil
	end

	arg_26_0.versionFilterList = nil

	arg_26_0.bottomFilter:Dispose()
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
