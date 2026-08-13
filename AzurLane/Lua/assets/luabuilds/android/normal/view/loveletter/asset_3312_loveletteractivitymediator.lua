class = var_0_10000

local var_0_0 = "LoveLetterActivityMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_SELECT_GROUP = "LoveLetterActivityMediator.ON_SELECT_GROUP"
var_0_1.ON_REALIZE_GIFT = "LoveLetterActivityMediator.ON_REALIZE_GIFT"
var_0_1.ON_GO_COLLECTION = "LoveLetterActivityMediator.ON_GO_COLLECTION"
var_0_1.ON_GO_TROPHY = "LoveLetterActivityMediator.ON_GO_TROPHY"
var_0_1.ON_DAILY_LOGIN_REWARD = "LoveLetterActivityMediator.ON_DAILY_LOGIN_REWARD"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SELECT_GROUP, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		LoveLetterSelectCharMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		LoveLetterSelectCharLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = {
			actId = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_REALIZE_GIFT, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_3_2 = var_2_10003.New
		local var_3_3 = {}

		LoveLetterGiftCollectMediator = var_2_10005
		var_3_3.mediator = var_2_10005
		LoveLetterGiftCollectLayer = var_2_10005
		var_3_3.viewComponent = var_2_10005

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_DAILY_LOGIN_REWARD, function(arg_4_0, arg_4_1)
		arg_1_0.contextData.submitTaskId = arg_4_1

		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.SUBMIT_TASK, arg_4_1, nil)

		return
	end)
	arg_1_0:bind(var_0_1.ON_GO_COLLECTION, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_5_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_5_3 = var_2_10004.WORLD_COLLECTION
		local var_5_4 = {}

		WorldMediaCollectionScene = var_2_10006
		var_5_4.page = var_2_10006.PAGE_ALBUM
		WorldMediaCollectionAlbumGroupLayer = var_6
		var_5_4.albumType = var_6.ALBUM_TYPE_LOVE_LETTER

		var_5_1(var_5_0, var_5_2, var_5_3, var_5_4)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_GO_TROPHY, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_6_2 = var_2_10003.New
		local var_6_3 = {}

		TrophyGalleryMediator = var_2_10005
		var_6_3.mediator = var_2_10005
		TrophyGalleryLayer = var_2_10005
		var_6_3.viewComponent = var_2_10005
		var_6_3.data = {
			index = 3
		}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_LOVE_LETTER_UP)
	local var_1_4 = arg_1_0.viewComponent

	var_3.SetActivity(var_1_4, var_1_3)

	local var_1_5 = arg_1_0.viewComponent

	var_3.SetDailyActivity(var_1_5, var_1:getActivityById(var_1_3:GetConfigClientSetting("sub_act_id")))

	return
end

function var_0_1.initNotificationHandleDic(arg_7_0)
	local var_7_0 = {}

	ActivityProxy = var_1_10002
	var_7_0[var_1_10002.ACTIVITY_UPDATED] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1:getBody()

		if arg_8_0.viewComponent.activity and arg_8_0.viewComponent.activity.id == var_8_0.id then
			local var_8_1 = arg_8_0.viewComponent

			var_3.SetActivity(var_8_1, var_8_0)

			local var_8_2 = arg_8_0.viewComponent

			var_3.UpdatePainting(var_8_2)

			local var_8_3 = arg_8_0.viewComponent

			var_3.UpdateSlider(var_8_3)

			local var_8_4 = arg_8_0.viewComponent

			var_3.UpdateLoveLetterMedal(var_8_4)
		end

		return
	end
	GAME = var_2
	var_7_0[var_2.REALIZE_LOVE_LETTER_GIFT_DONE] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.viewComponent

		var_2.UpdateSlider(var_9_0)

		local var_9_1 = arg_9_0.viewComponent

		var_2.UpdateLoveLetterMedal(var_9_1)

		return
	end
	GAME = var_2

	local var_7_1 = var_2.LOVE_LETTER_LEVEL_UP_DONE

	GAME = var_3
	var_7_0[var_7_1] = var_3.REALIZE_LOVE_LETTER_GIFT_DONE
	LoveLetterProxy = var_7_1
	var_7_0[var_7_1.UPDATE_LOVE_LETTER] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.viewComponent

		var_2.UpdateSlider(var_10_0)

		return
	end
	GAME = var_2
	var_7_0[var_2.SUBMIT_TASK_AWARD_DOWN] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1:getBody()
		local var_11_1 = arg_11_0.contextData.submitTaskId
		local var_11_2 = arg_11_1

		if var_11_1 ~= arg_11_1.getType(var_11_2)[1] then
			return
		end

		arg_11_0.contextData.submitTaskId = nil

		local var_11_3 = arg_11_0.viewComponent

		var_3.HideDailyPanel(var_11_3)

		local var_11_4 = arg_11_0.viewComponent
		local var_11_5 = var_3.emit

		BaseUI = var_11_2

		var_11_5(var_11_4, var_11_2.ON_ACHIEVE, var_11_0.awards, function()
			local var_12_0 = arg_11_0.viewComponent

			var_0.UpdateSlider(var_12_0)

			local var_12_1 = arg_11_0.viewComponent
			local var_12_2 = var_0.SetDailyActivity

			getProxy = var_3_10002
			ActivityProxy = var_3_10003

			local var_12_3 = var_3_10002(var_3_10003)

			var_12_2(var_12_1, var_2.getActivityById(var_12_3, arg_11_0.viewComponent.dailyActivity.id))

			return
		end)

		return
	end
	arg_7_0.handleDic = var_7_0

	return
end

return var_0_1
