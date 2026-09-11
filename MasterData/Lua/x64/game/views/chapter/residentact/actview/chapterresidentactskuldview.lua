ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local ChapterResidentActSkuldView = class("ChapterResidentActSkuldView", ChapterResidentActBaseView)

function ChapterResidentActSkuldView:AddUIListener()
	ChapterResidentActSkuldView.super.AddUIListener(self)
	self:AddBtnListener(self.emptyDreamBtn_, nil, function()
		JumpTools.JumpToPage({
			309,
			12112
		})
	end)
end

function ChapterResidentActSkuldView:RefreshUI()
	ChapterResidentActSkuldView.super.RefreshUI(self)

	local var_3_0 = 0
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM].chapter_list) do
		for iter_3_2, iter_3_3 in pairs(ChapterCfg[iter_3_1].section_id_list) do
			table.insert(var_3_1, iter_3_3)

			if BattleStageData:GetStageClearTimes(iter_3_3) > 0 then
				var_3_0 = var_3_0 + 1
			end
		end
	end

	self.emptyDreamFillText_.text = math.floor(var_3_0 / #var_3_1 * 100) .. "%"
	self.emptyDreamFillImage_.fillAmount = var_3_0 / #var_3_1
end

return ChapterResidentActSkuldView
