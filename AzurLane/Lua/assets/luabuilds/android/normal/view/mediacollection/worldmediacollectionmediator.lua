class = var_0_10000

local var_0_0 = "WorldMediaCollectionMediator"

ContextMediator = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

var_0_1.BEGIN_STAGE = "WorldMediaCollectionMediator BEGIN_STAGE"
var_0_1.ON_ADD_SUBLAYER = "WorldMediaCollectionMediator.ON_ADD_SUBLAYER"
var_0_1.GO_TASK = "WorldMediaCollectionMediator.GO_TASK"
var_0_1.TRIGGER_PERSONAL_TASK = "WorldMediaCollectionMediator.TRIGGER_PERSONAL_TASK"
var_0_1.OPEN_LOVE_LETTER_DISPLAY = "WorldMediaCollectionMediator.OPEN_LOVE_LETTER_DISPLAY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.BEGIN_STAGE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.contextData

		pg = var_2_10003
		var_2_0.revertBgm = var_2_10003.CriMgr.GetInstance().bgmNow

		local var_2_1 = arg_1_0
		local var_2_2 = var_2.sendNotification

		GAME = var_2_10004

		var_2_2(var_2_1, var_2_10004.BEGIN_STAGE, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ADD_SUBLAYER, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.addSubLayers(var_3_0, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.GO_TASK, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_4_3 = var_2_10005.TASK
		local var_4_4 = {}

		TaskScene = var_2_10007
		var_4_4.page = var_2_10007.PAGE_TYPE_BRANCH

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_LOVE_LETTER_DISPLAY, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		LoveLetterDisplayMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		LoveLetterDisplayLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		setmetatable = var_2_10006

		local var_5_4 = {
			groupId = arg_5_1
		}
		local var_5_5 = {}

		getProxy = var_2_10009
		LoveLetterProxy = var_2_10010

		local var_5_6 = var_2_10009(var_2_10010)
		local var_5_7 = var_9.GetGroupData(var_5_6, arg_5_1)

		var_5_5.__index = var_9.GetLetterDataFromId(var_5_7)
		var_5_3.data = var_2_10006(var_5_4, var_5_5)

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.TRIGGER_PERSONAL_TASK, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0

		var_3.TriggerPersonalTask(var_6_0, arg_6_1, arg_6_2)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	PlayerProxy = var_1_10002
	var_7_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_7_0[2] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_7_0[3] = var_2.UNLOCK_LOVE_LETTER_DONE
	GAME = var_2
	var_7_0[4] = var_2.STORY_UPDATE_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	PlayerProxy = var_8_1

	if var_8_0 == var_8_1.UPDATED then
		local var_8_3 = arg_8_0.viewComponent

		var_4.UpdateView(var_8_3)
	else
		GAME = var_4

		local var_8_5

		if var_8_0 == var_4.BEGIN_STAGE_DONE then
			local var_8_4 = arg_8_0

			var_8_5 = arg_8_0.sendNotification
			GAME = var_1_10006

			local var_8_6 = var_1_10006.GO_SCENE

			SCENE = var_1_10007

			var_8_5(var_8_4, var_8_6, var_1_10007.COMBATLOAD, var_8_2)
		else
			GAME = var_8_5

			if var_8_0 == var_8_5.UNLOCK_LOVE_LETTER_DONE then
				pg = var_4

				local var_8_7 = var_4.EasyRedDotMgr.GetInstance()

				var_4.TriggerMarks(var_8_7, "love_letter_unlock_letter")
			else
				GAME = var_4

				if var_8_0 == var_4.STORY_UPDATE_DONE then
					local var_8_8 = arg_8_0.contextData
					local var_8_9

					if not arg_8_0.contextData.listenStoryDic then
						var_8_9 = {}
					end

					var_8_8.listenStoryDic = var_8_9
					existCall = var_8_8

					var_8_8(arg_8_0.contextData.listenStoryDic[var_8_2.storyName])

					arg_8_0.contextData.listenStoryDic[var_8_2.storyName] = nil
				end
			end
		end
	end

	return
end

function var_0_1.TriggerPersonalTask(arg_9_0, arg_9_1, arg_9_2)
	assert = var_1_10003

	local var_9_0 = arg_9_1 and arg_9_1 ~= 0
	local var_9_1 = "invalid groupId:"

	tostring = var_1_10006

	var_1_10003(var_9_0, var_9_1 .. var_1_10006(arg_9_1))

	pg = var_1_10003

	local var_9_2

	if not var_1_10003.task_data_trigger.get_id_list_by_group_id[arg_9_1] then
		var_9_2 = {}
	end

	if var_9_2[1] then
		::label_9_0::

		pg = var_9_0
		var_9_0 = var_9_0.task_data_trigger[var_3].task_id
	end

	assert = var_5

	local var_9_3 = var_9_0 and var_9_0 ~= 0
	local var_9_4 = "invalid taskId for groupId:"

	tostring = var_1_10008

	var_5(var_9_3, var_9_4 .. var_1_10008(arg_9_1))

	getProxy = var_5
	TaskProxy = var_9_3

	local var_9_5 = var_5(var_9_3)

	if not var_5.getFinishTaskById(var_9_5, var_9_0) then
		pg = var_5

		local var_9_6 = var_5.task_data_template[var_9_0].story_id
		local var_9_7 = arg_9_0.contextData
		local var_9_8

		if not arg_9_0.contextData.listenStoryDic then
			var_9_8 = {}
		end

		var_9_7.listenStoryDic = var_9_8

		local var_9_9 = arg_9_0.contextData.listenStoryDic

		var_9_9[var_9_6] = arg_9_2
		pg = var_9_9

		local var_9_10 = var_9_9.m02
		local var_9_11 = var_6.sendNotification

		GAME = var_8

		var_9_11(var_9_10, var_8.TRIGGER_TASK, var_9_0)
	end

	return
end

return var_0_1
