local MysteryBossHurtRankComp = class("MysteryBossHurtRankComp", require("app.fairyGUI.mystery.UI_MysteryBossHurtRankComp"))

function MysteryBossHurtRankComp:ctor()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRender))
end

function MysteryBossHurtRankComp:_onRankItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._rankData[arg_2_1 + 1])
end

function MysteryBossHurtRankComp:updateRankInfo(arg_3_1)
	self._rankData = arg_3_1

	self.m_rankList:setNumItems(#self._rankData)
	self:_updateMyRankData()
end

function MysteryBossHurtRankComp:_updateMyRankData()
	local var_4_0 = g.core.model.User:getId()
	local var_4_1

	for iter_4_0, iter_4_1 in ipairs(self._rankData) do
		if iter_4_1.user_id == var_4_0 then
			var_4_1 = iter_4_1

			break
		end
	end

	if var_4_1 then
		self.m_myUserIcon:updateAsSelf()
		self.m_myNameTxt:setText(g.core.model.User:getName())
		self.m_curRankTxt:setText(g.core.lang:get(423504, {
			rank = var_4_1.rank
		}))
		self.m_myDamage:setText(var_4_1.damage)
	end

	self.m_myInfoGroup:setVisible(checkbool(var_4_1))
end

return MysteryBossHurtRankComp
