local var_0_0 = g.core.model.User.recruitData
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.common.Path
local DailyRecruitPreviewCell = class("DailyRecruitPreviewCell", require("app.fairyGUI.recruitDaily.UI_DailyRecruitPreviewCell"))

function DailyRecruitPreviewCell:ctor()
	self._showItemList = {}

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
end

function DailyRecruitPreviewCell:_onItemRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateItemByInfo(self._showItemList[arg_2_1 + 1])
end

function DailyRecruitPreviewCell:updatePreviewCell(arg_3_1, arg_3_2)
	self._showItemList = arg_3_2 or {}

	self.m_itemList:setNumItems(#self._showItemList)
	self.m_itemList:resizeToFit(#self._showItemList)
	self.m_qualityIcon:setURL(var_0_2:getQualityArtTxtURLNew(arg_3_1))
	self.m_title:setText(g.core.lang:get(410001, {
		num = self:getTitleNum(arg_3_1)
	}))
end

function DailyRecruitPreviewCell:getTitleNum(arg_4_1)
	local var_4_0 = 0

	if arg_4_1 == var_0_1.R then
		var_4_0 = var_0_0:getDailyRecruitInfo().r_rate
	elseif arg_4_1 == var_0_1.SR then
		var_4_0 = var_0_0:getDailyRecruitInfo().sr_rate
	elseif arg_4_1 == var_0_1.SSR then
		var_4_0 = var_0_0:getDailyRecruitInfo().ssr_rate
	elseif arg_4_1 == var_0_1.UR then
		var_4_0 = var_0_0:getDailyRecruitInfo().ur_rate
	end

	return var_4_0 * 0.1
end

return DailyRecruitPreviewCell
