local var_0_0 = class("LoveLetterSelectCharMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(LoveLetterSelectCharLayer.SELECT_CHAR, function(arg_2_0, arg_2_1)
		if arg_1_0.contextData.isRepair then
			arg_1_0:addSubLayers(Context.New({
				viewComponent = LoveLetterSelectCharConfirmLayer,
				mediator = LoveLetterSelectCharConfirmMediator,
				data = {
					isRepair = true,
					groupId = arg_2_1,
					itemVO = arg_1_0.contextData.itemVO
				}
			}))
		else
			local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.actId)

			if var_2_0:GetTargetGroupId() == arg_2_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("loveactivity_ui_18"))

				return
			end

			arg_1_0:addSubLayers(Context.New({
				viewComponent = LoveLetterSelectCharConfirmLayer,
				mediator = LoveLetterSelectCharConfirmMediator,
				data = {
					groupId = arg_2_1,
					actId = arg_1_0.contextData.actId
				}
			}))
		end

		return
	end)
	arg_1_0:bind(LoveLetterSelectCharLayer.ON_INDEX, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_3_1
		}))

		return
	end)
	arg_1_0.viewComponent:setShipGroups(getProxy(CollectionProxy):getGroups())
	arg_1_0.viewComponent:setProposeList(getProxy(BayProxy):getProposeGroupList())

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[ActivityProxy.ACTIVITY_OPERATION_DONE] = function(arg_5_0, arg_5_1)
			if arg_5_1:getBody() == arg_5_0.contextData.actId then
				arg_5_0.viewComponent:closeView()
			end

			return
		end,
		[GAME.USE_ITEM_DONE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:closeView()

			return
		end
	}

	return
end

return var_0_0
