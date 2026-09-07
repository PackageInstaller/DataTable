local ChapterTransportFleet = class("ChapterTransportFleet", import(".ChapterFleet"))

function ChapterTransportFleet:Ctor(arg_1_1, arg_1_2)
	self.line = {
		row = arg_1_1.pos.row,
		column = arg_1_1.pos.column
	}
	self.id = arg_1_2
	self.configId = arg_1_1.item_id
	self.restHp = arg_1_1.item_data
	self.rotation = Quaternion.identity

	self:updateShips({})

	return
end

function ChapterTransportFleet:bindConfigTable()
	return pg.friendly_data_template
end

function ChapterTransportFleet:getFleetType()
	return FleetType.Transport
end

function ChapterTransportFleet:getPrefab()
	local var_4_0 = {
		"merchant",
		"merchant_1",
		"merchant_2",
		"merchant_d"
	}
	local var_4_1 = var_4_0[1]

	for iter_4_0, iter_4_1 in ipairs({
		{
			20,
			16
		},
		{
			15,
			11
		},
		{
			10,
			1
		},
		{
			0,
			0
		}
	}) do
		if self:getRestHp() >= iter_4_1[2] and self:getRestHp() <= iter_4_1[1] then
			var_4_1 = var_4_0[iter_4_0]

			break
		end
	end

	return var_4_1
end

function ChapterTransportFleet:getRestHp()
	return self.restHp
end

function ChapterTransportFleet:setRestHp(arg_6_1)
	self.restHp = arg_6_1

	return
end

function ChapterTransportFleet:getTotalHp()
	return self:getConfig("hp")
end

function ChapterTransportFleet:isValid()
	return self.restHp > 0
end

return ChapterTransportFleet
