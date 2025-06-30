-- 旋转阀门动画定制效果
-- 镜头移动所有事件中心位置，然后升降障碍物对应升降动画，灯泡亮起或熄灭，其余播放ACT_TYPE_TRIGGER_1动画，然后恢复镜头
-- 目前直接拷贝MazeEffectExecuter_2，具体修改等待策划确定定制效果方案
module("maze.MazeEffectExecuter_3", Class.impl(maze.MazeBaseEffectExecuter))

function __initData(self)
	super.__initData(self)

	self.mTimeOutIndex = nil
	-- 0.5s是相机的移动时间，额外0.5秒停留时间
	self.mTweenTime = 0.5 + 0.5
	self.mTweenerList = {}
end

function startPlay(self, mazeId, updateEventList)
	if(#updateEventList <= 0)then
		maze.MazeEffectExecutor:removeEffect(self)
	else
		local moveFinishCall = function()
			if(self.mCallFun)then
				self.mCallFun()
			end

			for i = #updateEventList, 1, -1 do
				local eventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
				eventVo:setData(updateEventList[i])

				local oldEventVo = maze.MazeSceneManager:getMazeEventVo(eventVo:getTileId())
				if(oldEventVo)then
					local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(oldEventVo:getEventId())
					
					--这里表示的是障碍物的状态，障碍物打开，表示阻挡不可通行，关闭表示可以通行
					if(eventConfigVo:getEventType() == maze.THING_TYPE_OBSTACLE_OPEN)then
						local row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, oldEventVo:getTileId())
						local thingVo = maze.MazeSceneManager:getThingVo(maze.THING_TYPE_EVENT, row, col)
						local actState = maze.ACT_TYPE_TRIGGER_2
						local actHash = maze.getActHashByState(actState)
						thingVo:getThing():playAction(actHash, nil, function() end)
					elseif(eventConfigVo:getEventType() == maze.THING_TYPE_OBSTACLE_CLOSE)then
						local addEventVo = maze.MazeSceneManager:addMazeEventVo(updateEventList[i])
						if(addEventVo)then
							table.remove(updateEventList, i)
							
							local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, addEventVo:getTileId())
							local row, col = tileConfigVo:getRow(), tileConfigVo:getCol()
							maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_EVENT, row, col, true)

							local thingVo = maze.getEventThingVo(maze.THING_TYPE_EVENT)
							thingVo:setData(mazeId, addEventVo:getTileId())
							maze.MazeSceneManager:addThingVo(thingVo, true)
							local actState = maze.ACT_TYPE_TRIGGER_1
							local actHash = maze.getActHashByState(actState)
							thingVo:getThing():playAction(actHash, nil, function() end)
						end
					else
						local row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, eventVo:getTileId())
						local thingVo = maze.MazeSceneManager:getThingVo(maze.THING_TYPE_EVENT, row, col)
						local actState = eventVo:getActState()
						local actHash = maze.getActHashByState(actState)
						thingVo:getThing():playAction(actHash, nil, function() end)
					end
				end
	
				LuaPoolMgr:poolRecover(eventVo)
			end
		end
		
		GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, true)
		local eventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
		eventVo:setData(updateEventList[1])
		local row, col = maze.MazeSceneManager:getRowColByTileId(maze.MazeSceneManager:getMazeId(), eventVo:getTileId())
		maze.MazeCamera:setRowCol(row, col, true, moveFinishCall)
	
		local function finishCall()
			maze.MazeEffectExecutor:removeEffect(self)
			GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, false)
		end
		local timeOutCall = function()
			local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
			maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true,finishCall)
		end
		self.mTimeOutIndex = LoopManager:setTimeout(self.mTweenTime, self, timeOutCall)
	end
end

function __reset(self)
	super.__reset(self)

	for i = 1, #self.mTweenerList do
		self.mTweenerList[i]:Kill()
	end
	self.mTweenerList = {}

	if self.mTimeOutIndex then
		LoopManager:clearTimeout(self.mTimeOutIndex)
		self.mTimeOutIndex = nil
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
