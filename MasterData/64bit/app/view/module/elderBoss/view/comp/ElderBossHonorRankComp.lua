local var_0_0 = g.core.model.User.elderBossData
local var_0_1 = g.core.const.ConstMgr.ElderBossConst
local ElderBossHonorRankComp = class("ElderBossHonorRankComp", require("app.fairyGUI.elderBoss.UI_ElderBossHonorRankComp"))

function ElderBossHonorRankComp:ctor()
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self.onSelectTab))

	local var_1_0 = var_0_0:getChooseBuff()

	if var_1_0 > 0 then
		self.m_tabController:setSelectedIndex(var_1_0 - 1)
	else
		self.m_tabController:setSelectedIndex(0)
	end

	self:onSelectTab()
end

function ElderBossHonorRankComp:onSelectTab()
	self._selectIndex = self.m_tabController:getSelectedIndex() + 1

	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		id = var_0_1.MAX_HONNOR_RANK_ID[self._selectIndex],
		size = var_0_1.MAX_HONNOR_RANK_SIZE
	})
end

function ElderBossHonorRankComp:updateRankCell(arg_3_1)
	if var_0_1.MAX_HONNOR_RANK_ID[self._selectIndex] ~= arg_3_1.id then
		return
	end

	local var_3_0 = arg_3_1.rank_units

	if #arg_3_1.rank_units == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)

		for iter_3_0 = 1, var_0_1.MAX_HONNOR_RANK_SIZE do
			if var_3_0[iter_3_0] then
				self["m_rank" .. iter_3_0]:setVisible(true)
				self["m_rank" .. iter_3_0]:updateCell(var_3_0[iter_3_0])
			else
				self["m_rank" .. iter_3_0]:setVisible(false)
			end
		end
	end
end

return ElderBossHonorRankComp
