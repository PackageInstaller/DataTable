local CultivatePassCardBigCell = class("CultivatePassCardBigCell", require("app.fairyGUI.cultivate.UI_CultivatePassCardBigCell"))

function CultivatePassCardBigCell:ctor()
	self:addClickListener(handler(self, self.onClick))
end

function CultivatePassCardBigCell:onClick()
	if not self._item then
		return
	end

	local var_2_0 = clone(self._item)

	var_2_0.component = self

	g.core.common.GlobalFunc.pushInfoPop(var_2_0)
end

function CultivatePassCardBigCell:updateBigReward(arg_3_1, arg_3_2)
	self._item = arg_3_1
	self._actData = g.core.model.User.cultivateDataMgr:getCultivateData(arg_3_2)

	local var_3_0 = g.core.model.User.cultivateDataMgr:getResDirId(arg_3_2)

	if not self._actData:isWitchActivity() then
		self.m_itemBgLoader:setURL(g.core.common.Path:getCultivateImage("pic_zl_jianglidi1", var_3_0))
	else
		self.m_itemBgLoader:setURL(g.core.common.Path:getCultivateImage("pic_mnzj_jianglidi1", var_3_0))
	end

	self.m_itemIcon:setURL(arg_3_1.icon)
	self.m_numTxt:setText(arg_3_1.size)
	self.m_qualityLoader:setURL(g.core.common.Path:getCultivateImage("pic_pinzhi_" .. arg_3_1.quality + 1, var_3_0))
	self.m_nameTxt:setText(arg_3_1.name)
	self.m_lockNameTxt:setText(arg_3_1.mark)
	self.m_colorController:setSelectedIndex(g.core.config.cultivate_activity_display_info.get(arg_3_2).color_item - 1)
end

return CultivatePassCardBigCell
