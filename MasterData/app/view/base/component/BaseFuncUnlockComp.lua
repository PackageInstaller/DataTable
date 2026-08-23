local var_0_0 = g.core.model.User.functionUnlockData
local BaseFuncUnlockComp = class("BaseFuncUnlockComp")

function BaseFuncUnlockComp:ctor()
	self._funcRouteIds = {}
	self._effectParams = {}
	self._isAutoRefresh = true
	self._isShowEffect = true
	self._effectType = g.core.const.ConstMgr.FuncUnlockConst.EFFECT_TYPE.ICON
end

function BaseFuncUnlockComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_RESPONSE, handler(self, self._onRequestResponse), self)
end

function BaseFuncUnlockComp:_onRequestResponse()
	if self._isAutoRefresh then
		self:refresh()
	end
end

function BaseFuncUnlockComp:setEffectType(arg_4_1)
	self._effectType = arg_4_1
end

function BaseFuncUnlockComp:refresh(arg_5_1)
	if #self._funcRouteIds == 0 then
		return
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._funcRouteIds) do
		if var_0_0:isNewFuncUnlocked(iter_5_1) then
			table.insert(var_5_0, {
				state = 1,
				routeId = iter_5_1
			})
		end
	end

	if #var_5_0 > 0 and (arg_5_1 or true) then
		var_0_0:saveUnlockedFuncList(var_5_0)
	end
end

function BaseFuncUnlockComp:setAutoRefresh(arg_6_1)
	self._isAutoRefresh = arg_6_1
end

function BaseFuncUnlockComp:setEffectParams(arg_7_1)
	if arg_7_1 then
		self._effectParams = arg_7_1
	end
end

function BaseFuncUnlockComp:_playEffect()
	return
end

function BaseFuncUnlockComp:bindFuncRouteIds(arg_9_1)
	self._funcRouteIds = {}

	if arg_9_1 and next(arg_9_1) then
		table.insertto(self._funcRouteIds, arg_9_1)
	end
end

function BaseFuncUnlockComp:clearFuncRouteIds()
	self._funcRouteIds = {}
end

return BaseFuncUnlockComp
