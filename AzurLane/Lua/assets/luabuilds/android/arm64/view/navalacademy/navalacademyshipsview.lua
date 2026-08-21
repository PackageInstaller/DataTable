local var_0_0 = class("NavalAcademyShipsView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.parent = arg_1_1
	arg_1_0.academyStudents = {}
	arg_1_0._map = arg_1_1._tf:Find("academyMap/map")
	arg_1_0._shipTpl = arg_1_0._map:Find("ship")
	arg_1_0._fountain = arg_1_0._map:Find("fountain")
	arg_1_0.academyGraphPath = GraphPath.New(AcademyGraph)

	return
end

function var_0_0.BindBuildings(arg_2_0, arg_2_1)
	arg_2_0.buildings = _.map(arg_2_1, function(arg_3_0)
		return arg_3_0._tf
	end)

	return
end

function var_0_0.Refresh(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:getStudents()

	_.each(_.keys(arg_4_0.academyStudents), function(arg_5_0)
		if var_4_0[arg_5_0] then
			arg_4_0.academyStudents[arg_5_0]:updateStudent(var_4_0[arg_5_0], var_4_1[arg_5_0])
		else
			arg_4_0.academyStudents[arg_5_0]:detach()
		end

		return
	end)

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if not arg_4_0.academyStudents[iter_4_0] then
			local var_4_2 = var_4_1[iter_4_0]
			local var_4_3 = NavalAcademyStudent.New(cloneTplTo(arg_4_0._shipTpl, arg_4_0._map).gameObject)

			var_4_3:attach()
			var_4_3:setPathFinder(arg_4_0.academyGraphPath)
			var_4_3:setCallBack(function(arg_6_0)
				arg_4_0:onStateChange(iter_4_1, arg_6_0)

				return
			end, function(arg_7_0, arg_7_1)
				arg_4_0:onTask(iter_4_1, var_4_2)

				return
			end)
			var_4_3:updateStudent(iter_4_1, var_4_1[iter_4_0])

			arg_4_0.academyStudents[iter_4_0] = var_4_3
		end
	end

	arg_4_0:sortStudents()

	return
end

function var_0_0.Init(arg_8_0)
	arg_8_0:Refresh()

	return
end

function var_0_0.onStateChange(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.sortTimer then
		arg_9_0.sortTimer:Stop()

		arg_9_0.sortTimer = nil
	end

	if arg_9_2 == NavalAcademyStudent.ShipState.Walk then
		arg_9_0.sortTimer = Timer.New(function()
			arg_9_0:sortStudents()

			return
		end, 0.2, -1)

		arg_9_0.sortTimer:Start()
	end

	return
end

function var_0_0.sortStudents(arg_11_0)
	table.insertto({}, arg_11_0.buildings)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.academyStudents) do
		table.insert({}, iter_11_1._tf)
	end

	table.sort({}, function(arg_12_0, arg_12_1)
		return arg_12_0.anchoredPosition.y > arg_12_1.anchoredPosition.y
	end)

	for iter_11_2, iter_11_3 in ipairs({}) do
		iter_11_3:SetSiblingIndex(0)
	end

	return
end

function var_0_0.onTask(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = getProxy(ActivityProxy)
	local var_13_1 = _.detect(var_13_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST), function(arg_14_0)
		local var_14_0 = arg_14_0:getTaskShip()

		return var_14_0 and var_14_0.groupId == arg_13_1.groupId
	end)

	if var_13_1 and not var_13_1:isEnd() then
		if var_13_1.id == ActivityConst.JYHZ_ACTIVITY_ID and arg_13_2.acceptTaskId then
			local var_13_2 = getProxy(TaskProxy):getAcademyTask(arg_13_1.groupId)
			local var_13_3 = var_13_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_ZPROJECT)

			if var_13_3 then
				local var_13_4 = _.detect(var_13_3:getConfig("config_data"), function(arg_15_0)
					return _.any(pg.chapter_template[arg_15_0].npc_data, function(arg_16_0)
						return pg.npc_squad_template[arg_16_0].task_id == var_13_2
					end)
				end)

				if var_13_4 then
					if getProxy(ChapterProxy):getChapterById(var_13_4).active then
						pg.TipsMgr.GetInstance():ShowTips(i18n("task_target_chapter_in_progress"))

						return
					end
				end
			end
		end

		if arg_13_2.type then
			if arg_13_2.type == 1 then
				Application.OpenURL(arg_13_2.param)
			elseif arg_13_2.type == 2 then
				arg_13_0:emit(NavalAcademyMediator.GO_SCENE, arg_13_2.param)
			elseif arg_13_2.type == 3 then
				arg_13_0:emit(NavalAcademyMediator.OPEN_ACTIVITY_PANEL, tonumber(arg_13_2.param))
			elseif arg_13_2.type == 4 then
				arg_13_0:emit(NavalAcademyMediator.OPEN_ACTIVITY_SHOP)
			elseif arg_13_2.type == 5 then
				arg_13_0:emit(NavalAcademyMediator.OPEN_SCROLL, tonumber(arg_13_2.param))
			end
		elseif not arg_13_2.currentTask and arg_13_2.acceptTaskId then
			if getProxy(PlayerProxy):getRawData().level < pg.task_data_template[arg_13_2.acceptTaskId].level then
				pg.TipsMgr.GetInstance():ShowTips(i18n("task_level_notenough", pg.task_data_template[arg_13_2.acceptTaskId].level))

				return
			end

			arg_13_0:emit(NavalAcademyMediator.ACTIVITY_OP, {
				cmd = 1,
				activity_id = var_13_1.id,
				arg1 = arg_13_2.acceptTaskId
			})
		elseif arg_13_2.currentTask then
			if not arg_13_2.currentTask:isFinish() and arg_13_2.currentTask:getConfig("sub_type") == 29 then
				arg_13_0:emit(NavalAcademyMediator.TASK_GO, {
					taskVO = arg_13_2.currentTask
				})
			elseif not arg_13_2.currentTask:isReceive() then
				arg_13_0:emit(NavalAcademyMediator.GO_TASK_SCENE, {
					page = "activity"
				})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_work_done"))
		end
	end

	return
end

function var_0_0.emit(arg_17_0, ...)
	arg_17_0.parent:emit(...)

	return
end

function var_0_0.clearStudents(arg_18_0)
	if arg_18_0.sortTimer then
		arg_18_0.sortTimer:Stop()

		arg_18_0.sortTimer = nil
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.academyStudents) do
		iter_18_1:detach()
		Destroy(iter_18_1._go)
	end

	arg_18_0.academyStudents = {}

	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:clearStudents()

	return
