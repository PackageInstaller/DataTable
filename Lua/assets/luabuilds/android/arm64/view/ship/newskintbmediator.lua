local var_0_0 = class("NewSkinTBMediator", import("..base.ContextMediator"))

var_0_0.ON_EXIT = "NewSkinTBMediator:ON_EXIT"
var_0_0.GO_SET_TB_SKIN = "NewSkinTBMediator:GO_SET_TB_SKIN"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SET_TB_SKIN, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EDUCATE_DOCK, {
			OnSelected = function(arg_3_0)
				arg_1_0:sendNotification(GAME.CHANGE_EDUCATE, {
					id = arg_3_0
				})

				return
			end,
			tbSkinId = arg_1_0.contextData.skinId
		})

		return
	end)

	arg_1_0.contextData.secId = NewEducateHelper.GetSecIdBySkinId(arg_1_0.contextData.skinId)

	local var_1_0 = arg_1_0.contextData
	local var_1_1 = getProxy(PlayerProxy):getRawData()

	var_1_0.isClose = var_1_1:GetEducateCharacter() == arg_1_0.contextData.secId

	arg_1_0.viewComponent:setSkin(arg_1_0.contextData.skinId)

	return
end

function var_0_0.onUIAvalible(arg_4_0)
	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return var_0_0
