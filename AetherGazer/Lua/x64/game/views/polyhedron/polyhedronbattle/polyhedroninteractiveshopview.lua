local var_0_0 = import("game.views.polyhedron.polyhedronBattle.PolyhedronInteractiveView")
local var_0_1 = class("PolyhedronInteractiveShopView", var_0_0)

function var_0_1.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.m_btn, nil, function()
		JumpTools.OpenPageByJump("polyhedronBattle/polyhedronShop")
		LuaForCursor.SwitchCursor(true)
	end)
end

function var_0_1.RefreshUI(arg_3_0)
	arg_3_0.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_SHOP_DES")
	arg_3_0.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_SHOP_TITLE")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_contentTrs)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_desTrs)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_contentTrs)
	end, {})
end

return var_0_1