end

function var_0_0.getStudents(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = {}
	local var_20_2 = getProxy(TaskProxy)

	local function var_20_3(arg_21_0)
		local var_21_0 = arg_21_0:getConfig("config_client")
		local var_21_1 = _.flatten((arg_21_0:getConfig("config_data")))
		local var_21_2
		local var_21_3

		if type(var_21_0) == "table" then
			for iter_21_0, iter_21_1 in ipairs(var_21_0) do
				var_20_0[iter_21_1.id] = Ship.New(iter_21_1)

				if iter_21_0 == 1 then
					var_20_0[iter_21_1.id].withShipFace = true

					local var_21_4 = {}

					if iter_21_1.type then
						var_21_4.type = iter_21_1.type
						var_21_4.param = iter_21_1.param
					end

					local var_21_5, var_21_6 = getActivityTask(arg_21_0, true)

					var_21_4.showTips = var_21_5 and not var_21_6 or var_21_6 and var_21_6:isFinish() and not var_21_6:isReceive()
					var_21_4.acceptTaskId = var_21_5
					var_21_4.currentTask = var_21_6
					var_20_1[iter_21_1.id] = var_21_4
					var_21_2 = var_21_4.acceptTaskId
					var_21_3 = var_21_4.currentTask
				end

				local var_21_7 = iter_21_1.tasks

				if iter_21_1.tasks then
					var_20_0[iter_21_1.id].hide = true

					local var_21_8 = var_21_3 and table.indexof(var_21_1, var_21_3.id) or table.indexof(var_21_1, var_21_2)

					for iter_21_2, iter_21_3 in ipairs(var_21_7) do
						if iter_21_3 == var_21_8 then
							var_20_0[iter_21_1.id].hide = false

							break
						end
					end
				end
			end
		end

		return
	end

	_.each(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST), function(arg_22_0)
		if not arg_22_0:isEnd() then
			var_20_3(arg_22_0)
		end

		return
	end)

	var_20_0 = getProxy(NavalAcademyProxy):fillStudens(var_20_0)

	return var_20_0, {}
end

return var_0_0
