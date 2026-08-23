local MineTaskAwardItemComp = class("MineTaskAwardItemComp", require("app.fairyGUI.mine.UI_MineTaskAwardItemComp"))

function MineTaskAwardItemComp:ctor()
	self._canRec = false
	self._achieveId = 0

	self:addClickListener(handler(self, self._onClickReward))
end

function MineTaskAwardItemComp:updateCompData(arg_2_1)
	local var_2_0 = arg_2_1.info.num

	if arg_2_1.info.num == nil then
		var_2_0 = ""
	end

	self._achieveId = arg_2_1.info.id

	self.m_targetNum:setText(var_2_0)

	local var_2_1 = g.core.common.Drops:getGoodsArray(arg_2_1.info.drop_id, true)

	self.m_itemIcon:setURL(var_2_1[1].icon)
	self.m_blackIcon:setURL(var_2_1[1].icon)
	self.m_blackIcon:setGloaderColor(true, cc.vec3(0, 0, 0))
	self.m_numTxt:setText("X" .. var_2_1[1].size)
	self.m_canAwardEffComp:removeAllEffect()
	self.m_stateController:setSelectedIndex(arg_2_1.state)

	self._canRec = arg_2_1.state == 1

	if self._canRec then
		self:updateEffSpine()
	end
end

function MineTaskAwardItemComp:updateEffSpine()
	self.m_canAwardEffComp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_mine_taskget"
	})
end

function MineTaskAwardItemComp:_onClickReward()
	if self._canRec then
		g.core.network.GameNetProxy:send_C2S_Mine_GetAchieveReward({
			id = self._achieveId
		})
	end
end

return MineTaskAwardItemComp
