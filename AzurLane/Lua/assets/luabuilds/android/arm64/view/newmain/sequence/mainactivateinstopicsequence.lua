class = var_0_10000

local var_0_0 = var_0_10000("MainActivateInsTopicSequence")

pg = var_0_10001

local var_0_1 = var_0_10001.activity_ins_chat_group

pg = var_2

local var_0_2 = var_2.ship_data_group

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = {}

	getProxy = var_1_10003
	InstagramChatProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.GetNotActiveTopicIdsByType(var_1_1, 1)
	local var_1_3 = var_3:GetNotActiveTopicIdsByType(2)
	local var_1_4 = var_3:GetNotActiveTopicIdsByType(3)
	local var_1_5 = var_3:GetNotActiveTopicIdsByType(4)
	local var_1_6 = var_3:GetNotActiveTopicIdsByType(5)
	local var_1_7 = var_3
	local var_1_8 = var_3.GetNotActiveTopicIdsByType(var_1_7, 6)
	local var_1_9 = var_3:GetNotActiveTopicIdsByType(7)

	getProxy = var_1_7
	CollectionProxy = var_13

	local var_1_10 = var_1_7(var_13)
	local var_1_11 = var_11.getGroups(var_1_10)
	local var_1_12 = {}

	ipairs = var_1_10

	for iter_1_0, iter_1_1 in var_1_10(var_0_1.all) do
		if var_0_1[iter_1_1].group_ii ~= 0 then
			if not var_1_12[iter_1_8.group_ii] then
				var_1_12[iter_1_8.group_ii] = {}
			end

			table = var_1_10019

			var_1_10019.insert(var_1_12[iter_1_8.group_ii], iter_1_1)
		end
	end

	ipairs = var_13

	for iter_1_2, iter_1_3 in var_13(var_0_2.all) do
		iter_1_8 = var_0_2[iter_1_3]
		ShipGroup = var_1_10019
		var_1_10019 = var_1_10019.getState(iter_1_8.code, var_1_11[iter_1_8.group_type], false)
		ShipGroup = var_1_10020

		if var_1_10019 == var_1_10020.STATE_UNLOCK then
			var_1_10020 = {}
			Clone = var_1_10021
			var_1_10021 = var_1_10021(var_0_1.get_id_list_by_ship_group[iter_1_8.group_type])
			var_1_10022 = var_1_12[iter_1_8.group_type]

			if var_1_10021 then
				for iter_1_4 = #var_1_10021, 1, -1 do
					if var_0_1[var_1_10021[iter_1_4]].group_ii ~= 0 then
						table = var_27

						var_27.remove(var_1_10021, iter_1_4)
					end
				end

				table = var_23

				var_23.insertto(var_1_10020, var_1_10021)
			end

			if var_1_10022 then
				table = var_23

				var_23.insertto(var_1_10020, var_1_10022)
			end

			if #var_1_10020 > 0 then
				ipairs = var_23

				for iter_1_5, iter_1_6 in var_23(var_1_10020) do
					if var_1_2 then
						_ = var_1_10028

						if var_1_10028.contains(var_1_2, iter_1_6) then
							table = var_1_10028

							var_1_10028.insert(var_1_0, iter_1_6)
						end
					end

					if var_1_3 then
						_ = var_1_10028

						if var_1_10028.contains(var_1_3, iter_1_6) then
							var_1_10028 = var_1_11[iter_1_8.group_type].maxIntimacy / 100
							tonumber = var_1_10029

							if var_1_10029(var_0_1[iter_1_6].trigger_param) <= var_1_10028 then
								table = var_30

								var_30.insert(var_1_0, iter_1_6)
							end
						end
					end

					if var_1_9 then
						_ = var_1_10028

						if var_1_10028.contains(var_1_9, iter_1_6) then
							var_1_10028 = var_1_11[iter_1_8.group_type].married == 1

							if var_1_10028 then
								table = var_1_10029

								var_1_10029.insert(var_1_0, iter_1_6)
							end
						end
					end
				end
			end
		end
	end

	local var_1_13, var_1_14

	if var_1_4 then
		pg = var_1_14
		var_1_13 = var_1_14.TimeMgr.GetInstance()
		var_1_14 = var_1_14.GetServerTime(var_1_13)
		ipairs = var_14

		for iter_1_7, iter_1_8 in var_14(var_1_4) do
			if #var_0_1[iter_1_8].trigger_param == 1 then
				pg = var_1_10019
				var_1_10021 = var_1_10019.TimeMgr.GetInstance()

				if var_1_10019.parseTimeFromConfig(var_1_10021, var_0_1[iter_1_8].trigger_param[1]) <= var_1_14 then
					table = var_1_10020

					var_1_10020.insert(var_1_0, iter_1_8)
				end
			elseif #var_0_1[iter_1_8].trigger_param == 2 then
				pg = var_1_10019
				var_1_10021 = var_1_10019.TimeMgr.GetInstance()
				var_1_10019 = var_1_10019.parseTimeFromConfig(var_1_10021, var_0_1[iter_1_8].trigger_param[1])
				pg = var_1_10020
				var_1_10022 = var_1_10020.TimeMgr.GetInstance()
				var_1_10020 = var_1_10020.parseTimeFromConfig(var_1_10022, var_0_1[iter_1_8].trigger_param[2])

				if var_1_10019 <= var_1_14 and var_1_14 <= var_1_10020 then
					table = var_1_10021

					var_1_10021.insert(var_1_0, iter_1_8)
				end
			end
		end
	end

	if var_1_5 then
		ipairs = var_1_14

		for iter_1_9, iter_1_10 in var_1_14(var_1_5) do
			pg = iter_1_8
			var_1_10020 = iter_1_8.NewStoryMgr.GetInstance()
			iter_1_8 = iter_1_8.StoryId2StoryName
			tonumber = var_1_10021
			iter_1_8 = iter_1_8(var_1_10020, var_1_10021(var_0_1[iter_1_10].trigger_param))
			pg = var_1_10019
			var_1_10021 = var_1_10019.NewStoryMgr.GetInstance()

			if var_1_10019.IsPlayed(var_1_10021, iter_1_8) then
				table = var_1_10019

				var_1_10019.insert(var_1_0, iter_1_10)
			end
		end
	end

	if var_1_6 then
		ipairs = var_1_14

		for iter_1_11, iter_1_12 in var_1_14(var_1_6) do
			getProxy = iter_1_8
			ChapterProxy = var_1_10020
			var_1_10020 = iter_1_8(var_1_10020)
			iter_1_8 = iter_1_8.getChapterById
			tonumber = var_1_10021
			var_1_10021 = iter_1_8(var_1_10020, var_1_10021(var_0_1[iter_1_12].trigger_param))

			if iter_1_8.isClear(var_1_10021) then
				table = var_19

				var_19.insert(var_1_0, iter_1_12)
			end
		end
	end

	if var_1_8 then
		getProxy = var_1_14
		TaskProxy = var_1_13

		local var_1_15 = var_1_14(var_1_13)

		ipairs = var_14

		for iter_1_13, iter_1_14 in var_14(var_1_8) do
			local var_1_16 = var_1_15
			local var_1_17 = var_1_15.getFinishTaskById

			tonumber = var_1_10022

			if var_1_17(var_1_16, var_1_10022(var_0_1[iter_1_14].trigger_param)) then
				table = var_19

				var_19.insert(var_1_0, iter_1_14)
			end
		end
	end

	if #var_1_0 > 0 then
		var_3:ActivateTopics(var_1_0)
	end

	arg_1_1()

	return
end

function var_0_0.ShowTip(arg_2_0)
	return
end

return var_0_0
