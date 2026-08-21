local var_0_0 = import("game.views.polyhedron.polyhedronBattle.PolyhedronInteractiveView")
local var_0_1 = class("PolyhedronInteractiveHeroView", var_0_0)

function var_0_1.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.m_btn, nil, function()
		local var_2_0 = arg_1_0.polyhedronInfo:GetRewardType()

		if PolyhedronConst.REWARD_TYEP.TEAMMATE == var_2_0 then
			local var_2_1 = arg_1_0.enlistHero.enlist_type
			local var_2_2 = arg_1_0.enlistHero.heroId

			if PolyhedronConst.ENLIST_TYPE.PAY == var_2_1 and PolyhedronHeroCfg[var_2_2].need_coin > arg_1_0.polyhedronInfo:GetCoinCount() then
				ShowTips("POLYHEDRON_INTERACTIVE_HERO_FAIL")

				return
			end

			PolyhedronAction.QueryEnlistHero(arg_1_0.enlistHero)
		else
			DoPolyhedronNextTrigger()
		end
	end)
end

function var_0_1.RefreshUI(arg_3_0)
	arg_3_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	if arg_3_0.index == 0 then
		arg_3_0.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_GIVE_UP_DES")
		arg_3_0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_GIVE_UP_TITLE")
		arg_3_0.enlistHero = {
			heroId = 0,
			enlist_type = PolyhedronConst.ENLIST_TYPE.GIVE_UP
		}
	else
		arg_3_0.enlistHeroList = arg_3_0.polyhedronInfo:GetEnlistHeroList()
		arg_3_0.enlistHero = arg_3_0.enlistHeroList[arg_3_0.index]

		if arg_3_0.enlistHero then
			local var_3_0 = arg_3_0.enlistHero.enlist_type
			local var_3_1 = arg_3_0.enlistHero.heroId

			if PolyhedronConst.ENLIST_TYPE.BATTLE == var_3_0 then
				arg_3_0.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_1")
				arg_3_0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_1")
			elseif PolyhedronConst.ENLIST_TYPE.PAY == var_3_0 then
				local var_3_2 = PolyhedronHeroCfg[var_3_1].need_coin
				local var_3_3 = arg_3_0.polyhedronInfo:GetCoinCount()
				local var_3_4 = var_3_2

				if var_3_3 < var_3_2 then
					var_3_4 = string.format("<color=#F63D2F>%s</color>", var_3_2)
				end

				arg_3_0.m_des.text = string.format(GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_2"), var_3_4)
				arg_3_0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_2")
			else
				arg_3_0.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_3")
				arg_3_0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_3")
			end
		else
			arg_3_0.m_des.text = "error"
			arg_3_0.m_btnLab.text = ""
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_contentTrs)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_desTrs)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_contentTrs)
	end, {})
end

return var_0_1
