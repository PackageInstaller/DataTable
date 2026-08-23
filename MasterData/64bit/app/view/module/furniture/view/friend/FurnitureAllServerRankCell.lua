local FurnitureAllServerRankCell = class("FurnitureAllServerRankCell", require("app.fairyGUI.furniture.UI_FurnitureAllServerRankCell"))

function FurnitureAllServerRankCell:ctor()
	self._awards = nil

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRenderer))
end

function FurnitureAllServerRankCell:updateCellData(arg_2_1, arg_2_2)
	self.m_haveBgController:setSelectedIndex(arg_2_2 % 2)

	local var_2_0 = g.core.model.User.furnitureData:getServerCharmRankAward(arg_2_1.rank)

	self.m_indexComp:updateRankIndex(arg_2_1)
	self.m_charmTxt:setText(arg_2_1.score)

	local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if var_2_1 then
		self.m_nameTxt:setText(var_2_1.name)
		self.m_levelTxt:setText(g.core.lang:get(2052, {
			level = var_2_1.level
		}))
		self.m_headComp:updateAsUser(var_2_1)
		self.m_headComp:setVisible(true)
	else
		self.m_nameTxt:setText("")
		self.m_levelTxt:setText("")
		self.m_headComp:setVisible(false)
	end

	if var_2_0 then
		self._awards = var_2_0.data

		self.m_awardList:setNumItems(#self._awards)
	else
		self.m_awardList:setNumItems(0)
	end
end

function FurnitureAllServerRankCell:_onAwardRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

return FurnitureAllServerRankCell
