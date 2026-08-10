local var_0_0 = class("SummerPubSkinPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_3_SummerPub/V4_3_SummerPub_SkinDLCPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	local var_4_0 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC
	local var_4_1 = AssignmentCfg.get_id_list_by_activity_id[var_4_0] or {}

	arg_4_0.taskItemList_ = {}

	for iter_4_0 = 1, 2 do
		local var_4_2 = var_4_1[iter_4_0]

		if var_4_2 then
			local var_4_3 = SummerPopSkinPopTaskItem.New(arg_4_0["item" .. iter_4_0 .. "_"], var_4_2)

			table.insert(arg_4_0.taskItemList_, var_4_3)
		end
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.descText_.text = string.format(GetTips("SUMMER_PUB_SKIN_POP_DESC"))
	arg_8_0.heroImage_.sprite = pureGetSpriteWithoutAtlas(GameSetting.summer_pub_skin_dlc_hero_image.value[1])

	for iter_8_0 = 1, #arg_8_0.taskItemList_ do
		arg_8_0.taskItemList_[iter_8_0]:RefreshUI()
	end
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.taskItemList_ then
		for iter_9_0 = 1, #arg_9_0.taskItemList_ do
			arg_9_0.taskItemList_[iter_9_0]:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnDispose(arg_10_0)
	var_0_0.super.OnDispose(arg_10_0)
end

function var_0_0.OnExit(arg_11_0)
	var_0_0.super.OnExit(arg_11_0)
end

return var_0_0
