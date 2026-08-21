local var_0_0 = class("NewCardPuzzleResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.LoadBG(arg_1_0, arg_1_1)
	LoadAnyAsync("BattleResultItems/" .. "CommonBg", "", nil, function(arg_2_0)
		if arg_1_0.exited or IsNil(arg_2_0) then
			if arg_1_1 then
				arg_1_1()
			end

			return
		end

		Object.Instantiate(arg_2_0, arg_1_0.bgTr).transform:SetAsFirstSibling()

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function var_0_0.LoadGrade(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = NewBattleResultUtil.Score2Grade(arg_3_0.contextData.score)

	LoadImageSpriteAsync(var_3_0, arg_3_0.gradeIcon, true)
	LoadImageSpriteAsync(var_3_1, arg_3_0.gradeTxt, true)

	if arg_3_1 then
		arg_3_1()
	end

	return
end

function var_0_0.SetUp(arg_4_0, arg_4_1)
	arg_4_0:Show()
	seriesAsync({
		function(arg_5_0)
			arg_4_0:LoadBGAndGrade(arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_4_0:PlayEnterAnimation(arg_6_0)

			return
		end,
		function(arg_7_0)
			arg_4_0:RegisterEvent(arg_7_0)

			return
		end
	}, function()
		arg_4_0:Clear()
		arg_4_0:Destroy()
		arg_4_1()

		return
	end)

	return
end

return var_0_0
