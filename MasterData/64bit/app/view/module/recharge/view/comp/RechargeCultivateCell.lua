local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_1 = g.core.model.User.cultivateDataMgr
local RechargeCultivateCell = class("RechargeCultivateCell", require("app.fairyGUI.shop.UI_ShopCultivateGiftCell"))

function RechargeCultivateCell:updateCellItemByAct(arg_1_1)
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(g.core.config.cultivate_activity_display_info.get(arg_1_1).color_time)))

	self._actData = var_0_1:getCultivateData(arg_1_1)

	local var_1_0 = var_0_1:getResDirId(arg_1_1)

	if self._actData:getActivityCfg().type == CultivateConst.ACTIVITY_TYPE.WITCH then
		self.m_unbuyLoader:setURL("ui://shop/btn_mnzj_goumai2")
		self.m_canbuyLoader:setURL("ui://shop/btn_mnzj_goumai1")
		self.m_bgLoader:setURL(g.core.common.Path:getCultivateImage("bg_mnzj_libaodi", var_1_0))
	else
		self.m_unbuyLoader:setURL("ui://shop/btn_xbrc_goumai2")
		self.m_canbuyLoader:setURL("ui://shop/btn_xbrc_goumai1")
		self.m_bgLoader:setURL(g.core.common.Path:getCultivateImage("bg_libaodi", var_1_0))
	end
end

return RechargeCultivateCell
