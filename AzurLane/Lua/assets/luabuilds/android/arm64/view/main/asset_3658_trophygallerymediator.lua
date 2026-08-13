class = var_0_10000

local var_0_0 = "TrophyGalleryMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_TROPHY_CLAIM = "TrophyGalleryMediator:ON_TROPHY_CLAIM"
var_0_1.ON_GET_ALL_LOVE_LETTER_REWARD = "TrophyGalleryMediator.ON_GET_ALL_LOVE_LETTER_REWARD"
var_0_1.OPEN_DISPLAY_WINDOW = "TrophyGalleryMediator.OPEN_DISPLAY_WINDOW"
var_0_1.OPEN_REALIZE_GIFT_LAYER = "TrophyGalleryMediator.OPEN_REALIZE_GIFT_LAYER"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	CollectionProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.ON_TROPHY_CLAIM, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.TROPHY_CLAIM, {
			trophyID = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_ALL_LOVE_LETTER_REWARD, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.GET_LOVE_LETTER_REWARD, {
			list = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DISPLAY_WINDOW, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		LoveLetterGiftLevelDisplayMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		LoveLetterGiftLevelDisplayLayer = var_2_10008
		var_4_3.viewComponent = var_2_10008
		var_4_3.data = {
			groupId = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_REALIZE_GIFT_LAYER, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		LoveLetterGiftCollectMediator = var_2_10007
		var_5_3.mediator = var_2_10007
		LoveLetterGiftCollectLayer = var_2_10007
		var_5_3.viewComponent = var_2_10007

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_1 = var_1_0:getTrophyGroup()
	local var_1_2 = var_1_0:getTrophys()
	local var_1_3 = arg_1_0.viewComponent

	var_4.setTrophyGroups(var_1_3, var_1_1)

	local var_1_4 = arg_1_0.viewComponent

	var_4.setTrophyList(var_1_4, var_1_2)

	return
end

function var_0_1.initNotificationHandleDic(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[var_1_10002.TROPHY_CLAIM_DONE] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1
		local var_7_1 = arg_7_1.getBody(var_7_0).trophyID

		pg = var_7_0

		local var_7_2 = var_7_0.medal_template[var_7_1].hide

		Trophy = var_2_10006

		if var_7_2 == var_2_10006.ALWAYS_HIDE then
			return
		end

		math = var_7_2

		local var_7_3 = var_7_2.floor(var_7_1 / 10)

		getProxy = var_6
		CollectionProxy = var_2_10008

		local var_7_4 = var_6(var_2_10008)
		local var_7_5 = var_6.getTrophyGroup(var_7_4)
		local var_7_6 = var_6:getTrophys()
		local var_7_7 = arg_7_0.viewComponent

		var_9.setTrophyGroups(var_7_7, var_7_5)

		local var_7_8 = arg_7_0.viewComponent

		var_9.setTrophyList(var_7_8, var_7_6)

		local var_7_9 = arg_7_0.viewComponent

		var_9.PlayTrophyClaim(var_7_9, var_7_3)

		return
	end
	GAME = var_2
	var_6_0[var_2.GET_LOVE_LETTER_REWARD_DONE] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1:getBody()
		local var_8_1 = {}

		if #var_8_0.awards > 0 then
			table = var_4

			var_4.insert(var_8_1, function(arg_9_0)
				local var_9_0 = arg_8_0.viewComponent
				local var_9_1 = var_1.emit

				BaseUI = var_3_10004

				var_9_1(var_9_0, var_3_10004.ON_ACHIEVE, var_8_0.awards, arg_9_0)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_8_1, function()
			local var_10_0 = arg_8_0.viewComponent

			var_0.updateLoveLetterPage(var_10_0)

			pg = var_0

			local var_10_1 = var_0.EasyRedDotMgr.GetInstance()

			var_0.TriggerMarks(var_10_1, "love_letter_level_reward")

			return
		end)

		return
	end
	GAME = var_2
	var_6_0[var_2.LOVE_LETTER_LEVEL_UP_DONE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.viewComponent

		var_2.updateLoveLetterPage(var_11_0)

		pg = var_2

		local var_11_1 = var_2.EasyRedDotMgr.GetInstance()

		var_2.TriggerMarks(var_11_1, "love_letter_level_up")

		return
	end
	GAME = var_2
	var_6_0[var_2.REALIZE_LOVE_LETTER_GIFT_DONE] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0.viewComponent

		var_2.updateLoveLetterPage(var_12_0)

		return
	end
	arg_6_0.handleDic = var_6_0

	return
end

return var_0_1
