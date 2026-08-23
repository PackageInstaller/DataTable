local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = {}

function var_0_2.isFinishCondition(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_2["_isFinish" .. arg_1_0]

	if not var_0_2["_isFinish" .. arg_1_0] then
		return false
	end

	return var_1_0(arg_1_1, arg_1_2) == true
end

function var_0_2._isFinish432(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = 1, var_0_1.LINEUP_MAX do
		local var_2_1 = g.core.model.User.knightsData:getKnight({
			pos = iter_2_0
		})

		if var_2_1 and arg_2_1 <= var_2_1:getLevel() then
			var_2_0 = var_2_0 + 1
		end

		if arg_2_0 <= var_2_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish433(arg_3_0, arg_3_1)
	local var_3_0 = 0

	for iter_3_0 = 1, var_0_1.LINEUP_MAX do
		local var_3_1 = g.core.model.User.knightsData:getKnight({
			pos = iter_3_0
		})

		if var_3_1 and arg_3_1 <= var_3_1:getAdvanceLevel() then
			var_3_0 = var_3_0 + 1
		end

		if arg_3_0 <= var_3_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish54(arg_4_0, arg_4_1)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(g.core.model.User.knightsData:getOwnerAllList(true)) do
		if iter_4_1:getQuality() >= var_0_0.SSR then
			var_4_0 = var_4_0 + 1
		end

		if arg_4_1 <= var_4_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish426(arg_5_0, arg_5_1)
	local var_5_0 = 0

	for iter_5_0 = 1, var_0_1.LINEUP_MAX do
		local var_5_1 = g.core.model.User.artifactData:getArtifactByPos(iter_5_0)

		if var_5_1 and arg_5_1 <= var_5_1:getLevel() then
			var_5_0 = var_5_0 + 1
		end

		if arg_5_0 <= var_5_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish86(arg_6_0, arg_6_1)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs((g.core.model.User.artifactData:getOwnArtifactList(true))) do
		if iter_6_1:getQuality() >= var_0_0.SR then
			var_6_0 = var_6_0 + 1
		end

		if arg_6_1 <= var_6_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish434(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs((g.core.model.User.artifactData:getOwnArtifactList(true))) do
		if arg_7_0 <= iter_7_1:getStar() and iter_7_1:getQuality() >= var_0_0.SR then
			var_7_0 = var_7_0 + 1
		end

		if arg_7_1 <= var_7_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish87(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs((g.core.model.User.artifactData:getOwnArtifactList(true))) do
		if iter_8_1:getQuality() >= var_0_0.SSR then
			var_8_0 = var_8_0 + 1
		end

		if arg_8_1 <= var_8_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish398(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs((g.core.model.User.uniteTokenData:getOwnTokenList())) do
		if arg_9_0 <= iter_9_1:getLevel() then
			var_9_0 = var_9_0 + 1
		end

		if arg_9_1 <= var_9_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish427(arg_10_0, arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs((g.core.model.User.uniteTokenData:getOwnTokenList())) do
		if iter_10_1:getQuality() >= var_0_0.SR and arg_10_0 <= iter_10_1:getStarLevel() then
			var_10_0 = var_10_0 + 1
		end

		if arg_10_1 <= var_10_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish14(arg_11_0, arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs((g.core.model.User.uniteTokenData:getOwnTokenList())) do
		if iter_11_1:getQuality() >= var_0_0.SSR then
			var_11_0 = var_11_0 + 1
		end

		if arg_11_1 <= var_11_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish428(arg_12_0, arg_12_1)
	local var_12_0 = 0

	for iter_12_0 = 1, g.core.const.ConstMgr.PetConst.LINEUP_MAX do
		local var_12_1 = g.core.model.User.petsData:getPetByPos(iter_12_0)

		if var_12_1 and arg_12_1 <= var_12_1:getLevel() then
			var_12_0 = var_12_0 + 1
		end

		if arg_12_0 <= var_12_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish429(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0 = 1, g.core.const.ConstMgr.PetConst.LINEUP_MAX do
		local var_13_1 = g.core.model.User.petsData:getPetByPos(iter_13_0)

		if var_13_1 and arg_13_1 <= var_13_1:getBigSmallStage() then
			var_13_0 = var_13_0 + 1
		end

		if arg_13_0 <= var_13_0 then
			return true
		end
	end

	return false
end

function var_0_2._isFinish402(arg_14_0, arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs((g.core.model.User.petsData:getOwnPetArr())) do
		if iter_14_1:getQuality() >= var_0_0.SSR then
			var_14_0 = var_14_0 + 1
		end

		if arg_14_1 <= var_14_0 then
			return true
		end
	end

	return false
end

function var_0_2.getValue(arg_15_0, arg_15_1)
	if not var_0_2["_getValue" .. arg_15_0] then
		return 0
	end

	return var_0_2["_getValue" .. arg_15_0](arg_15_1)
end

function var_0_2._getValue430(arg_16_0, arg_16_1)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs((g.core.model.User.knightsData:getOwnerAllList(true))) do
		if iter_16_1:getQuality() >= var_0_0.SSR and arg_16_0 <= iter_16_1:getStarLv() then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_2._getValue431(arg_17_0, arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs((g.core.model.User.artifactData:getOwnArtifactList(true))) do
		if iter_17_1:getQuality() >= var_0_0.SSR and arg_17_0 <= iter_17_1:getStar() then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0
end

function var_0_2._isFinish431(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs((g.core.model.User.artifactData:getOwnArtifactList(true))) do
		if iter_18_1:getQuality() >= var_0_0.SSR and arg_18_0 <= iter_18_1:getStar() then
			var_18_0 = var_18_0 + 1
		end

		if arg_18_1 <= var_18_0 then
			return true
		end
	end

	return false
end

function var_0_2._getValue397(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs((g.core.model.User.uniteTokenData:getOwnTokenList())) do
		if iter_19_1:getQuality() >= var_0_0.SSR and arg_19_0 <= iter_19_1:getStarLevel() then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function var_0_2._isFinish397(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs((g.core.model.User.uniteTokenData:getOwnTokenList())) do
		if iter_20_1:getQuality() >= var_0_0.SSR and arg_20_0 <= iter_20_1:getStarLevel() then
			var_20_0 = var_20_0 + 1
		end

		if arg_20_1 <= var_20_0 then
			return true
		end
	end

	return false
end

function var_0_2._getValue404(arg_21_0, arg_21_1)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs((g.core.model.User.petsData:getOwnPetArr())) do
		if iter_21_1:getQuality() >= var_0_0.SSR and arg_21_0 <= iter_21_1:getStarNum() then
			var_21_0 = var_21_0 + 1
		end
	end

	return var_21_0
end

return var_0_2
