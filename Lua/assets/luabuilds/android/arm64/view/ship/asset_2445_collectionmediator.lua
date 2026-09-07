local CollectionMediator = class("CollectionMediator", import("..base.ContextMediator"))

CollectionMediator.EVENT_OBTAIN_SKIP = "CollectionMediator:EVENT_OBTAIN_SKIP"

function CollectionMediator:register()
	self.collectionProxy = getProxy(CollectionProxy)

	self.viewComponent:setShipGroups(self.collectionProxy:getGroups())
	self.viewComponent:setAwards(self.collectionProxy:getAwards())
	self.viewComponent:setCollectionRate(self.collectionProxy:getCollectionRate())
	self.viewComponent:setLinkCollectionCount(self.collectionProxy:getLinkCollectionCount())
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())
	self.viewComponent:setProposeList(getProxy(BayProxy):getProposeGroupList())
	self:bind(CollectionScene.GET_AWARD, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.COLLECT_GET_AWARD, {
			id = arg_2_1,
			index = arg_2_2
		})

		return
	end)
	self:bind(CollectionScene.SHOW_DETAIL, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIP_PROFILE, {
			showTrans = arg_3_1,
			groupId = arg_3_2
		})

		return
	end)
	self:bind(CollectionScene.ACTIVITY_OP, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_4_1)

		return
	end)
	self:bind(CollectionScene.BEGIN_STAGE, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.BEGIN_STAGE, arg_5_1)

		return
	end)
	self:bind(CollectionScene.ON_INDEX, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	self.viewComponent:updateCollectNotices(self.collectionProxy:hasFinish())

	return
end

function CollectionMediator:listNotificationInterests()
	return {
		CollectionProxy.AWARDS_UPDATE,
		GAME.COLLECT_GET_AWARD_DONE,
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_DONE,
		CollectionMediator.EVENT_OBTAIN_SKIP
	}
end

function CollectionMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == CollectionProxy.AWARDS_UPDATE then
		self.viewComponent:setAwards(var_8_1)
	elseif var_8_0 == GAME.COLLECT_GET_AWARD_DONE then
		self.viewComponent:sortDisplay()
		self.viewComponent:updateCollectNotices(self.collectionProxy:hasFinish())
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.items)
	elseif var_8_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_8_1)
	elseif var_8_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_8_1)
	elseif var_8_0 == CollectionMediator.EVENT_OBTAIN_SKIP then
		self.viewComponent:skipIn(var_8_1.toggle, var_8_1.displayGroupId)
	end

	return
end

return CollectionMediator
