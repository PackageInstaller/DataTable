class = var_0_10000

local var_0_0 = var_0_10000("NavalAcademyShipsView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.parent = arg_1_1
	arg_1_0.academyStudents = {}

	local var_1_0 = arg_1_1._tf

	arg_1_0._map = var_2.Find(var_1_0, "academyMap/map")

	local var_1_1 = arg_1_0._map

	arg_1_0._shipTpl = var_2.Find(var_1_1, "ship")

	local var_1_2 = arg_1_0._map

	arg_1_0._fountain = var_2.Find(var_1_2, "fountain")
	GraphPath = var_2

	local var_1_3 = var_2.New

	AcademyGraph = var_1_2
	arg_1_0.academyGraphPath = var_1_3(var_1_2)

	return
end

function var_0_0.BindBuildings(arg_2_0, arg_2_1)
	_ = var_1_10002
	arg_2_0.buildings = var_1_10002.map(arg_2_1, function(arg_3_0)
		return arg_3_0._tf
	end)

	return
end

function var_0_0.Refresh(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1, var_4_2 = arg_4_0.getStudents(var_4_0)

	_ = var_4_0

	local var_4_3 = var_4_0.each

	_ = var_1_10005

	var_4_3(var_1_10005.keys(arg_4_0.academyStudents), function(arg_5_0)
		local var_5_0 = var_4_1[arg_5_0]
		local var_5_1 = var_4_2[arg_5_0]
		local var_5_2 = arg_4_0.academyStudents[arg_5_0]

		if var_5_0 then
			var_5_2:updateStudent(var_5_0, var_5_1)
		else
			var_5_2:detach()
		end

		return
	end)

	pairs = var_4_3

	for iter_4_0, iter_4_1 in var_4_3(var_4_1) do
		if not arg_4_0.academyStudents[iter_4_0] then
			local var_4_4 = var_4_2[iter_4_0]

			cloneTplTo = var_1_10009
			var_1_10009 = var_1_10009(arg_4_0._shipTpl, arg_4_0._map)
			NavalAcademyStudent = var_1_10010

			local var_4_5 = var_1_10010.New(var_1_10009.gameObject)

			var_1_10010.attach(var_4_5)
			var_1_10010:setPathFinder(arg_4_0.academyGraphPath)
			var_1_10010:setCallBack(function(arg_6_0)
				local var_6_0 = arg_4_0

				var_1.onStateChange(var_6_0, iter_4_1, arg_6_0)

				return
			end, function(arg_7_0, arg_7_1)
				local var_7_0 = arg_4_0

				var_2.onTask(var_7_0, iter_4_1, var_4_4)

				return
			end)
			var_1_10010:updateStudent(iter_4_1, var_4_4)

			arg_4_0.academyStudents[iter_4_0] = var_1_10010
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
		local var_9_0 = arg_9_0.sortTimer

		var_3.Stop(var_9_0)

		arg_9_0.sortTimer = nil
	end

	NavalAcademyStudent = var_3

	if arg_9_2 == var_3.ShipState.Walk then
		Timer = var_3
		arg_9_0.sortTimer = var_3.New(function()
			local var_10_0 = arg_9_0

			var_0.sortStudents(var_10_0)

			return
		end, 0.2, -1)

		local var_9_1 = arg_9_0.sortTimer

		var_3.Start(var_9_1)
	end

	return
end

function var_0_0.sortStudents(arg_11_0)
	local var_11_0 = {}

	table = var_1_10002

	var_1_10002.insertto(var_11_0, arg_11_0.buildings)

	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.academyStudents) do
		table = var_1_10007

		var_1_10007.insert(var_11_0, iter_11_1._tf)
	end

	table = var_2

	var_2.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.anchoredPosition.y > arg_12_1.anchoredPosition.y
	end)

	local var_11_1 = 0

	ipairs = var_3

	for iter_11_2, iter_11_3 in var_3(var_11_0) do
		iter_11_3:SetSiblingIndex(var_11_1)

		var_11_1 = var_11_1 + 1
	end

	return
end

