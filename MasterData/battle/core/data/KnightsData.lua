local KnightsData = class("KnightsData")
local var_0_1 = load("const.BattleConst")
local var_0_2 = loadCfg("core.config.cfg.artifact_info")
local var_0_3 = loadCfg("core.config.cfg.battle_quality_counter_info")
local var_0_5 = var_0_1.Q_SUPPRESS_MODULE
local var_0_6 = var_0_1.Q_SUPPRESS_TYPE

function KnightsData.create()
	return KnightsData.new()
end

function KnightsData:ctor()
	self._raw = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self._totalPower = {
		0,
		0
	}
	self._qualitySuppressDataKnight = {}
	self._qualitySuppressDataArtifact = {}
	self._maxKnightQuality = {
		0,
		0
	}
	self._maxArtifactQuality = {
		0,
		0
	}
	self._isBoss = false
end

function KnightsData:ipairs(arg_3_1)
	local var_3_0 = 0
	local var_3_1 = var_3_0 + 20

	if arg_3_1 then
		var_3_0 = arg_3_1 == 1 and 0 or 10
		var_3_1 = var_3_0 + 10
	end

	return function(arg_4_0, arg_4_1)
		local var_4_0

		repeat
			arg_4_1 = arg_4_1 + 1
			var_4_0 = arg_4_0._raw[arg_4_1]
		until arg_4_0._raw[arg_4_1] ~= 0

		if not var_4_0 or arg_4_1 > var_3_1 then
			return nil, nil
		end

		return arg_4_1, var_4_0
	end, self, var_3_0
end

function KnightsData:getKnightByIdAndPos(arg_5_1, arg_5_2)
	return self:getKnightData((arg_5_1 - 1) * 10 + arg_5_2)
end

function KnightsData:setKnightData(arg_6_1, arg_6_2)
	arg_6_1.serialId = (arg_6_2 - 1) * 10 + arg_6_1.originInfo.pos
	self._raw[(arg_6_2 - 1) * 10 + arg_6_1.originInfo.pos] = arg_6_1
end

function KnightsData:getKnightData(arg_7_1)
	return self._raw[arg_7_1] ~= 0 and self._raw[arg_7_1] or nil
end

