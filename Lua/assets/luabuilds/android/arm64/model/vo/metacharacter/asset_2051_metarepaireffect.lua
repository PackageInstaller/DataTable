local MetaRepairEffect = class("MetaRepairEffect", import("..BaseVO"))

function MetaRepairEffect:bindConfigTable()
	return pg.ship_meta_repair_effect
end

function MetaRepairEffect:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.progress = arg_2_1.progress
	self.attrs = {}

	for iter_2_0, iter_2_1 in ipairs(self:getConfig("effect_attr")) do
		self.attrs[iter_2_1[1]] = iter_2_1[2]
	end

	self.words = self:getConfig("effect_dialog")
	self.descs = string.split(self:getConfig("effect_desc"), "|")
	self.descs = ""

	return
end

function MetaRepairEffect:getAttrAdditionList()
	return self:getConfig("effect_attr")
end

function MetaRepairEffect:getAttrAddition(arg_4_1)
	return self.attrs[arg_4_1] or 0
end

function MetaRepairEffect:getDescs()
	return self.descs
end

function MetaRepairEffect:getWords()
	return self.words
end

return MetaRepairEffect
