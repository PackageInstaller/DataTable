local var_0_0 = {
	201572,
	201573,
	201574,
	201575
}
local InfoProgressComp = class("InfoProgressComp", require("app.fairyGUI.infoPop.UI_InfoProgressComp"))

function InfoProgressComp:ctor(arg_1_1)
	self.m_getBtn:addClickListener(handler(self, self._onGetBtnClick))
end

function InfoProgressComp:updateShow(arg_2_1)
	self._baseId = arg_2_1.baseId

	local var_2_0 = g.core.config.equipment_info.get(self._baseId)

	self._equipConfigInfo = var_2_0

	self.m_progressGroup:setVisible(false)

	if var_2_0.fragment_id ~= 0 then
		self.m_progressGroup:setVisible(true)

		local var_2_1 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_FRAGMENT, self._equipConfigInfo.fragment_id)
		local var_2_2 = g.core.config.fragment_info.get(self._equipConfigInfo.fragment_id).combine_num

		self.m_progress:setPercent({
			cur = var_2_1,
			max = var_2_2
		})
		self.m_isEnoughController:setSelectedIndex(var_2_1 < var_2_2 and 1 or 0)
		self.m_curNumText:setText(var_2_1)
		self.m_fullNumText:setText("/" .. var_2_2)
		self.m_icon:updateIcon({
			hideNum = true,
			type = 2,
			overrideClick = true,
			value = var_2_0.id
		})
	end

	self.m_quliatyIcon:setURL("ui://text_new/pic_pinzhi_" .. var_2_0.quality + 1)
	self.m_nameText:setText(var_2_0.name)

	if self.m_nameType then
		self.m_nameType:setText(g.core.lang:get(var_0_0[var_2_0.type or 1]))
	end
end

function InfoProgressComp:_onGetBtnClick()
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		type = g.core.common.Goods.TYPE_FRAGMENT,
		value = self._equipConfigInfo.fragment_id,
		size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_FRAGMENT, self._equipConfigInfo.fragment_id)
	})
end

return InfoProgressComp
