local PolyhedronInteractiveShopView = class("PolyhedronInteractiveShopView", (import("game.views.polyhedron.polyhedronBattle.PolyhedronInteractiveView")))

function PolyhedronInteractiveShopView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		JumpTools.OpenPageByJump("polyhedronBattle/polyhedronShop")
		LuaForCursor.SwitchCursor(true)
	end)
end

function PolyhedronInteractiveShopView:RefreshUI()
	self.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_SHOP_DES")
	self.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_SHOP_TITLE")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)
	end, {})
end

return PolyhedronInteractiveShopView
