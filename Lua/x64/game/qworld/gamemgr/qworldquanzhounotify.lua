return {
	Init = function(arg_1_0)
		arg_1_0.questMap = {}

		for iter_1_0, iter_1_1 in pairs(QuanzhouPhaseCfg.get_id_list_by_task_id) do
			local var_1_0 = QuanzhouPhaseCfg[iter_1_1[1]]

			if var_1_0 then
				arg_1_0.questMap[var_1_0.task_id] = var_1_0.id
			end
		end

		arg_1_0.alreadyPopTask = {}
		arg_1_0.entity = nil
		arg_1_0.isInit = true

		arg_1_0:AddListener()
	end,
	AddListener = function(arg_2_0)
		arg_2_0.questHandle = handler(arg_2_0, arg_2_0.OnQuestGraphStart)

		manager.notify:RegistListener(QWORLD_ON_QUEST_GRAPH_START, arg_2_0.questHandle)

		arg_2_0.destroyHandle = handler(arg_2_0, arg_2_0.OnDisposeLua)

		manager.notify:RegistListener(ON_DESTROY_LUA, function()
			arg_2_0:OnDisposeLua()
		end)
	end,
	RemoveListener = function(arg_4_0)
		manager.notify:RemoveListener(QWORLD_ON_QUEST_GRAPH_START, arg_4_0.questHandle)
		manager.notify:RemoveListener(ON_DESTROY_LUA, arg_4_0.destroyHandle)
	end,
	OnDisposeLua = function(arg_5_0)
		arg_5_0:Dispose()
	end,
	OnQuestGraphStart = function(arg_6_0, arg_6_1)
		if arg_6_0.questMap[arg_6_1] then
			if arg_6_0.alreadyPopTask[arg_6_1] then
				return
			end

			arg_6_0.alreadyPopTask[arg_6_1] = true

			arg_6_0:Show()
		end
	end,
	Process = function(arg_7_0)
		for iter_7_0, iter_7_1 in pairs(arg_7_0.questMap) do
			if QWorldQuestTool.GetQuestStatus(iter_7_0) == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
				if arg_7_0.alreadyPopTask[iter_7_0] then
					return
				end

				arg_7_0.alreadyPopTask[iter_7_0] = true

				arg_7_0:Show()

				return
			end
		end
	end,
	Show = function(arg_8_0)
		if not arg_8_0.entity then
			arg_8_0.entity = QWorldQuanzhouPhaseView.New()
		end

		arg_8_0.entity:SetData()
		arg_8_0.entity:Show()
		QWorldUIHide()
	end,
	Hide = function(arg_9_0)
		if arg_9_0.entity then
			arg_9_0.entity:Hide()
			arg_9_0.entity:Dispose()

			arg_9_0.entity = nil
		end

		QWorldUIShow()
	end,
	Dispose = function(arg_10_0)
		arg_10_0.isInit = false

		if arg_10_0.entity then
			arg_10_0.entity:Dispose()

			arg_10_0.entity = nil
		end
	end
}
