local IndexMediator = class("IndexMediator", import("..base.ContextMediator"))

function IndexMediator:register()
	assert(self.contextData.display)

	if self.contextData.display.sort then
		assert(self.contextData.sort)
	end

	if self.contextData.display.index then
		assert(self.contextData.index)
	end

	if self.contextData.display.camp then
		assert(self.contextData.camp)
	end

	if self.contextData.display.rarity then
		assert(self.contextData.rarity)
	end

	return
end

function IndexMediator:listNotificationInterests()
	return {}
end

function IndexMediator:handleNotification(arg_3_1)
	return
end

return IndexMediator
