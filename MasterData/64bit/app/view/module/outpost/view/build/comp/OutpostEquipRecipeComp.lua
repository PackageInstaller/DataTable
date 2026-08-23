local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEquipRecipeComp = class("OutpostEquipRecipeComp", require("app.fairyGUI.outpost.UI_OutpostEquipRecipeComp"))

function OutpostEquipRecipeComp:ctor()
	self.getSharedTrans(self, "enter_scaleOut", "CommonCardCellList", self)
end

function OutpostEquipRecipeComp:updateRecipeComp(arg_2_1)
	local var_2_0 = arg_2_1:getCfg()
	local var_2_1 = {
		res = g.core.common.Path:getOutpostEquipBookIcon(var_2_0.drawing_res),
		name = var_2_0.name,
		quality = var_2_0.quality
	}

	if var_2_0.equip_type ~= var_0_0.EquipType.ARMS then
		self.m_equip:setVisible(false)
	else
		self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. var_2_0.profession)
		self.m_equip:setVisible(true)
	end

	self.m_itemComp:updateItemCell(var_2_1)
	self.m_starComp:initStar({
		gap = -20,
		style = 1,
		index = arg_2_1:getStarIndex(),
		num = arg_2_1:getStar()
	})
end

return OutpostEquipRecipeComp
