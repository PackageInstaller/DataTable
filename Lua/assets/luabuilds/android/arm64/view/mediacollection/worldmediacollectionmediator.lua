local var_0_0 = class("WorldMediaCollectionMediator", ContextMediator)

var_0_0.BEGIN_STAGE = "WorldMediaCollectionMediator BEGIN_STAGE"
var_0_0.ON_ADD_SUBLAYER = "WorldMediaCollectionMediator.ON_ADD_SUBLAYER"
var_0_0.GO_TASK = "WorldMediaCollectionMediator.GO_TASK"
var_0_0.TRIGGER_PERSONAL_TASK = "WorldMediaCollectionMediator.TRIGGER_PERSONAL_TASK"
var_0_0.OPEN_LOVE_LETTER_DISPLAY = "WorldMediaCollectionMediator.OPEN_LOVE_LETTER_DISPLAY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.BEGIN_STAGE, function(arg_2_0, arg_2_1)
		arg_1_0.contextData.revertBgm = pg.CriMgr.GetInstance().bgmNow

		arg_1_0:sendNotification(GAME.BEGIN_STAGE, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_ADD_SUBLAYER, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.GO_TASK, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.TASK, {
			page = TaskScene.PAGE_TYPE_BRANCH
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_LOVE_LETTER_DISPLAY, function(arg_5_0, arg_5_1)
		({}).__index = getProxy(LoveLetterProxy):GetGroupData(arg_5_1):GetLetterDataFromId()
		;({
			mediator = LoveLetterDisplayMediator,
			viewComponent = LoveLetterDisplayLayer
		}).data = setmetatable({
			groupId = arg_5_1
		}, {})

		arg_1_0:addSubLayers(Context.New({
			mediator = LoveLetterDisplayMediator,
			viewComponent = LoveLetterDisplayLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.TRIGGER_PERSONAL_TASK, function(arg_6_0, arg_6_1, arg_6_2)
		arg_1_0:TriggerPersonalTask(arg_6_1, arg_6_2)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_DONE,
		GAME.UNLOCK_LOVE_LETTER_DONE,
		GAME.STORY_UPDATE_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == PlayerProxy.UPDATED then
		arg_8_0.viewComponent:UpdateView()
	elseif var_8_0 == GAME.BEGIN_STAGE_DONE then
		arg_8_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_8_1)
	elseif var_8_0 == GAME.UNLOCK_LOVE_LETTER_DONE then
		pg.EasyRedDotMgr.GetInstance():TriggerMarks("love_letter_unlock_letter")
	elseif var_8_0 == GAME.STORY_UPDATE_DONE then
		arg_8_0.contextData.listenStoryDic = arg_8_0.contextData.listenStoryDic or {}

		existCall(arg_8_0.contextData.listenStoryDic[var_8_1.storyName])

		arg_8_0.contextData.listenStoryDic[var_8_1.storyName] = nil
	end

	return
end

function var_0_0.TriggerPersonalTask(arg_9_0, arg_9_1, arg_9_2)
	assert(arg_9_1 and arg_9_1 ~= 0, "invalid groupId:" .. tostring(arg_9_1))

	local var_9_0 = pg.task_data_trigger.get_id_list_by_group_id[arg_9_1] or {}
	local var_9_1 = var_9_0[1]
	local var_9_2 = var_9_0[1] and pg.task_data_trigger[var_9_1].task_id

	assert(var_9_0[1] and pg.task_data_trigger[var_9_1].task_id and var_9_2 ~= 0, "invalid taskId for groupId:" .. tostring(arg_9_1))

	if not getProxy(TaskProxy):getFinishTaskById(var_9_2) then
		arg_9_0.contextData.listenStoryDic = arg_9_0.contextData.listenStoryDic or {}
		arg_9_0.contextData.listenStoryDic[pg.task_data_template[var_9_2].story_id] = arg_9_2

		pg.m02:sendNotification(GAME.TRIGGER_TASK, var_9_2)
	end

	return
end

return var_0_0
