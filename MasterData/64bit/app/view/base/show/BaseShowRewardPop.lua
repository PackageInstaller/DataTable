local BaseShowFeedBackPop = class("BaseShowFeedBackPop", require("app.fairyGUI.base_new.UI_BaseShowRewardPop"), function()
	return fgui.GComponent:create({
		resName = "BaseShowRewardPop",
		pkgName = "base_new",
		pkgPath = "ui/base_new/base_new"
	})
end)

function BaseShowFeedBackPop:ctor(arg_2_1)
	self:getView():setPosition(display.width - cc.Director:getInstance():getSafeAreaRect().x, display.height * 0.2)

	self._waitingList = arg_2_1
	self._curElem = nil
	self._executeSchedulerId = nil
	self._lastExitTimer = nil

	self:_startAnim()

	self._closeSelfWhenFinish = false
end

function BaseShowFeedBackPop:_startAnim()
	self:_createObject()

	if #self._waitingList > 0 then
		self._executeSchedulerId = g.core.common.Scheduler:newSchedule(handler(self, self._execute), 0.4)
	end
end

function BaseShowFeedBackPop:_createObject()
	local var_4_0 = fgui.UIPackage:createObject("base_new", "BaseShowRewardComp")

	var_4_0:setView((table.remove(self._waitingList, 1)))

	self._curElem = var_4_0

	self.m_placeComp:addChild(var_4_0)

	if #self._waitingList == 0 then
		self._lastExitTimer = g.core.common.Scheduler:newScheduleOnce(handler(self, self._onShowFinish), 0.8)
	end
end

function BaseShowFeedBackPop:_execute()
	if self._curElem then
		self._curElem:exitView()

		self._curElem = nil
	end

	self:_createObject()

	if #self._waitingList == 0 and self._executeSchedulerId then
		g.core.common.Scheduler:cancelSchedule(self._executeSchedulerId)

		self._executeSchedulerId = nil
	end
end

function BaseShowFeedBackPop:_onShowFinish()
	self._curElem:exitView(handler(self, self._onExit))

	self._lastExitTimer = nil
end

function BaseShowFeedBackPop:_onExit()
	if self._closeSelfWhenFinish then
		g.core.module.ModuleManager:popComponent()
	else
		self:dispatchCompEvent("Event_close_pop_layer")
	end
end

function BaseShowFeedBackPop:onUnload()
	if self._executeSchedulerId then
		g.core.common.Scheduler:cancelSchedule(self._executeSchedulerId)

		self._executeSchedulerId = nil
	end

	if self._lastExitTimer then
		g.core.common.Scheduler:cancelSchedule(self._lastExitTimer)

		self._lastExitTimer = nil
	end
end

function BaseShowFeedBackPop:setCloseWhenFinish(arg_9_1)
	self._closeSelfWhenFinish = arg_9_1
end

return BaseShowFeedBackPop
