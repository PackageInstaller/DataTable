local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = {
	[g.core.const.ConstMgr.outpostConst.EquipType.ARMS] = {
		"ui://outpost/pic_hxsz_wuqi2_k",
		"ui://outpost/pic_hxsz_wuqi1_k",
		"ui://outpost/pic_hxsz_wuqi3_k"
	},
	[g.core.const.ConstMgr.outpostConst.EquipType.UPPER_BODY_ARMOR] = "ui://outpost/pic_hxsz_shangyi_k",
	[g.core.const.ConstMgr.outpostConst.EquipType.LOWER_BODY_ARMOR] = "ui://outpost/pic_hxsz_xiezi_k"
}
local OutpostEquipIcon = class("OutpostEquipIcon", require("app.fairyGUI.outpost.UI_OutpostEquipIcon"))

function OutpostEquipIcon:updateEquip(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_1 then
		self.m_quality:setURL(g.core.common.Path:getQualityLineByQuality(arg_1_1:getQuality() + 1))
		self.m_equipIcon:setURL(g.core.common.Path:getOutpostEquipIcon(arg_1_1:getItemInfo().icon))
		self.m_starComp:initStar({
			gap = -7,
			style = 1,
			index = arg_1_1:getStarIndex(),
			num = arg_1_1:getStar()
		})
		self.m_showStarController:setSelectedIndex(0)

		if arg_1_1:getCfg().equip_type ~= var_0_0.EquipType.ARMS then
			self.m_equip:setVisible(false)
		else
			self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. arg_1_1:getCfg().profession)
			self.m_equip:setVisible(true)
		end
	else
		self.m_quality:setURL(g.core.common.Path:getQualityLineByQuality(1))

		if var_0_0.EquipType.ARMS == arg_1_2 then
			self.m_equipIcon:setURL(var_0_1[arg_1_2][arg_1_3 or 1])
		else
			self.m_equipIcon:setURL(var_0_1[arg_1_2])
		end

		self.m_showStarController:setSelectedIndex(1)
		self.m_equip:setVisible(false)
	end
end

function OutpostEquipIcon:setStarCompVisible(arg_2_1)
	self.m_starComp:setVisible(arg_2_1)
end

return OutpostEquipIcon
