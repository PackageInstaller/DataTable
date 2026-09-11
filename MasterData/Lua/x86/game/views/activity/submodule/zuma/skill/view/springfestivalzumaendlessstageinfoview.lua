local SpringFestivalZumaEndlessStageInfoView = class("SpringFestivalZumaEndlessStageInfoView", ReduxView)

function SpringFestivalZumaEndlessStageInfoView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.difficultType = arg_1_2
	self.difficultCfgList = ZumaData:GetZumaCfgData()[arg_1_2]

	self:InitUI()
end

function SpringFestivalZumaEndlessStageInfoView:InitUI()
	self:BindCfgUI()

	self.rateController = self.controllerexcollection_:GetController("rate")
	self.selectController = self.controllerexcollection_:GetController("select")

	self:AddBtnListener(self.stageBtn_, nil, function()
		manager.notify:CallUpdateFunc(ZUMA_SELECT_CHAPTER)
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalZumaEndlessEffectPopView")
	end)

	self.rangeTalentScoreList = {}

	for iter_2_0, iter_2_1 in pairs((ZumaData:GetEndlessTalentList())) do
		local var_2_0 = self[string.format("progressValueTxt%s_", iter_2_0)]

		if var_2_0 then
			var_2_0.text = ActivityZumaTalentCfg[iter_2_1].need
		end

		table.insert(self.rangeTalentScoreList, ActivityZumaTalentCfg[iter_2_1].need)
	end
end

function SpringFestivalZumaEndlessStageInfoView:ChangeSelectState(arg_5_1)
	self.selectController:SetSelectedState(arg_5_1 and "on" or "off")
end

local var_0_1 = {
	0,
	0.13,
	0.33,
	0.58,
	1
}

function SpringFestivalZumaEndlessStageInfoView:RefreshStageUI()
	self.nameText_.text = self:GetLevelCfg().name

	local var_6_0 = ZumaData:GetEndlessScore() or 0

	self.scoreText_.text = var_6_0

	local var_6_1 = #self.rangeTalentScoreList + 1

	for iter_6_0, iter_6_1 in ipairs(self.rangeTalentScoreList) do
		if var_6_0 < iter_6_1 then
			var_6_1 = iter_6_0

			break
		end
	end

	local var_6_2 = self.rangeTalentScoreList[var_6_1] or nil

	self.progressImg_.fillAmount = var_6_2 == nil and 1 or var_0_1[var_6_1 - 1] + (var_6_0 - self.rangeTalentScoreList[var_6_1 - 1]) / (var_6_2 - self.rangeTalentScoreList[var_6_1 - 1]) * (var_0_1[var_6_1] - var_0_1[var_6_1 - 1])

	self.rateController:SetSelectedIndex(var_6_1 - 2)
end

function SpringFestivalZumaEndlessStageInfoView:SetRedState(arg_7_1)
	return
end

function SpringFestivalZumaEndlessStageInfoView:DefalutSelect()
	return
end

function SpringFestivalZumaEndlessStageInfoView:GetAllScore()
	return ZumaData:GetZumaStageScore(self:GetLevelCfg().id) or 0
end

function SpringFestivalZumaEndlessStageInfoView:GetLevelCfg()
	return self.difficultCfgList[1]
end

function SpringFestivalZumaEndlessStageInfoView:GetDifficultCfgList()
	return {}
end

function SpringFestivalZumaEndlessStageInfoView:Dispose()
	SpringFestivalZumaEndlessStageInfoView.super.Dispose(self)
end

return SpringFestivalZumaEndlessStageInfoView
