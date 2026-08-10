local var_0_0 = class("SummerChessBoardTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Quest/Summer2024_QuestMenuUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.tree_ = LuaTree.New(arg_3_0.uiTreeGo_)

	arg_3_0.tree_:SetSelectedHandler(handler(arg_3_0, arg_3_0.OnGroupSelect), handler(arg_3_0, arg_3_0.OnItemSelect))

	arg_3_0.updateActivityHandler_ = handler(arg_3_0, arg_3_0.UpdateActivity)
	arg_3_0.taskViewList_ = {}
end

function var_0_0.CreateTree(arg_4_0)
	local var_4_0 = ActivitySummerTaskGroupUICfg.get_id_list_by_theme[arg_4_0.themeID_]
	local var_4_1 = UITreeData.New()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_2 = UITreeGroupData.New()

		var_4_2.id = iter_4_1

		local var_4_3 = ActivitySummerTaskGroupUICfg[iter_4_1]

		var_4_2.text = GetI18NText(var_4_3.name)

		for iter_4_2, iter_4_3 in pairs(var_4_3.item_id_list) do
			local var_4_4 = UITreeItemData.New()
			local var_4_5 = ActivitySummerTaskItemUICfg[iter_4_3]

			var_4_4.id = var_4_5.id

			local var_4_6 = ActivityCfg[var_4_5.activity_id]

			var_4_4.text = var_4_6 and GetI18NText(var_4_6.remark) or ""
			var_4_4.extraData = iter_4_1

			var_4_2.itemDatas:Add(var_4_4)
		end

		var_4_1.groupDatas:Add(var_4_2)
	end

	arg_4_0.tree_:SetData(var_4_1)
end

function var_0_0.BindRedPoint(arg_5_0)
	local var_5_0 = ActivitySummerTaskGroupUICfg.get_id_list_by_theme[arg_5_0.themeID_]

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = ActivitySummerTaskGroupUICfg[iter_5_1]
		local var_5_2 = string.format("%s_%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, arg_5_0.themeID_, iter_5_1)

		manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(iter_5_1), var_5_2)

		for iter_5_2, iter_5_3 in pairs(var_5_1.item_id_list) do
			local var_5_3 = ActivitySummerTaskItemUICfg[iter_5_3]
			local var_5_4 = SummerChessBoardData:CallFun("GetTaskRedPointKey", var_5_3.main_activity_id, var_5_3.activity_id)

			manager.redPoint:bindUIandKey(arg_5_0.tree_:GetItemRedPointContainerById(iter_5_1, var_5_3.id), var_5_4)
		end
	end
end

function var_0_0.UnBindRedPoint(arg_6_0)
	local var_6_0 = ActivitySummerTaskGroupUICfg.get_id_list_by_theme[arg_6_0.themeID_]

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = ActivitySummerTaskGroupUICfg[iter_6_1]
		local var_6_2 = string.format("%s_%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, arg_6_0.themeID_, iter_6_1)

		manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(iter_6_1), var_6_2)

		for iter_6_2, iter_6_3 in pairs(var_6_1.item_id_list) do
			local var_6_3 = ActivitySummerTaskItemUICfg[iter_6_3]
			local var_6_4 = SummerChessBoardData:CallFun("GetTaskRedPointKey", var_6_3.main_activity_id, var_6_3.activity_id)

			manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetItemRedPointContainerById(iter_6_1, var_6_3.id), var_6_4)
		end
	end
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_7_0, iter_7_1 in pairs(arg_7_0.taskViewList_) do
		iter_7_1:OnEnter()
	end

	arg_7_0.selectTaskActivityID_ = arg_7_0.params_.taskActivityID or ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_TASK

	local var_7_0 = ActivityCfg[arg_7_0.selectTaskActivityID_]

	if arg_7_0.themeID_ ~= var_7_0.activity_theme then
		arg_7_0.themeID_ = var_7_0.activity_theme

		arg_7_0:CreateTree()
	end

	local var_7_1, var_7_2 = SummerChessBoardTools.GetTaskGroupIndex(arg_7_0.selectTaskActivityID_)

	arg_7_0.tree_:SelectItem(var_7_1, var_7_2)
	arg_7_0:UpdateActivity()
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_7_0.updateActivityHandler_)
	arg_7_0:BindRedPoint()
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:UnBindRedPoint()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_8_0.updateActivityHandler_)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.taskViewList_) do
		iter_8_1:OnExit()
	end

	arg_8_0.lastSelectID_ = nil
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.updateActivityHandler_ = nil

	arg_9_0.tree_:Dispose()

	arg_9_0.tree_ = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_0.taskViewList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.taskViewList_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.AddListeners(arg_10_0)
	return
