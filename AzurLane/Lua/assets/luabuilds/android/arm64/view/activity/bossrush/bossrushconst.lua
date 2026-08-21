local var_0_0 = class("BossRushConst")

function var_0_0.GetPassedLayer(arg_1_0)
	return switch(arg_1_0, {
		[ActivityConst.ALVIT_BOSS_RUSH_ID] = function()
			return BossRushAlvitPassedLayer
		end,
		[ActivityConst.ZENGKEHAIJUNSHANGJIANG_BOSS_RUSH_ID] = function()
			return BossRushSardiniaPassedLayer
		end,
		[ActivityConst.ESCAPE_BOSS_RUSH_ID] = function()
			return BossRushEscapeManorPassedLayer
		end
	}, function()
		local var_5_0 = checkExist(pg.activity_template[arg_1_0], {
			"config_client"
		}, {
			"passed"
		})

		if var_5_0 then
			return _G[var_5_0] or BossRushPassedCombatLoadLayer
		end
	end)
end

function var_0_0.GetEXBattleResultLayer(arg_6_0)
	return switch(arg_6_0, {
		[ActivityConst.ALVIT_BOSS_RUSH_ID] = function()
			return BossRushAlvitEXBattleResultLayer
		end,
		[ActivityConst.ZENGKEHAIJUNSHANGJIANG_BOSS_RUSH_ID] = function()
			return BossRushVerZenkerEXBattleResultLayer
		end,
		[ActivityConst.ESCAPE_BOSS_RUSH_ID] = function()
			return BossRushEscapeManorBattleResultLayer
		end
	}, function()
		local var_10_0 = checkExist(pg.activity_template[arg_6_0], {
			"config_client"
		}, {
			"result"
		})

		if var_10_0 then
			return _G[var_10_0] or BossRushEXBattleResultLayer
		end
	end)
end

return var_0_0
