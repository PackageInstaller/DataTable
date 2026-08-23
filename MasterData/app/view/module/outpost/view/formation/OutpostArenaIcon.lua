local OutpostArenaIcon = class("OutpostArenaIcon", require("app.fairyGUI.outpost.UI_OutpostArenaIcon"))

function OutpostArenaIcon:ctor()
	self._advId = -1
	self._arena = -1
	self._knight = nil
	self._isSel = false

	self:addClickListener(handler(self, self.onClickSel))
	self.m_stateController:setSelectedIndex(self._isSel and 1 or 0)
end

function OutpostArenaIcon:updateKnight(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 then
		self._isSel = false

		self.m_stateController:setSelectedIndex(0)
	end

	self._knight = arg_2_1

	local var_2_0 = arg_2_1:getAdvId()
	local var_2_1 = arg_2_1:getCfg()

	self._arena = arg_2_2
	self._advId = var_2_0

	self.m_knightIcon:updateIcon({
		struct = g.core.model.User.knightsData:getKnight({
			advance_id = var_2_0
		})
	})
	self.m_levelTxt:setText(arg_2_1:getLevel())
	self.m_iconElem:setURL(g.core.common.Path:getKnightElementIcon(var_2_1.classical))
	self.m_fightValueTxt:setText(self._knight:getSelfFightValue())
	self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. var_2_1.profession)
end

function OutpostArenaIcon:onClickSel()
	self._isSel = not self._isSel

	self.m_stateController:setSelectedIndex(self._isSel and 1 or 0)
	self:dispatchCompEvent("OutpostFormationArenaComp_sel_knight", {
		id = self._knight:getServerId(),
		sel = self._isSel,
		arena = self._arena,
		knight = self._knight
	})
end

return OutpostArenaIcon
