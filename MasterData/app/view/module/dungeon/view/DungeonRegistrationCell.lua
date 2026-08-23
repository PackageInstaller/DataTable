local DungeonRegistrationCell = class("DungeonRegistrationCell", require("app.fairyGUI.dungeon.UI_DungeonRegistrationCell"))

function DungeonRegistrationCell:ctor()
	self._awards = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function DungeonRegistrationCell:updateAwardCell(arg_2_1)
	self._awards = g.core.common.Drops:getGoodsArray(arg_2_1.dropId)

	for iter_2_0 = 1, #self._awards do
		if self._awards[iter_2_0].type == 13 then
			local var_2_0 = g.core.config.skin_info.get(self._awards[iter_2_0].value)

			if var_2_0.sex < 2 and var_2_0.sex ~= g.core.model.User.knightsData:getMainKnight():getBaseInfo().sex then
				table.remove(self._awards, iter_2_0)

				break
			end
		end
	end

	self.m_awardList:setNumItems(#self._awards)
	self.m_nameMarkTxt:setText(arg_2_1.name)
	self.m_nameTxt:setText(g.core.lang:get(300041, {
		str = arg_2_1.name
	}))
	self.m_isBigRewardController:setSelectedIndex(arg_2_1.isBig and 1 or 0)
end

function DungeonRegistrationCell:_onAwardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

return DungeonRegistrationCell
