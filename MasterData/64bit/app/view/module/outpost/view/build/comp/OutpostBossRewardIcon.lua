local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBossRewardIcon = class("OutpostBossRewardIcon", require("app.fairyGUI.outpost.UI_OutpostBossRewardIcon"))

function OutpostBossRewardIcon:updateBossRewardIcon(arg_1_1)
	if arg_1_1.type == var_0_0.EXCHANGE_ITEM_TYPE then
		self.m_outpostIcon:updateItemIcon({
			item_id = arg_1_1.value,
			item_num = arg_1_1.size
		})
		self.m_outpostIcon:setVisible(true)
		self.m_baseIcon:setVisible(false)
	else
		self.m_baseIcon:updateIcon(arg_1_1)
		self.m_baseIcon:setVisible(true)
		self.m_outpostIcon:setVisible(false)
	end

	if arg_1_1.pro then
		self.m_proTxt:setText(g.core.lang:get(2073, {
			num = math.floor(arg_1_1.pro / 100)
		}))
		self.m_isHideProController:setSelectedIndex(0)
	elseif arg_1_1.tagStr then
		self.m_proTxt:setText(arg_1_1.tagStr)
		self.m_isHideProController:setSelectedIndex(0)
	else
		self.m_isHideProController:setSelectedIndex(1)
	end
end

return OutpostBossRewardIcon
