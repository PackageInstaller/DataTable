return {
	GetCardEffectsDesc = function(arg_1_0)
		local var_1_0 = BloodCardGameCardCfg[arg_1_0]
		local var_1_1 = ""
		local var_1_2 = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_0.effect_list) do
			for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
				if not var_1_2[iter_1_3] then
					var_1_2[iter_1_3] = true

					local var_1_3 = BloodCardGameEffectCfg[iter_1_3]

					if var_1_3 then
						if var_1_1 == "" then
							var_1_1 = var_1_1 .. var_1_3.name
						else
							var_1_1 = var_1_1 .. "\n" .. var_1_3.name
						end
					end
				end
			end
		end

		return var_1_1
	end,
	CheckCacheUnlockCard = function()
		local var_2_0 = BloodCardData:GetCacheUnlockCard()

		if not table.isEmpty(var_2_0) then
			JumpTools.OpenPageByJump("bloodCardUnlockCardPop")
		end
	end,
	IsUnlockGuide = function(arg_3_0)
		if arg_3_0 == 1803 then
			return BloodCardManager.Instance and BloodCardManager.Instance.guideIndex == 2 and BloodCardManager.Instance.isDrawCardDone
		elseif arg_3_0 == 1804 then
			return BloodCardManager.Instance and BloodCardManager.Instance.guideIndex == 2 and BloodCardManager.Instance.isDrawCardDone
		elseif arg_3_0 == 1805 then
			return BloodCardManager.Instance and BloodCardManager.Instance.enemyPlaceOverlayCard
		else
			return false
		end
	end
}
