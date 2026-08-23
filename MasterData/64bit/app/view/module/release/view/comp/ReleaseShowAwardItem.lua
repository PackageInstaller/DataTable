local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local ReleaseShowAwardItem = class("ReleaseShowAwardItem", require("app.fairyGUI.release.UI_ReleaseShowAwardItem"))

function ReleaseShowAwardItem:updateShowItem(arg_1_1)
	self.m_enterTransition:play()

	self._goods = g.core.common.Goods:convert(arg_1_1)

	if self._goods then
		self.m_nameTxt:setText(self._goods.name)
		self.m_itemIcon:setURL(self._goods.icon)
		self.m_numTxt:setText(arg_1_1.size)
		self.m_itemQualityLoader:setURL("ui://release/pic_zm_pinzhiwp_" .. self._goods.quality + 1)

		if self._goods.quality >= var_0_0.SR then
			self.m_eff_fag_enter_holder:addEffectSpine({
				isLoop = false,
				name = "eff_ui_release_rewardresult",
				anim = "play_" .. self._goods.quality + 1
			})
			self.m_eff_item_idel_holder:addEffectSpine({
				isLoop = true,
				anim = "play",
				name = "eff_ui_recruitUniteToken_frag_" .. self._goods.quality + 1
			})
		end
	end
end

return ReleaseShowAwardItem
