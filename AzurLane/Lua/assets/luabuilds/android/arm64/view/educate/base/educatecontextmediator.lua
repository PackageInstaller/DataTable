local var_0_0 = class("EducateContextMediator", import("view.base.ContextMediator"))

function var_0_0.onRegister(arg_1_0)
	var_0_0.super.onRegister(arg_1_0)
	arg_1_0:bind(EducateBaseUI.EDUCATE_GO_SCENE, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(EducateBaseUI.EDUCATE_CHANGE_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.CHANGE_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(EducateBaseUI.EDUCATE_GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	arg_1_0:bind(EducateBaseUI.EDUCATE_ON_AWARD, function(arg_5_0, arg_5_1)
		if #arg_5_1.items <= 0 then
			return
		end

		if #EducateHelper.FilterDropByTypes(arg_5_1.items, {
			EducateConst.DROP_TYPE_ATTR,
			EducateConst.DROP_TYPE_RES,
			EducateConst.DROP_TYPE_ITEM,
			EducateConst.DROP_TYPE_BUFF,
			EducateConst.DROP_TYPE_POLAROID
		}) <= 0 then
			return
		end

		arg_1_0:addSubLayers(Context.New({
			mediator = EducateAwardInfoMediator,
			viewComponent = EducateAwardInfoLayer,
			data = arg_5_1
		}))

		return
	end)
	arg_1_0:bind(EducateBaseUI.EDUCATE_ON_ITEM, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = EducateMsgBoxLayer,
			mediator = EducateMsgBoxMediator,
			data = setmetatable({
				type = EducateMsgBoxLayer.TYPE_SINGLE_ITEM
			}, {
				__index = arg_6_1
			})
		}))

		return
	end)
	arg_1_0:bind(EducateBaseUI.EDUCATE_ON_MSG_TIP, function(arg_7_0, arg_7_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = EducateMsgBoxLayer,
			mediator = EducateMsgBoxMediator,
			data = setmetatable({
				type = EducateMsgBoxLayer.TYPE_NORMAL
			}, {
				__index = arg_7_1
			})
		}))

		return
	end)
	arg_1_0:bind(EducateBaseUI.EDUCATE_ON_UNLOCK_TIP, function(arg_8_0, arg_8_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = EducateUnlockTipLayer,
			mediator = EducateContextMediator,
			data = arg_8_1
		}))

		return
	end)

	return
end

return var_0_0
