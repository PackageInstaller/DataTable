local var_0_0 = class("FishingGroupPageView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.idList_ = ActivitySummerFishGroupCfg.all

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.SortData(arg_3_0)
	local var_3_0 = FishingData:GetActivityData().received_constitute_list

	table.sort(arg_3_0.idList_, function(arg_4_0, arg_4_1)
		local var_4_0 = ActivitySummerFishGroupCfg[arg_4_0]
		local var_4_1 = ActivitySummerFishGroupCfg[arg_4_1]
		local var_4_2 = table.indexof(var_3_0, var_4_0.id) or 0
		local var_4_3 = table.indexof(var_3_0, var_4_1.id) or 0

		if (var_4_2 == 0 or var_4_3 == 0) and var_4_2 ~= var_4_3 then
			return var_4_2 < var_4_3
		end

		local var_4_4 = 1

		for iter_4_0, iter_4_1 in ipairs(var_4_0.group[1]) do
			local var_4_5
			local var_4_6 = FishingData:GetActivityData().fish_infos[iter_4_1]

			if not (var_4_6 and var_4_6.num > 0 and true or false) then
				var_4_4 = 0

				break
			end
		end

		local var_4_7 = 1

		for iter_4_2, iter_4_3 in ipairs(var_4_1.group[1]) do
			local var_4_8
			local var_4_9 = FishingData:GetActivityData().fish_infos[iter_4_3]

			if not (var_4_9 and var_4_9.num > 0 and true or false) then
				var_4_7 = 0

				break
			end
		end

		if var_4_7 ~= var_4_4 then
			return var_4_7 < var_4_4
		end

		return arg_4_0 < arg_4_1
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.listGo_, FishingGroupItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetId(arg_6_0.idList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	return
end

function var_0_0.AddEventListeners(arg_8_0)
	arg_8_0:RegistEventListener(FISHING_GROUP_REWARD_CHANGE, function()
		arg_8_0:UpdateView()
	end)
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_11_0)
	return
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:AddEventListeners()
	arg_12_0:UpdateView()
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0:SortData()
	arg_13_0.uiList_:StartScroll(#arg_13_0.idList_)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.uiList_ then
		arg_16_0.uiList_:Dispose()

		arg_16_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