function KnightsData:getKnightCount(arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in self:ipairs(arg_8_1) do
		var_8_0 = var_8_0 + 1
	end

	return var_8_0
end

function KnightsData:getAliveKnightCount(arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in self:ipairs(arg_9_1) do
		if not iter_9_1.isDead then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function KnightsData:getDeathKnightCount(arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in self:ipairs(arg_10_1) do
		if iter_10_1.isDead then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function KnightsData:clear(arg_11_1)
	for iter_11_0 = 1, 10 do
		self._raw[(arg_11_1 - 1) * 10 + iter_11_0] = 0
	end

	self._qualitySuppressDataKnight = {}
	self._qualitySuppressDataArtifact = {}
	self._maxKnightQuality = {
		0,
		0
	}
	self._maxArtifactQuality = {
		0,
		0
	}
end

function KnightsData:getKnightQualitySuppress(arg_12_1, arg_12_2, arg_12_3)
	if not self._qualitySuppressDataKnight[arg_12_1] then
		self:calculationQualitySuppress(arg_12_1)
	end

	local var_12_0 = self._maxKnightQuality[arg_12_1]

	if self._maxKnightQuality[arg_12_1] < var_0_1.START_QUALITY then
		return 0
	end

	local var_12_1 = self._qualitySuppressDataKnight[arg_12_1]
	local var_12_2 = 0

	if var_12_0 - arg_12_3 >= 1 then
		local var_12_3 = var_12_1[arg_12_3 + 1] or {}
		local var_12_4 = var_12_3[arg_12_2] or 0

		if var_12_4 > 0 then
			var_12_2 = math.clamp(var_12_2 + var_12_4, var_12_3.minValue, var_12_3.maxValue)
		end
	end

	if var_12_0 - arg_12_3 >= 2 then
		local var_12_5

		if var_12_1[arg_12_3 + 2] then
			var_12_5 = var_12_1[arg_12_3 + 2].default or {}
		end

		local var_12_6 = var_12_5[arg_12_2] or 0

		if var_12_6 > 0 then
			var_12_2 = math.clamp(var_12_2 + var_12_6, var_12_5.minValue, var_12_5.maxValue)
		end
	end

	if var_12_0 - arg_12_3 >= 3 then
		-- block empty
	end

	return var_12_2
end

function KnightsData:getArtifactQualitySuppress(arg_13_1, arg_13_2, arg_13_3)
	if not self._qualitySuppressDataArtifact[arg_13_1] then
		self:calculationQualitySuppress(arg_13_1)
	end

	local var_13_0 = self._maxArtifactQuality[arg_13_1]

	if self._maxArtifactQuality[arg_13_1] < var_0_1.START_QUALITY then
		return 0
	end

	local var_13_1 = self._qualitySuppressDataArtifact[arg_13_1]
	local var_13_2 = 0

	if var_13_0 - arg_13_3 >= 1 then
		local var_13_3 = var_13_1[arg_13_3 + 1] or {}
		local var_13_4 = var_13_3[arg_13_2] or 0

		if var_13_4 > 0 then
			var_13_2 = math.clamp(var_13_2 + var_13_4, var_13_3.minValue, var_13_3.maxValue)
		end
	end

	if var_13_0 - arg_13_3 >= 2 then
		local var_13_5

		if var_13_1[arg_13_3 + 2] then
			var_13_5 = var_13_1[arg_13_3 + 2].default or {}
		end

		local var_13_6 = var_13_5[arg_13_2] or 0

		if var_13_6 > 0 then
			var_13_2 = math.clamp(var_13_2 + var_13_6, var_13_5.minValue, var_13_5.maxValue)
		end
	end

	if var_13_0 - arg_13_3 >= 3 then
		-- block empty
	end

	return var_13_2
end

function KnightsData:calculationQualitySuppress(arg_14_1)
	self._qualitySuppressDataKnight[arg_14_1] = {}
	self._qualitySuppressDataArtifact[arg_14_1] = {}

	local var_14_0 = {}
	local var_14_1 = {}

	if self._isBoss and arg_14_1 == 2 then
		local var_14_2 = 0
		local var_14_3 = 0
		local var_14_4 = 0
		local var_14_5 = 0

		for iter_14_0, iter_14_1 in self:ipairs(arg_14_1) do
			var_14_2 = math.max(var_14_2, iter_14_1.knightCfg.quality)
			var_14_3 = math.max(var_14_3, iter_14_1.star)

			local var_14_6 = iter_14_1.baseData.artifactId or 0

			if var_14_6 > 0 then
				local var_14_7 = var_0_2.get(var_14_6)

				var_14_4 = math.max(var_14_4, var_14_7.quality)
				var_14_5 = math.max(var_14_5, var_14_7.star)
			end
		end

		var_14_0[var_14_2] = var_14_0[var_14_2] or {
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

		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.FORMULA, var_14_2, var_14_3, var_14_0[var_14_2], 6)
		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.BUFF, var_14_2, var_14_3, var_14_0[var_14_2], 6)
		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.PASSIVE, var_14_2, var_14_3, var_14_0[var_14_2], 6)
		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.EFFECT, var_14_2, var_14_3, var_14_0[var_14_2], 6)
		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.FORMULA, 999, var_14_3, var_14_0[var_14_2].default, 6)
		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.BUFF, 999, var_14_3, var_14_0[var_14_2].default, 6)
		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.PASSIVE, 999, var_14_3, var_14_0[var_14_2].default, 6)
		self:_calculationQSData(var_0_5.KNIGHT, var_0_6.EFFECT, 999, var_14_3, var_14_0[var_14_2].default, 6)

		self._maxKnightQuality[arg_14_1] = var_14_2
		var_14_1[var_14_4] = var_14_1[var_14_4] or {
			[var_0_6.BUFF] = 0,
			[var_0_6.PASSIVE] = 0,
			default = {
				[var_0_6.BUFF] = 0,
				[var_0_6.PASSIVE] = 0
			}
		}

		self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.BUFF, var_14_4, var_14_5, var_14_1[var_14_4], 6)
		self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.PASSIVE, var_14_4, var_14_5, var_14_1[var_14_4], 6)
		self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.BUFF, 999, var_14_5, var_14_1[var_14_4].default, 6)
		self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.PASSIVE, 999, var_14_5, var_14_1[var_14_4].default, 6)

		self._maxArtifactQuality[arg_14_1] = var_14_4
	else
		for iter_14_2, iter_14_3 in self:ipairs(arg_14_1) do
			if iter_14_3 then
				var_14_0[iter_14_3.knightCfg.quality] = var_14_0[iter_14_3.knightCfg.quality] or {
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

				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.FORMULA, iter_14_3.knightCfg.quality, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality])
				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.BUFF, iter_14_3.knightCfg.quality, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality])
				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.PASSIVE, iter_14_3.knightCfg.quality, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality])
				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.EFFECT, iter_14_3.knightCfg.quality, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality])
				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.FORMULA, 999, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality].default)
				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.BUFF, 999, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality].default)
				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.PASSIVE, 999, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality].default)
				self:_calculationQSData(var_0_5.KNIGHT, var_0_6.EFFECT, 999, iter_14_3.star, var_14_0[iter_14_3.knightCfg.quality].default)

				self._maxKnightQuality[arg_14_1] = math.max(self._maxKnightQuality[arg_14_1], iter_14_3.knightCfg.quality)

				local var_14_8 = iter_14_3.baseData.artifactId or 0

				if var_14_8 > 0 then
					local var_14_9 = var_0_2.get(var_14_8)

					var_14_1[var_14_9.quality] = var_14_1[var_14_9.quality] or {
						[var_0_6.BUFF] = 0,
						[var_0_6.PASSIVE] = 0,
						default = {
							[var_0_6.BUFF] = 0,
							[var_0_6.PASSIVE] = 0
						}
					}

					self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.BUFF, var_14_9.quality, var_14_9.star, var_14_1[var_14_9.quality])
					self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.PASSIVE, var_14_9.quality, var_14_9.star, var_14_1[var_14_9.quality])
					self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.BUFF, 999, var_14_9.star, var_14_1[var_14_9.quality].default)
					self:_calculationQSData(var_0_5.ARTIFACT, var_0_6.PASSIVE, 999, var_14_9.star, var_14_1[var_14_9.quality].default)

					self._maxArtifactQuality[arg_14_1] = math.max(self._maxArtifactQuality[arg_14_1], var_14_9.quality)
				end
			end
		end
	end

	self._qualitySuppressDataKnight[arg_14_1] = var_14_0
	self._qualitySuppressDataArtifact[arg_14_1] = var_14_1
end

function KnightsData:_calculationQSData(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	arg_15_6 = arg_15_6 or 1

	local var_15_0 = var_0_3.get(arg_15_1, arg_15_3, arg_15_4, arg_15_2)

	if var_15_0 then
		arg_15_5.minValue = 1000 - var_15_0.value_low
		arg_15_5.maxValue = 1000 - var_15_0.value_high
		arg_15_5[arg_15_2] = arg_15_5[arg_15_2] + var_15_0.value1 * arg_15_6
	end
end

function KnightsData:getAllKnightMaxQuality()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in self:ipairs() do
		if var_16_0 < iter_16_1.knightCfg.quality then
			var_16_0 = iter_16_1.knightCfg.quality
		end
	end

	return var_16_0
end

function KnightsData:setIsBoss(arg_17_1)
	self._isBoss = arg_17_1
end

return KnightsData
