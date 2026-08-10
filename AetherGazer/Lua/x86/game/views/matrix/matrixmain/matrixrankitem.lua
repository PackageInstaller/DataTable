local var_0_0 = class("MatrixRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.heroCountController_ = ControllerUtil.GetController(arg_2_0.transform_, "heroCount")
	arg_2_0.rankController_ = ControllerUtil.GetController(arg_2_0.transform_, "rank")
end

function var_0_0.Refresh(arg_3_0, arg_3_1)
	arg_3_0.user_id = arg_3_1.user_id
	arg_3_0.m_rankText.text = arg_3_1.rank
	arg_3_0.m_scoreText.text = arg_3_1.score
	arg_3_0.m_difficultyText.text = arg_3_1.difficulty

	local var_3_0 = arg_3_1.select_hero_id_list
	local var_3_1 = math.min(table.length(var_3_0), 3)

	arg_3_0.heroCountController_:SetSelectedIndex(var_3_1)

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = var_3_0[iter_3_0]
		local var_3_3 = HeroStandardSystemCfg[var_3_2.id]

		if var_3_3 then
			local var_3_4 = var_3_3.hero_id
			local var_3_5 = var_3_2.skin_id

			if var_3_5 == 0 then
				var_3_5 = var_3_4
			end

			arg_3_0["m_heroIcon_" .. iter_3_0].sprite = getSpriteViaConfig("HeroLittleIcon", SkinCfg[var_3_5].picture_id)
		end
	end

	if arg_3_1.rank <= 3 then
		arg_3_0.rankController_:SetSelectedIndex(arg_3_1.rank)
	else
		arg_3_0.rankController_:SetSelectedIndex(0)
	end

	arg_3_0.m_name.text = GetI18NText(arg_3_1.nick)
	arg_3_0.m_icon.sprite = ItemTools.getItemSprite(arg_3_1.icon)
	arg_3_0.m_frame.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_3_1.icon_frame)
end

return var_0_0
