local WorkBenchItemDetailMediator = class("WorkBenchItemDetailMediator", import("view.base.ContextMediator"))

WorkBenchItemDetailMediator.SHOW_DETAIL = "SHOW_DETAIL"

function WorkBenchItemDetailMediator:register()
	self:bind(GAME.WORKBENCH_ITEM_GO, function(arg_2_0, arg_2_1)
		self.viewComponent:closeView()
		self:sendNotification(GAME.WORKBENCH_ITEM_GO, arg_2_1)

		return
	end)

	return
end

function WorkBenchItemDetailMediator:listNotificationInterests()
	return {}
end

function WorkBenchItemDetailMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == nil then
		-- block empty
	end

	return
end

function WorkBenchItemDetailMediator:remove()
	return
end

return WorkBenchItemDetailMediator
