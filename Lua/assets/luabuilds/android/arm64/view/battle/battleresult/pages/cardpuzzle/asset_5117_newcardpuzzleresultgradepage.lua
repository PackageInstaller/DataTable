local NewCardPuzzleResultGradePage = class("NewCardPuzzleResultGradePage", import("..NewBattleResultGradePage"))

function NewCardPuzzleResultGradePage:LoadBG(arg_1_1)
	LoadAnyAsync("BattleResultItems/" .. "CommonBg", "", nil, function(arg_2_0)
		if self.exited or IsNil(arg_2_0) then
			if arg_1_1 then
				arg_1_1()
			end

			return
		end

		Object.Instantiate(arg_2_0, self.bgTr).transform:SetAsFirstSibling()

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function NewCardPuzzleResultGradePage:LoadGrade(arg_3_1)
	local var_3_0, var_3_1 = NewBattleResultUtil.Score2Grade(self.contextData.score)

	LoadImageSpriteAsync(var_3_0, self.gradeIcon, true)
	LoadImageSpriteAsync(var_3_1, self.gradeTxt, true)

	if arg_3_1 then
		arg_3_1()
	end

	return
end

function NewCardPuzzleResultGradePage:SetUp(arg_4_1)
	self:Show()
	seriesAsync({
		function(arg_5_0)
			self:LoadBGAndGrade(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:PlayEnterAnimation(arg_6_0)

			return
		end,
		function(arg_7_0)
			self:RegisterEvent(arg_7_0)

			return
		end
	}, function()
		self:Clear()
		self:Destroy()
		arg_4_1()

		return
	end)

	return
end

return NewCardPuzzleResultGradePage
