local NewShipMediator = class("NewShipMediator", import("..base.ContextMediator"))

NewShipMediator.ON_LOCK = "NewShipMediator:ON_LOCK"
NewShipMediator.ON_EXIT = "NewShipMediator:ON_EXIT"
NewShipMediator.ON_SKILLINFO = "NewShipMediator:ON_SKILLINFO"
NewShipMediator.ON_EVALIATION = "NewShipMediator:ON_EVALIATION"
NewShipMediator.ON_SKIP_BATCH = "NewShipMediator:ON_SKIP_BATCH"
NewShipMediator.SKIP_TYPE = {
	CHAPTER_AUTO_AWARD = 2,
	BUILD = 1
}

function NewShipMediator:register()
	self.fromRemould = self.contextData.fromRemould

	assert(self.contextData.ship, "必须存在船")

	self.showTrans = self.contextData.ship:isRemoulded()

	self.viewComponent:setShip(self.contextData.ship)
	self:bind(NewShipMediator.ON_EXIT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(self.contextData.onExit or GAME.REMOVE_LAYERS, {
			context = getProxy(ContextProxy):getCurrentContext():getContextByMediator(self.class)
		})

		return
	end)
	self:bind(NewShipMediator.ON_SKIP_BATCH, function(arg_3_0, arg_3_1)
		if arg_3_1 == NewShipMediator.SKIP_TYPE.BUILD then
			getProxy(BuildShipProxy):setSkipBatchBuildFlag(true)
		elseif arg_3_1 == NewShipMediator.SKIP_TYPE.CHAPTER_AUTO_AWARD then
			getProxy(ChapterAutoProxy):SetSkipBatchBuildFlag(true)
		end

		local var_3_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(self.class)

		self:sendNotification(self.contextData.onExit or GAME.REMOVE_LAYERS, {
			context = var_3_0
		})

		return
	end)
	self:bind(NewShipMediator.ON_LOCK, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.UPDATE_LOCK, {
			ship_id_list = arg_4_1,
			is_locked = arg_4_2
		})

		return
	end)
	self:bind(NewShipMediator.ON_SKILLINFO, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				fromNewShip = true,
				skillOnShip = arg_5_2,
				skillId = arg_5_1
			}
		}))

		return
	end)
	self:bind(NewShipMediator.ON_EVALIATION, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.FETCH_EVALUATION, arg_6_1)

		return
	end)

	if self.contextData.ship:getRarity() >= 4 and not getProxy(PlayerProxy):getData():GetCommonFlag(GAME_RESTOREVIEW_ALREADY) then
		pg.SdkMgr.GetInstance():StoreReview()
		self:sendNotification(GAME.COMMON_FLAG, {
			flagID = GAME_RESTOREVIEW_ALREADY
		})
	end

	return
end

function NewShipMediator:listNotificationInterests()
	return {
		GAME.UPDATE_LOCK_DONE,
		GAME.FETCH_EVALUATION_DONE
	}
end

function NewShipMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.UPDATE_LOCK_DONE then
		self.viewComponent:UpdateLockButton(var_8_1:GetLockState())
		self.viewComponent:updateShip(var_8_1)
	elseif var_8_0 == GAME.FETCH_EVALUATION_DONE then
		if self.fromRemould then
			return
		end

		self:addSubLayers(Context.New({
			mediator = ShipEvaluationMediator,
			viewComponent = ShipEvaluationLayer,
			data = {
				groupId = var_8_1,
				showTrans = self.showTrans
			}
		}))
	end

	return
end

return NewShipMediator
