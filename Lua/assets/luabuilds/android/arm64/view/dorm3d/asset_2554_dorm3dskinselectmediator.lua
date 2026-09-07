local Dorm3dSkinSelectMediator = class("Dorm3dSkinSelectMediator", import("view.base.ContextMediator"))

Dorm3dSkinSelectMediator.CHANGE_SKIN = "Dorm3dSkinSelectMediator:CHANGE_SKIN"
Dorm3dSkinSelectMediator.SWITCH_SKIN = "Dorm3dSkinSelectMediator:SWITCH_SKIN"
Dorm3dSkinSelectMediator.OPEN_SHOP_WINDOW = "Dorm3dSkinSelectMediator:OPEN_SHOP_WINDOW"
Dorm3dSkinSelectMediator.PLAY_ANIM = "Dorm3dSkinSelectMediator:PLAY_ANIM"
Dorm3dSkinSelectMediator.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dSkinSelectMediator:OPEN_ROOM_UNLOCK_WINDOW"

function Dorm3dSkinSelectMediator:register()
	self:bind(Dorm3dSkinSelectMediator.CHANGE_SKIN, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.APARTMENT_CHANGE_SKIN, {
			groupId = arg_2_1,
			skinId = arg_2_2
		})
		self:sendNotification(GAME.APARTMENT_SKIN_PART_HIDDEN, {
			groupId = arg_2_1,
			skinId = arg_2_2,
			partList = arg_2_3
		})

		return
	end)
	self:bind(Dorm3dSkinSelectMediator.OPEN_ROOM_UNLOCK_WINDOW, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_3_1,
				groupId = arg_3_2
			},
			onRemoved = function()
				self.viewComponent:FlushSkinList()

				return
			end
		}))

		return
	end)
	self:bind(Dorm3dSkinSelectMediator.OPEN_SHOP_WINDOW, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dShoppingConfirmWindow,
			mediator = Dorm3dShoppingConfirmWindowMediator,
			data = arg_5_1
		}))

		return
	end)
	self:bind(GAME.SHOPPING, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.SHOPPING, arg_6_1)

		return
	end)
	self.viewComponent:SetApartment(getProxy(ApartmentProxy):getApartment(self.contextData.groupId))

	return
end

function Dorm3dSkinSelectMediator:initNotificationHandleDic()
	local function var_7_0(arg_8_0)
		self.viewComponent:FlushSkinList()
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
			title = i18n("title_info"),
			contentText = i18n("dorm3d_skin_equip", ShipGroup.getDefaultShipNameByGroupID(self.contextData.groupId), pg.dorm3d_resource[pg.shop_template[arg_8_0].effect_args[1]].name),
			onConfirm = function()
				self.viewComponent:ConfirmCurrentSkin()

				return
			end,
			onClose = function()
				self.viewComponent:CancelCurrentSkin()

				return
			end
		})

		return
	end

	self.handleDic = {
		[GAME.SHOPPING_DONE] = function(arg_11_0, arg_11_1)
			var_7_0(arg_11_1:getBody().id)

			return
		end,
		[GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_12_0, arg_12_1)
			local var_12_0 = arg_12_1:getBody()

			var_7_0((Apartment.getGroupConfig(var_12_0.groupId, (getProxy(ApartmentProxy):getRoom(var_12_0.roomId):getConfig("invite_cost")))))

			return
		end,
		[ApartmentProxy.UPDATE_APARTMENT] = function(arg_13_0, arg_13_1)
			arg_13_0.viewComponent:SetApartment(getProxy(ApartmentProxy):getApartment(arg_13_0.contextData.groupId))
			arg_13_0.viewComponent:FlushSkinList()

			return
		end
	}

	return
end

function Dorm3dSkinSelectMediator:remove()
	return
end

return Dorm3dSkinSelectMediator
