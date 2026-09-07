local NewEducateBenefit = class("NewEducateBenefit")

function NewEducateBenefit:Ctor(arg_1_1, arg_1_2)
	self.buffs = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.actives) do
		self.buffs[iter_1_1.id] = NewEducateBuff.New(iter_1_1)
	end

	self:InitDisplayPct(arg_1_2.benefit_display)
	self:InitDisplayNum(arg_1_2.dollar_num_display)
	self:InitDisplayCounter(arg_1_2.counter)

	return
end

function NewEducateBenefit:AddBuff(arg_2_1)
	self.buffs[arg_2_1.id] = NewEducateBuff.New(arg_2_1)

	return
end

function NewEducateBenefit:RemoveBuff(arg_3_1)
	self.buffs[arg_3_1] = nil

	return
end

function NewEducateBenefit:GetBuff(arg_4_1)
	return self.buffs[arg_4_1]
end

function NewEducateBenefit:GetListByType(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.buffs) do
		if NewEducateBuff.IsVisible(iter_5_1.id) and iter_5_1:getConfig("type") == arg_5_1 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	table.sort(var_5_0, CompareFuncs({
		function(arg_6_0)
			return arg_6_0.round
		end,
		function(arg_7_0)
			return arg_7_0.id
		end
	}))

	return var_5_0
end

function NewEducateBenefit:GetAllBuffList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.buffs) do
		table.insert(var_8_0, iter_8_1)
	end

	return var_8_0
end

function NewEducateBenefit:OnNextRound(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.buffs) do
		iter_9_1:OnNextRound(arg_9_1)

		if arg_9_1 == iter_9_1:GetEndRound() then
			self.buffs[iter_9_1.id] = nil
		end
	end

	return
end

function NewEducateBenefit:ExistBuff(arg_10_1)
	return self.buffs[arg_10_1]
end

function NewEducateBenefit:GetAllIds()
	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(self.buffs) do
		if iter_11_1:IsPending() then
			table.insert(var_11_1, iter_11_1.id)
		else
			table.insert(var_11_0, iter_11_1.id)
		end
	end

	return var_11_0, var_11_1
end

function NewEducateBenefit:InitDisplayPct(arg_12_1)
	self.displayPctData = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		self.displayPctData[iter_12_1.type] = self.displayPctData[iter_12_1.type] or {}
		self.displayPctData[iter_12_1.type][iter_12_1.id] = iter_12_1.number
	end

	return
end

