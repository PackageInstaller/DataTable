local TeamBattleWorkComp = class("TeamBattleWorkComp", require("app.fairyGUI.teamBattle.UI_TeamBattleWorkComp"))

function TeamBattleWorkComp:ctor()
	self._curIndex = -1

	self:_initComp()
end

function TeamBattleWorkComp:_initComp()
	self.m_workList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeWork))

	local var_2_0 = g.core.model.User.teamBattleData:getMapData()
	local var_2_1 = math.max(var_2_0 - 1, 0)

	self.m_workList:setSelectedIndex(var_2_1)

	if var_2_0:getPlayerStruct():getWork() == 0 then
		self:_onChangeWork()
	else
		self.m_workList:getChildAt(var_2_1):setCtrlState("button", {
			index = 1
		})
	end
end

function TeamBattleWorkComp:_onChangeWork(arg_3_1)
	local var_3_0 = self.m_workList:getSelectedIndex()

	if self._curIndex == var_3_0 then
		return
	end

	self:_playSwitchEffect(var_3_0 + 1)

	self._curIndex = var_3_0

	self.m_workList:getChildAt(self._curIndex):setCtrlState("button", {
		index = 1
	})
	g.core.network.GameNetProxy:send_C2S_TeamBattle_SetWork({
		work = self._curIndex + 1
	})
end

function TeamBattleWorkComp:_playSwitchEffect(arg_4_1)
	print("_playSwitchEffect-->")

	for iter_4_0 = 1, 3 do
		self.m_workList:getChildAt(iter_4_0 - 1).m_eff:removeAllEffect()
	end

	print(arg_4_1)
	self.m_workList:getChildAt((self.m_workList:itemIndexToChildIndex(arg_4_1 - 1))):playSelectEff()
end

return TeamBattleWorkComp
