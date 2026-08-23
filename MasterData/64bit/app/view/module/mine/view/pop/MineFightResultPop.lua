local MineFightResultPop = class("MineFightResultPop", require("app.fairyGUI.mine.UI_MineFightResultPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/mine/mine",
		resName = "MineFightResultPop",
		pkgName = "mine"
	})
end)

function MineFightResultPop:ctor()
	self:addBg("bg/mine/bg_zhanbao.jpg")
	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onUpdateRecordCell))
end

function MineFightResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETRECORD, self._onRcvGetRecord, self)
	g.core.network.GameNetProxy:send_C2S_Mine_GetRecord({})
	g.core.model.User.mineData:updateEnterRecordTs()
end

function MineFightResultPop:_onRcvGetRecord(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_3.records or {}

	if #var_4_0 > 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)

		return
	end

	self._recordData = {}

	local var_4_1 = g.core.common.ServerTime:getTime()

	for iter_4_0 = #var_4_0, 1, -1 do
		var_4_0[iter_4_0].time_ago = var_4_1 - var_4_0[iter_4_0].battle_ts

		table.insert(self._recordData, var_4_0[iter_4_0])
	end

	table.sort(self._recordData, function(arg_5_0, arg_5_1)
		if arg_5_0.battle_ts ~= arg_5_1.battle_ts then
			return arg_5_0.battle_ts > arg_5_1.battle_ts
		elseif arg_5_0.atker_power ~= arg_5_1.atker_power then
			return arg_5_0.atker_power < arg_5_1.atker_power
		else
			return arg_5_0.defer_power < arg_5_1.defer_power
		end
	end)
	self.m_recordList:setNumItems(#self._recordData)
	self.m_recordList:transitionShowCells("enter_left", 0.03, 1)
end

function MineFightResultPop:_onUpdateRecordCell(arg_6_1, arg_6_2)
	arg_6_2:updateRecordCell({
		data = self._recordData[arg_6_1 + 1]
	})
end

return MineFightResultPop
