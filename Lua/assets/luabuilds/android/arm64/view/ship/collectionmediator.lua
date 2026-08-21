local var_0_0 = class("CollectionMediator", import("..base.ContextMediator"))

var_0_0.EVENT_OBTAIN_SKIP = "CollectionMediator:EVENT_OBTAIN_SKIP"

function var_0_0.register(arg_1_0)
	arg_1_0.collectionProxy = getProxy(CollectionProxy)

	arg_1_0.viewComponent:setShipGroups(arg_1_0.collectionProxy:getGroups())
	arg_1_0.viewComponent:setAwards(arg_1_0.collectionProxy:getAwards())
	arg_1_0.viewComponent:setCollectionRate(arg_1_0.collectionProxy:getCollectionRate())
	arg_1_0.viewComponent:setLinkCollectionCount(arg_1_0.collectionProxy:getLinkCollectionCount())
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())
	arg_1_0.viewComponent:setProposeList(getProxy(BayProxy):getProposeGroupList())
	arg_1_0:bind(CollectionScene.GET_AWARD, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.COLLECT_GET_AWARD, {
			id = arg_2_1,
			index = arg_2_2
		})

		return
	end)
	arg_1_0:bind(CollectionScene.SHOW_DETAIL, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIP_PROFILE, {
			showTrans = arg_3_1,
			groupId = arg_3_2
		})

		return
	end)
	arg_1_0:bind(CollectionScene.ACTIVITY_OP, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_4_1)

		return
	end)
	arg_1_0:bind(CollectionScene.BEGIN_STAGE, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, arg_5_1)

		return
	end)
	arg_1_0:bind(CollectionScene.ON_INDEX, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	arg_1_0.viewComponent:updateCollectNotices(arg_1_0.collectionProxy:hasFinish())

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		CollectionProxy.AWARDS_UPDATE,
		GAME.COLLECT_GET_AWARD_DONE,
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_DONE,
		var_0_0.EVENT_OBTAIN_SKIP
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == CollectionProxy.AWARDS_UPDATE then
		arg_8_0.viewComponent:setAwards(var_8_1)
	elseif var_8_0 == GAME.COLLECT_GET_AWARD_DONE then
		arg_8_0.viewComponent:sortDisplay()
		arg_8_0.viewComponent:updateCollectNotices(arg_8_0.collectionProxy:hasFinish())
		arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.items)
	elseif var_8_0 == PlayerProxy.UPDATED then
		arg_8_0.viewComponent:setPlayer(var_8_1)
	elseif var_8_0 == GAME.BEGIN_STAGE_DONE then
		arg_8_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_8_1)
	elseif var_8_0 == var_0_0.EVENT_OBTAIN_SKIP then
		arg_8_0.viewComponent:skipIn(var_8_1.toggle, var_8_1.displayGroupId)
	end

	return
end

return var_0_0
