local NewEducateBuff = class("NewEducateBuff", import("model.vo.BaseVO"))

NewEducateBuff.TYPE = {
	TALENT = 1,
	TAROT = 3,
	ENTRY = 4,
	STATUS = 2
}
NewEducateBuff.RARITY = {
	BLUE = 1,
	GOLD = 3,
	PURPLE = 2,
	COLOURS = 4
}

function NewEducateBuff:bindConfigTable()
	return pg.child2_benefit_list
end

function NewEducateBuff:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.round = arg_2_1.round
	self.isPending = arg_2_1.is_pending == 1

	self:InitEndRound()

	self.effectNums = {}

	return
end

function NewEducateBuff:InitEndRound()
	local var_3_0 = self:getConfig("during_time")

	self.endRound = var_3_0 == -1 and var_3_0 or self.round + var_3_0

	return
end

function NewEducateBuff:IsPending()
	return self.isPending
end

function NewEducateBuff:GetEndRound()
	return self.endRound
end

function NewEducateBuff:OnNextRound(arg_6_1)
	if not self.isPending then
		return
	end

	self.isPending = false
	self.round = arg_6_1

	self:InitEndRound()

	return
end

function NewEducateBuff:GetBenefitIdsByEffectType(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(self:getConfig("show_content")) do
		if underscore.any(pg.child2_benefit[iter_7_1].effect, function(arg_8_0)
			assert(type(arg_8_0) == "table", "请检查effect配置的括号,benefit id:" .. iter_7_1)

			return arg_8_0[1] == arg_7_1
		end) then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function NewEducateBuff:UpdateDisplayNum(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		self.effectNums[iter_9_1.key] = iter_9_1.value
	end

	return
end

function NewEducateBuff:GetDisplayNum(arg_10_1)
	return self.effectNums[arg_10_1] or 0
end

function NewEducateBuff:IsVisible()
	return pg.child2_benefit_list[self].ignore_on_collection ~= 1 and pg.child2_benefit_list[self].is_show ~= 0
end

return NewEducateBuff
