local MythicSelectHeroProxy = class("MythicSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function MythicSelectHeroProxy:InitCustomParams(arg_1_1)
	self.partition = arg_1_1.partition
	self.difficulty = arg_1_1.difficulty
end

function MythicSelectHeroProxy:CustomCheckBeforeBattle()
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/mythic", nil)
			end
		})

		return false
	end

	return true
end

function MythicSelectHeroProxy:GetStageData()
	return (BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC, self.stageID, self.partition))
end

return MythicSelectHeroProxy
