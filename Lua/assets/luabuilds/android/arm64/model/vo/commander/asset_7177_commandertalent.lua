local CommanderTalent = class("CommanderTalent", import("..BaseVO"))
local var_0_1 = pg.commander_ability_group

function CommanderTalent:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.groupId = self:getConfig("group_id")

	assert(var_0_1[self.groupId])

	self.list = var_0_1[self.groupId].ability_list

	return
end

function CommanderTalent:reset()
	self.id = self.list[1]
	self.configId = self.id

	return
end

function CommanderTalent:setOrigin(arg_3_1)
	self.origin = arg_3_1

	return
end

function CommanderTalent:isOrigin()
	return self.origin
end

function CommanderTalent:getTalentList()
	return self.list
end

function CommanderTalent:bindConfigTable()
	return pg.commander_ability_template
end

function CommanderTalent:getConsume()
	local var_7_1 = table.indexof(self.list, self.id)

	return self.origin and var_7_1 - table.indexof(self.list, self.origin.id) or var_7_1
end

function CommanderTalent:getAttrsAddition()
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(CommanderConst.PROPERTIES) do
		for iter_8_2, iter_8_3 in ipairs(self:getConfig("add")) do
			if CommanderConst.TALENT_ADDITION_NUMBER == iter_8_3[1] then
				if iter_8_3[4] == iter_8_0 then
					var_8_0[iter_8_1] = {
						value = iter_8_3[5],
						nation = iter_8_3[2],
						shiptype = iter_8_3[3]
					}
				end
			elseif CommanderConst.TALENT_ADDITION_RATIO == iter_8_3[1] and iter_8_3[4] == iter_8_0 then
				var_8_1[iter_8_1] = {
					value = iter_8_3[5],
					nation = iter_8_3[2],
					shiptype = iter_8_3[3]
				}
			end
		end
	end

	return var_8_0, var_8_1
end

function CommanderTalent:getBuffsAddition()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self:getConfig("add")) do
		if CommanderConst.TALENT_ADDITION_BUFF == iter_9_1[1] then
			table.insert(var_9_0, iter_9_1[4])
		end
	end

	return var_9_0
end

function CommanderTalent:getDestoryExpValue()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs((self:getConfig("add"))) do
		if iter_10_1[1] == CommanderConst.TALENT_ADDITION_NUMBER and iter_10_1[4] == CommanderConst.DESTROY_ATTR_ID then
			var_10_0 = var_10_0 + iter_10_1[5]
		end
	end

	return var_10_0
end

function CommanderTalent:getDestoryExpRetio()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs((self:getConfig("add"))) do
		if iter_11_1[1] == CommanderConst.TALENT_ADDITION_RATIO and iter_11_1[4] == CommanderConst.DESTROY_ATTR_ID then
			var_11_0 = var_11_0 + iter_11_1[5]
		end
	end

	return var_11_0
end

function CommanderTalent:getDesc()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs((self:getConfig("add_desc"))) do
		local var_12_1 = iter_12_1[1]

		if var_12_0[iter_12_1[1]] then
			var_12_0[var_12_1].value = var_12_0[var_12_1].value + iter_12_1[2]
		else
			local var_12_2 = {
				value = iter_12_1[2]
			}

			if iter_12_1[3] then
				var_12_2.type = CommanderConst.TALENT_ADDITION_RATIO or CommanderConst.TALENT_ADDITION_NUMBER
			end

			var_12_0[var_12_1] = var_12_2
		end
	end

	return var_12_0
end

return CommanderTalent
