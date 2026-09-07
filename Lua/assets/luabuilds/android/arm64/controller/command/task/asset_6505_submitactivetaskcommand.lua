local SubmitActiveTaskCommand = class("SubmitActiveTaskCommand", pm.SimpleCommand)
local var_0_1 = {
	59599
}

function SubmitActiveTaskCommand:GetSubmitActivityTaskDone()
	return GAME.SUBMIT_ACTIVITY_TASK_DONE
end

function SubmitActiveTaskCommand:GetSubMitActivityAwardDown()
	return GAME.SUBMIT_TASK_AWARD_DOWN
end

function SubmitActiveTaskCommand:execute(arg_3_1)
	local var_3_0 = arg_3_1:getBody() or {}
	local var_3_1 = var_3_0.callback
	local var_3_2 = pg.activity_template[var_3_0.act_id].type
	local var_3_3 = {}

	if table.contains(TotalTaskProxy.avatar_task_type, pg.activity_template[var_3_0.act_id].type) then
		-- block empty
	elseif table.contains(TotalTaskProxy.activity_task_type, var_3_2) then
		for iter_3_0, iter_3_1 in ipairs(var_3_0.task_ids) do
			local var_3_4 = getProxy(ActivityTaskProxy):getTaskVo(var_3_0.act_id, iter_3_1)

			if var_3_4 then
				table.insert(var_3_3, var_3_4)
			end
		end
	elseif table.contains(TotalTaskProxy.normal_task_type, var_3_2) then
		for iter_3_2, iter_3_3 in ipairs(var_3_0.task_ids) do
			local var_3_5 = getProxy(TaskProxy):getTaskById(iter_3_3)

			if getProxy(TaskProxy):isSubmitting(iter_3_3) then
				-- block empty
			else
				getProxy(TaskProxy):addSubmittingTask(iter_3_3)
				table.insert(var_3_3, var_3_5)
			end
		end
	end

	if not self:InTaskScene() then
		local var_3_6, var_3_7 = self:filterOverflowTaskVOList(var_3_3)

		if var_3_7 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("player_expResource_mail_fullBag"),
				onYes = function()
					self:submitActivity(var_3_0, var_3_3, var_3_2, var_3_1)

					return
				end,
				onNo = function()
					if var_3_1 then
						var_3_1(false)
					end

					return
				end
			})

			return
		end
	end

	self:submitActivity(var_3_0, var_3_3, var_3_2, var_3_1)

	return
end

function SubmitActiveTaskCommand:submitActivity(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	pg.ConnectionMgr.GetInstance():Send(20205, {
		act_id = arg_6_1.act_id,
		task_ids = arg_6_1.task_ids
	}, 20206, function(arg_7_0)
		if arg_7_0.result == 0 then
			local var_7_0 = {}

			if table.contains(TotalTaskProxy.avatar_task_type, arg_6_3) then
				local var_7_1 = Clone(pg.activity_event_avatarframe[pg.activity_template[arg_6_1.act_id].config_id].award_display)[1]
				local var_7_2 = 0

				for iter_7_0, iter_7_1 in ipairs(arg_6_1.task_ids) do
					var_7_2 = var_7_2 + self:getAwardNum(pg.activity_event_avatarframe[pg.activity_template[arg_6_1.act_id].config_id], iter_7_1)
				end

				local var_7_3 = getProxy(ActivityProxy):RawGetActivityById(arg_6_1.act_id)

				if var_7_3 then
					var_7_3.data1 = var_7_3.data1 + var_7_2
				end

				var_7_1[3] = var_7_2

				table.insert(var_7_0, (Drop.Create(var_7_1)))
				self:sendNotification(GAME.SUBMIT_AVATAR_TASK_DONE, {
					awards = var_7_0
				})
			elseif table.contains(TotalTaskProxy.activity_task_type, arg_6_3) then
				for iter_7_2, iter_7_3 in ipairs(arg_6_2) do
					self:updateTaskActivityData(iter_7_3.id, arg_6_1.act_id)
					self:updateTaskBagData(iter_7_3.id, arg_6_1.act_id)
					SubmitTaskCommand.OnSubmitSuccess(iter_7_3)
				end

				if arg_6_1.inIsland then
					self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK_IN_ISLAND_DONE, {
						dropData = IslandDropHelper.AddItems({
							drop_list = arg_7_0.award_list
						}),
						actId = arg_6_1.act_id
					})
				else
					var_7_0 = PlayerConst.addTranDrop(arg_7_0.award_list, {})

					self:sendNotification(self:GetSubmitActivityTaskDone(), {
						awards = var_7_0
					}, arg_6_1.task_ids)
				end
			elseif table.contains(TotalTaskProxy.normal_task_type, arg_6_3) then
				var_7_0 = PlayerConst.addTranDrop(arg_7_0.award_list, {})

				for iter_7_4 = #var_7_0, 1, -1 do
					if table.contains(var_0_1, var_7_0[iter_7_4].id) then
						table.remove(var_7_0, iter_7_4)
					end
				end

				for iter_7_5, iter_7_6 in ipairs(arg_6_2) do
					self:updateTaskBagData(iter_7_6.id, arg_6_1.act_id)
					SubmitTaskCommand.OnSubmitSuccess(iter_7_6)
					getProxy(TaskProxy):removeSubmittingTask(iter_7_6.id)
				end

				self:sendNotification(self:GetSubmitActivityTaskDone(), {
					awards = var_7_0
				}, arg_6_1.task_ids)
			end

			self:sendNotification(self:GetSubMitActivityAwardDown(), {
				awards = var_7_0
			}, arg_6_1.task_ids)

			if arg_6_4 then
				arg_6_4(true)
			end
		else
			if arg_6_4 then
				arg_6_4(false)
			end

			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_7_0.result))
		end

		return
	end)

	return
