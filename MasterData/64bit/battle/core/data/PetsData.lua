local var_0_0 = load("core.data.PetSkill")
local var_0_2 = table.insert
local var_0_3 = load("const.BattleConst")
local var_0_4 = loadCfg("core.config.cfg.battle_quality_counter_info")
local var_0_5 = var_0_3.Q_SUPPRESS_MODULE
local var_0_6 = var_0_3.Q_SUPPRESS_TYPE
local PetsData = class("PetsData")

function PetsData:ctor(arg_1_1)
	self._identity = arg_1_1
	self._pets = {}
	self._qualitySuppressData = nil
	self._maxQuality = 0
	self._isBoss = false
end

function PetsData:setPets(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_0_2(self._pets, (var_0_0.createPet(iter_2_1)))
	end
end

function PetsData:checkPetExtraSkill(arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(self._pets) do
		local var_3_0 = iter_3_1:getExtraSkill(arg_3_2)

		if var_3_0 > 0 then
			arg_3_1:addFastPassive({
				identity = self._identity,
				info = loadCfg("core.config.cfg.passive_skill_info").get(var_3_0)
			})
		end
	end
end

function PetsData:getPets()
	return self._pets
end

function PetsData:calculationQualitySuppress()
	self._qualitySuppressData = {}

	if self._isBoss then
		local var_5_0 = 0
		local var_5_1 = 0
		local var_5_2 = {}

		for iter_5_0, iter_5_1 in pairs(self._pets) do
			if iter_5_1 then
				var_5_0 = math.max(var_5_0, iter_5_1:getQuality())
				var_5_1 = math.max(var_5_1, iter_5_1:getStar())
			end
		end

		var_5_2[var_5_0] = var_5_2[var_5_0] or {
			[var_0_6.FORMULA] = 0,
			[var_0_6.BUFF] = 0,
			[var_0_6.PASSIVE] = 0,
			[var_0_6.EFFECT] = 0,
			default = {
				[var_0_6.FORMULA] = 0,
				[var_0_6.BUFF] = 0,
				[var_0_6.PASSIVE] = 0,
				[var_0_6.EFFECT] = 0
			}
		}

		self:_calculationQSData(var_0_5.PET, var_0_6.FORMULA, var_5_0, var_5_1, var_5_2[var_5_0], 5)
		self:_calculationQSData(var_0_5.PET, var_0_6.BUFF, var_5_0, var_5_1, var_5_2[var_5_0], 5)
		self:_calculationQSData(var_0_5.PET, var_0_6.PASSIVE, var_5_0, var_5_1, var_5_2[var_5_0], 5)
		self:_calculationQSData(var_0_5.PET, var_0_6.EFFECT, var_5_0, var_5_1, var_5_2[var_5_0], 5)
		self:_calculationQSData(var_0_5.PET, var_0_6.FORMULA, 999, var_5_1, var_5_2[var_5_0].default, 5)
		self:_calculationQSData(var_0_5.PET, var_0_6.BUFF, 999, var_5_1, var_5_2[var_5_0].default, 5)
		self:_calculationQSData(var_0_5.PET, var_0_6.PASSIVE, 999, var_5_1, var_5_2[var_5_0].default, 5)
		self:_calculationQSData(var_0_5.PET, var_0_6.EFFECT, 999, var_5_1, var_5_2[var_5_0].default, 5)

		self._maxQuality = var_5_0
		self._qualitySuppressData = var_5_2
	else
		local var_5_3 = 0
		local var_5_4 = {}

		for iter_5_2, iter_5_3 in pairs(self._pets) do
			if iter_5_3 then
				local var_5_5 = iter_5_3:getQuality()

				if var_5_3 < var_5_5 then
					var_5_3 = var_5_5
				end

				var_5_4[var_5_5] = var_5_4[var_5_5] or {
					[var_0_6.FORMULA] = 0,
					[var_0_6.BUFF] = 0,
					[var_0_6.PASSIVE] = 0,
					[var_0_6.EFFECT] = 0,
					default = {
						[var_0_6.FORMULA] = 0,
						[var_0_6.BUFF] = 0,
						[var_0_6.PASSIVE] = 0,
						[var_0_6.EFFECT] = 0
					}
				}

				self:_calculationQSData(var_0_5.PET, var_0_6.FORMULA, var_5_5, iter_5_3:getStar(), var_5_4[var_5_5])
				self:_calculationQSData(var_0_5.PET, var_0_6.BUFF, var_5_5, iter_5_3:getStar(), var_5_4[var_5_5])
				self:_calculationQSData(var_0_5.PET, var_0_6.PASSIVE, var_5_5, iter_5_3:getStar(), var_5_4[var_5_5])
				self:_calculationQSData(var_0_5.PET, var_0_6.EFFECT, var_5_5, iter_5_3:getStar(), var_5_4[var_5_5])
				self:_calculationQSData(var_0_5.PET, var_0_6.FORMULA, 999, iter_5_3:getStar(), var_5_4[var_5_5].default)
				self:_calculationQSData(var_0_5.PET, var_0_6.BUFF, 999, iter_5_3:getStar(), var_5_4[var_5_5].default)
				self:_calculationQSData(var_0_5.PET, var_0_6.PASSIVE, 999, iter_5_3:getStar(), var_5_4[var_5_5].default)
				self:_calculationQSData(var_0_5.PET, var_0_6.EFFECT, 999, iter_5_3:getStar(), var_5_4[var_5_5].default)
			end
		end

		self._maxQuality = var_5_3
		self._qualitySuppressData = var_5_4
	end
end

function PetsData:_calculationQSData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	arg_6_6 = arg_6_6 or 1

	local var_6_0 = var_0_4.get(arg_6_1, arg_6_3, arg_6_4, arg_6_2)

	if var_6_0 then
		arg_6_5.minValue = 1000 - var_6_0.value_low
		arg_6_5.maxValue = 1000 - var_6_0.value_high
		arg_6_5[arg_6_2] = arg_6_5[arg_6_2] + var_6_0.value1 * arg_6_6
	end
end

function PetsData:getQualitySuppress(arg_7_1, arg_7_2)
	if not self._qualitySuppressData then
		self:calculationQualitySuppress()
	end

	local var_7_0 = self._maxQuality

	if self._maxQuality < var_0_3.START_QUALITY then
		return 0
	end

	local var_7_1 = self._qualitySuppressData
	local var_7_2 = 0

	if var_7_0 - arg_7_2 >= 1 then
		local var_7_3 = var_7_1[arg_7_2 + 1] or {}
		local var_7_4 = var_7_3[arg_7_1] or 0

		if var_7_4 > 0 then
			var_7_2 = math.clamp(var_7_2 + var_7_4, var_7_3.minValue, var_7_3.maxValue)
		end
	end

	if var_7_0 - arg_7_2 >= 2 then
		local var_7_5

		if var_7_1[arg_7_2 + 2] then
			var_7_5 = var_7_1[arg_7_2 + 2].default or {}
		end

		local var_7_6 = var_7_5[arg_7_1] or 0

		if var_7_6 > 0 then
			var_7_2 = math.clamp(var_7_2 + var_7_6, var_7_5.minValue, var_7_5.maxValue)
		end
	end

	if var_7_0 - arg_7_2 >= 3 then
		-- block empty
	end

	return var_7_2
end

function PetsData:setIsBoss(arg_8_1)
	return
end

return PetsData
