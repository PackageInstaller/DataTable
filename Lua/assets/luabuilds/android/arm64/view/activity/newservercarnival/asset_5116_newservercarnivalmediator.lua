local NewServerCarnivalMediator = class("NewServerCarnivalMediator", import("...base.ContextMediator"))

NewServerCarnivalMediator.TASK_GO = "NewServerCarnivalMediator.TASK_GO"
NewServerCarnivalMediator.TASK_SUBMIT = "NewServerCarnivalMediator.TASK_SUBMIT"
NewServerCarnivalMediator.TASK_SUBMIT_ONESTEP = "NewServerCarnivalMediator.TASK_SUBMIT_ONESTEP"
NewServerCarnivalMediator.GIFT_BUY_ITEM = "NewServerCarnivalMediator.GIFT_BUY_ITEM"
NewServerCarnivalMediator.GIFT_OPEN_ITEM_PANEL = "NewServerCarnivalMediator.GIFT_OPEN_ITEM_PANEL"
NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT = "NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT"

function NewServerCarnivalMediator:register()
	self:bind(NewServerCarnivalMediator.TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(NewServerCarnivalMediator.TASK_SUBMIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	self:bind(NewServerCarnivalMediator.TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1)
		pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = arg_4_1
		})

		return
	end)
	self:bind(NewServerCarnivalMediator.GIFT_BUY_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	self:bind(NewServerCarnivalMediator.GIFT_OPEN_ITEM_PANEL, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_6_1
			}
		}))

		return
	end)
	self:bind(NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT, function(arg_7_0)
		self.viewComponent:updateShopDedDot()

		return
	end)
	self.viewComponent:setData()

	return
end

function NewServerCarnivalMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_DONE,
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE,
		GAME.NEW_SERVER_SHOP_SHOPPING_DONE
	}
end

function NewServerCarnivalMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1, function()
			self.viewComponent:onUpdateTask()

			return
		end)
	elseif var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:onUpdatePlayer(var_9_1)
	elseif var_9_0 == GAME.SHOPPING_DONE then
		if #var_9_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards)
		end

		self.viewComponent:onUpdateGift()
	elseif var_9_0 == GAME.NEW_SERVER_SHOP_SHOPPING_DONE then
		if #var_9_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards)
		end

		if self.viewComponent.newServerShopPage and self.viewComponent.newServerShopPage:GetLoaded() then
			self.viewComponent.newServerShopPage:Refresh()
		end
	end

	return
end

return NewServerCarnivalMediator
