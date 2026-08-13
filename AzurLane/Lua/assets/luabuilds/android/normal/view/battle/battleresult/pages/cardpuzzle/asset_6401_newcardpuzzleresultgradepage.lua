class = var_0_10000

local var_0_0 = "NewCardPuzzleResultGradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultGradePage"))

function var_0_1.LoadBG(arg_1_0, arg_1_1)
	local var_1_0 = "CommonBg"

	LoadAnyAsync = var_1_10003

	var_1_10003("BattleResultItems/" .. var_1_0, "", nil, function(arg_2_0)
		if not arg_1_0.exited then
			IsNil = var_1

			if var_1(arg_2_0) then
				if arg_1_1 then
					arg_1_1()
				end

				return
			end

			Object = var_1

			local var_2_0 = var_1.Instantiate(arg_2_0, arg_1_0.bgTr).transform

			var_2.SetAsFirstSibling(var_2_0)

			if arg_1_1 then
				arg_1_1()
			end

			return
		end
	end)

	return
end

function var_0_1.LoadGrade(arg_3_0, arg_3_1)
	NewBattleResultUtil = var_1_10002

	local var_3_0, var_3_1 = var_1_10002.Score2Grade(arg_3_0.contextData.score)

	LoadImageSpriteAsync = var_1_10004

	var_1_10004(var_3_0, arg_3_0.gradeIcon, true)

	LoadImageSpriteAsync = var_1_10004

	var_1_10004(var_3_1, arg_3_0.gradeTxt, true)

	if arg_3_1 then
		arg_3_1()
	end

	return
end

function var_0_1.SetUp(arg_4_0, arg_4_1)
	arg_4_0:Show()

	seriesAsync = var_2

	var_2({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.LoadBGAndGrade(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.PlayEnterAnimation(var_6_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_4_0

			var_1.RegisterEvent(var_7_0, arg_7_0)

			return
		end
	}, function()
		local var_8_0 = arg_4_0

		var_0.Clear(var_8_0)

		local var_8_1 = arg_4_0

		var_0.Destroy(var_8_1)
		arg_4_1()

		return
	end)

	return
end

return var_0_1
