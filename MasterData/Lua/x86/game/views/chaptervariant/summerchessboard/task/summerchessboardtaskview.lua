local SummerChessBoardTaskView = class("SummerChessBoardTaskView", ReduxView)

function SummerChessBoardTaskView:UIName()
	return "Widget/System/Summer2024/Summer2024_Quest/Summer2024_QuestMenuUI"
end

function SummerChessBoardTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerChessBoardTaskView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.tree_ = LuaTree.New(self.uiTreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.updateActivityHandler_ = handler(self, self.UpdateActivity)
	self.taskViewList_ = {}
end

function SummerChessBoardTaskView:CreateTree()
	local var_4_0 = UITreeData.New()

	for iter_4_0, iter_4_1 in ipairs(ActivitySummerTaskGroupUICfg.get_id_list_by_theme[self.themeID_]) do
		local var_4_1 = UITreeGroupData.New()

		var_4_1.id = iter_4_1
		var_4_1.text = GetI18NText(ActivitySummerTaskGroupUICfg[iter_4_1].name)

		for iter_4_2, iter_4_3 in pairs(ActivitySummerTaskGroupUICfg[iter_4_1].item_id_list) do
			local var_4_2 = UITreeItemData.New()

			var_4_2.id = ActivitySummerTaskItemUICfg[iter_4_3].id
			var_4_2.text = ActivityCfg[ActivitySummerTaskItemUICfg[iter_4_3].activity_id] and GetI18NText(ActivityCfg[ActivitySummerTaskItemUICfg[iter_4_3].activity_id].remark) or ""
			var_4_2.extraData = iter_4_1

			var_4_1.itemDatas:Add(var_4_2)
		end

		var_4_0.groupDatas:Add(var_4_1)
	end

	self.tree_:SetData(var_4_0)
end

function SummerChessBoardTaskView:BindRedPoint()
	for iter_5_0, iter_5_1 in ipairs(ActivitySummerTaskGroupUICfg.get_id_list_by_theme[self.themeID_]) do
		manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_5_1), (string.format("%s_%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, self.themeID_, iter_5_1)))

		for iter_5_2, iter_5_3 in pairs(ActivitySummerTaskGroupUICfg[iter_5_1].item_id_list) do
			manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(iter_5_1, ActivitySummerTaskItemUICfg[iter_5_3].id), (SummerChessBoardData:CallFun("GetTaskRedPointKey", ActivitySummerTaskItemUICfg[iter_5_3].main_activity_id, ActivitySummerTaskItemUICfg[iter_5_3].activity_id)))
		end
	end
end

function SummerChessBoardTaskView:UnBindRedPoint()
	for iter_6_0, iter_6_1 in ipairs(ActivitySummerTaskGroupUICfg.get_id_list_by_theme[self.themeID_]) do
		manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_6_1), (string.format("%s_%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, self.themeID_, iter_6_1)))

		for iter_6_2, iter_6_3 in pairs(ActivitySummerTaskGroupUICfg[iter_6_1].item_id_list) do
			manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(iter_6_1, ActivitySummerTaskItemUICfg[iter_6_3].id), (SummerChessBoardData:CallFun("GetTaskRedPointKey", ActivitySummerTaskItemUICfg[iter_6_3].main_activity_id, ActivitySummerTaskItemUICfg[iter_6_3].activity_id)))
		end
	end
end

function SummerChessBoardTaskView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_7_0, iter_7_1 in pairs(self.taskViewList_) do
		iter_7_1:OnEnter()
	end

	self.selectTaskActivityID_ = self.params_.taskActivityID or ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS_TASK

	if self.themeID_ ~= ActivityCfg[self.selectTaskActivityID_].activity_theme then
		self.themeID_ = ActivityCfg[self.selectTaskActivityID_].activity_theme

		self:CreateTree()
	end

	local var_7_0, var_7_1 = SummerChessBoardTools.GetTaskGroupIndex(self.selectTaskActivityID_)

	self.tree_:SelectItem(var_7_0, var_7_1)
	self:UpdateActivity()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.updateActivityHandler_)
	self:BindRedPoint()
end

function SummerChessBoardTaskView:OnExit()
	self:UnBindRedPoint()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.updateActivityHandler_)

	for iter_8_0, iter_8_1 in pairs(self.taskViewList_) do
		iter_8_1:OnExit()
	end

	self.lastSelectID_ = nil
end

function SummerChessBoardTaskView:Dispose()
	self.updateActivityHandler_ = nil

	self.tree_:Dispose()

	self.tree_ = nil

	for iter_9_0, iter_9_1 in pairs(self.taskViewList_) do
		iter_9_1:Dispose()
	end

	self.taskViewList_ = nil

	SummerChessBoardTaskView.super.Dispose(self)
