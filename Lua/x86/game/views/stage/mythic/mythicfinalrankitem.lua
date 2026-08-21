local var_0_0 = class("MythicFinalRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()

	arg_1_0.commonPortrait_ = CommonHeadPortrait.New(arg_1_0.headItem_)

	arg_1_0:AddListeners()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rankController_ = arg_2_0.conExCollection_:GetController("rank")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("mythicFinalRankHeroView", {
			herolist = arg_3_0.team_list_,
			name = arg_3_0.name_,
			userID = arg_3_0.user_id
		})
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	arg_5_0.user_id = arg_5_1.user_id
	arg_5_0.rankText_.text = arg_5_1.rank
	arg_5_0.scoreText_.text = arg_5_1.score
	arg_5_0.layerText_.text = arg_5_1.difficulty

	if arg_5_1.rank <= 3 then
		arg_5_0.rankController_:SetSelectedIndex(arg_5_1.rank)
	else
		arg_5_0.rankController_:SetSelectedIndex(0)
	end

	arg_5_0.name_ = arg_5_1.nick
	arg_5_0.nickText_.text = arg_5_1.nick

	arg_5_0.commonPortrait_:RenderHead(arg_5_1.portrait)
	arg_5_0.commonPortrait_:RenderFrame(arg_5_1.frame)

	arg_5_0.team_list_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.stage_team_list[0]) do
		arg_5_0.team_list_[iter_5_0] = {}

		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			table.insert(arg_5_0.team_list_[iter_5_0], {
				id = iter_5_3.hero_id,
				skin_id = iter_5_3.skin_id
			})
		end
	end
end

function firstLargeSize(arg_6_0, arg_6_1)
	if #arg_6_0 <= 0 then
		return arg_6_0
	end

	local var_6_0, var_6_1, var_6_2, var_6_3 = string.find(arg_6_0, "<(.-)>(.+)")

	var_6_3 = var_6_3 or arg_6_0

	local var_6_4 = {
		"“",
		"《"
	}
	local var_6_5 = 0
	local var_6_6

	for iter_6_0 = 1, var_6_3:getWCharCount() do
		local var_6_7 = var_6_3:getWChar(iter_6_0)

		if table.indexOf(var_6_4, var_6_7) == -1 then
			local var_6_8 = string.sub(var_6_3, 1, var_6_5)

			var_6_5 = var_6_5 + string.len(var_6_7)

			local var_6_9 = string.sub(var_6_3, var_6_5 + 1, -1)

			var_6_6 = string.format("%s<size=%d>%s</size>%s", var_6_8, arg_6_1, var_6_7, var_6_9)

			break
		else
			var_6_5 = var_6_5 + string.len(var_6_7)
		end
	end

	if not var_6_6 then
		return arg_6_0
	end

	if var_6_2 then
		var_6_6 = string.format("<%s>%s", var_6_2, var_6_6)
	end

	return var_6_6
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
