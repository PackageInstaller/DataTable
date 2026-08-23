local var_0_0 = table.insert
local ShowPop = class("ShowPop", function(arg_1_0, arg_1_1)
	return fgui.GComponent:create(arg_1_0, arg_1_1)
end)

function ShowPop:ctor(arg_2_1, arg_2_2)
	self:setOpaque(true)
	self:addClickListener(handler(self, self._onTouchBegin))
	self:showAtCenter()

	self._isWaiting = false
	self._executeIndex = 0
	self._resultParams = arg_2_2

	self:_checkComps()

	self._enterTrans = self:getTransition("enter")
	self._closeTrans = self:getTransition("back")
end

function ShowPop:onLoad()
	if self._enterTrans then
		self._enterTrans:play(handler(self, self._onAniFinish))
	end

	self:newScheduleOnce(handler(self, self.onTouchClick), 2)
	self:_updateComps()
	self:_execute()
end

function ShowPop:playSpineAnim(arg_4_1, arg_4_2)
	local var_4_0 = self:getChild(arg_4_1)

	if var_4_0 then
		var_4_0:addEffectSpine(arg_4_2)
	end
end

function ShowPop:onTouchClick()
	if self._closeTrans then
		self._closeTrans:play(handler(self, self._onClose))
	end
end

function ShowPop:_onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ShowPop:onUnload()
	if self._resultParams and type(self._resultParams) == "table" then
		if self._resultParams.func then
			self._resultParams.func()
		end
	end
end

function ShowPop:receiveCompEvent(arg_8_1, arg_8_2)
	return
end

function ShowPop:_checkComps()
	self._curPageComps = {}

	local var_9_0 = self:getView()

	for iter_9_0 = 1, var_9_0:numChildren() do
		local var_9_1 = var_9_0:getChildAt(iter_9_0 - 1)

		if tolua.type(var_9_1) ~= "fgui.GGroup" and var_9_1:isVisibleActually() then
			var_0_0(self._curPageComps, var_9_1)
		end
	end
end

function ShowPop:_execute()
	return
end

function ShowPop:_updateComps()
	for iter_11_0 = 1, #self._curPageComps do
		if self._curPageComps[iter_11_0].update then
			self._curPageComps[iter_11_0]:update(self._resultParams)
		end
	end
end

function ShowPop:_wait()
	self._isWaiting = true
end

function ShowPop:_continue()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ShowPop:_onTouchBegin()
	if self._isWaiting then
		self:_continue()

		self._isWaiting = false
	end
end

function ShowPop:_onAniFinish()
	self:receiveCompEvent("GetShow_continue")
end

return ShowPop