end

function SummerChessBoardTaskView:AddListeners()
	return
end

function SummerChessBoardTaskView:OnGroupSelect(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if ActivitySummerTaskGroupUICfg[arg_11_2].prefab_path == "" then
		return
	end

	if self.lastSelectID_ == arg_11_2 then
		return
	end

	self.lastSelectID_ = arg_11_2

	if self.taskViewList_[ActivitySummerTaskGroupUICfg[arg_11_2].prefab_path] == nil then
		self.taskViewList_[ActivitySummerTaskGroupUICfg[arg_11_2].prefab_path] = ActivitySummerTaskGroupUICfg[arg_11_2].class_name.New(self.contentGo_, ActivitySummerTaskGroupUICfg[arg_11_2])
	end

	self:SwitchRighePanel(ActivitySummerTaskGroupUICfg[arg_11_2])
end

function SummerChessBoardTaskView:OnItemSelect(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = ActivitySummerTaskGroupUICfg[tonumber(arg_12_4)]

	if var_12_0.prefab_path ~= "" then
		return
	end

	if self.lastSelectID_ == arg_12_2 then
		return
	end

	self.lastSelectID_ = arg_12_2

	local var_12_1 = ActivitySummerTaskItemUICfg[arg_12_2]

	if ActivityTools.GetActivityStatus(ActivitySummerTaskItemUICfg[arg_12_2].main_activity_id) == ActivityConst.ACTIVITY_STATE.OVER then
		self.lastIndex_ = arg_12_2

		for iter_12_0, iter_12_1 in ipairs(var_12_0.item_id_list) do
			if ActivityTools.GetActivityStatus(ActivitySummerTaskItemUICfg[iter_12_1].main_activity_id) ~= ActivityConst.ACTIVITY_STATE.OVER then
				local var_12_2, var_12_3 = SummerChessBoardTools.GetTaskGroupIndex(ActivitySummerTaskItemUICfg[iter_12_1].activity_id)

				self.tree_:SetGroupItemOn(tonumber(arg_12_4), iter_12_1)
				self.tree_:RefreshSelectGroupItem(var_12_2, var_12_3)

				return
			end
		end

		self.tree_:SelectItem(1, 1)

		return
	end

	if self.taskViewList_[var_12_1.prefab_path] == nil then
		self.taskViewList_[var_12_1.prefab_path] = var_12_1.class_name.New(self.contentGo_, var_12_1)
	end

	self:SwitchRighePanel(var_12_1)
end

function SummerChessBoardTaskView:SwitchRighePanel(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.taskViewList_) do
		if iter_13_0 == arg_13_1.prefab_path then
			iter_13_1:SetData(arg_13_1)
			iter_13_1:Show(true)
		else
			iter_13_1:Show(false)
		end
	end

	self.params_.taskActivityID = arg_13_1.activity_id
	self.selectTaskActivityID_ = arg_13_1.activity_id
end

function SummerChessBoardTaskView:UpdateActivity()
	for iter_14_0, iter_14_1 in ipairs(ActivitySummerTaskGroupUICfg.get_id_list_by_theme[self.themeID_]) do
		local var_14_0 = ActivitySummerTaskGroupUICfg[iter_14_1]

		if ActivitySummerTaskGroupUICfg[iter_14_1].activity_id ~= 0 then
			SetActive(self.tree_:GetGroupGameObjectById(iter_14_1), ActivityTools.GetActivityStatus(var_14_0.activity_id) ~= ActivityConst.ACTIVITY_STATE.OVER)
		else
			local var_14_1 = false

			for iter_14_2, iter_14_3 in pairs(var_14_0.item_id_list) do
				local var_14_2 = ActivityTools.GetActivityStatus(ActivitySummerTaskItemUICfg[iter_14_3].activity_id) ~= ActivityConst.ACTIVITY_STATE.OVER

				SetActive(self.tree_:GetItemGameObjectById(iter_14_1, ActivitySummerTaskItemUICfg[iter_14_3].id), var_14_2)

				var_14_1 = var_14_2 or var_14_1
			end

			SetActive(self.tree_:GetGroupGameObjectById(iter_14_1), var_14_1)
		end
	end

	if ActivityTools.GetActivityStatus(self.selectTaskActivityID_) == ActivityConst.ACTIVITY_STATE.OVER then
		self.tree_:SelectItem(1, 1)
	end
end

return SummerChessBoardTaskView
