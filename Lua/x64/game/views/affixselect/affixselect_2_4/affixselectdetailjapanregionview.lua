local var_0_0 = import("game.views.AffixSelect.AffixSelectDetailView")
local var_0_1 = class("AffixSelectDetailJapanRegionView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_StageDetailsUI"
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectBossInfoJapanRegion", {
			bossIDList = arg_2_0.cfg_.boss_id,
			index = arg_2_0.params_.index
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.challengeBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = arg_2_0.cfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT,
			activityID = arg_2_0.params_.activityId
		})
	end)
end

return var_0_1
