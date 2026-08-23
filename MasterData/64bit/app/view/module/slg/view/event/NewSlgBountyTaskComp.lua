local NewSlgBountyTaskComp = class("NewSlgBountyTaskComp")

function NewSlgBountyTaskComp:ctor()
	self._listTask = self:getChild("List_tasks")

	self._listTask:setVirtual(self)
	self._listTask:setItemRenderer(handler(self, self._onRenderListTaskCell))

	self._taskArr = {}
end

function NewSlgBountyTaskComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYINFO, handler(self, self._onRcvBountyInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYREFRESHTASK, handler(self, self._onRefreshTasks), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self.onCrossDay), self)
end

function NewSlgBountyTaskComp:_onRenderListTaskCell(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._taskArr[arg_3_1 + 1], arg_3_1 + 1)
end

function NewSlgBountyTaskComp:onCrossDay()
	g.core.network.GameNetProxy:send_C2S_NewSlg_BountyInfo({})
end

function NewSlgBountyTaskComp:updateView()
	self._taskArr = g.core.model.User.newSlgData:getBountyTasks()

	if table.nums(self._taskArr) < 3 then
		g.core.network.GameNetProxy:send_C2S_NewSlg_BountyInfo({})
	else
		self._listTask:setNumItems(#self._taskArr)
	end
end

function NewSlgBountyTaskComp:_onRcvBountyInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._taskArr = g.core.model.User.newSlgData:getBountyTasks()

	self._listTask:setNumItems(#self._taskArr)
end

function NewSlgBountyTaskComp:_onRefreshTasks(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(429677))
	self._listTask:setNumItems(#self._taskArr)
end

return NewSlgBountyTaskComp
