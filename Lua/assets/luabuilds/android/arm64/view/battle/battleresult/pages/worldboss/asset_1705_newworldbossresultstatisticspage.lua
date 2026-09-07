local NewWorldBossResultStatisticsPage = class("NewWorldBossResultStatisticsPage", import("..NewBattleResultStatisticsPage"))

function NewWorldBossResultStatisticsPage:UpdateGrade()
	LoadImageSpriteAsync("battlescore/grade_label_clear", self.gradeTxt, false)
	setActive(self.gradeIcon, false)
	setActive(self.topPanel:Find("grade/label"), false)

	return
end

function NewWorldBossResultStatisticsPage:LoadBG(arg_2_1)
	LoadAnyAsync("BattleResultItems/" .. "CommonBg", "", nil, function(arg_3_0)
		if self.exited or IsNil(arg_3_0) then
			if arg_2_1 then
				arg_2_1()
			end

			return
		end

		local var_3_0 = Object.Instantiate(arg_3_0, self._tf)

		var_3_0.transform:SetAsFirstSibling()

		self.effectTr = var_3_0.transform

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function NewWorldBossResultStatisticsPage:UpdateOutput(arg_4_1)
	setText(arg_4_1:Find("Text"), self.contextData.statistics.specificDamage)

	return
end

function NewWorldBossResultStatisticsPage:UpdateCommanders(arg_5_1)
	LoadAnyAsync("BattleResultItems/Worldboss", "", nil, function(arg_6_0)
		if self.exited or IsNil(arg_6_0) then
			arg_5_1()

			return
		end

		self:UpdateOutput(Object.Instantiate(arg_6_0, self.topPanel).transform)
		arg_5_1()

		return
	end)

	return
end

function NewWorldBossResultStatisticsPage:UpdatePlayer()
	setActive(self.topPanel:Find("exp"), false)

	return
end

function NewWorldBossResultStatisticsPage:RegisterEvent(arg_8_1)
	NewWorldBossResultStatisticsPage.super.RegisterEvent(self, arg_8_1)
	triggerButton(self.statisticsBtn)
	setActive(self.statisticsBtn, false)

	return
end

function NewWorldBossResultStatisticsPage:UpdatePainting(arg_9_1)
	self:UpdatePaintingPosition()
	self:UpdateMvpPainting(arg_9_1)

	return
end

function NewWorldBossResultStatisticsPage:UpdateChapterName()
	self.chapterName.text = ""

	setActive(self.opBonus, false)

	return
end

return NewWorldBossResultStatisticsPage
