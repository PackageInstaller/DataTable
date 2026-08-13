class = var_0_10000

local var_0_0 = "NewWorldBossResultStatisticsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultStatisticsPage"))

function var_0_1.UpdateGrade(arg_1_0)
	local var_1_0 = "battlescore/grade_label_clear"

	LoadImageSpriteAsync = var_1_10002

	var_1_10002(var_1_0, arg_1_0.gradeTxt, false)

	setActive = var_1_10002

	var_1_10002(arg_1_0.gradeIcon, false)

	setActive = var_1_10002

	local var_1_1 = arg_1_0.topPanel

	var_1_10002(var_3.Find(var_1_1, "grade/label"), false)

	return
end

function var_0_1.LoadBG(arg_2_0, arg_2_1)
	local var_2_0 = "CommonBg"

	LoadAnyAsync = var_1_10003

	var_1_10003("BattleResultItems/" .. var_2_0, "", nil, function(arg_3_0)
		if not arg_2_0.exited then
			IsNil = var_1

			if var_1(arg_3_0) then
				if arg_2_1 then
					arg_2_1()
				end

				return
			end

			Object = var_1

			local var_3_0 = var_1.Instantiate(arg_3_0, arg_2_0._tf).transform

			var_2.SetAsFirstSibling(var_3_0)

			arg_2_0.effectTr = var_1.transform

			if arg_2_1 then
				arg_2_1()
			end

			return
		end
	end)

	return
end

function var_0_1.UpdateOutput(arg_4_0, arg_4_1)
	setText = var_1_10002

	var_1_10002(arg_4_1:Find("Text"), arg_4_0.contextData.statistics.specificDamage)

	return
end

function var_0_1.UpdateCommanders(arg_5_0, arg_5_1)
	LoadAnyAsync = var_1_10002

	var_1_10002("BattleResultItems/Worldboss", "", nil, function(arg_6_0)
		if not arg_5_0.exited then
			IsNil = var_1

			if var_1(arg_6_0) then
				arg_5_1()

				return
			end

			Object = var_1

			local var_6_0 = var_1.Instantiate(arg_6_0, arg_5_0.topPanel)
			local var_6_1 = arg_5_0

			var_2.UpdateOutput(var_6_1, var_6_0.transform)
			arg_5_1()

			return
		end
	end)

	return
end

function var_0_1.UpdatePlayer(arg_7_0)
	setActive = var_1_10001

	local var_7_0 = arg_7_0.topPanel

	var_1_10001(var_2.Find(var_7_0, "exp"), false)

	return
end

function var_0_1.RegisterEvent(arg_8_0, arg_8_1)
	var_0_1.super.RegisterEvent(arg_8_0, arg_8_1)

	triggerButton = var_2

	var_2(arg_8_0.statisticsBtn)

	setActive = var_2

	var_2(arg_8_0.statisticsBtn, false)

	return
end

function var_0_1.UpdatePainting(arg_9_0, arg_9_1)
	arg_9_0:UpdatePaintingPosition()
	arg_9_0:UpdateMvpPainting(arg_9_1)

	return
end

function var_0_1.UpdateChapterName(arg_10_0)
	local var_10_0 = arg_10_0.chapterName

	var_10_0.text = ""
	setActive = var_10_0

	var_10_0(arg_10_0.opBonus, false)

	return
end

return var_0_1
