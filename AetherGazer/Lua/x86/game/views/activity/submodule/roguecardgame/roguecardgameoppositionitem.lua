local var_0_0 = class("RogueCardGameOppositionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.lockCon_ = arg_3_0.controller_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.lockBtn_, nil, function()
		ShowTips("ROGUE_CARD_COLLECT_BOSS_EFFECT_LOCKED_TIPS")
	end)
	arg_4_0:AddBtnListener(arg_4_0.unlockBtn_, nil, function()
		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, false)
		RogueCardGameData:SetIllustratedRedPoint_Weal(arg_4_0.id)
	end)
end

function var_0_0.RefreshData(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1
	arg_7_0.cfg = RogueCardBossEffectCfg[arg_7_1]

	if RogueCardGameTools.IsUnlockWealWoeById(arg_7_0.id) then
		arg_7_0.lockCon_:SetSelectedIndex(1)
		RichTextTools.SetMixedTextWithImage(arg_7_0.desc_, GetI18NText(arg_7_0.cfg.desc))

		arg_7_0.desc_.text = GetI18NText(arg_7_0.cfg.desc)

		manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, RogueCardGameData:GetIllustratedRedPoint_Weal(arg_7_1))
	else
		arg_7_0.lockCon_:SetSelectedIndex(0)

		arg_7_0.desc_.text = GetTips("CAPTURE_GAME_PRE_SECTION_UNREACHED_SMALL")

		manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, false)
	end
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)

	arg_9_0.gameObject_ = nil
	arg_9_0.transform_ = nil
end

return var_0_0
