local ExplorationGuildBuffPop = class("ExplorationGuildBuffPop", require("app.fairyGUI.exploration.UI_ExplorationGuildBuffPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationGuildBuffPop",
		pkgName = "exploration"
	})
end)

function ExplorationGuildBuffPop:ctor(arg_2_1)
	self:showAtCenter()

	self._buffList = {}

	self:_initListView()
end

function ExplorationGuildBuffPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_GETGUILDBUFFDETAIL, self._onRecvGuildBuff, self)
	g.core.network.GameNetProxy:send_C2S_Exploration_GetGuildBuffDetail({})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ORGANIZATION_GAIN)
end

function ExplorationGuildBuffPop:_initListView()
	self:addListen(self.m_buffList)
	self.m_buffList:setIniter()
	self.m_buffList:setItemRenderer(handler(self, self._onRenderBuffList))
end

function ExplorationGuildBuffPop:_onRenderBuffList(arg_5_1, arg_5_2)
	arg_5_2:updateBuffInfo(self._buffList[arg_5_1 + 1])
end

function ExplorationGuildBuffPop:updateView()
	self._buffList = g.core.model.User.explorationData:getGuildBuffList()

	self.m_buffList:setNumItems(#self._buffList)
end

function ExplorationGuildBuffPop:_onRecvGuildBuff(arg_7_1, arg_7_2, arg_7_3)
	self:updateView()
end

function ExplorationGuildBuffPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "ExplorationGuildBuffPop_moveToMap" then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		self:dispatchCompEvent("moveToMap", {
			closePop = false,
			coord = g.core.model.User.explorationData:getMapData():getRoomCenterGlobalCoordinateByRoomId(arg_8_2.roomId)
		})
	end
end

return ExplorationGuildBuffPop
