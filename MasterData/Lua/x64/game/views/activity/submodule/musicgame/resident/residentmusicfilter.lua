local ResidentMusicFilter = class("ResidentMusicFilter", ReduxView)

function ResidentMusicFilter:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ResidentMusicFilter:Init()
	self:InitUI()
	self:AddUIListener()
end

function ResidentMusicFilter:InitUI()
	self:BindCfgUI()
	self:InitFilterContent()
	self:RegistEventListener(MUSIC_FILTER_CLICK_ITEM, handler(self, self.OnFilterClickItem))

	self.bottomFilter = ResidentMusicBottomFilter.New(self.filterBottomObj_)

	self.bottomFilter:SetClearCallback(function()
		self:ClearFilter()
	end)
end

function ResidentMusicFilter:ClearFilter()
	self.filter_data_list = {
		[MusicConst.MusicFilterType.verFilterKey] = {},
		[MusicConst.MusicFilterType.tagFilterKey] = {}
	}

	self:UpdateFilterSelect()
end

function ResidentMusicFilter:OnOkBtn()
	MusicData:UpdateFilterList(self.filter_data_list)
	manager.notify:Invoke(MUSIC_FILTER_UPDATE)
end

function ResidentMusicFilter:OnEnter()
	self:RefreshUI()
end

function ResidentMusicFilter:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		manager.notify:Invoke(MUSIC_FILTER_COLSE)
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:OnOkBtn()
	end)
end

function ResidentMusicFilter:RefreshUI()
	self.filter_data_list = MusicData:GetFilterList()

	self:UpdateFilterSelect()
end

