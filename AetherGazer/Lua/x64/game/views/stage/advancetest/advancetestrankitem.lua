local var_0_0 = class("AdvanceTestRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddListeners()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)
	arg_2_0.rankController_ = arg_2_0.conExCollection_:GetController("rank")
	arg_2_0.heroCountController_ = arg_2_0.conExCollection_:GetController("heroCount")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_lookBtn, nil, function()
		JumpTools.OpenPageByJump("coreVerificationChallengeTeamCheckView", {
			notCoreCl = true,
			dataList = arg_3_0.otherInfoData
		})
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.user_id = arg_5_1.user_id
	arg_5_0.rankText_.text = arg_5_1.rank
	arg_5_0.scoreText_.text = arg_5_1.score

	if arg_5_1.rank <= 3 then
		arg_5_0.rankController_:SetSelectedIndex(arg_5_1.rank)
	else
		arg_5_0.rankController_:SetSelectedIndex(0)
	end

	arg_5_0.name_ = arg_5_1.nick
	arg_5_0.nickText_.text = arg_5_1.nick

	arg_5_0.commonPortrait_:RenderHead(arg_5_1.portrait)
	arg_5_0.commonPortrait_:RenderFrame(arg_5_1.frame)

	if arg_5_2 <= 3 then
		local var_5_0 = arg_5_1:GetSingleSelectHeroList()
		local var_5_1 = math.min(#var_5_0, 3)

		arg_5_0.heroCountController_:SetSelectedIndex(var_5_1)

		for iter_5_0 = 1, var_5_1 do
			local var_5_2 = var_5_0[iter_5_0].skin_id

			if var_5_2 == 0 then
				var_5_2 = var_5_0[iter_5_0].hero_id
			end

			arg_5_0["heroImg_" .. iter_5_0].sprite = getSpriteViaConfig("HeroItemshead", var_5_2)
		end
	else
		arg_5_0.heroCountController_:SetSelectedIndex(4)

		local var_5_3 = {}

		if arg_5_1.extraInfo then
			for iter_5_1, iter_5_2 in pairs(arg_5_1.extraInfo) do
				local var_5_4 = {
					id = iter_5_2,
					lv = ActivityAffixPoolCfg[iter_5_2] and ActivityAffixPoolCfg[iter_5_2].affix[2] or 0
				}

				table.insert(var_5_3, var_5_4)
			end
		end

		local var_5_5 = {}
		local var_5_6 = arg_5_1:GetSingleSelectHeroList()

		for iter_5_3, iter_5_4 in pairs(var_5_6) do
			table.insert(var_5_5, iter_5_4.skin_id == 0 and skin_id or iter_5_4.hero_id)
		end

		arg_5_0.otherInfoData = {
			{
				hero_list = var_5_5,
				affix_list = var_5_3
			}
		}
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
