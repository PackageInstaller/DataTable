local LinerEvent = class("LinerEvent", import("model.vo.BaseVO"))

function LinerEvent:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id

	return
end

function LinerEvent:bindConfigTable()
	return pg.activity_liner_event
end

function LinerEvent:GetOptionName()
	return HXSet.hxLan(self:getConfig("option"))
end

function LinerEvent:GetOptionDisplay()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self:getConfig("option_desc_display")) do
		table.insert(var_4_0, (HXSet.hxLan(iter_4_1[1])))
	end

	return var_4_0
end

function LinerEvent:GetTitle()
	return HXSet.hxLan(self:getConfig("title"))
end

function LinerEvent:GetLogDesc()
	return HXSet.hxLan(self:getConfig("option_desc"))
end

function LinerEvent:GetReasoningDesc()
	return HXSet.hxLan(self:getConfig("option_desc_2"))
end

return LinerEvent