function var_0_0.onTask(arg_13_0, arg_13_1, arg_13_2)
	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_13_0 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	ActivityProxy = var_1_10006

	local var_13_1 = var_1_10004(var_1_10006)
	local var_13_2 = var_4.getActivitiesByType

	ActivityConst = var_1_10008

	local var_13_3 = var_13_2(var_13_1, var_1_10008.ACTIVITY_TYPE_TASK_LIST)

	_ = var_1_10006

	if var_1_10006.detect(var_13_3, function(arg_14_0)
		return arg_14_0:getTaskShip() and var_1.groupId == arg_13_1.groupId
	end) then
		local var_13_4 = var_6

		if not var_6.isEnd(var_13_4) then
			local var_13_5 = var_6.id

			ActivityConst = var_8

			if var_13_5 == var_8.JYHZ_ACTIVITY_ID and arg_13_2.acceptTaskId then
				var_13_4 = var_13_0

				local var_13_6 = var_13_0.getAcademyTask(var_13_4, arg_13_1.groupId)

				var_1_10010 = var_4

				local var_13_7 = var_4.getActivityByType

				ActivityConst = var_1_10011

				if var_13_7(var_1_10010, var_1_10011.ACTIVITY_TYPE_ZPROJECT) then
					var_1_10011 = var_8
					var_13_4 = var_8.getConfig(var_1_10011, "config_data")
					_ = var_1_10010

					if var_1_10010.detect(var_13_4, function(arg_15_0)
						pg = var_2_10001

						local var_15_0 = var_2_10001.chapter_template[arg_15_0]

						_ = var_2_10002

						return var_2_10002.any(var_15_0.npc_data, function(arg_16_0)
							pg = var_3_10001

							return var_3_10001.npc_squad_template[arg_16_0].task_id == var_13_6
						end)
					end) then
						getProxy = var_1_10011
						ChapterProxy = var_1_10013

						local var_13_8 = var_1_10011(var_1_10013)

						if var_1_10011.getChapterById(var_13_8, var_1_10010).active then
							pg = var_1_10013

							local var_13_9 = var_1_10013.TipsMgr.GetInstance()

							var_1_10013 = var_1_10013.ShowTips
							i18n = var_1_10016

							var_1_10013(var_13_9, var_1_10016("task_target_chapter_in_progress"))

							return
						end
					end
				end
			end

			if arg_13_2.type then
				if arg_13_2.type == 1 then
					Application = var_7

					var_7.OpenURL(arg_13_2.param)
				elseif arg_13_2.type == 2 then
					var_13_4 = arg_13_0

					local var_13_10 = arg_13_0.emit

					NavalAcademyMediator = var_1_10010

					var_13_10(var_13_4, var_1_10010.GO_SCENE, arg_13_2.param)
				elseif arg_13_2.type == 3 then
					var_13_4 = arg_13_0

					local var_13_11 = arg_13_0.emit

					NavalAcademyMediator = var_1_10010
					var_1_10010 = var_1_10010.OPEN_ACTIVITY_PANEL
					tonumber = var_1_10011

					var_13_11(var_13_4, var_1_10010, var_1_10011(arg_13_2.param))
				elseif arg_13_2.type == 4 then
					var_13_4 = arg_13_0

					local var_13_12 = arg_13_0.emit

					NavalAcademyMediator = var_1_10010

					var_13_12(var_13_4, var_1_10010.OPEN_ACTIVITY_SHOP)
				elseif arg_13_2.type == 5 then
					var_13_4 = arg_13_0

					local var_13_13 = arg_13_0.emit

					NavalAcademyMediator = var_1_10010
					var_1_10010 = var_1_10010.OPEN_SCROLL
					tonumber = var_1_10011

					var_13_13(var_13_4, var_1_10010, var_1_10011(arg_13_2.param))
				end
			elseif not arg_13_2.currentTask and arg_13_2.acceptTaskId then
				getProxy = var_7
				PlayerProxy = var_13_4
				var_1_10010 = var_7(var_13_4)

				local var_13_14 = var_7.getRawData(var_1_10010)

				pg = var_13_4

				local var_13_15 = var_13_4.task_data_template[arg_13_2.acceptTaskId]

				if var_13_14.level < var_13_15.level then
					pg = var_1_10010

					local var_13_16 = var_1_10010.TipsMgr.GetInstance()

					var_1_10010 = var_1_10010.ShowTips
					i18n = var_1_10013

					var_1_10010(var_13_16, var_1_10013("task_level_notenough", var_13_15.level))

					return
				end

				local var_13_17 = arg_13_0

				var_1_10010 = arg_13_0.emit
				NavalAcademyMediator = var_1_10013

				var_1_10010(var_13_17, var_1_10013.ACTIVITY_OP, {
					cmd = 1,
					activity_id = var_6.id,
					arg1 = arg_13_2.acceptTaskId
				})
			else
				local var_13_21

				if arg_13_2.currentTask then
					local var_13_18 = arg_13_2.currentTask

					if not var_13_21.isFinish(var_13_18) then
						local var_13_19 = arg_13_2.currentTask

						if var_13_21.getConfig(var_13_19, "sub_type") == 29 then
							local var_13_20 = arg_13_0

							var_13_21 = arg_13_0.emit
							NavalAcademyMediator = var_1_10010

							var_13_21(var_13_20, var_1_10010.TASK_GO, {
								taskVO = arg_13_2.currentTask
							})

							goto label_13_0
						end
					end

					local var_13_22 = arg_13_2.currentTask

					if not var_13_21.isReceive(var_13_22) then
						local var_13_23 = arg_13_0

						var_13_21 = arg_13_0.emit
						NavalAcademyMediator = var_1_10010

						var_13_21(var_13_23, var_1_10010.GO_TASK_SCENE, {
							page = "activity"
						})
					end
				else
					pg = var_13_21

					local var_13_24 = var_13_21.TipsMgr.GetInstance()
					local var_13_25 = var_7.ShowTips

					i18n = var_1_10010

					var_13_25(var_13_24, var_1_10010("main_navalAcademyScene_work_done"))
				end
			end
		end
	end

	::label_13_0::

	return
