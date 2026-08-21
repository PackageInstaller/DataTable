local var_0_0 = class("NewWorldBossResultStatisticsPage", import("..NewBattleResultStatisticsPage"))

function var_0_0.UpdateGrade(arg_1_0)
	LoadImageSpriteAsync("battlescore/grade_label_clear", arg_1_0.gradeTxt, false)
	setActive(arg_1_0.gradeIcon, false)
	setActive(arg_1_0.topPanel:Find("grade/label"), false)

	return
end

function var_0_0.LoadBG(arg_2_0, arg_2_1)
	LoadAnyAsync("BattleResultItems/" .. "CommonBg", "", nil, function(arg_3_0)
		if arg_2_0.exited or IsNil(arg_3_0) then
			if arg_2_1 then
				arg_2_1()
			end

			return
		end

		local var_3_0 = Object.Instantiate(arg_3_0, arg_2_0._tf)

		var_3_0.transform:SetAsFirstSibling()

		arg_2_0.effectTr = var_3_0.transform

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function var_0_0.UpdateOutput(arg_4_0, arg_4_1)
	setText(arg_4_1:Find("Text"), arg_4_0.contextData.statistics.specificDamage)

	return
end

function var_0_0.UpdateCommanders(arg_5_0, arg_5_1)
	LoadAnyAsync("BattleResultItems/Worldboss", "", nil, function(arg_6_0)
		if arg_5_0.exited or IsNil(arg_6_0) then
			arg_5_1()

			return
		end

		arg_5_0:UpdateOutput(Object.Instantiate(arg_6_0, arg_5_0.topPanel).transform)
		arg_5_1()

		return
	end)

	return
end

function var_0_0.UpdatePlayer(arg_7_0)
	setActive(arg_7_0.topPanel:Find("exp"), false)

	return
end

function var_0_0.RegisterEvent(arg_8_0, arg_8_1)
	var_0_0.super.RegisterEvent(arg_8_0, arg_8_1)
	triggerButton(arg_8_0.statisticsBtn)
	setActive(arg_8_0.statisticsBtn, false)

	return
end

function var_0_0.UpdatePainting(arg_9_0, arg_9_1)
	arg_9_0:UpdatePaintingPosition()
	arg_9_0:UpdateMvpPainting(arg_9_1)

	return
end

function var_0_0.UpdateChapterName(arg_10_0)
	arg_10_0.chapterName.text = ""

	setActive(arg_10_0.opBonus, false)

	return
end

return var_0_0
