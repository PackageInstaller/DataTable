local ResidentMusicBottomFilter = class("ResidentMusicBottomFilter", ReduxView)

function ResidentMusicBottomFilter:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ResidentMusicBottomFilter:Init()
	self:InitUI()
	self:AddUIListener()
end

function ResidentMusicBottomFilter:InitUI()
	self:BindCfgUI()

	self.filterItemList = {}
	self.emptyController_ = self.emptyCon_:GetController("empty")
end

function ResidentMusicBottomFilter:AddUIListener()
	self:AddBtnListener(self.clearBtn_, nil, function()
		if self.clearCallback then
			self.clearCallback()
		end
	end)
end

function ResidentMusicBottomFilter:SetClearCallback(arg_6_1)
	self.clearCallback = arg_6_1
end

function ResidentMusicBottomFilter:RefreshUI(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1[MusicConst.MusicFilterType.verFilterKey]) do
		if iter_7_1 then
			table.insert(var_7_0, {
				value = iter_7_0,
				type = MusicConst.MusicFilterType.verFilterKey
			})
		end
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_1[MusicConst.MusicFilterType.tagFilterKey]) do
		if iter_7_3 then
			table.insert(var_7_0, {
				value = iter_7_2,
				type = MusicConst.MusicFilterType.tagFilterKey
			})
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		if arg_8_0.type == arg_8_1.type then
			return arg_8_0.value > arg_8_1.value
		else
			return arg_8_0.type > arg_8_1.type
		end
	end)

	self.filterBottomList = var_7_0

	for iter_7_4, iter_7_5 in pairs(self.filterBottomList) do
		self.filterItemList[iter_7_4] = self.filterItemList[iter_7_4] or self:CreateFilterItem()

		self.filterItemList[iter_7_4]:Show(true)
		self.filterItemList[iter_7_4]:RefreshUI(iter_7_5.value, iter_7_5.type)
	end

	for iter_7_6 = #self.filterBottomList + 1, #self.filterItemList do
		self.filterItemList[iter_7_6]:Show(false)
	end

	if #self.filterBottomList > 0 then
		self.emptyController_:SetSelectedState("false")
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function ResidentMusicBottomFilter:CreateFilterItem()
	return MusicBottomFilterItem.New((Object.Instantiate(self.filterItemGo_, self.filterContent_)))
end

function ResidentMusicBottomFilter:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.filterItemList) do
		iter_10_1:Dispose()

		iter_10_1 = nil
	end

	self.filterItemList = nil

	ResidentMusicBottomFilter.super.Dispose(self)
end

return ResidentMusicBottomFilter
