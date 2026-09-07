local WorldMediaCollectionMediator = class("WorldMediaCollectionMediator", ContextMediator)

WorldMediaCollectionMediator.BEGIN_STAGE = "WorldMediaCollectionMediator BEGIN_STAGE"
WorldMediaCollectionMediator.ON_ADD_SUBLAYER = "WorldMediaCollectionMediator.ON_ADD_SUBLAYER"
WorldMediaCollectionMediator.GO_TASK = "WorldMediaCollectionMediator.GO_TASK"
WorldMediaCollectionMediator.TRIGGER_PERSONAL_TASK = "WorldMediaCollectionMediator.TRIGGER_PERSONAL_TASK"
WorldMediaCollectionMediator.OPEN_LOVE_LETTER_DISPLAY = "WorldMediaCollectionMediator.OPEN_LOVE_LETTER_DISPLAY"

function WorldMediaCollectionMediator:register()
	self:bind(WorldMediaCollectionMediator.BEGIN_STAGE, function(arg_2_0, arg_2_1)
		self.contextData.revertBgm = pg.CriMgr.GetInstance().bgmNow

		self:sendNotification(GAME.BEGIN_STAGE, arg_2_1)

		return
	end)
	self:bind(WorldMediaCollectionMediator.ON_ADD_SUBLAYER, function(arg_3_0, arg_3_1)
		self:addSubLayers(arg_3_1)

		return
	end)
	self:bind(WorldMediaCollectionMediator.GO_TASK, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.TASK, {
			page = TaskScene.PAGE_TYPE_BRANCH
		})

		return
	end)
	self:bind(WorldMediaCollectionMediator.OPEN_LOVE_LETTER_DISPLAY, function(arg_5_0, arg_5_1)
		local var_5_0 = {
			mediator = LoveLetterDisplayMediator,
			viewComponent = LoveLetterDisplayLayer
		}
		local var_5_1 = {}

		var_5_1.__index = getProxy(LoveLetterProxy):GetGroupData(arg_5_1):GetLetterDataFromId()
		var_5_0.data = setmetatable({
			groupId = arg_5_1
		}, var_5_1)

		self:addSubLayers(Context.New(var_5_0))

		return
	end)
	self:bind(WorldMediaCollectionMediator.TRIGGER_PERSONAL_TASK, function(arg_6_0, arg_6_1, arg_6_2)
		self:TriggerPersonalTask(arg_6_1, arg_6_2)

		return
	end)

	return
end

function WorldMediaCollectionMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_DONE,
		GAME.UNLOCK_LOVE_LETTER_DONE,
		GAME.STORY_UPDATE_DONE
	}
end

function WorldMediaCollectionMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == PlayerProxy.UPDATED then
		self.viewComponent:UpdateView()
	elseif var_8_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_8_1)
	elseif var_8_0 == GAME.UNLOCK_LOVE_LETTER_DONE then
		pg.EasyRedDotMgr.GetInstance():TriggerMarks("love_letter_unlock_letter")
	elseif var_8_0 == GAME.STORY_UPDATE_DONE then
		self.contextData.listenStoryDic = self.contextData.listenStoryDic or {}

		existCall(self.contextData.listenStoryDic[var_8_1.storyName])

		self.contextData.listenStoryDic[var_8_1.storyName] = nil
	end

	return
end

function WorldMediaCollectionMediator:TriggerPersonalTask(arg_9_1, arg_9_2)
	assert(arg_9_1 and arg_9_1 ~= 0, "invalid groupId:" .. tostring(arg_9_1))

	local var_9_0 = (pg.task_data_trigger.get_id_list_by_group_id[arg_9_1] or {})[1] and pg.task_data_trigger[(pg.task_data_trigger.get_id_list_by_group_id[arg_9_1] or {})[1]].task_id

	assert((pg.task_data_trigger.get_id_list_by_group_id[arg_9_1] or {})[1] and pg.task_data_trigger[(pg.task_data_trigger.get_id_list_by_group_id[arg_9_1] or {})[1]].task_id and var_9_0 ~= 0, "invalid taskId for groupId:" .. tostring(arg_9_1))

	if not getProxy(TaskProxy):getFinishTaskById(var_9_0) then
		self.contextData.listenStoryDic = self.contextData.listenStoryDic or {}
		self.contextData.listenStoryDic[pg.task_data_template[var_9_0].story_id] = arg_9_2

		pg.m02:sendNotification(GAME.TRIGGER_TASK, var_9_0)
	end

	return
end

return WorldMediaCollectionMediator