function ResidentMusicFilter:ShowView(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function ResidentMusicFilter:InitFilterContent()
	self.typeFilterList = {}
	self.versionFilterList = {}

	for iter_13_0, iter_13_1 in pairs(MusicConst.MusicTag) do
		local var_13_0 = self:CreateFilterItem(self.typeContent_, MusicConst.MusicFilterType.tagFilterKey)

		var_13_0:RefreshUI(iter_13_0, iter_13_1, MusicConst.MusicFilterType.tagFilterKey)

		self.typeFilterList[iter_13_0] = var_13_0
	end

	for iter_13_2, iter_13_3 in pairs(MusicData:GetActThemeList() or {}) do
		local var_13_1 = self:CreateFilterItem(self.versionContent_, MusicConst.MusicFilterType.verFilterKey)

		var_13_1:RefreshUI(iter_13_2, iter_13_3, MusicConst.MusicFilterType.verFilterKey)

		self.versionFilterList[iter_13_2] = var_13_1
	end
end

function ResidentMusicFilter:CreateFilterItem(arg_14_1)
	return MusicFilterItem.New((Object.Instantiate(self.filterItemObj_, arg_14_1)))
end

function ResidentMusicFilter:OnFilterClickItem(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0

	if arg_15_1 == MusicConst.MusicFilterType.tagFilterKey then
		var_15_0 = self.typeFilterList[arg_15_2]
	elseif arg_15_1 == MusicConst.MusicFilterType.verFilterKey then
		var_15_0 = self.versionFilterList[arg_15_2]
	end

	var_15_0:UpdateSelect(arg_15_3)

	self.filter_data_list[arg_15_1][var_15_0:GetFilterValue()] = arg_15_3

	self:UpdateBottomFiler()
end

function ResidentMusicFilter:UpdateFilterSelect()
	local var_16_0 = self.filter_data_list[MusicConst.MusicFilterType.verFilterKey] or {}

	for iter_16_0, iter_16_1 in pairs(self.versionFilterList) do
		iter_16_1:UpdateSelect(not not var_16_0[iter_16_1.filterValue])
	end

	local var_16_2 = self.filter_data_list[MusicConst.MusicFilterType.tagFilterKey] or {}

	for iter_16_2, iter_16_3 in pairs(self.typeFilterList) do
		iter_16_3:UpdateSelect(not not var_16_2[iter_16_3.filterValue])
	end

	self:UpdateBottomFiler()
end

function ResidentMusicFilter:UpdateBottomFiler()
	self.bottomFilter:RefreshUI(self.filter_data_list)
end

function ResidentMusicFilter:ChcekIsHaveFilter(arg_18_1, arg_18_2)
	local var_18_0 = false

	for iter_18_0, iter_18_1 in pairs(arg_18_2[arg_18_1]) do
		if iter_18_1 then
			var_18_0 = true

			break
		end
	end

	return var_18_0
end

function ResidentMusicFilter:CheckisClose(arg_19_1)
	if arg_19_1.tagType == MusicConst.MusicLinkTag.LimitLink then
		local var_19_1

		if ActivityData:GetActivityIsOpen(arg_19_1.activity_id) then
			do return false end

			var_19_1 = false
		end

		for iter_19_0, iter_19_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[arg_19_1.activity_id]) do
			if MusicData:GetIsComplete(iter_19_1) ~= 0 then
				var_19_1 = true

				break
			end
		end

		if var_19_1 then
			return false
		else
			return true
		end
	end

	return false
end

function ResidentMusicFilter:GetSelectMusicList()
	local var_20_0 = MusicData:GetFilterList()
	local var_20_1 = {}
	local var_20_2 = self:ChcekIsHaveFilter(MusicConst.MusicFilterType.verFilterKey, var_20_0)
	local var_20_3 = self:ChcekIsHaveFilter(MusicConst.MusicFilterType.tagFilterKey, var_20_0)
	local var_20_4 = {}

	for iter_20_0, iter_20_1 in ipairs(ActivityMusicCfg.all) do
		local var_20_5 = ActivityMusicCfg[iter_20_1].activity_id

		if not var_20_4[ActivityMusicCfg[iter_20_1].activity_id] then
			var_20_4[var_20_5] = true

			local var_20_6 = self:CheckisClose(ActivityMusicCfg[iter_20_1])
			local var_20_7 = false
			local var_20_8 = false

			if not var_20_6 then
				var_20_7 = not var_20_2 and true or self:CheckIsMeetActTheme(var_20_5, var_20_0)
				var_20_8 = not var_20_3 and true or self:CheckIsMeetTag(var_20_5, var_20_0)
			end

			if var_20_7 and var_20_8 and not var_20_6 then
				local var_20_9 = ActivityTools.GetActivityTheme(var_20_5)

				if var_20_1[var_20_9] == nil then
					var_20_1[var_20_9] = {}
					var_20_1[var_20_9].theme = var_20_9
					var_20_1[var_20_9].musicActList = {}
				end

				table.insert(var_20_1[var_20_9].musicActList, var_20_5)
			end
		end
	end

	local var_20_10 = {}

	for iter_20_2, iter_20_3 in pairs(var_20_1) do
		table.insert(var_20_10, iter_20_3)
	end

	table.sort(var_20_10, function(arg_21_0, arg_21_1)
		return arg_21_0.theme > arg_21_1.theme
	end)

	return var_20_10
end

function ResidentMusicFilter:CheckIsMeetActTheme(arg_22_1, arg_22_2)
	if self:GetFilterCount(arg_22_2, MusicConst.MusicFilterType.verFilterKey) == 0 then
		return true
	end

	return arg_22_2[MusicConst.MusicFilterType.verFilterKey][ActivityTools.GetActivityTheme(arg_22_1)]
end

function ResidentMusicFilter:GetFilterCount(arg_23_1, arg_23_2)
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

function ResidentMusicFilter:CheckIsMeetTag(arg_24_1, arg_24_2)
	if self:GetFilterCount(arg_24_2, MusicConst.MusicFilterType.tagFilterKey) == 0 then
		return true
	end

	local var_24_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_24_1]
	local var_24_1 = false

	for iter_24_0, iter_24_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[arg_24_1]) do
		if MusicConst.MusicFinishState.Unfinished ~= MusicData:GetIsComplete(iter_24_1) then
			var_24_1 = true

			break
		end
	end

	local var_24_3

	if var_24_0[1] then
		var_24_3 = ActivityMusicCfg[var_24_0[1]].tagType or -1
	end

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

function ResidentMusicFilter:OnExit()
	return
end

function ResidentMusicFilter:Dispose()
	self:RemoveAllEventListener()

	for iter_26_0, iter_26_1 in pairs(self.typeFilterList or {}) do
		iter_26_1:Dispose()

		iter_26_1 = nil
	end

	self.typeFilterList = nil

	for iter_26_2, iter_26_3 in pairs(self.versionFilterList or {}) do
		iter_26_3:Dispose()

		iter_26_3 = nil
	end

	self.versionFilterList = nil

	self.bottomFilter:Dispose()
	ResidentMusicFilter.super.Dispose(self)
end

return ResidentMusicFilter
