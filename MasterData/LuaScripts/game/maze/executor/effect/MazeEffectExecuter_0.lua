-- 通用动画定制效果
-- 镜头移动所有事件中心位置，然后播放ACT_TYPE_TRIGGER_1动画，然后恢复镜头
module("maze.MazeEffectExecuter_0", Class.impl(maze.MazeBaseEffectExecuter))

function __initData(self)
	super.__initData(self)
end

function startPlay(self, mazeId, delEventList, addEventList, updateEventList)
	local allActionFinish = function()
		local function finishCall()
			maze.MazeEffectExecutor:removeEffect(self)
			GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, false)
		end
		local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
		maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true, finishCall)
	end
	local updateActionFinish = function() self:startAction(mazeId, addEventList, allActionFinish) end
	local delActionFinish = function() self:startAction(mazeId, updateEventList, updateActionFinish) end
	GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, true)
	self:startAction(mazeId, delEventList, delActionFinish)
end

function startAction(self, mazeId, eventList, callFun)
	if(#eventList <= 0)then
		callFun()
	else
		local maxTime = 0
		local maxTimeEventId = nil
		local tempEventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
		for i = 1, #eventList do
            tempEventVo:setData(eventList[i])
			local row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, tempEventVo:getTileId())
			local thingVo = maze.MazeSceneManager:getThingVo(maze.THING_TYPE_EVENT, row, col)
			thingVo:getThing():getAniLenght(maze.ACT_STR_TRIGGER_1, function (aniLenght)
				if(aniLenght and aniLenght >= maxTime)then
					maxTime = aniLenght
					maxTimeEventId = tempEventVo:getEventId()
				end
			end)
		end
		LuaPoolMgr:poolRecover(tempEventVo)
	
		local moveFinishCall = function()
			for i = #eventList, 1, -1 do
				local eventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
				eventVo:setData(eventList[i])
				local oldEventVo = maze.MazeSceneManager:getMazeEventVo(eventVo:getTileId())
				if(oldEventVo)then
					local isEndFinishCall = false
					if((maxTimeEventId == nil and i == 1) or maxTimeEventId == eventVo:getEventId())then
						isEndFinishCall = true
					end
					local row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, eventVo:getTileId())
					local thingVo = maze.MazeSceneManager:getThingVo(maze.THING_TYPE_EVENT, row, col)
					thingVo:getThing():playAction(maze.getActHashByState(maze.ACT_TYPE_TRIGGER_1), nil, 
					function()
						if(isEndFinishCall)then
							callFun()
						end
					end)
				end
			end
		end
		
		local eventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
		eventVo:setData(eventList[1])
		local row, col = maze.MazeSceneManager:getRowColByTileId(maze.MazeSceneManager:getMazeId(), eventVo:getTileId())
		maze.MazeCamera:setRowCol(row, col, true, moveFinishCall)
	end
end

function __reset(self)
	super.__reset(self)
	if(self.mCallFun)then
		self.mCallFun()
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