end

function SubmitActiveTaskCommand:updateTaskActivityData(arg_8_1, arg_8_2)
	local var_8_0 = getProxy(ActivityProxy):getActivityById(arg_8_2)

	if var_8_0 then
		getProxy(ActivityTaskProxy):finishActTask(arg_8_2, arg_8_1)
		self:sendNotification(ActivityProxy.ACTIVITY_UPDATED, var_8_0)
	end

	return
end

local var_0_2 = {
	{
		6,
		1006
	},
	{
		16,
		1006
	}
}
local var_0_3 = {
	{
		6,
		1007
	},
	{
		16,
		1007
	}
}

function SubmitActiveTaskCommand:updateTaskBagData(arg_9_1, arg_9_2)
	local var_9_0 = tonumber(pg.task_data_template[arg_9_1].target_id)

	if pg.activity_drop_type[var_9_0] then
		for iter_9_0, iter_9_1 in ipairs(var_0_2) do
			if pg.task_data_template[arg_9_1].type == iter_9_1[1] and pg.task_data_template[arg_9_1].sub_type == iter_9_1[2] then
				local var_9_1 = tonumber(pg.task_data_template[arg_9_1].target_id_2)
				local var_9_2 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[var_9_0].activity_id)

				if var_9_2 then
					var_9_2:subVitemNumber(var_9_1, pg.task_data_template[arg_9_1].target_num)
					getProxy(ActivityProxy):updateActivity(var_9_2)
				end
			end
		end

		for iter_9_2, iter_9_3 in ipairs(var_0_3) do
			if pg.task_data_template[arg_9_1].type == iter_9_3[1] and pg.task_data_template[arg_9_1].sub_type == iter_9_3[2] then
				local var_9_3 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[var_9_0].activity_id)

				if var_9_3 then
					for iter_9_4, iter_9_5 in ipairs(pg.task_data_template[arg_9_1].target_id_2) do
						var_9_3:subVitemNumber(iter_9_5[1], iter_9_5[2])
					end

					getProxy(ActivityProxy):updateActivity(var_9_3)
				end
			end
		end
	end

	return
end

function SubmitActiveTaskCommand:filterOverflowTaskVOList(arg_10_1)
	local var_10_0 = {}
	local var_10_1 = getProxy(PlayerProxy):getData()
	local var_10_2 = var_10_1.gold
	local var_10_3 = var_10_1.oil
	local var_10_4

	if not LOCK_UR_SHIP then
		var_10_4 = getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]) or 0
	end

	if LOCK_UR_SHIP or not pg.gameset.urpt_chapter_max.description[2] then
		-- block empty
	end

	local var_10_8 = false

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		local var_10_9 = iter_10_1:judgeOverflow(var_10_2, var_10_3, var_10_4)

		if not var_10_9 then
			table.insert(var_10_0, iter_10_1)
		end

		if var_10_9 then
			var_10_8 = true
		end
	end

	return var_10_0, var_10_8
end

function SubmitActiveTaskCommand:getAwardNum(arg_11_1, arg_11_2)
	for iter_11_0 = 1, #AvatarFrameTask.fillter_task_type do
		for iter_11_1, iter_11_2 in ipairs(arg_11_1[AvatarFrameTask.fillter_task_type[iter_11_0]]) do
			if arg_11_2 == iter_11_2[1] then
				if AvatarFrameTask.fillter_task_type[iter_11_0] == AvatarFrameTask.type_task_level then
					return iter_11_2[6]
				elseif AvatarFrameTask.fillter_task_type[iter_11_0] == AvatarFrameTask.type_task_ship then
					return iter_11_2[4]
				end
			end
		end
	end

	print("找不到taskId:" .. arg_11_2)

	return 0
end

function SubmitActiveTaskCommand:InTaskScene()
	return getProxy(ContextProxy):getCurrentContext().mediator == TaskMediator
end

return SubmitActiveTaskCommand
