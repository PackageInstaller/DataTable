local var_0_0 = class("Dorm3dRoomMediator", import("view.dorm3d.Core.Dorm3dBaseMediator"))

var_0_0.TRIGGER_FAVOR = "Dorm3dRoomMediator.TRIGGER_FAVOR"
var_0_0.FAVOR_LEVEL_UP = "Dorm3dRoomMediator.FAVOR_LEVEL_UP"
var_0_0.TALKING_EVENT_FINISH = "Dorm3dRoomMediator.TALKING_EVENT_FINISH"
var_0_0.DO_TALK = "Dorm3dRoomMediator.DO_TALK"
var_0_0.COLLECTION_ITEM = "Dorm3dRoomMediator.COLLECTION_ITEM"
var_0_0.OPEN_FURNITURE_SELECT = "Dorm3dRoomMediator.OPEN_FURNITURE_SELECT"
var_0_0.OPEN_LEVEL_LAYER = "Dorm3dRoomMediator.OPEN_LEVEL_LAYER"
var_0_0.OPEN_GIFT_LAYER = "Dorm3dRoomMediator.OPEN_GIFT_LAYER"
var_0_0.OPEN_CAMERA_LAYER = "Dorm3dRoomMediator.OPEN_CAMERA_LAYER"
var_0_0.OPEN_DROP_LAYER = "Dorm3dRoomMediator.OPEN_DROP_LAYER"
var_0_0.OPEN_COLLECTION_LAYER = "Dorm3dRoomMediator.OPEN_COLLECTION_LAYER"
var_0_0.OPEN_INVITE_WINDOW = "Dorm3dRoomMediator.OPEN_INVITE_WINDOW"
var_0_0.OPEN_ACCOMPANY_WINDOW = "Dorm3dRoomMediator.OPEN_ACCOMPANY_WINDOW"
var_0_0.OPEN_MINIGAME_WINDOW = "Dorm3dRoomMediator.OPEN_MINIGAME_WINDOW"
var_0_0.OPEN_SKIN_SELECT_LAYER = "Dorm3dRoomMediator.OPEN_SKIN_SELECT_LAYER"
var_0_0.OPEN_SETTING_LAYER = "Dorm3dRoomMediator.OPEN_SETTING_LAYER"
var_0_0.ON_LEVEL_UP_FINISH = "Dorm3dRoomMediator.ON_LEVEL_UP_FINISH"
var_0_0.ON_CLICK_FURNITURE_SLOT = "Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT"
var_0_0.OTHER_DO_TALK = "Dorm3dRoomMediator.OTHER_DO_TALK"
var_0_0.OTHER_POP_UNLOCK = "Dorm3dRoomMediator.OTHER_POP_UNLOCK"
var_0_0.CHAMGE_TIME_RELOAD_SCENE = "Dorm3dRoomMediator.CHAMGE_TIME_RELOAD_SCENE"
var_0_0.GUIDE_CLICK_LADY = "Dorm3dRoomMediator.GUIDE_CLICK_LADY"
var_0_0.GUIDE_CHECK_GUIDE = "Dorm3dRoomMediator.GUIDE_CHECK_GUIDE"
var_0_0.GUIDE_CHECK_LEVEL_UP = "Dorm3dRoomMediator.GUIDE_CHECK_LEVEL_UP"
var_0_0.Camera_Pinch_Value_Change = "Dorm3dRoomMediator.Camera_Pinch_Value_Change"
var_0_0.ENTER_VOLLEYBALL = "Dorm3dRoomMediator.ENTER_VOLLEYBALL"
var_0_0.ENTER_DANCE = "Dorm3dRoomMediator.ENTER_DANCE"
var_0_0.ENTER_CARWASH = "Dorm3dRoomMediator.ENTER_CARWASH"
var_0_0.ON_DROP_CLIENT = "Dorm3dRoomMediator.ON_DROP_CLIENT"
var_0_0.UPDATE_FAVOR_DISPLAY = "Dorm3dRoomMediator.UPDATE_FAVOR_DISPLAY"
var_0_0.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE = "Dorm3dRoomMediator.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE"
var_0_0.REFRESH_FURNITURE_AND_SLOTS_DONE = "Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE"
var_0_0.REMOVE_EXTRA_SYSTEM = "Dorm3dRoomMediator.REMOVE_EXTRA_SYSTEM"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.TRIGGER_FAVOR, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.APARTMENT_TRIGGER_FAVOR, {
			groupId = arg_2_1,
			triggerId = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.FAVOR_LEVEL_UP, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.APARTMENT_LEVEL_UP, {
			groupId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.TALKING_EVENT_FINISH, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(arg_4_1, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_FURNITURE_SELECT, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dFurnitureSelectMediator,
			viewComponent = Dorm3dFurnitureSelectLayer,
			data = arg_5_1,
			onRemoved = function()
				arg_1_0.viewComponent:InitExtraSystem({
					SlideExtraSystem
				})
				arg_1_0.viewComponent:TempHideUI(false, arg_5_2)

				arg_1_0.viewComponent.isInFurnitureSelect = false

				return
			end
		}), nil, function()
			arg_1_0.viewComponent:TempHideUI(true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CLICK_FURNITURE_SLOT, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(arg_8_0, arg_8_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_LEVEL_LAYER, function(arg_9_0, arg_9_1, arg_9_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dLevelLayer,
			mediator = Dorm3dLevelMediator,
			data = arg_9_1,
			onRemoved = function()
				arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", false)
				arg_1_0.viewComponent:TempHideUI(false, arg_9_2)

				return
			end
		}), nil, function()
			arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", true)
			arg_1_0.viewComponent:TempHideUI(true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_GIFT_LAYER, function(arg_12_0, arg_12_1, arg_12_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dGiftLayer,
			mediator = Dorm3dGiftMediator,
			data = arg_12_1,
			onRemoved = function()
				arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", false)
				arg_1_0.viewComponent:TempHideUI(false, arg_12_2)

				return
			end
		}), nil, function()
			arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", true)
			arg_1_0.viewComponent:TempHideUI(true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CAMERA_LAYER, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dPhotoLayer,
			mediator = Dorm3dPhotoMediator,
			data = {
				groupId = arg_15_2,
				view = arg_15_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DROP_LAYER, function(arg_16_0, arg_16_1, arg_16_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dAwardInfoLayer,
			mediator = Dorm3dAwardInfoMediator,
			data = {
				items = arg_16_1
			},
			onRemoved = arg_16_2
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_COLLECTION_LAYER, function(arg_17_0, arg_17_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dCollectionLayer,
			mediator = Dorm3dCollectionMediator,
			data = {
				roomId = arg_17_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_INVITE_WINDOW, function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dInviteLayer,
			mediator = Dorm3dInviteMediator,
			data = {
				roomId = arg_18_1,
				groupIds = arg_18_2
			},
			onRemoved = function()
				arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", false)
				arg_1_0.viewComponent:TempHideUI(false, arg_18_3)

				return
			end
		}), nil, function()
			arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", true)
			arg_1_0.viewComponent:TempHideUI(true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SKIN_SELECT_LAYER, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dSkinSelectLayer,
			mediator = Dorm3dSkinSelectMediator,
			data = {
				groupId = arg_21_1,
				ladyEnv = arg_21_2,
				onSwitchSkin = arg_21_3
			},
			onRemoved = arg_21_5 and arg_21_4 or function()
				arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", false)
				arg_1_0.viewComponent:TempHideUI(false, arg_21_4)

				return
			end
		}), nil, not arg_21_5 and function()
			arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", true)
			arg_1_0.viewComponent:TempHideUI(true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ACCOMPANY_WINDOW, function(arg_24_0, arg_24_1, arg_24_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dAccompanyLayer,
			mediator = Dorm3dAccompanyMediator,
			data = arg_24_1,
			onRemoved = function()
				arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", false)
				arg_1_0.viewComponent:TempHideUI(false, arg_24_2)

				return
			end
		}), nil, function()
			arg_1_0.viewComponent:SetAllBlackbloardValue("inLockLayer", true)
			arg_1_0.viewComponent:TempHideUI(true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_MINIGAME_WINDOW, function(arg_27_0, arg_27_1, arg_27_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = switch(arg_27_1.minigameId, {
				[67] = function()
					return EatFoodLayer
				end,
				[70] = function()
					return NengDaiScheduleGameView
				end,
				[75] = function()
					return RPSGameLayer
				end
			}, function()
				assert(false, "without dorm minigame config in id:" .. arg_27_1.minigameId)

				return
			end),
			mediator = Dorm3dMiniGameMediator,
			data = arg_27_1,
			onRemoved = arg_27_2
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE, function(arg_32_0, arg_32_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = FurnitureSlideExtraLayer,
			mediator = FurnitureSlideExtraMediator,
			data = arg_32_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.REFRESH_FURNITURE_AND_SLOTS_DONE, function(arg_33_0)
		arg_1_0:sendNotification(var_0_0.REFRESH_FURNITURE_AND_SLOTS_DONE)

		return
	end)
	arg_1_0:bind(var_0_0.REMOVE_EXTRA_SYSTEM, function(arg_34_0, arg_34_1)
		arg_1_0:removeSubLayers(arg_34_1)

		return
	end)
	arg_1_0:bind(var_0_0.DO_TALK, function(arg_35_0, arg_35_1, arg_35_2)
		arg_1_0:sendNotification(GAME.APARTMENT_DO_TALK, {
			talkId = arg_35_1,
			callback = arg_35_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.COLLECTION_ITEM, function(arg_36_0, arg_36_1)
		arg_1_0:sendNotification(GAME.APARTMENT_COLLECTION_ITEM, arg_36_1)

		return
	end)
	arg_1_0:bind(var_0_0.Camera_Pinch_Value_Change, function(arg_37_0, arg_37_1)
		arg_1_0:sendNotification(Dorm3dPhotoMediator.Camera_Pinch_Value_Change, {
			value = arg_37_1
		})

		return
	end)
	arg_1_0:bind(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, function(arg_38_0, arg_38_1)
		arg_1_0:sendNotification(Dorm3dPhotoMediator.CAMERA_LIFT_CHANGED, {
			value = arg_38_1
		})

		return
	end)
	arg_1_0:bind(Dorm3dPhotoMediator.CAMERA_STICK_MOVE, function(arg_39_0, arg_39_1)
		arg_1_0:sendNotification(Dorm3dPhotoMediator.CAMERA_STICK_MOVE, arg_39_1)

		return
	end)
	arg_1_0:bind(var_0_0.ENTER_VOLLEYBALL, function(arg_40_0, arg_40_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_VOLLEYBALL, {
			groupId = arg_40_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ENTER_DANCE, function(arg_41_0, arg_41_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_DANCE, {
			groupId = arg_41_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ENTER_CARWASH, function(arg_42_0, arg_42_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_CAR_WASH, {
			groupId = arg_42_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_DROP_CLIENT, function(arg_43_0, arg_43_1)
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_DROP_CLIENT, arg_43_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SETTING_LAYER, function(arg_44_0)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dSettingScene,
			mediator = NewSettingsMediator
		}))

		return
	end)
	arg_1_0.viewComponent:SetRoom(getProxy(ApartmentProxy):getRoom(arg_1_0.contextData.roomId))

	if arg_1_0.viewComponent.room:isPersonalRoom() then
		arg_1_0.viewComponent:SetApartment((getProxy(ApartmentProxy):getApartment(arg_1_0.contextData.groupIds[1])))
	end

	Dorm3dFurniture.RecordLastTimelimitShopFurniture()

	return
end

function var_0_0.initNotificationHandleDic(arg_45_0)
	arg_45_0.handleDic = {
		[GAME.APARTMENT_TRIGGER_FAVOR_DONE] = function(arg_46_0, arg_46_1)
			arg_46_0.viewComponent:PopFavorTrigger((arg_46_1:getBody()))

			return
		end,
		[GAME.APARTMENT_LEVEL_UP_DONE] = function(arg_47_0, arg_47_1)
			local var_47_0 = arg_47_1:getBody()

			seriesAsync({
				function(arg_48_0)
					arg_47_0.viewComponent:SetAllBlackbloardValue("inLockLayer", true)
					arg_47_0.viewComponent:PopFavorLevelUp(var_47_0.apartment, var_47_0.award, arg_48_0)

					return
				end
			}, function()
				arg_47_0.viewComponent:SetAllBlackbloardValue("inLockLayer", false)
				arg_47_0.viewComponent:CheckQueue()
				arg_47_0:sendNotification(var_0_0.ON_LEVEL_UP_FINISH)

				return
			end)

			return
		end,
		[STORY_EVENT.TEST] = function(arg_50_0, arg_50_1)
			arg_50_0.viewComponent:TalkingEventHandle((arg_50_1:getBody()))

			return
		end,
		[ApartmentProxy.UPDATE_APARTMENT] = function(arg_51_0, arg_51_1)
			local var_51_0 = arg_51_1:getBody()

			if arg_51_0.viewComponent.apartment and arg_51_0.viewComponent.apartment:GetConfigID() == var_51_0:GetConfigID() then
				arg_51_0.viewComponent:SetApartment(var_51_0)
			end

			return
		end,
		[var_0_0.OTHER_DO_TALK] = function(arg_52_0, arg_52_1)
			local var_52_0 = arg_52_1:getBody()

			arg_52_0.viewComponent.inReplayTalk = true

			arg_52_0.viewComponent:DoTalk(arg_52_1:getBody().talkId, function()
				arg_52_0.viewComponent.inReplayTalk = false

				existCall(var_52_0.callback)

				return
			end)

			return
		end,
		[var_0_0.OTHER_POP_UNLOCK] = function(arg_54_0, arg_54_1)
			arg_54_0.viewComponent:AddUnlockDisplay((arg_54_1:getBody()))

			return
		end,
		[GAME.APARTMENT_DO_TALK_DONE] = function(arg_55_0, arg_55_1)
			arg_55_0.viewComponent:UpdateBtnState()

			return
		end,
		[GAME.APARTMENT_COLLECTION_ITEM_DONE] = function(arg_56_0, arg_56_1)
			local var_56_0 = arg_56_1:getBody()

			arg_56_0:addSubLayers(Context.New({
				viewComponent = Dorm3dCollectAwardLayer,
				mediator = Dorm3dCollectAwardMediator,
				data = {
					itemId = var_56_0.itemId,
					isNew = var_56_0.isNew
				}
			}))
			arg_56_0.viewComponent:UpdateBtnState()

			return
		end,
		[var_0_0.CHAMGE_TIME_RELOAD_SCENE] = function(arg_57_0, arg_57_1)
			arg_57_0.contextData.timeIndex = arg_57_1:getBody().timeIndex

			arg_57_0.viewComponent:SwitchDayNight(arg_57_0.contextData.timeIndex)
			onNextTick(function()
				arg_57_0.viewComponent:RefreshSlots()

				return
			end)
			arg_57_0.viewComponent:UpdateContactState()

			return
		end,
		[GAME.APARTMENT_GIVE_GIFT_DONE] = function(arg_59_0, arg_59_1)
			local var_59_0 = arg_59_1:getBody()

			arg_59_0.viewComponent:PlayHeartFX(var_59_0.groupId)
			arg_59_0.viewComponent:UpdateBtnState()
			getProxy(Dorm3dChatProxy):TriggerEvent({
				{
					value = 1,
					event_type = arg_59_0.contextData.timeIndex == 1 and 113 or 118,
					ship_id = var_59_0.groupId
				}
			})

			return
		end,
		[var_0_0.GUIDE_CLICK_LADY] = function(arg_60_0, arg_60_1)
			warning("this.GUIDE_CLICK_LADY")
			arg_60_0.viewComponent:EnterWatchMode()

			return
		end,
		[var_0_0.GUIDE_CHECK_GUIDE] = function(arg_61_0, arg_61_1)
			arg_61_0.viewComponent:CheckGuide()

			return
		end,
		[var_0_0.GUIDE_CHECK_LEVEL_UP] = function(arg_62_0, arg_62_1)
			arg_62_0.viewComponent:CheckLevelUp()

			return
		end,
		[ApartmentProxy.UPDATE_ROOM] = function(arg_63_0, arg_63_1)
			local var_63_0 = arg_63_1:getBody()

			if var_63_0:GetConfigID() == arg_63_0.viewComponent.room:GetConfigID() then
				arg_63_0.viewComponent:SetRoom(var_63_0)
			end

			return
		end,
		[Dorm3dInviteMediator.ON_DORM] = function(arg_64_0, arg_64_1)
			arg_64_0:sendNotification(GAME.CHANGE_SCENE, SCENE.DORM3D_ROOM, (arg_64_1:getBody()))

			return
		end,
		[Dorm3dMiniGameMediator.OPERATION] = function(arg_65_0, arg_65_1)
			arg_65_0.viewComponent:HandleGameNotification(Dorm3dMiniGameMediator.OPERATION, (arg_65_1:getBody()))

			return
		end,
		[ApartmentProxy.ZERO_HOUR_REFRESH] = function(arg_66_0, arg_66_1)
			local var_66_0 = arg_66_1:getBody()

			arg_66_0.viewComponent:UpdateFavorDisplay()

			return
		end,
		[var_0_0.UPDATE_FAVOR_DISPLAY] = function(arg_67_0, arg_67_1)
			arg_67_0.viewComponent:UpdateFavorDisplay()

			return
		end,
		[ApartmentProxy.UPDATE_ROOM_INVITE_LIST] = function(arg_68_0, arg_68_1)
			local var_68_0 = arg_68_1:getBody()

			for iter_68_0, iter_68_1 in ipairs(var_68_0.addIds) do
				table.insert(arg_68_0.contextData.groupIds, iter_68_1)
			end

			arg_68_0.viewComponent:LoadCharacterAdditionally(var_68_0.addIds, var_68_0.callback)

			return
		end
	}

	return
end

function var_0_0.remove(arg_69_0)
	return
end

return var_0_0
