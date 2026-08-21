return {
	BindBilliardGameUI = function(arg_1_0)
		BilliardGameLuaBridge.BindBilliardGameUI(arg_1_0)
	end,
	GetIsInTrackChain = function(arg_2_0)
		local var_2_0 = BilliardGameMgr:GetTrackBuffId()

		if not var_2_0 then
			return false
		end

		local var_2_1 = MergeBallBuffCfg[arg_2_0]

		if not var_2_1 then
			return false
		end

		local var_2_2 = MergeBallBuffCfg[var_2_0]

		if not var_2_2 then
			return false
		end

		if arg_2_0 == var_2_0 then
			return true
		end

		local function var_2_3(arg_3_0)
			local var_3_0 = BilliardGameMgr:GetSkillByMainBuffId(arg_3_0)

			return var_3_0 ~= nil and not var_3_0.isCombine_
		end

		local var_2_4 = var_2_2.formula

		if var_2_1.parent_id and type(var_2_4) == "table" and #var_2_4 > 0 then
			local var_2_5 = true
			local var_2_6 = false

			for iter_2_0, iter_2_1 in ipairs(var_2_1.parent_id) do
				for iter_2_2, iter_2_3 in ipairs(var_2_4) do
					if iter_2_1 == iter_2_3 then
						var_2_6 = true

						if not var_2_3(iter_2_3) then
							var_2_5 = false
						end

						break
					end
				end
			end

			if var_2_6 and var_2_5 then
				return false
			end
		end

		local function var_2_7(arg_4_0)
			if arg_4_0 == var_2_0 then
				return true
			end

			local var_4_0 = MergeBallBuffCfg[arg_4_0]

			if var_4_0 and var_4_0.parent_id then
				for iter_4_0, iter_4_1 in ipairs(var_4_0.parent_id) do
					if var_2_7(iter_4_1) then
						return true
					end
				end
			end

			return false
		end

		if var_2_1.parent_id then
			for iter_2_4, iter_2_5 in ipairs(var_2_1.parent_id) do
				if var_2_7(iter_2_5) then
					return true
				end
			end
		end

		return false
	end,
	GetIsUltimateSkillUnlocked = function()
		return table.indexof(VehicleBallData:GetPassedStageList(), BilliardGameConst.UltimateSkillUnlockStage)
	end
}
