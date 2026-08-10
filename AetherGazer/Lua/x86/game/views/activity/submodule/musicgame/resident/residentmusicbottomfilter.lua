local var_0_0 = class("ResidentMusicBottomFilter", ReduxView)

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

	arg_3_0.filterItemList = {}
	arg_3_0.emptyController_ = arg_3_0.emptyCon_:GetController("empty")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clearBtn_, nil, function()
		if arg_4_0.clearCallback then
			arg_4_0.clearCallback()
		end
	end)
end

function var_0_0.SetClearCallback(arg_6_0, arg_6_1)
	arg_6_0.clearCallback = arg_6_1
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
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

	arg_7_0.filterBottomList = var_7_0

	for iter_7_4, iter_7_5 in pairs(arg_7_0.filterBottomList) do
		if not arg_7_0.filterItemList[iter_7_4] then
			arg_7_0.filterItemList[iter_7_4] = arg_7_0:CreateFilterItem()
		end

		arg_7_0.filterItemList[iter_7_4]:Show(true)
		arg_7_0.filterItemList[iter_7_4]:RefreshUI(iter_7_5.value, iter_7_5.type)
	end

	for iter_7_6 = #arg_7_0.filterBottomList + 1, #arg_7_0.filterItemList do
		arg_7_0.filterItemList[iter_7_6]:Show(false)
	end

	if #arg_7_0.filterBottomList > 0 then
		arg_7_0.emptyController_:SetSelectedState("false")
	else
		arg_7_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.CreateFilterItem(arg_9_0)
	local var_9_0 = Object.Instantiate(arg_9_0.filterItemGo_, arg_9_0.filterContent_)

	return MusicBottomFilterItem.New(var_9_0)
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.filterItemList) do
		iter_10_1:Dispose()

		iter_10_1 = nil
	end

	arg_10_0.filterItemList = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
