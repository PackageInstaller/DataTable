local var_0_0 = class("LoveLetterActivityMediator", import("view.base.ContextMediator"))

var_0_0.ON_SELECT_GROUP = "LoveLetterActivityMediator.ON_SELECT_GROUP"
var_0_0.ON_REALIZE_GIFT = "LoveLetterActivityMediator.ON_REALIZE_GIFT"
var_0_0.ON_GO_COLLECTION = "LoveLetterActivityMediator.ON_GO_COLLECTION"
var_0_0.ON_GO_TROPHY = "LoveLetterActivityMediator.ON_GO_TROPHY"
var_0_0.ON_DAILY_LOGIN_REWARD = "LoveLetterActivityMediator.ON_DAILY_LOGIN_REWARD"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SELECT_GROUP, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = LoveLetterSelectCharMediator,
			viewComponent = LoveLetterSelectCharLayer,
			data = {
				actId = arg_2_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_REALIZE_GIFT, function(arg_3_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = LoveLetterGiftCollectMediator,
			viewComponent = LoveLetterGiftCollectLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_DAILY_LOGIN_REWARD, function(arg_4_0, arg_4_1)
		arg_1_0.contextData.submitTaskId = arg_4_1

		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_4_1, nil)

		return
	end)
	arg_1_0:bind(var_0_0.ON_GO_COLLECTION, function(arg_5_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM,
			albumType = WorldMediaCollectionAlbumGroupLayer.ALBUM_TYPE_LOVE_LETTER
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GO_TROPHY, function(arg_6_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = TrophyGalleryMediator,
			viewComponent = TrophyGalleryLayer,
			data = {
				index = 3
			}
		}))

		return
	end)

	local var_1_0 = getProxy(ActivityProxy)
	local var_1_1 = var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_UP)

	arg_1_0.viewComponent:SetActivity(var_1_1)
	arg_1_0.viewComponent:SetDailyActivity(var_1_0:getActivityById(var_1_1:GetConfigClientSetting("sub_act_id")))

	return
end

function var_0_0.initNotificationHandleDic(arg_7_0)
	arg_7_0.handleDic = {
		[ActivityProxy.ACTIVITY_UPDATED] = function(arg_8_0, arg_8_1)
			local var_8_0 = arg_8_1:getBody()

			if arg_8_0.viewComponent.activity and arg_8_0.viewComponent.activity.id == var_8_0.id then
				arg_8_0.viewComponent:SetActivity(var_8_0)
				arg_8_0.viewComponent:UpdatePainting()
				arg_8_0.viewComponent:UpdateSlider()
				arg_8_0.viewComponent:UpdateLoveLetterMedal()
			end

			return
		end,
		[GAME.REALIZE_LOVE_LETTER_GIFT_DONE] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:UpdateSlider()
			arg_9_0.viewComponent:UpdateLoveLetterMedal()

			return
		end,
		[GAME.LOVE_LETTER_LEVEL_UP_DONE] = GAME.REALIZE_LOVE_LETTER_GIFT_DONE,
		[LoveLetterProxy.UPDATE_LOVE_LETTER] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:UpdateSlider()

			return
		end,
		[GAME.SUBMIT_TASK_AWARD_DOWN] = function(arg_11_0, arg_11_1)
			if arg_11_0.contextData.submitTaskId ~= arg_11_1:getType()[1] then
				return
			end

			arg_11_0.contextData.submitTaskId = nil

			arg_11_0.viewComponent:HideDailyPanel()
			arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_11_1:getBody().awards, function()
				arg_11_0.viewComponent:UpdateSlider()
				arg_11_0.viewComponent:SetDailyActivity(getProxy(ActivityProxy):getActivityById(arg_11_0.viewComponent.dailyActivity.id))

				return
			end)

			return
		end
	}

	return
end

return var_0_0