end

function var_0_0.OnGroupSelect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = ActivitySummerTaskGroupUICfg[arg_11_2]

	if var_11_0.prefab_path == "" then
		return
	end

	if arg_11_0.lastSelectID_ == arg_11_2 then
		return
	end

	arg_11_0.lastSelectID_ = arg_11_2

	if arg_11_0.taskViewList_[var_11_0.prefab_path] == nil then
		arg_11_0.taskViewList_[var_11_0.prefab_path] = var_11_0.class_name.New(arg_11_0.contentGo_, var_11_0)
	end

	arg_11_0:SwitchRighePanel(var_11_0)
end

function var_0_0.OnItemSelect(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = ActivitySummerTaskGroupUICfg[tonumber(arg_12_4)]

	if var_12_0.prefab_path ~= "" then
		return
	end

	if arg_12_0.lastSelectID_ == arg_12_2 then
		return
	end

	arg_12_0.lastSelectID_ = arg_12_2

	local var_12_1 = ActivitySummerTaskItemUICfg[arg_12_2]

	if not (ActivityTools.GetActivityStatus(var_12_1.main_activity_id) ~= ActivityConst.ACTIVITY_STATE.OVER) then
		arg_12_0.lastIndex_ = arg_12_2

		for iter_12_0, iter_12_1 in ipairs(var_12_0.item_id_list) do
			local var_12_2 = ActivitySummerTaskItemUICfg[iter_12_1]

			if ActivityTools.GetActivityStatus(var_12_2.main_activity_id) ~= ActivityConst.ACTIVITY_STATE.OVER then
				local var_12_3, var_12_4 = SummerChessBoardTools.GetTaskGroupIndex(var_12_2.activity_id)

				arg_12_0.tree_:SetGroupItemOn(tonumber(arg_12_4), iter_12_1)
				arg_12_0.tree_:RefreshSelectGroupItem(var_12_3, var_12_4)

				return
			end
		end

		arg_12_0.tree_:SelectItem(1, 1)

		return
	end

	if arg_12_0.taskViewList_[var_12_1.prefab_path] == nil then
		arg_12_0.taskViewList_[var_12_1.prefab_path] = var_12_1.class_name.New(arg_12_0.contentGo_, var_12_1)
	end

	arg_12_0:SwitchRighePanel(var_12_1)
end

function var_0_0.SwitchRighePanel(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.taskViewList_) do
		if iter_13_0 == arg_13_1.prefab_path then
			iter_13_1:SetData(arg_13_1)
			iter_13_1:Show(true)
		else
			iter_13_1:Show(false)
		end
	end

	arg_13_0.params_.taskActivityID = arg_13_1.activity_id
	arg_13_0.selectTaskActivityID_ = arg_13_1.activity_id
end

function var_0_0.UpdateActivity(arg_14_0)
	local var_14_0 = ActivitySummerTaskGroupUICfg.get_id_list_by_theme[arg_14_0.themeID_]

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = ActivitySummerTaskGroupUICfg[iter_14_1]

		if var_14_1.activity_id ~= 0 then
			local var_14_2 = ActivityTools.GetActivityStatus(var_14_1.activity_id) ~= ActivityConst.ACTIVITY_STATE.OVER

			SetActive(arg_14_0.tree_:GetGroupGameObjectById(iter_14_1), var_14_2)
		else
			local var_14_3 = false

			for iter_14_2, iter_14_3 in pairs(var_14_1.item_id_list) do
				local var_14_4 = ActivitySummerTaskItemUICfg[iter_14_3]
				local var_14_5 = ActivityTools.GetActivityStatus(var_14_4.activity_id) ~= ActivityConst.ACTIVITY_STATE.OVER

				SetActive(arg_14_0.tree_:GetItemGameObjectById(iter_14_1, var_14_4.id), var_14_5)

				var_14_3 = var_14_5 or var_14_3
			end

			SetActive(arg_14_0.tree_:GetGroupGameObjectById(iter_14_1), var_14_3)
		end
	end

	if ActivityTools.GetActivityStatus(arg_14_0.selectTaskActivityID_) == ActivityConst.ACTIVITY_STATE.OVER then
		arg_14_0.tree_:SelectItem(1, 1)
	end
end

return var_0_0
