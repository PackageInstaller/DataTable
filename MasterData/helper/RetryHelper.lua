-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\RetryHelper.lua

local UIConst = require("UI/UIConst")
local RetryHelper = {}
local self = RetryHelper

self._stateDict = {}
self.CLOSE_DELAY = 0.8

function RetryHelper.setSpinnerVisible(name, visible, content)
	if visible then
		self._stateDict[name] = true
	else
		self._stateDict[name] = nil
	end

	self._refreshSpinner(content)
end

function RetryHelper._refreshSpinner(content)
	local visible = next(self._stateDict) ~= nil

	if visible then
		local spinner = UIManager.getUI("loginSpinner", true, true)

		if spinner then
			spinner:setText(content)
		end

		self._timerDelayClose:Stop()
	else
		self._timerDelayClose:Restart()
	end
end

function RetryHelper._delayCloseSpinner()
	local visible = next(self._stateDict) ~= nil

	if not visible then
		local spinner = UIManager.tryGetUI("loginSpinner")

		if spinner then
			spinner:setVisible(false)
		end
	end
end

self._timerDelayClose = Timer.New(self._delayCloseSpinner, self.CLOSE_DELAY, 1)

return RetryHelper
