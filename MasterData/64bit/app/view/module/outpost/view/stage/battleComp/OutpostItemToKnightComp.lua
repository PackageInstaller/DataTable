local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.config.outpost_item_info
local OutpostItemToKnightComp = class("OutpostItemToKnightComp", require("app.fairyGUI.outpost.UI_OutpostItemToKnightComp"))

function OutpostItemToKnightComp:showItem(arg_1_1)
	local var_1_0 = var_0_2.get(arg_1_1.item_id)

	self.m_bgLoader:setURL(var_0_1:getOutpostItemQualityBg(var_1_0.quality))
	self.m_itemIcon:setURL(var_0_1:getOutpostItemIcon(var_1_0.icon, true))
end

function OutpostItemToKnightComp:getEntityType()
	return var_0_0.ShowType.ItemToKnight
end

function OutpostItemToKnightComp:playDropInFloor()
	self.m_dropTransition:play()
end

return OutpostItemToKnightComp
