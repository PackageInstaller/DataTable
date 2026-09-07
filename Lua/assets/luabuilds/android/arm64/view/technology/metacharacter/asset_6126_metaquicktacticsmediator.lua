local MetaQuickTacticsMediator = class("MetaQuickTacticsMediator", import("...base.ContextMediator"))

MetaQuickTacticsMediator.USE_TACTICS_BOOK = "MetaQuickTacticsMediator.USE_TACTICS_BOOK"
MetaQuickTacticsMediator.OPEN_OVERFLOW_LAYER = "MetaQuickTacticsMediator.OPEN_OVERFLOW_LAYER"

function MetaQuickTacticsMediator:register()
	self:bindEvent()

	return
end

function MetaQuickTacticsMediator:listNotificationInterests()
	return {
		GAME.META_QUICK_TACTICS_DONE
	}
end

function MetaQuickTacticsMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.META_QUICK_TACTICS_DONE then
		self.viewComponent:updateAfterUse()
		self.viewComponent:resetUseData()
		self.viewComponent:updateAfterModifyUseCount()
	end

	return
end

function MetaQuickTacticsMediator:bindEvent()
	self:bind(MetaQuickTacticsMediator.USE_TACTICS_BOOK, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:sendNotification(GAME.META_QUICK_TACTICS, {
			shipID = arg_5_1,
			skillID = arg_5_2,
			useCountDict = arg_5_3
		})

		return
	end)
	self:bind(MetaQuickTacticsMediator.OPEN_OVERFLOW_LAYER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		self:addSubLayers(Context.New({
			mediator = MetaQuickTacticsOverflowMediator,
			viewComponent = MetaQuickTacticsOverflowLayer,
			data = {
				shipID = arg_6_1,
				skillID = arg_6_2,
				useCountDict = arg_6_3,
				overExp = arg_6_4
			}
		}))

		return
	end)

	return
end

return MetaQuickTacticsMediator
