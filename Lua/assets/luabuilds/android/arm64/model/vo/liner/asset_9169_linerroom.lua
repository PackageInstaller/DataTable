local LinerRoom = class("LinerRoom", import("model.vo.BaseVO"))

function LinerRoom:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id
	self.time2CharInfo = {}

	for iter_1_0, iter_1_1 in ipairs(self:getConfig("sd")) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1[1]) do
			self.time2CharInfo[iter_1_3] = {
				iter_1_1[2],
				iter_1_1[3]
			}
		end
	end

	return
end

function LinerRoom:bindConfigTable()
	return pg.activity_liner_room
end

function LinerRoom:GetName()
	return self:getConfig("name")
end

function LinerRoom:GetPic()
	return self:getConfig("pic")
end

function LinerRoom:GetDesc()
	return HXSet.hxLan(self:getConfig("desc"))
end

function LinerRoom:GetDescList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self:getConfig("desc_display")) do
		table.insert(var_6_0, (HXSet.hxLan(iter_6_1[1])))
	end

	return var_6_0
end

function LinerRoom:GetStory()
	return self:getConfig("memory_id")
end

function LinerRoom:GetSpineCharInfo(arg_8_1)
	return self.time2CharInfo[arg_8_1]
end

return LinerRoom
