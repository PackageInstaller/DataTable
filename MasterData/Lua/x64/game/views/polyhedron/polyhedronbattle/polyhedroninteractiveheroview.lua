local PolyhedronInteractiveHeroView = class("PolyhedronInteractiveHeroView", (import("game.views.polyhedron.polyhedronBattle.PolyhedronInteractiveView")))

function PolyhedronInteractiveHeroView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if PolyhedronConst.REWARD_TYEP.TEAMMATE == self.polyhedronInfo:GetRewardType() then
			if PolyhedronConst.ENLIST_TYPE.PAY == self.enlistHero.enlist_type and PolyhedronHeroCfg[self.enlistHero.heroId].need_coin > self.polyhedronInfo:GetCoinCount() then
				ShowTips("POLYHEDRON_INTERACTIVE_HERO_FAIL")

				return
			end

			PolyhedronAction.QueryEnlistHero(self.enlistHero)
		else
			DoPolyhedronNextTrigger()
		end
	end)
end

function PolyhedronInteractiveHeroView:RefreshUI()
	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	if self.index == 0 then
		self.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_GIVE_UP_DES")
		self.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_GIVE_UP_TITLE")
		self.enlistHero = {
			heroId = 0,
			enlist_type = PolyhedronConst.ENLIST_TYPE.GIVE_UP
		}
	else
		self.enlistHeroList = self.polyhedronInfo:GetEnlistHeroList()
		self.enlistHero = self.enlistHeroList[self.index]

		if self.enlistHero then
			if PolyhedronConst.ENLIST_TYPE.BATTLE == self.enlistHero.enlist_type then
				self.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_1")
				self.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_1")
			elseif PolyhedronConst.ENLIST_TYPE.PAY == self.enlistHero.enlist_type then
				self.m_des.text = string.format(GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_2"), (self.polyhedronInfo:GetCoinCount() < PolyhedronHeroCfg[self.enlistHero.heroId].need_coin or nil) and string.format("<color=#F63D2F>%s</color>", PolyhedronHeroCfg[self.enlistHero.heroId].need_coin))
				self.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_2")
			else
				self.m_des.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_DES_3")
				self.m_btnLab.text = GetTips("POLYHEDRON_INTERACTIVE_HERO_TITLE_3")
			end
		else
			self.m_des.text = "error"
			self.m_btnLab.text = ""
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)
	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)
	end, {})
end

return PolyhedronInteractiveHeroView