end

function var_0_0.emit(arg_17_0, ...)
	local var_17_0 = arg_17_0.parent

	var_1.emit(var_17_0, ...)

	return
end

function var_0_0.clearStudents(arg_18_0)
	if arg_18_0.sortTimer then
		local var_18_0 = arg_18_0.sortTimer

		var_1.Stop(var_18_0)

		arg_18_0.sortTimer = nil
	end

	pairs = var_1

	for iter_18_0, iter_18_1 in var_1(arg_18_0.academyStudents) do
		iter_18_1:detach()

		Destroy = var_6

		var_6(iter_18_1._go)
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

	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_20_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	ActivityProxy = var_1_10006

	local var_20_3 = var_1_10004(var_1_10006)
	local var_20_4 = var_4.getActivitiesByType

	ActivityConst = var_1_10008

	local var_20_5 = var_20_4(var_20_3, var_1_10008.ACTIVITY_TYPE_TASK_LIST)

	local function var_20_6(arg_21_0)
		local var_21_0 = arg_21_0
		local var_21_1 = arg_21_0.getConfig(var_21_0, "config_client")
		local var_21_2 = arg_21_0:getConfig("config_data")

		_ = var_21_0

		local var_21_3 = var_21_0.flatten(var_21_2)
		local var_21_4
		local var_21_5

		type = var_2_10006

		if var_2_10006(var_21_1) == "table" then
			ipairs = var_6

			for iter_21_0, iter_21_1 in var_6(var_21_1) do
				local var_21_6 = var_20_0
				local var_21_7 = iter_21_1.id

				Ship = var_2_10013
				var_21_6[var_21_7] = var_2_10013.New(iter_21_1)

				if iter_21_0 == 1 then
					var_20_0[iter_21_1.id].withShipFace = true

					local var_21_8 = {}

					if iter_21_1.type then
						var_21_8.type = iter_21_1.type
						var_21_8.param = iter_21_1.param
					end

					getActivityTask = var_12

					local var_21_9

					var_21_9, var_2_10013 = var_12(arg_21_0, true)

					if not var_21_9 or var_2_10013 then
						if var_2_10013 and var_2_10013:isFinish() then
							local var_21_10 = not var_2_10013:isReceive()
						end

						if false then
							var_21_10 = false
						end
					else
						var_21_10 = true
					end

					var_21_8.showTips = var_21_10
					var_21_8.acceptTaskId = var_21_9
					var_21_8.currentTask = var_2_10013
					var_20_1[iter_21_1.id] = var_21_8
					var_21_4 = var_21_8.acceptTaskId
					var_21_5 = var_21_8.currentTask
				end

				if iter_21_1.tasks then
					local var_21_11 = var_20_0[iter_21_1.id]

					var_21_11.hide = true

					if var_21_5 then
						table = var_21_11

						if not var_21_11.indexof(var_21_3, var_21_5.id) then
							table = var_21_11
							var_21_11 = var_21_11.indexof(var_21_3, var_21_4)
						end

						ipairs = var_2_10013

						for iter_21_2, iter_21_3 in var_2_10013(var_11) do
							if iter_21_3 == var_21_11 then
								var_20_0[iter_21_1.id].hide = false

								break
							end
						end
					end
				end
			end
		end

		return
	end

	_ = var_20_3

	var_20_3.each(var_20_5, function(arg_22_0)
		if not arg_22_0:isEnd() then
			var_20_6(arg_22_0)
		end

		return
	end)

	getProxy = var_7
	NavalAcademyProxy = var_9

	local var_20_7 = var_7(var_9)

	return var_7.fillStudens(var_20_7, var_20_0), var_20_1
end

return var_0_0
