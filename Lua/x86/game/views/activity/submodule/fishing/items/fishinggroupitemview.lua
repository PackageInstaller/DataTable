local var_0_0 = class("FishingGroupItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.fishList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexFishItem), arg_3_0.fishListGo_, FishIcon)
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.bonusListGo_, CommonItem)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id
		})
	end)
	arg_4_2:RefreshData({
		id = arg_4_0.cfg_.reward_item_list[arg_4_1][1],
		number = arg_4_0.cfg_.reward_item_list[arg_4_1][2]
	})
end

function var_0_0.indexFishItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetNeedUpdateHave(true)

	local var_6_0 = 0
	local var_6_1 = FishingData:GetFish(arg_6_0.cfg_.group[1][arg_6_1])

	if var_6_1 then
		var_6_0 = var_6_1.num
	end

	arg_6_2:SetId(arg_6_0.cfg_.group[1][arg_6_1], 1, var_6_0)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.exchangeBtn_, nil, function()
		FishingAction.GetConstituteFishBonus(ActivityConst.SUMMER_FISHING, arg_7_0.groupId_)
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(RARE_FISH_CHANGE, function(arg_10_0)
		if table.indexof(arg_9_0.cfg_.group[1], arg_10_0) or arg_10_0 == 0 then
			arg_9_0:UpdateView()
		end
	end)
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_12_0)
	return
end

function var_0_0.SetId(arg_13_0, arg_13_1)
	arg_13_0.groupId_ = arg_13_1
	arg_13_0.cfg_ = ActivitySummerFishGroupCfg[arg_13_1]

	arg_13_0:UpdateView()
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0.groupNameLabel_.text = GetI18NText(arg_14_0.cfg_.name)

	arg_14_0.fishList_:StartScroll(#arg_14_0.cfg_.group[1])
	arg_14_0.uiList_:StartScroll(#arg_14_0.cfg_.reward_item_list)

	local var_14_0 = true

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.cfg_.group[1]) do
		local var_14_1
		local var_14_2 = FishingData:GetActivityData().fish_infos[iter_14_1]

		if not (var_14_2 and var_14_2.num > 0 and true or false) then
			var_14_0 = false

			break
		end
	end

	local var_14_3 = FishingData:GetActivityData().received_constitute_list

	if table.indexof(var_14_3, arg_14_0.cfg_.id) then
		arg_14_0.statusController_:SetSelectedState("haveGet")
	elseif not var_14_0 then
		arg_14_0.statusController_:SetSelectedState("cannotGet")
	else
		arg_14_0.statusController_:SetSelectedState("canGet")
	end
end

function var_0_0.OnEnter(arg_15_0)
	return
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.OnMainHomeViewTop(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllEventListener()

	if arg_18_0.uiList_ then
		arg_18_0.uiList_:Dispose()

		arg_18_0.uiList_ = nil
	end

	if arg_18_0.fishList_ then
		arg_18_0.fishList_:Dispose()

		arg_18_0.fishList_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