function NewEducateBenefit:UpdateDisplayPct(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		self.displayPctData[iter_13_1.type] = self.displayPctData[iter_13_1.type] or {}
		self.displayPctData[iter_13_1.type][iter_13_1.id] = iter_13_1.number
	end

	return
end

function NewEducateBenefit:GetDisplayPctData(arg_14_1, arg_14_2)
	if not self.displayPctData[arg_14_1] then
		return 0
	end

	return self.displayPctData[arg_14_1][arg_14_2] and calcFloor(self.displayPctData[arg_14_1][arg_14_2] / 100) or 0
end

function NewEducateBenefit:GetDisplayPctList()
	local var_15_0 = {}

	table.insert(var_15_0, {
		type = NewEducateConst.DROP_TYPE.RES,
		id = self:GetResIdByType(NewEducateChar.RES_TYPE.MONEY)
	})

	for iter_15_0, iter_15_1 in ipairs(self:GetAttrIds()) do
		table.insert(var_15_0, {
			type = NewEducateConst.DROP_TYPE.ATTR,
			id = iter_15_1
		})
	end

	return var_15_0
end

function NewEducateBenefit:IsMoodBenefit()
	return self >= 10001 and self <= 10100
end

function NewEducateBenefit:GetFinalPct(arg_17_1)
	local var_17_0 = self / 16

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		var_17_0 = var_17_0 * (iter_17_1 / 16)
	end

	return var_17_0 * 100
end

function NewEducateBenefit:GetDisplayPctByDrop(arg_18_1)
	local var_18_0 = 0
	local var_18_1 = 0
	local var_18_2 = {}
	local var_18_3 = {}

	for iter_18_0, iter_18_1 in pairs(self.buffs) do
		for iter_18_2, iter_18_3 in ipairs(pg.child2_benefit_list[iter_18_0].content) do
			if not NewEducateBenefit.IsMoodBenefit(iter_18_3) then
				local var_18_4, var_18_5 = NewEducateBenefit.GetDisplayPctByBenefitId(iter_18_3, arg_18_1)

				var_18_0 = var_18_0 + var_18_4[1]
				var_18_2 = table.mergeArray(var_18_2, var_18_4[2])
				var_18_1 = var_18_1 + var_18_5[1]
				var_18_3 = table.mergeArray(var_18_3, var_18_5[2])
			end
		end
	end

	local var_18_6 = NewEducateBenefit.GetFinalPct(var_18_0, var_18_2)
	local var_18_7 = NewEducateBenefit.GetFinalPct(var_18_1, var_18_3)
end

function NewEducateBenefit:GetDisplayPctByBenefitId(arg_19_1)
	local var_19_0 = 0
	local var_19_1 = 0
	local var_19_2 = {}
	local var_19_3 = {}
	local var_19_4 = pg.child2_benefit[self].trigger == NewEducateConst.TRIGGER_TYPE.PERMANENT and #pg.child2_benefit[self].condition == 0

	for iter_19_0, iter_19_1 in ipairs(pg.child2_benefit[self].effect) do
		switch(iter_19_1[1], {
			[NewEducateConst.EFFECT_TYPE.ADD_PPT] = function()
				if iter_19_1[2][1] == arg_19_1.type and iter_19_1[2][2] == arg_19_1.id then
					var_19_1 = var_19_1 + iter_19_1[2][3]

					if var_19_4 then
						var_19_0 = var_19_0 + iter_19_1[2][3]
					end
				end

				return
			end,
			[NewEducateConst.EFFECT_TYPE.MULT_PPT] = function()
				if iter_19_1[2][1] == arg_19_1.type and iter_19_1[2][2] == arg_19_1.id then
					table.insert(var_19_3, iter_19_1[2][3])

					if var_19_4 then
						table.insert(var_19_2, iter_19_1[2][3])
					end
				end

				return
			end
		})
	end

	return {
		0,
		var_19_2
	}, {
		var_19_1,
		var_19_3
	}
end

function NewEducateBenefit:InitDisplayNum(arg_22_1)
	self:UpdateDisplayNum(arg_22_1)

	return
end

function NewEducateBenefit:UpdateDisplayNum(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if not self.buffs[iter_23_1.buffid] then
			warning("not exist buff: ", iter_23_1.buffid)
		else
			self.buffs[iter_23_1.buffid]:UpdateDisplayNum(iter_23_1.benefitval)
		end
	end

	return
end

function NewEducateBenefit:InitDisplayCounter(arg_24_1)
	self.displayCounterData = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		self.displayCounterData[iter_24_1.group] = NewEducateBenefitCounter.New(iter_24_1)
	end

	return
end

function NewEducateBenefit:UpdateDisplayCounter(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		self.displayCounterData[iter_25_1.group] = NewEducateBenefitCounter.New(iter_25_1)
	end

	return
end

function NewEducateBenefit:GetDisplayCounterData(arg_26_1)
	return self.displayCounterData[arg_26_1]
end

function NewEducateBenefit:GetActiveEffectsByType(arg_27_1, arg_27_2)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self.buffs) do
		local var_27_1 = iter_27_1:GetBenefitIdsByEffectType(arg_27_2)

		if #var_27_1 > 0 then
			for iter_27_2, iter_27_3 in ipairs(var_27_1) do
				if arg_27_1:IsMatchComplex(pg.child2_benefit[iter_27_3].condition) then
					for iter_27_4, iter_27_5 in ipairs(pg.child2_benefit[iter_27_3].effect) do
						if iter_27_5[1] == arg_27_2 then
							table.insert(var_27_0, iter_27_5)
						end
					end
				end
			end
		end
	end

	return var_27_0
end

function NewEducateBenefit:GetExtraPlan(arg_28_1)
	local var_28_0 = {}

	underscore.each(self:GetActiveEffectsByType(arg_28_1, NewEducateConst.EFFECT_TYPE.EXTRA_PLAN), function(arg_29_0)
		var_28_0 = table.mergeArray(var_28_0, arg_29_0[2], true)

		return
	end)

	return var_28_0
end

function NewEducateBenefit:GetGoodsDiscountInfos(arg_30_1)
	return self:GetCommonDiscountInfos((self:GetActiveEffectsByType(arg_30_1, NewEducateConst.EFFECT_TYPE.REDUCE_GOODS_COST)))
end

function NewEducateBenefit:GetCommonDiscountInfos(arg_31_1)
	local var_31_0 = {}

	underscore.each(arg_31_1, function(arg_32_0)
		var_31_0[arg_32_0[2][1]] = var_31_0[arg_32_0[2][1]] or {}
		var_31_0[arg_32_0[2][1]][arg_32_0[2][2]] = var_31_0[arg_32_0[2][1]][arg_32_0[2][2]] or {
			value = 0,
			ratio = 0
		}

		if arg_32_0[2][3] == 1 then
			var_31_0[arg_32_0[2][1]][arg_32_0[2][2]].value = var_31_0[arg_32_0[2][1]][arg_32_0[2][2]].value + arg_32_0[2][4]
		elseif arg_32_0[2][3] == 2 then
			var_31_0[arg_32_0[2][1]][arg_32_0[2][2]].ratio = var_31_0[arg_32_0[2][1]][arg_32_0[2][2]].ratio + arg_32_0[2][4]
		end

		return
	end)

	return var_31_0
end

function NewEducateBenefit:GetActivePlanDiscountEffects(arg_33_1)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(self.buffs) do
		local var_33_1 = iter_33_1:GetBenefitIdsByEffectType(NewEducateConst.EFFECT_TYPE.REDUCE_PLAN_COST)

		if #var_33_1 > 0 then
			for iter_33_2, iter_33_3 in ipairs(var_33_1) do
				for iter_33_4, iter_33_5 in ipairs((arg_33_1:GetConditionIdsFromComplex(pg.child2_benefit[iter_33_3].condition))) do
					if pg.child2_condition[iter_33_5].type == 8 or pg.child2_condition[iter_33_5].type == 15 then
						local var_33_2 = {}

						for iter_33_6, iter_33_7 in ipairs(pg.child2_benefit[iter_33_3].effect) do
							if iter_33_7[1] == NewEducateConst.EFFECT_TYPE.REDUCE_PLAN_COST then
								table.insert(var_33_2, iter_33_7)
							end
						end

						for iter_33_8, iter_33_9 in ipairs(pg.child2_condition[iter_33_5].param[1]) do
							var_33_0[iter_33_9] = var_33_0[iter_33_9] or {}
							var_33_0[iter_33_9] = table.mergeArray(var_33_0[iter_33_9], var_33_2)
						end
					end
				end
			end
		end
	end

	return var_33_0
end

function NewEducateBenefit:GetPlanDiscountInfos(arg_34_1)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs((self:GetActivePlanDiscountEffects(arg_34_1))) do
		var_34_0[iter_34_0] = self:GetCommonDiscountInfos(iter_34_1)
	end

	return var_34_0
end

return NewEducateBenefit
