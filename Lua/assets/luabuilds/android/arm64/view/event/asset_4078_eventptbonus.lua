local EventPtBonus = class("EventPtBonus")

function EventPtBonus:Ctor(arg_1_1)
	self.tr = arg_1_1
	self.resIcon = findTF(self.tr, "Image"):GetComponent(typeof(Image))
	self.resName = findTF(self.tr, "Text"):GetComponent(typeof(Text))

	setActive(self.tr, false)
	self:Update()

	return
end

function EventPtBonus:Update()
	local var_2_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_EVENT)

	if var_2_0 and var_2_0:getConfig("config_client").shopActID then
		setActive(self.tr, true)
	end

	return
end

return EventPtBonus
