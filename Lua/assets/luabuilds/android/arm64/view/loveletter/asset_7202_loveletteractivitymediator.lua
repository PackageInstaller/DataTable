local LoveLetterActivityMediator = class("LoveLetterActivityMediator", import("view.base.ContextMediator"))

LoveLetterActivityMediator.ON_SELECT_GROUP = "LoveLetterActivityMediator.ON_SELECT_GROUP"
LoveLetterActivityMediator.ON_REALIZE_GIFT = "LoveLetterActivityMediator.ON_REALIZE_GIFT"
LoveLetterActivityMediator.ON_GO_COLLECTION = "LoveLetterActivityMediator.ON_GO_COLLECTION"
LoveLetterActivityMediator.ON_GO_TROPHY = "LoveLetterActivityMediator.ON_GO_TROPHY"
LoveLetterActivityMediator.ON_DAILY_LOGIN_REWARD = "LoveLetterActivityMediator.ON_DAILY_LOGIN_REWARD"

function LoveLetterActivityMediator:register()
	self:bind(LoveLetterActivityMediator.ON_SELECT_GROUP, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = LoveLetterSelectCharMediator,
			viewComponent = LoveLetterSelectCharLayer,
			data = {
				actId = arg_2_1
			}
		}))

		return
	end)
	self:bind(LoveLetterActivityMediator.ON_REALIZE_GIFT, function(arg_3_0)
		self:addSubLayers(Context.New({
			mediator = LoveLetterGiftCollectMediator,
			viewComponent = LoveLetterGiftCollectLayer
		}))

		return
	end)
	self:bind(LoveLetterActivityMediator.ON_DAILY_LOGIN_REWARD, function(arg_4_0, arg_4_1)
		self.contextData.submitTaskId = arg_4_1

		self:sendNotification(GAME.SUBMIT_TASK, arg_4_1, nil)

		return
	end)
	self:bind(LoveLetterActivityMediator.ON_GO_COLLECTION, function(arg_5_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM,
			albumType = WorldMediaCollectionAlbumGroupLayer.ALBUM_TYPE_LOVE_LETTER
		})

		return
	end)
	self:bind(LoveLetterActivityMediator.ON_GO_TROPHY, function(arg_6_0)
		self:addSubLayers(Context.New({
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

	self.viewComponent:SetActivity(var_1_1)
	self.viewComponent:SetDailyActivity(var_1_0:getActivityById(var_1_1:GetConfigClientSetting("sub_act_id")))

	return
end

function LoveLetterActivityMediator:initNotificationHandleDic()
	self.handleDic = {
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

return LoveLetterActivityMediator
