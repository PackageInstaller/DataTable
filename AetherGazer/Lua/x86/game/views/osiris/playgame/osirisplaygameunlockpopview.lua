local var_0_0 = class("OsirisPlayGameUnlockPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_UnlockPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tagCon_ = arg_4_0.tyoeConEx_:GetController("type")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroId = arg_7_0.params_.heroId

	for iter_7_0 = 1, 3 do
		SetActive(arg_7_0["genGo_" .. iter_7_0], false)
	end

	arg_7_0:RefreshView()
end

function var_0_0.RefreshView(arg_8_0)
	local var_8_0 = ActivityGeneralityCharactorCfg[arg_8_0.heroId]

	arg_8_0.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_8_0.heroId)

	local var_8_1 = HeroCfg[arg_8_0.heroId]

	arg_8_0.campImg_.sprite = getSprite("Atlas/SystemGroupAtlas", string.format("com_white_icon_group_%s_c", var_8_1.race))
	arg_8_0.typeText_.text = var_8_0.charactor_type == 1 and GetTips("IS_CAPTAIN") or GetTips("IS_SUPPORT")

	arg_8_0.tagCon_:SetSelectedIndex(var_8_0.charactor_type == 1 and 1 or 0)

	arg_8_0.nameText_.text = GetI18NText(var_8_1.name)
	arg_8_0.sufffixText_.text = GetI18NText(var_8_1.suffix)

	local var_8_2 = var_8_0.generality

	for iter_8_0 = 1, #var_8_2 do
		SetActive(arg_8_0["genGo_" .. iter_8_0], true)

		arg_8_0["genImg_" .. iter_8_0].sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_8_2[iter_8_0])
		arg_8_0["tagText_" .. iter_8_0].text = ActivityGeneralityTagCfg[var_8_2[iter_8_0]].name
	end

	if var_8_0.qte_skill ~= 0 then
		SetActive(arg_8_0.supportGo_, true)

		local var_8_3 = ActivityGeneralityQteCfg[var_8_0.qte_skill].icon

		arg_8_0.supportImg_.sprite = getSprite("Atlas/" .. arg_8_0.heroId, var_8_3)
		arg_8_0.skillDesc_.text = GetI18NText(ActivityGeneralityQteCfg[var_8_0.qte_skill] and ActivityGeneralityQteCfg[var_8_0.qte_skill].desc or "")
	else
		SetActive(arg_8_0.supportGo_, false)
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
