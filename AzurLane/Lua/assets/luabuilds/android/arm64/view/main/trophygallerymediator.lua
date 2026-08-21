local var_0_0 = class("TrophyGalleryMediator", import("..base.ContextMediator"))

var_0_0.ON_TROPHY_CLAIM = "TrophyGalleryMediator:ON_TROPHY_CLAIM"
var_0_0.ON_GET_ALL_LOVE_LETTER_REWARD = "TrophyGalleryMediator.ON_GET_ALL_LOVE_LETTER_REWARD"
var_0_0.OPEN_DISPLAY_WINDOW = "TrophyGalleryMediator.OPEN_DISPLAY_WINDOW"
var_0_0.OPEN_REALIZE_GIFT_LAYER = "TrophyGalleryMediator.OPEN_REALIZE_GIFT_LAYER"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(CollectionProxy)

	arg_1_0:bind(var_0_0.ON_TROPHY_CLAIM, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TROPHY_CLAIM, {
			trophyID = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_ALL_LOVE_LETTER_REWARD, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.GET_LOVE_LETTER_REWARD, {
			list = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DISPLAY_WINDOW, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = LoveLetterGiftLevelDisplayMediator,
			viewComponent = LoveLetterGiftLevelDisplayLayer,
			data = {
				groupId = arg_4_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_REALIZE_GIFT_LAYER, function(arg_5_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = LoveLetterGiftCollectMediator,
			viewComponent = LoveLetterGiftCollectLayer
		}))

		return
	end)
	arg_1_0.viewComponent:setTrophyGroups((var_1_0:getTrophyGroup()))
	arg_1_0.viewComponent:setTrophyList((var_1_0:getTrophys()))

	return
end

function var_0_0.initNotificationHandleDic(arg_6_0)
	arg_6_0.handleDic = {
		[GAME.TROPHY_CLAIM_DONE] = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_7_1:getBody().trophyID

			if pg.medal_template[var_7_0].hide == Trophy.ALWAYS_HIDE then
				return
			end

			local var_7_1 = math.floor(var_7_0 / 10)
			local var_7_2 = getProxy(CollectionProxy)

			arg_7_0.viewComponent:setTrophyGroups((var_7_2:getTrophyGroup()))
			arg_7_0.viewComponent:setTrophyList((var_7_2:getTrophys()))
			arg_7_0.viewComponent:PlayTrophyClaim(var_7_1)

			return
		end,
		[GAME.GET_LOVE_LETTER_REWARD_DONE] = function(arg_8_0, arg_8_1)
			if #arg_8_1:getBody().awards > 0 then
				table.insert({}, function(arg_9_0)
					arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_0.awards, arg_9_0)

					return
				end)
			end

			seriesAsync({}, function()
				arg_8_0.viewComponent:updateLoveLetterPage()
				pg.EasyRedDotMgr.GetInstance():TriggerMarks("love_letter_level_reward")

				return
			end)

			return
		end,
		[GAME.LOVE_LETTER_LEVEL_UP_DONE] = function(arg_11_0, arg_11_1)
			arg_11_0.viewComponent:updateLoveLetterPage()
			pg.EasyRedDotMgr.GetInstance():TriggerMarks("love_letter_level_up")

			return
		end,
		[GAME.REALIZE_LOVE_LETTER_GIFT_DONE] = function(arg_12_0, arg_12_1)
			arg_12_0.viewComponent:updateLoveLetterPage()

			return
		end
	}

	return
end

return var_0_0
