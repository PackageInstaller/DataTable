local FightWorldMap = class("FightWorldMap")

function FightWorldMap:ctor(arg_1_1, arg_1_2)
	self._width = arg_1_1
	self._start = arg_1_2 or 0
	self._finish = self._start + arg_1_1
	self._pos = 0
	self._worldmaplisteners = {}
end

function FightWorldMap:getSize()
	return self._width
end

function FightWorldMap:getPosition()
	return self._pos
end

function FightWorldMap:setPosition(arg_4_1)
	self._pos = arg_4_1
end

function FightWorldMap:move(arg_5_1)
	self._pos = self._pos - arg_5_1

	self:dispatchEventOnWorldMapMove()
end

function FightWorldMap:convertToWorldSpace(arg_6_1)
	return arg_6_1 - self._pos
end

function FightWorldMap:convertToGLSpace(arg_7_1)
	return self._pos + arg_7_1
end

function FightWorldMap:isInWorldMap(arg_8_1)
	return arg_8_1 >= self._start and arg_8_1 <= self._finish
end

function FightWorldMap:isInCameraValidWorldMap(arg_9_1)
	local var_9_0 = FightManager.getCamera().getBaseConfig()

	return arg_9_1 >= self._start + var_9_0.center and arg_9_1 <= self._finish - GameDisplay.width + var_9_0.center
end

function FightWorldMap:isOutOfWorldMapRightBound(arg_10_1)
	return arg_10_1 >= self._finish
end

function FightWorldMap:isOutOfWorldMapLeftBound(arg_11_1)
	return arg_11_1 <= self._start
end

function FightWorldMap:registerWorldMapListener(arg_12_1, arg_12_2)
	table.insert(self._worldmaplisteners, {
		obj = arg_12_1,
		handler = arg_12_2
	})
end

function FightWorldMap:unregisterWorldMapListener(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self._worldmaplisteners) do
		if iter_13_1.handler == arg_13_1 then
			table.remove(self._worldmaplisteners, iter_13_0)

			break
		end
	end
end

function FightWorldMap:dispatchEventOnWorldMapMove()
	for iter_14_0, iter_14_1 in ipairs(self._worldmaplisteners) do
		local var_14_0, var_14_1 = pcall(iter_14_1.handler, iter_14_1.obj)

		if not var_14_0 then
			print(var_14_1)
		end
	end
end

return FightWorldMap
