local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_2 = g.core.common.Path
local CultivatePassCardItem = class("CultivatePassCardItem", require("app.fairyGUI.cultivate.UI_CultivatePassCardItem"))

function CultivatePassCardItem:ctor()
	self:addClickListener(handler(self, self.onClick))
end

function CultivatePassCardItem:setUnClickSelfEvent(arg_2_1)
	self._isUnClick = arg_2_1
end

function CultivatePassCardItem:onClick()
	if self._state == 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(421414))
	else
		if self._isUnClick then
			return
		end

		self:showGetTip()
	end
end

function CultivatePassCardItem:showGetTip()
	if not self._item then
		return
	end

	local var_4_0 = clone(self._item)

	var_4_0.component = self

	g.core.common.GlobalFunc.pushInfoPop(var_4_0)
end

function CultivatePassCardItem:updateCultivatePassItem(arg_5_1, arg_5_2)
	self._item = arg_5_1
	self._actData = g.core.model.User.cultivateDataMgr:getCultivateData(arg_5_2)

	local var_5_0 = g.core.model.User.cultivateDataMgr:getResDirId(arg_5_2)

	if not self._actData:isWitchActivity() then
		self.m_itemIconBg:setURL(var_0_2:getCultivateImage("pic_zl_jianglidi2", var_5_0))
		self.m_receiveLoader:setURL(var_0_2:getCultivateImage("pic_yilingqu", var_5_0))
		self.m_canReceiveLoader:setURL(var_0_2:getCultivateImage("pic_kelingqu", var_5_0))
		self.m_itemMaskLoader:setURL(var_0_2:getCultivateImage("pic_zl_jianglidi2_mask", var_5_0))
		self.m_qualityLoader:setURL(g.core.common.Path:getCultivateImage("pic_pinzhi_" .. arg_5_1.quality + 1, var_5_0))
		self.m_isWitchController:setSelectedIndex(0)
	else
		self.m_itemIconBg:setURL(var_0_2:getCultivateImage("pic_mnzj_jianglidi2", var_5_0))
		self.m_receiveLoader:setURL(var_0_2:getCultivateImage("pic_mnzj_yilingqu", var_5_0))
		self.m_canReceiveLoader:setURL(var_0_2:getCultivateImage("pic_mnzj_kelingqu", var_5_0))
		self.m_itemMaskLoader:setURL(var_0_2:getCultivateImage("pic_mnzj_zl_jianglidi2_mask", var_5_0))
		self.m_qualityLoader:setURL(g.core.common.Path:getCultivateImage("pic_pinzhi_" .. arg_5_1.quality + 1, var_5_0))
		self.m_isWitchController:setSelectedIndex(1)
	end

	self.m_itemLoader:setURL(arg_5_1.icon)
	self.m_numTxt:setText(arg_5_1.size)
end

function CultivatePassCardItem:updateItemState(arg_6_1)
	self._state = arg_6_1

	self.m_stateController:setSelectedIndex(arg_6_1)
end

return CultivatePassCardItem
