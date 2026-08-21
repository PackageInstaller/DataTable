local var_0_0 = class("ActivityQuestSubView", BaseView)
local var_0_1 = {
	inProgress = 1,
	done = 0,
	complete = 2
}

local function var_0_2()
	return true
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_0.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform
	arg_2_0.itemCls = arg_2_4
	arg_2_0.activity = arg_2_2
	arg_2_0.taskFilter = arg_2_3 or var_0_2
	arg_2_0.showSubmitAll = arg_2_5

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.questList = LuaList.New(handler(arg_3_0, arg_3_0.UpdateQuestItem), arg_3_0.questList_, arg_3_0.itemCls)

	if arg_3_0.showSubmitAll then
		arg_3_0.clearController = ControllerUtil.GetController(arg_3_0.transform_, "clear")

		arg_3_0:AddBtnListenerScale(arg_3_0.receiveBtn_, nil, function()
			local var_4_0 = {}

			for iter_4_0, iter_4_1 in ipairs(arg_3_0.quests) do
				if iter_4_1.status == var_0_1.complete then
					table.insert(var_4_0, iter_4_1.id)
				end
			end

			TaskAction:SubmitTaskList(var_4_0)
		end)
	end
end

function var_0_0.UpdateQuestItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.quests[arg_5_1]
	local var_5_1 = var_5_0.id
	local var_5_2 = var_5_0.activityID

	arg_5_2:SetData(var_5_1, var_5_2)

	if arg_5_0.OnQuestItemRender then
		arg_5_0:OnQuestItemRender(var_5_1, arg_5_2, arg_5_1)
	end
end

function var_0_0.RefreshAllTask(arg_6_0)
	arg_6_0.quests = {}

	local var_6_0 = 0
	local var_6_1 = arg_6_0.activity
	local var_6_2 = TaskData2:GetActivityTaskSortList(var_6_1)

	for iter_6_0, iter_6_1 in pairs(var_6_2) do
		if arg_6_0.taskFilter(iter_6_1) then
			local var_6_3 = var_0_1.inProgress

			if iter_6_1.complete_flag >= 1 then
				var_6_3 = var_0_1.done
			elseif iter_6_1.progress >= AssignmentCfg[iter_6_1.id].need then
				var_6_3 = var_0_1.complete
				var_6_0 = var_6_0 + 1
			end

			table.insert(arg_6_0.quests, {
				id = iter_6_1.id,
				activityID = AssignmentCfg[iter_6_1.id].activity_id,
				status = var_6_3
			})
		end
	end

	arg_6_0.completeQuest = var_6_0

	if arg_6_0.showSubmitAll then
		if var_6_0 > 0 then
			arg_6_0.clearController:SetSelectedState("true")
		else
			arg_6_0.clearController:SetSelectedState("false")
		end
	end

	arg_6_0.questList:StartScroll(#arg_6_0.quests)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshAllTask()
	arg_7_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_7_0, arg_7_0.RefreshAllTask))
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.questList then
		arg_9_0.questList:Dispose()

		arg_9_0.questList = nil
	end

	arg_9_0.quests = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
