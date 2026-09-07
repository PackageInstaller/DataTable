local OtherWorldTaskMediator = class("OtherWorldTaskMediator", import("..base.ContextMediator"))

OtherWorldTaskMediator.SUBMIT_TASK_ALL = "activity submit task all"
OtherWorldTaskMediator.SUBMIT_TASK = "activity submit task "
OtherWorldTaskMediator.TASK_GO = "activity task go "
OtherWorldTaskMediator.SHOW_DETAIL = "activity task show detail"

function OtherWorldTaskMediator:register()
	self:bind(OtherWorldTaskMediator.SUBMIT_TASK_ALL, function(arg_2_0, arg_2_1)
		self:checkActStory(arg_2_1.activityId, arg_2_1.ids, function()
			self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_2_1.activityId,
				task_ids = arg_2_1.ids
			})

			return
		end)

		return
	end)
	self:bind(OtherWorldTaskMediator.SUBMIT_TASK, function(arg_4_0, arg_4_1)
		self:checkActStory(arg_4_1.activityId, {
			arg_4_1.id
		}, function()
			self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_4_1.activityId,
				task_ids = {
					arg_4_1.id
				}
			})

			return
		end)

		return
	end)
	self:bind(OtherWorldTaskMediator.TASK_GO, function(arg_6_0, arg_6_1)
		self.viewComponent:closeView()

		local var_6_0 = arg_6_1.taskVO:getConfig("scene")

		if var_6_0[1] == SCENE.OTHERWORLD_MAP then
			pg.SceneAnimMgr.GetInstance():OtherWorldCoverGoScene(SCENE.OTHERWORLD_MAP, {
				mode = var_6_0[2].mode
			})
		else
			self:sendNotification(GAME.TASK_GO, {
				taskVO = arg_6_1.taskVO
			})
		end

		return
	end)
	self:bind(OtherWorldTaskMediator.SHOW_DETAIL, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			mediator = AtelierMaterialDetailMediator,
			viewComponent = AtelierMaterialDetailLayer,
			data = {
				material = arg_7_1
			}
		}))

		return
	end)

	return
end

function OtherWorldTaskMediator:checkActStory(arg_8_1, arg_8_2, arg_8_3)
	if not pg.activity_template[arg_8_1].config_client.task_story then
		arg_8_3()

		return
	end

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(pg.activity_template[arg_8_1].config_client.task_story) do
		if table.contains(arg_8_2, iter_8_1[1]) then
			table.insert(var_8_0, iter_8_1[2])
		end
	end

	local var_8_1 = {}

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		table.insert(var_8_1, function(arg_9_0)
			pg.NewStoryMgr.GetInstance():Play(iter_8_3, arg_9_0, true)

			return
		end)
	end

	seriesAsync(var_8_1, function()
		arg_8_3()

		return
	end)

	return
end

function OtherWorldTaskMediator:onUIAvalible()
	return
end

function OtherWorldTaskMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function OtherWorldTaskMediator:handleNotification(arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()

	if var_13_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_13_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_13_1.awards)
		end

		if var_13_1.callback then
			-- block empty
		end

		self.viewComponent:updateTask(true)
	elseif var_13_0 == GAME.ZERO_HOUR_OP_DONE then
		self.viewComponent:updateTask(true)
	end

	return
end

return OtherWorldTaskMediator
